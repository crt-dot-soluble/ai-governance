# VS Code Tasks

All bounded decisions are made through VS Code Tasks.

## Governance Bootstrap
Runs the bootstrap process and creates the policy file.

## Governance Bootstrap (Defaults)
Runs bootstrap in defaults mode without prompting for additional options.

## Governance Preflight
Detects installed tools and writes a report to .vscode/tooling.json. Bootstrap and policy tasks depend on this preflight step.

## Governance Policy Revision
Updates policy values using native pickers.

## Set Autonomy Policy
Updates the autonomy/stop contract.

## Set Workflow Mode
Updates version control policy (git local/remote/ci).

## Start Spec Implementation
Verifies governance policy and spec exist, then signals that implementation can begin from spec/SPECIFICATION.md.

## Input Rules
- Use pickers for predefined options.
- Text input is reserved for large code payloads or explicit human intervention due to roadblocks.
