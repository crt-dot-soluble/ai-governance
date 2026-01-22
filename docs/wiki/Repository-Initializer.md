# Repository Initializer (CLI)

Use the initializer to create a ready-to-use repository with the required AI governance files and structure.

## Scripts
- scripts/init-governance.ps1
- scripts/init-governance.sh

## Usage
Provide exactly one argument: the path to SPECIFICATION.md.
The filename **must** be SPECIFICATION.md.

The initializer:
- Creates the required governance structure
- Copies governance files (excluding any .git data)
- Places the provided SPECIFICATION.md at /spec/SPECIFICATION.md
- Aborts if the target already contains required files or directories

## Target Root Resolution
- If the provided SPECIFICATION.md is located under a spec/ folder, the target root is the parent of spec/
- Otherwise, the target root is the directory containing SPECIFICATION.md
