#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_PATH="${1:-$REPO_ROOT/.vscode/audit.json}"

log_json() {
  local level="$1"; local message="$2"; local data="$3"
  printf '{"timestamp":"%s","level":"%s","message":"%s","data":%s}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$level" "$message" "$data"
}

PYTHON_BIN=""
if command -v python3 >/dev/null 2>&1; then
  PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
fi
if [ -z "$PYTHON_BIN" ]; then
  log_json "error" "selfaudit.missing_python" "{}"
  echo "Python is required for self-audit.sh (python3 or python)." >&2
  exit 1
fi

REPO_ROOT="$REPO_ROOT" OUTPUT_PATH="$OUTPUT_PATH" "$PYTHON_BIN" - <<'PY'
import json
import os
import sys
from datetime import datetime

repo_root = os.environ.get("REPO_ROOT") or os.getcwd()
output_path = os.environ.get("OUTPUT_PATH") or os.path.join(repo_root, ".vscode", "audit.json")

os.makedirs(os.path.dirname(output_path), exist_ok=True)

errors = []
warnings = []

required_dirs = [".ai", ".vscode", "scripts", "templates", "docs", "plans", "src", "spec", ".github", "schemas"]
for d in required_dirs:
  if not os.path.isdir(os.path.join(repo_root, d)):
    errors.append(f"Missing required directory: {d}")

required_files = ["CONSTITUTION.md", "MEMORY-LEDGER.md", "TODO-LEDGER.md", "CHANGELOG.md"]
for f in required_files:
  if not os.path.isfile(os.path.join(repo_root, f)):
    errors.append(f"Missing required file: {f}")

policy_config = os.path.join(repo_root, "governance.config.json")
policy_alt = os.path.join(repo_root, "POLICY.md")
if not os.path.isfile(policy_config) and not os.path.isfile(policy_alt):
  errors.append("Missing policy file: governance.config.json or POLICY.md")

spec_path = os.path.join(repo_root, "spec", "SPECIFICATION.md")
if not os.path.isfile(spec_path):
  errors.append("Missing spec/SPECIFICATION.md")

schema_path = os.path.join(repo_root, "schemas", "governance.schema.json")
if not os.path.isfile(schema_path):
  errors.append("Missing schema: schemas/governance.schema.json")

manifest_path = os.path.join(repo_root, "manifest.json")
if not os.path.isfile(manifest_path):
  errors.append("Missing manifest.json")

tasks_path = os.path.join(repo_root, ".vscode", "tasks.json")
if not os.path.isfile(tasks_path):
  errors.append("Missing .vscode/tasks.json")
else:
  try:
    with open(tasks_path, "r", encoding="utf-8") as f:
      tasks_json = json.load(f)
    labels = [t.get("label") for t in tasks_json.get("tasks", [])]
    required_tasks = [
      "Governance Preflight",
      "Governance Init Repository",
      "Governance Policy Validate",
      "Governance Git Init",
      "Governance Wiki Sync",
      "Governance Self-Audit",
      "Governance Bootstrap",
      "Governance Bootstrap (Defaults)",
      "Governance Policy Revision",
      "Set Autonomy Policy",
      "Set Workflow Mode",
      "Start Spec Implementation",
      "Governance Report Bundle",
    ]
    for label in required_tasks:
      if label not in labels:
        errors.append(f"Missing VS Code task: {label}")
  except Exception:
    errors.append("Failed to parse .vscode/tasks.json")

if os.path.isfile(policy_config):
  try:
    with open(policy_config, "r", encoding="utf-8-sig") as f:
      policy = json.load(f)
    required_keys = [
      "version", "policyGeneratedBy", "bootstrap", "versionControl", "testing",
      "documentation", "language", "autonomy", "phases", "ciCdEnforced", "remoteRequired",
    ]
    for key in required_keys:
      if key not in policy:
        errors.append(f"Missing policy key: {key}")
  except Exception:
    errors.append("Failed to parse governance.config.json")

scripts_dir = os.path.join(repo_root, "scripts")
if os.path.isdir(scripts_dir):
  ps1 = {os.path.splitext(f)[0] for f in os.listdir(scripts_dir) if f.endswith(".ps1")}
  sh = {os.path.splitext(f)[0] for f in os.listdir(scripts_dir) if f.endswith(".sh")}
  for name in sorted(ps1):
    if name not in sh:
      errors.append(f"Missing .sh counterpart for scripts/{name}.ps1")
  for name in sorted(sh):
    if name not in ps1:
      errors.append(f"Missing .ps1 counterpart for scripts/{name}.sh")

report = {
  "timestamp": datetime.utcnow().isoformat() + "Z",
  "ok": len(errors) == 0,
  "errors": errors,
  "warnings": warnings,
}

with open(output_path, "w", encoding="utf-8") as f:
  json.dump(report, f, indent=2)

if errors:
  log = {
    "timestamp": datetime.utcnow().isoformat() + "Z",
    "level": "error",
    "message": "selfaudit.failed",
    "data": {"output": output_path, "errors": errors},
  }
  sys.stdout.write(json.dumps(log) + "\n")
  sys.stderr.write(f"Self-audit failed. See {output_path}\n")
  sys.exit(1)

log = {
  "timestamp": datetime.utcnow().isoformat() + "Z",
  "level": "info",
  "message": "selfaudit.passed",
  "data": {"output": output_path},
}
sys.stdout.write(json.dumps(log) + "\n")
print(f"Self-audit passed. Report written to {output_path}")
PY
