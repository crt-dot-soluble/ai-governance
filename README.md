# AI Governance Repository (Human Readable)


> **⚠️ AI AGENTS MUST IGNORE THIS FILE ⚠️**
> This README is for humans only. All authoritative AI instructions are in:
> - `.github/copilot-instructions.md`
> - `/.ai/*`
> If instructions here conflict with AI governance files, THIS FILE IS WRONG.

---

- [Preferred Quickstart: Automated Setup](#preferred-quickstart-automated-setup)
- [Alternative: Manual Copy/Paste Fallback](#alternative-manual-copypaste-fallback)
- [VS Code Tasks Reference](#vs-code-tasks-reference)
- [What This Repository Is](#what-this-repository-is)
- [Updating or Reusing This System](#updating-or-reusing-this-system)
- [Files Humans Should Care About](#files-humans-should-care-about)
- [Final Note](#final-note)

---


## Preferred Quickstart: Automated Setup

**This is the recommended and fastest onboarding method.**

1. **Create and enter your new project folder:**
  ```bash
  mkdir my-app
  cd my-app
  ```
2. **Scaffold governance structure:**
  - PowerShell:
    ```powershell
    irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex
    ```
  - Bash:
    ```bash
    curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash
    ```
3. **Place your SPECIFICATION.md in the `spec` folder:**
  ```bash
  cp ../MY-APP.md ./spec/SPECIFICATION.md
  ```
4. **Open the project in VS Code**
5. **Run VS Code tasks in this order:**
  - Governance Preflight *(optional, recommended)*
  - Governance Bootstrap *(required)*
  - Start Spec Implementation *(required)*
  - Governance Policy Revision / Set Autonomy Policy / Set Workflow Mode *(as needed)*

---

## Alternative: Manual Copy/Paste Fallback

**Use this only if the automated quickstart does not work.**

1. Create or Fork a New GitHub Repository
2. Upload or Push This Repo as the Root
3. Clone It Locally:
  ```bash
  git clone <your-repo-url>
  cd <your-repo>
  ```
4. Delete This README (after cloning)
5. Start Building Your Project:
  - Add your project code
  - Add machine-readable specs (OpenAPI, schemas, etc.)
  - **Do NOT modify governance files**
  - Use templates in /templates when creating root NAME.md files
  - Add planning docs under /plans and implementation specs under /spec

---

## VS Code Tasks Reference

| Task                                   | Description                                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|
| Governance Preflight                   | Checks for required tools (git, python, etc.) before any governance action. |
| Governance Bootstrap                   | Runs the main governance bootstrap process (customize or accept defaults).  |
| Governance Policy Revision             | Allows updating governance policy interactively.                            |
| Set Autonomy Policy                    | Lets you change the autonomy/feedback stop contract.                        |
| Set Workflow Mode                      | Lets you change the version control workflow mode.                          |
| Start Spec Implementation              | Begins the implementation phase after governance bootstrap.                 |
| Activate ARCHITECT/GIT/DEBUG/... Agent | Echoes which agent is active and points to the relevant agent spec.         |

---

## What This Repository Is

This repository is a **drop-in, cloneable governance layer** for AI-driven software development.

| Feature | Description |
|---------|-------------|
| Supreme Copilot instruction file | `.github/copilot-instructions.md` |
| Deterministic agent roles | architect, git, debug, implementer, tester, refactor |
| Automatic agent selection | Self-identification and role enforcement |
| Persistent machine memory | Ledgers for memory and TODOs |
| CI enforcement | Prevents drift from governance policy |
| Template system | For root governance files and spec/plan docs |

This repo contains **no application code** by design.

---

## Updating or Reusing This System

To use this system in another project:
- [ ] Clone this repo
- [ ] Rename it
- [ ] Push to a new GitHub repo
- [ ] Start coding

This repo is intentionally stack-agnostic.

---

## Files Humans Should Care About

| File | Purpose |
|------|---------|
| README.md | This file (human onboarding) |
| CHANGELOG.md | Release tracking |

Everything else is **for machines**.

---

## Final Note

> This repository functions as an **AI operating system layer**.
>
> Treat it as infrastructure, not documentation.

---
