# Bootstrap Process

## Trigger Conditions
Bootstrap MUST run when:
- The repository contains only governance files, OR
- No governance policy file exists, OR
- The user explicitly requests bootstrap

## Required Entry Point
Use the VS Code Task: **Governance Bootstrap**.
All selections MUST use native pickers or yes/no confirmations.
Text input is reserved for large code payloads or explicit human intervention due to roadblocks.

## Modes
- **Skip Bootstrap (defaults)**: writes a policy mirroring defaults
- **Customize Governance**: interactive setup

## Output
Bootstrap generates exactly one policy artifact:
- governance.config.json (preferred), OR
- POLICY.md

## README Removal
Bootstrap removes the default README.md when it contains the AI-ignore marker.
