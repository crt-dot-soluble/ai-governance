#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /path/to/SPECIFICATION.md" >&2
  exit 1
fi

SPEC_PATH="$1"
SPEC_BASENAME="$(basename "$SPEC_PATH")"
if [ "$SPEC_BASENAME" != "SPECIFICATION.md" ]; then
  echo "Spec file must be named SPECIFICATION.md" >&2
  exit 1
fi

SPEC_DIR="$(cd "$(dirname "$SPEC_PATH")" && pwd)"
SPEC_FULL_PATH="${SPEC_DIR}/${SPEC_BASENAME}"
if [ ! -f "$SPEC_FULL_PATH" ]; then
  echo "Spec file not found: $SPEC_FULL_PATH" >&2
  exit 1
fi

if [ "$(basename "$SPEC_DIR")" = "spec" ]; then
  TARGET_ROOT="$(dirname "$SPEC_DIR")"
else
  TARGET_ROOT="$SPEC_DIR"
fi

mkdir -p "$TARGET_ROOT"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

required_dirs=(.ai .vscode scripts templates docs plans src spec .github)
for dir in "${required_dirs[@]}"; do
  if [ -e "$TARGET_ROOT/$dir" ]; then
    echo "Target already contains $dir at $TARGET_ROOT/$dir. Aborting to avoid overwrite." >&2
    exit 1
  fi
done

required_files=(CONSTITUTION.md CHANGELOG.md MEMORY-LEDGER.md TODO-LEDGER.md README.md governance.config.json)
for file in "${required_files[@]}"; do
  if [ -e "$TARGET_ROOT/$file" ]; then
    echo "Target already contains $file at $TARGET_ROOT/$file. Aborting to avoid overwrite." >&2
    exit 1
  fi
done

cp -R "$REPO_ROOT/.ai" "$TARGET_ROOT/.ai"
cp -R "$REPO_ROOT/.vscode" "$TARGET_ROOT/.vscode"
cp -R "$REPO_ROOT/scripts" "$TARGET_ROOT/scripts"
cp -R "$REPO_ROOT/templates" "$TARGET_ROOT/templates"
cp -R "$REPO_ROOT/docs" "$TARGET_ROOT/docs"
cp -R "$REPO_ROOT/plans" "$TARGET_ROOT/plans"
cp -R "$REPO_ROOT/src" "$TARGET_ROOT/src"
cp -R "$REPO_ROOT/.github" "$TARGET_ROOT/.github"

cp "$REPO_ROOT/templates/CONSTITUTION.md" "$TARGET_ROOT/CONSTITUTION.md"
cp "$REPO_ROOT/templates/CHANGELOG.md" "$TARGET_ROOT/CHANGELOG.md"
cp "$REPO_ROOT/templates/MEMORY-LEDGER.md" "$TARGET_ROOT/MEMORY-LEDGER.md"
cp "$REPO_ROOT/templates/TODO-LEDGER.md" "$TARGET_ROOT/TODO-LEDGER.md"
cp "$REPO_ROOT/templates/README.md" "$TARGET_ROOT/README.md"
cp "$REPO_ROOT/governance.config.json" "$TARGET_ROOT/governance.config.json"

mkdir -p "$TARGET_ROOT/spec"
cp "$SPEC_FULL_PATH" "$TARGET_ROOT/spec/SPECIFICATION.md"

echo "Initialized governance repository at $TARGET_ROOT"
