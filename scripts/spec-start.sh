#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
POLICY_PATH="$REPO_ROOT/governance.config.json"
SPEC_PATH="$REPO_ROOT/spec/SPECIFICATION.md"

if [ ! -f "$POLICY_PATH" ]; then
  echo "Missing governance.config.json. Run the Governance Bootstrap task first." >&2
  exit 1
fi

if [ ! -f "$SPEC_PATH" ]; then
  echo "Missing spec/SPECIFICATION.md. Create it before starting from spec." >&2
  exit 1
fi

echo "Spec execution can begin. Follow spec/SPECIFICATION.md using the active governance policy."
