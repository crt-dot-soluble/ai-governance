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

## How To Use This (Exact Steps)

### 0. Delete This README
Delete README.md immediately after cloning to avoid confusion.
The AI will generate your project README, wiki, and documentation based on your project.

### 1. Create or Fork a New GitHub Repository
Create an empty repository on GitHub (public or private).

### 2. Upload or Push This Repo as the Root
Either:
- Upload the contents of this repository directly to GitHub **as the root**, or
- Push this repo as the initial commit

Do NOT nest it inside another folder.

### 3. Clone It Locally
```bash
git clone <your-repo-url>
cd <your-repo>
```

### 4. Start Building Your Project
Inside this repo:
- Add your project code
- Add machine-readable specs (OpenAPI, schemas, etc.)
- Do NOT modify governance files
 - Use templates in /templates when creating root NAME.md files
 - Add planning docs under /plans and implementation specs under /spec

VS Code + GitHub Copilot will automatically:
- Load `.github/copilot-instructions.md`
- Infer agent roles
- Enforce agent declarations

### 5. Work Normally — AI Is Now Governed
Open the repo in VS Code and start prompting Copilot.

Agent behavior is automatic:
- Architecture questions → ARCHITECT
- Git/GitHub workflows → GIT
- Debugging and bugfixes → DEBUG
- Code writing → IMPLEMENTER
- Tests → TESTER
- Cleanup → REFACTOR

Each AI response will declare its agent mode.

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
