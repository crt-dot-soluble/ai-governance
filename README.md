# AI Governance Repository (Human Readable)

> **⚠️ AI AGENTS MUST IGNORE THIS FILE ⚠️**
> This README is for humans only. All authoritative AI instructions are in:
> - `.github/copilot-instructions.md`
> - `/.ai/*`
> If instructions here conflict with AI governance files, THIS FILE IS WRONG.
>
> ---

---

## Table of Contents
- [Project Setup Order](#project-setup-order-recommended)
- [Quickstart Commands](#quickstart-commands)
- [VS Code Tasks (Reference)](#vs-code-tasks-reference)
- [Example Workflow](#example-workflow)
- [Manual Copy/Paste Method](#fallback-manual-copypaste-method)
- [What This Repository Is](#what-this-repository-is)
- [Updating or Reusing This System](#updating-or-reusing-this-system)
- [Files Humans Should Care About](#files-humans-should-care-about)
- [Final Note](#final-note)

---

## Project Setup Order (Recommended)

| Step | Action |
|------|--------|
| ☑️ 1 | **Create and enter your new project folder:**<br> <pre>mkdir my-app
cd my-app</pre> |
| ☑️ 2 | **Scaffold governance structure:**<br> <b>PowerShell:</b> <pre>irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex</pre><b>Bash:</b> <pre>curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash</pre> |
| ☑️ 3 | **Place your SPECIFICATION.md in the `spec` folder:**<br> <pre>cp ../MY-APP.md ./spec/SPECIFICATION.md</pre> |
| ☑️ 4 | **Open the project in VS Code.** |
| ☑️ 5 | **Run VS Code tasks in this order:**<br> <ul><li><b>Governance Preflight</b> <span style="color:gray">(optional, recommended)</span></li><li><b>Governance Bootstrap</b></li><li><b>Start Spec Implementation</b></li><li><b>Governance Policy Revision</b> / <b>Set Autonomy Policy</b> / <b>Set Workflow Mode</b> <span style="color:gray">(as needed)</span></li></ul> |

---

## Quickstart Commands

> **Run these inside your project folder:**
>
> **PowerShell:**
> ```powershell
> irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex
> ```
>
> **Bash:**
> ```bash
> curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash
> ```
>
> - Copies all required governance files/folders into your current folder
> - Creates an empty `spec` folder
> - **You must manually place your `SPECIFICATION.md` in the `spec` folder after running the script**
> - Result: ready-to-use VS Code project, no manual cleanup needed

---

## VS Code Tasks (Reference)

| Task | Description |
|------|-------------|
| **Governance Preflight** | Checks for required tools (git, python, etc.) before any governance operation. |
| **Governance Bootstrap** | Runs the main governance bootstrap process (lets you customize or accept defaults as prompted). |
| **Governance Policy Revision** | Allows updating governance policy interactively. |
| **Set Autonomy Policy** | Lets you change the autonomy/feedback stop contract. |
| **Set Workflow Mode** | Lets you change the version control workflow mode. |
| **Start Spec Implementation** | Begins the implementation phase after governance bootstrap. |
| **Activate ARCHITECT/GIT/DEBUG/IMPLEMENTER/TESTER/REFACTOR Agent** | Echoes which agent is active and points to the relevant agent spec. |

---

## Example Workflow

```bash
mkdir my-app
cd my-app
irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex
# or for Bash:
curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash
# Then manually copy your SPECIFICATION.md into the spec folder
cp ../MY-APP.md ./spec/SPECIFICATION.md
```

> This scaffolds the full governance structure in your current folder. Place your spec at `spec/SPECIFICATION.md`.

---

## Fallback: Manual Copy/Paste Method

If you cannot use the quick bootstrap scripts, you can still use this system by copying the repo contents manually:

- [ ] **Create or Fork a New GitHub Repository**
- [ ] **Upload or Push This Repo as the Root**
- [ ] **Clone It Locally**
  ```bash
  git clone <your-repo-url>
  cd <your-repo>
  ```
- [ ] **Delete This README** (after cloning)
- [ ] **Start Building Your Project**
  - Add your project code
  - Add machine-readable specs (OpenAPI, schemas, etc.)
  - Do NOT modify governance files
  - Use templates in /templates when creating root NAME.md files
  - Add planning docs under /plans and implementation specs under /spec

VS Code + GitHub Copilot will automatically:
- Load `.github/copilot-instructions.md`
- Infer agent roles
- Enforce agent declarations

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
| `README.md` | This file (human onboarding) |
| `CHANGELOG.md` | Release tracking |

Everything else is **for machines**.

---

## Final Note

> This repository functions as an **AI operating system layer**.
>
> Treat it as infrastructure, not documentation.

---
