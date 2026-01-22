#!/usr/bin/env bash
set -euo pipefail

VERSION_CONTROL="${1:-}"
TESTING="${2:-}"
DOCUMENTATION="${3:-}"
LANGUAGE="${4:-}"
FRAMEWORKS="${5:-}"
AUTONOMY="${6:-}"

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
  echo "Python is required for policy-update.sh (python3 or python)." >&2
  exit 1
fi

POLICY_PATH="$POLICY_PATH" VERSION_CONTROL="$VERSION_CONTROL" TESTING="$TESTING" DOCUMENTATION="$DOCUMENTATION" LANGUAGE="$LANGUAGE" FRAMEWORKS="$FRAMEWORKS" AUTONOMY="$AUTONOMY" "$PYTHON_BIN" - <<'PY'
import json
import os

version_control = os.environ.get("VERSION_CONTROL", "")
testing = os.environ.get("TESTING", "")
documentation = os.environ.get("DOCUMENTATION", "")
language = os.environ.get("LANGUAGE", "")
frameworks = os.environ.get("FRAMEWORKS", "")
autonomy = os.environ.get("AUTONOMY", "")

allowed_version_control = {"git-local", "git-remote", "git-remote-ci"}
allowed_testing = {"full", "baseline"}
allowed_documentation = {"inline", "comments-only", "generate"}
allowed_autonomy = {"feature", "milestone", "fully-autonomous"}

policy_path = os.environ.get("POLICY_PATH") or "governance.config.json"
with open(policy_path, "r", encoding="utf-8") as f:
  policy = json.load(f)

if version_control:
  if version_control not in allowed_version_control:
    raise SystemExit("Invalid VersionControl")
  policy["versionControl"] = version_control
  policy["remoteRequired"] = version_control != "git-local"

if testing:
  if testing not in allowed_testing:
    raise SystemExit("Invalid Testing")
  policy["testing"] = testing

if documentation:
  if documentation not in allowed_documentation:
    raise SystemExit("Invalid Documentation")
  policy["documentation"] = documentation

if language:
  policy["language"]["primary"] = language

if frameworks:
  if frameworks == "None":
    policy["language"]["frameworks"] = []
  else:
    policy["language"]["frameworks"] = [f.strip() for f in frameworks.split(",") if f.strip()]

if autonomy:
  if autonomy not in allowed_autonomy:
    raise SystemExit("Invalid Autonomy")
  policy["autonomy"] = autonomy

with open(policy_path, "w", encoding="utf-8") as f:
  json.dump(policy, f, indent=2)

print(f"Updated governance policy at {policy_path}")
PY
