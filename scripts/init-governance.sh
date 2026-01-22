#!/usr/bin/env bash
set -euo pipefail


# No arguments required. Only scaffolds governance structure in current directory.
TARGET_ROOT="$PWD"

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

echo "Initialized governance repository at $TARGET_ROOT.\n\nPlease manually place your SPECIFICATION.md in the 'spec' folder."
