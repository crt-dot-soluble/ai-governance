$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$policyPath = Join-Path $repoRoot "governance.config.json"
$specPath = Join-Path $repoRoot "spec\SPECIFICATION.md"

if (-not (Test-Path $policyPath)) {
  throw "Missing governance.config.json. Run the Governance Bootstrap task first."
}

if (-not (Test-Path $specPath)) {
  throw "Missing spec/SPECIFICATION.md. Create it before starting from spec."
}

Write-Output "Spec execution can begin. Follow spec/SPECIFICATION.md using the active governance policy."
