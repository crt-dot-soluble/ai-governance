#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
POLICY_PATH="$REPO_ROOT/governance.config.json"
SCHEMA_PATH="$REPO_ROOT/schemas/governance.schema.json"

log_json() {
  local level="$1"; local message="$2"; local data="$3"
  printf '{"timestamp":"%s","level":"%s","message":"%s","data":%s}\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$level" "$message" "$data"
}

if [ ! -f "$POLICY_PATH" ]; then
  log_json "error" "policy.missing" "{\"path\":\"$POLICY_PATH\"}"
  echo "Missing governance.config.json at $POLICY_PATH"
  exit 1
fi

if [ ! -f "$SCHEMA_PATH" ]; then
  log_json "error" "schema.missing" "{\"path\":\"$SCHEMA_PATH\"}"
  echo "Missing schemas/governance.schema.json at $SCHEMA_PATH"
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

POLICY_PATH="$POLICY_PATH" SCHEMA_PATH="$SCHEMA_PATH" "$PYTHON_BIN" - <<'PY'
import json
import os

def validate(schema, data, path="$"):
  errors = []
  schema_type = schema.get("type")
  if schema_type == "object":
    if not isinstance(data, dict):
      return [f"{path} should be object"]
    for req in schema.get("required", []):
      if req not in data:
        errors.append(f"{path} missing required '{req}'")
    for key, subschema in schema.get("properties", {}).items():
      if key in data:
        errors.extend(validate(subschema, data[key], f"{path}.{key}"))
  elif schema_type == "array":
    if not isinstance(data, list):
      return [f"{path} should be array"]
    item_schema = schema.get("items")
    if item_schema:
      for i, item in enumerate(data):
        errors.extend(validate(item_schema, item, f"{path}[{i}]"))
  elif schema_type == "string":
    if not isinstance(data, str):
      errors.append(f"{path} should be string")
  elif schema_type == "boolean":
    if not isinstance(data, bool):
      errors.append(f"{path} should be boolean")
  elif schema_type == "integer":
    if not isinstance(data, int):
      errors.append(f"{path} should be integer")
  elif schema_type == "number":
    if not isinstance(data, (int, float)):
      errors.append(f"{path} should be number")
  if "enum" in schema and data not in schema["enum"]:
    errors.append(f"{path} must be one of {', '.join(schema['enum'])}")
  return errors

policy_path = os.environ.get("POLICY_PATH") or "governance.config.json"
schema_path = os.environ.get("SCHEMA_PATH") or "schemas/governance.schema.json"
with open(policy_path, "r", encoding="utf-8-sig") as f:
  data = json.load(f)
with open(schema_path, "r", encoding="utf-8-sig") as f:
  schema = json.load(f)

errors = validate(schema, data)
if errors:
  raise SystemExit("; ".join(errors))
print(f"Policy validated: {policy_path}")
PY
log_json "info" "policy.validation_ok" "{\"path\":\"$POLICY_PATH\",\"schema\":\"$SCHEMA_PATH\"}"
