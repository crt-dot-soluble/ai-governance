#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_PATH="${1:-$REPO_ROOT/.vscode/report-bundle.zip}"

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
  log_json "error" "Python required for report-bundle" "{}"
  echo "Python is required for report-bundle.sh (python3 or python)." >&2
  exit 1
fi

FILES=("$REPO_ROOT/.vscode/audit.json" "$REPO_ROOT/.vscode/tooling.json" "$REPO_ROOT/governance.config.json" "$REPO_ROOT/spec/SPECIFICATION.md")
for f in "${FILES[@]}"; do
  if [ ! -f "$f" ]; then
    log_json "error" "Missing report input" "{\"path\":\"$f\"}"
    echo "Missing report input: $f" >&2
    exit 1
  fi
done

mkdir -p "$(dirname "$OUTPUT_PATH")"
rm -f "$OUTPUT_PATH"

log_json "info" "Creating report bundle" "{\"output\":\"$OUTPUT_PATH\"}"
REPO_ROOT="$REPO_ROOT" OUTPUT_PATH="$OUTPUT_PATH" FILES_JSON='[]' "$PYTHON_BIN" - <<'PY'
import json, os, sys, zipfile
repo_root = os.environ.get("REPO_ROOT")
output_path = os.environ.get("OUTPUT_PATH")
files = [
  os.path.join(repo_root, ".vscode", "audit.json"),
  os.path.join(repo_root, ".vscode", "tooling.json"),
  os.path.join(repo_root, "governance.config.json"),
  os.path.join(repo_root, "spec", "SPECIFICATION.md"),
]
with zipfile.ZipFile(output_path, "w", compression=zipfile.ZIP_DEFLATED) as zf:
  for f in files:
    arc = os.path.relpath(f, repo_root)
    zf.write(f, arc)
PY
log_json "info" "Report bundle created" "{\"output\":\"$OUTPUT_PATH\"}"
