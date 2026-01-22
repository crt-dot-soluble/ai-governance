param(
  [Parameter(Mandatory = $true)][string]$SpecPath
)

if ($args.Count -gt 1) {
  throw "Only one argument is allowed: path to SPECIFICATION.md"
}

$resolvedSpecPath = Resolve-Path -Path $SpecPath -ErrorAction Stop
if ((Split-Path -Leaf $resolvedSpecPath) -ne "SPECIFICATION.md") {
  throw "Spec file must be named SPECIFICATION.md"
}

$specDir = Split-Path -Parent $resolvedSpecPath
$specDirName = Split-Path -Leaf $specDir
if ($specDirName -ieq "spec") {
  $targetRoot = Split-Path -Parent $specDir
} else {
  $targetRoot = $specDir
}

if (-not (Test-Path $targetRoot)) {
  New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

$requiredDirs = @(".ai", ".vscode", "scripts", "templates", "docs", "plans", "src", "spec", ".github")
foreach ($dir in $requiredDirs) {
  $targetPath = Join-Path $targetRoot $dir
  if (Test-Path $targetPath) {
    throw "Target already contains $dir at $targetPath. Aborting to avoid overwrite."
  }
}

$requiredFiles = @(
  "CONSTITUTION.md",
  "CHANGELOG.md",
  "MEMORY-LEDGER.md",
  "TODO-LEDGER.md",
  "README.md",
  "governance.config.json"
)
foreach ($file in $requiredFiles) {
  $targetPath = Join-Path $targetRoot $file
  if (Test-Path $targetPath) {
    throw "Target already contains $file at $targetPath. Aborting to avoid overwrite."
  }
}

Copy-Item -Path (Join-Path $repoRoot ".ai") -Destination (Join-Path $targetRoot ".ai") -Recurse
Copy-Item -Path (Join-Path $repoRoot ".vscode") -Destination (Join-Path $targetRoot ".vscode") -Recurse
Copy-Item -Path (Join-Path $repoRoot "scripts") -Destination (Join-Path $targetRoot "scripts") -Recurse
Copy-Item -Path (Join-Path $repoRoot "templates") -Destination (Join-Path $targetRoot "templates") -Recurse
Copy-Item -Path (Join-Path $repoRoot "docs") -Destination (Join-Path $targetRoot "docs") -Recurse
Copy-Item -Path (Join-Path $repoRoot "plans") -Destination (Join-Path $targetRoot "plans") -Recurse
Copy-Item -Path (Join-Path $repoRoot "src") -Destination (Join-Path $targetRoot "src") -Recurse
Copy-Item -Path (Join-Path $repoRoot ".github") -Destination (Join-Path $targetRoot ".github") -Recurse

Copy-Item -Path (Join-Path $repoRoot "templates\CONSTITUTION.md") -Destination (Join-Path $targetRoot "CONSTITUTION.md")
Copy-Item -Path (Join-Path $repoRoot "templates\CHANGELOG.md") -Destination (Join-Path $targetRoot "CHANGELOG.md")
Copy-Item -Path (Join-Path $repoRoot "templates\MEMORY-LEDGER.md") -Destination (Join-Path $targetRoot "MEMORY-LEDGER.md")
Copy-Item -Path (Join-Path $repoRoot "templates\TODO-LEDGER.md") -Destination (Join-Path $targetRoot "TODO-LEDGER.md")
Copy-Item -Path (Join-Path $repoRoot "templates\README.md") -Destination (Join-Path $targetRoot "README.md")
Copy-Item -Path (Join-Path $repoRoot "governance.config.json") -Destination (Join-Path $targetRoot "governance.config.json")

$specTargetDir = Join-Path $targetRoot "spec"
if (-not (Test-Path $specTargetDir)) {
  New-Item -ItemType Directory -Force -Path $specTargetDir | Out-Null
}
Copy-Item -Path $resolvedSpecPath -Destination (Join-Path $specTargetDir "SPECIFICATION.md") -Force

Write-Output "Initialized governance repository at $targetRoot"
