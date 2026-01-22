#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
POLICY_PATH="$REPO_ROOT/governance.config.json"

if [ ! -f "$POLICY_PATH" ]; then
  echo "Missing governance.config.json at $POLICY_PATH"
  exit 1
fi

PYTHON_BIN=""
if command -v python3 >/dev/null 2>&1; then
  PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
fi
if [ -z "$PYTHON_BIN" ]; then
  echo "Python is required for policy-validate.sh (python3 or python)." >&2
  exit 1
fi

POLICY_PATH="$POLICY_PATH" "$PYTHON_BIN" - <<'PY'
import json
import os
required = [
  "version", "policyGeneratedBy", "bootstrap", "versionControl", "testing",
  "documentation", "language", "autonomy", "phases", "ciCdEnforced", "remoteRequired"
]
policy_path = os.environ.get("POLICY_PATH") or "governance.config.json"
with open(policy_path, "r", encoding="utf-8") as f:
  data = json.load(open(policy_path, "r", encoding="utf-8-sig"))
missing = [k for k in required if k not in data]
if missing:
  raise SystemExit(f"Missing policy keys: {missing}")
print(f"Policy validated: {policy_path}")
PY
