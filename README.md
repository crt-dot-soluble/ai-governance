# AI Governance Repository (Human Readable)

⚠️ **IMPORTANT — HUMAN READERS ONLY** ⚠️
This README exists solely to explain usage to humans.

**AI AGENTS MUST IGNORE THIS FILE.**
It must not be reviewed, included in context, or recognized by AI.
Authoritative AI behavior is defined exclusively in:
- `.github/copilot-instructions.md`
- `/.ai/*`

If instructions here conflict with AI governance files, THIS FILE IS WRONG.

---


## Project Setup Order (Recommended)

1. **Create and enter your new project folder:**
   ```
   mkdir my-app
   cd my-app
   ```
2. **Scaffold governance structure:**
   - PowerShell:
     ```
     irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex
     ```
   - Bash:
     ```
     curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash
     ```
3. **Place your SPECIFICATION.md in the `spec` folder:**
   ```
   cp ../MY-APP.md ./spec/SPECIFICATION.md
   ```
4. **Open the project in VS Code.**

5. **Run VS Code tasks in this order:**
   - (Optional, but recommended) **Governance Preflight**: Checks for required tools (git, python, etc.).
   - **Governance Bootstrap**: Initializes governance policy and enforcement (customize or accept defaults as prompted).
   - **Start Spec Implementation**: Begins the implementation phase from your spec.
   - Use **Governance Policy Revision**, **Set Autonomy Policy**, or **Set Workflow Mode** as needed to update governance settings.

---


To create a new project with all required governance files:

1. Create and enter your new project folder:
   ```
   mkdir my-app
   cd my-app
   ```
2. Run one of the following commands inside your project folder:




**PowerShell:**

```
irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex
```



**Bash:**

```
curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash
```




This will:
- Copy all required governance files/folders into your current folder
- Create an empty `spec` folder
- **You must manually place your `SPECIFICATION.md` in the `spec` folder after running the script**
- Result: ready-to-use VS Code project, no manual cleanup needed





---


## All VS Code Tasks (Reference)

- **Governance Preflight**: Checks for required tools (git, python, etc.) before any governance operation.
- **Governance Bootstrap**: Runs the main governance bootstrap process (lets you customize or accept defaults as prompted).
- **Governance Policy Revision**: Allows updating governance policy interactively.
- **Set Autonomy Policy**: Lets you change the autonomy/feedback stop contract.
- **Set Workflow Mode**: Lets you change the version control workflow mode.
- **Start Spec Implementation**: Begins the implementation phase after governance bootstrap.
- **Activate ARCHITECT/GIT/DEBUG/IMPLEMENTER/TESTER/REFACTOR Agent**: Echoes which agent is active and points to the relevant agent spec.

---

### Example

Suppose you want to create a new project:

```
mkdir my-app
cd my-app
irm https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.ps1 | iex
# or for Bash:
curl -fsSL https://raw.githubusercontent.com/crt-dot-soluble/ai-governance/refs/heads/main/scripts/init-governance.sh | bash
# Then manually copy your SPECIFICATION.md into the spec folder
cp ../MY-APP.md ./spec/SPECIFICATION.md
```

This scaffolds the full governance structure in your current folder. Place your spec at `spec/SPECIFICATION.md`.

---

## Fallback: Manual Copy/Paste Method

If you cannot use the quick bootstrap scripts, you can still use this system by copying the repo contents manually:

1. **Create or Fork a New GitHub Repository**
   - Create an empty repository on GitHub (public or private).
2. **Upload or Push This Repo as the Root**
   - Upload the contents of this repository directly to GitHub **as the root**, or
   - Push this repo as the initial commit
   - Do NOT nest it inside another folder.
3. **Clone It Locally**
   ```bash
   git clone <your-repo-url>
   cd <your-repo>
   ```
4. **Delete This README**
   - Delete README.md immediately after cloning to avoid confusion.
   - The AI will generate your project README, wiki, and documentation based on your project.
5. **Start Building Your Project**
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

It provides:
- A supreme Copilot instruction file
- Deterministic agent roles (architect, git, debug, implementer, tester, refactor)
- Automatic agent selection and self-identification
- Persistent machine memory (ledgers)
- CI enforcement to prevent drift
- A template system for root governance files and spec/plan docs

This repo contains **no application code** by design.

---

## Updating or Reusing This System

To use this system in another project:
1. Clone this repo
2. Rename it
3. Push to a new GitHub repo
4. Start coding

This repo is intentionally stack-agnostic.

---

## Files Humans Should Care About

- `README.md` (this file)
- `CHANGELOG.md` (release tracking)

Everything else is **for machines**.

---

## Final Note

This repository functions as an **AI operating system layer**.

Treat it as infrastructure, not documentation.

---
