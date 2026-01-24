#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

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
  echo "Python is required for bootstrap.sh (python3 or python)." >&2
  exit 1
fi

MODE="${1:-}"
VERSION_CONTROL="${2:-}"
TESTING="${3:-}"
DOCUMENTATION="${4:-}"
LANGUAGE="${5:-}"
FRAMEWORKS="${6:-}"
AUTONOMY="${7:-}"

log_json "info" "bootstrap.start" "{\"mode\":\"$MODE\"}"

if [ -z "$MODE" ]; then
  log_json "error" "bootstrap.missing_mode" "{}"
  echo "Missing bootstrap mode. Re-run the Governance Bootstrap task and select a mode." >&2
  exit 1
fi

if [ "$MODE" != "defaults" ] && [ "$MODE" != "customize" ]; then
  echo "Invalid Mode" >&2
  exit 1
fi

if [ "$MODE" != "customize" ]; then
  VERSION_CONTROL="git-remote-ci"
  TESTING="full"
  DOCUMENTATION="inline"
  LANGUAGE="unspecified"
  FRAMEWORKS=""
  AUTONOMY="feature"
else
  if [ -z "$VERSION_CONTROL" ] || [ -z "$TESTING" ] || [ -z "$DOCUMENTATION" ] || [ -z "$LANGUAGE" ] || [ -z "$AUTONOMY" ]; then
    echo "Missing bootstrap inputs. Re-run the Governance Bootstrap task and complete all pickers." >&2
    exit 1
  fi
fi

case "$VERSION_CONTROL" in
  git-local|git-remote|git-remote-ci) ;;
  *) echo "Invalid VersionControl" >&2; exit 1 ;;
esac

case "$TESTING" in
  full|baseline) ;;
  *) echo "Invalid Testing" >&2; exit 1 ;;
esac

case "$DOCUMENTATION" in
  inline|comments-only|generate) ;;
  *) echo "Invalid Documentation" >&2; exit 1 ;;
esac

case "$AUTONOMY" in
  feature|milestone|fully-autonomous) ;;
  *) echo "Invalid Autonomy" >&2; exit 1 ;;
esac

if [ "$FRAMEWORKS" = "None" ]; then
  FRAMEWORKS=""
fi

if [ -f "${REPO_ROOT}/README.md" ]; then
  if grep -q "AI AGENTS MUST IGNORE THIS FILE" "${REPO_ROOT}/README.md"; then
    rm -f "${REPO_ROOT}/README.md"
    echo "Removed default README.md"
  fi
fi

SPEC_PATH="${REPO_ROOT}/spec/SPECIFICATION.md"
if [ ! -f "$SPEC_PATH" ]; then
  log_json "error" "bootstrap.missing_spec" "{\"path\":\"$SPEC_PATH\"}"
  echo "Missing spec/SPECIFICATION.md. Create it before running bootstrap." >&2
  exit 1
fi

MODE="$MODE" VERSION_CONTROL="$VERSION_CONTROL" TESTING="$TESTING" DOCUMENTATION="$DOCUMENTATION" LANGUAGE="$LANGUAGE" FRAMEWORKS="$FRAMEWORKS" AUTONOMY="$AUTONOMY" REPO_ROOT="$REPO_ROOT" "$PYTHON_BIN" - <<'PY'
import json, os, datetime
mode = os.environ.get("MODE")
version_control = os.environ.get("VERSION_CONTROL")
testing = os.environ.get("TESTING")
documentation = os.environ.get("DOCUMENTATION")
language = os.environ.get("LANGUAGE")
frameworks = os.environ.get("FRAMEWORKS", "")
autonomy = os.environ.get("AUTONOMY")

policy = {
  "version": "1.0.0",
  "policyGeneratedBy": "bootstrap",
  "bootstrap": {
    "mode": mode,
    "skipped": mode != "customize",
    "timestamp": datetime.date.today().isoformat()
  },
  "versionControl": version_control,
  "testing": testing,
  "documentation": documentation,
  "language": {
    "primary": language,
    "frameworks": [f.strip() for f in frameworks.split(",") if f.strip()]
  },
  "autonomy": autonomy,
  "phases": {"required": True, "list": [0,1,2,3,4,5]},
  "ciCdEnforced": True,
  "remoteRequired": version_control != "git-local"
}

repo_root = os.environ.get("REPO_ROOT") or os.getcwd()
with open(os.path.join(repo_root, "governance.config.json"), "w", encoding="utf-8") as f:
  json.dump(policy, f, indent=2)

print("Wrote governance policy to governance.config.json")
PY

log_json "info" "bootstrap.policy_written" "{\"path\":\"$REPO_ROOT/governance.config.json\"}"
