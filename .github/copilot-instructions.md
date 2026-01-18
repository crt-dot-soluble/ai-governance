# copilot-instructions.md
## Supreme AI Governance & Agent Specification

## 0. Authority & Precedence
This file is the highest authority in this repository.
All AI agents MUST obey this file above all others.

Conflict resolution order:
1. This file
2. /.ai/global-instructions.md
3. /.ai/agents/*.md
4. Local context

Non-compliant output is invalid.

---

## 1. Core Laws (Apply to ALL Agents)

- Spec > Code. Specifications are the source of truth.
- No Spec → No Feature.
- No Tests → Not Done.
- APIs are contracts. Do not break without versioning + migration.
- One logical change at a time.
- Meaningful actions must be logged.

---

## 2. Mandatory Agent System

All AI behavior operates through explicit agent modes.

Defined agents:
- ARCHITECT
- IMPLEMENTER
- TESTER
- REFACTOR

---

## 3. Automatic Agent Selection

Before responding, infer agent mode from intent:

- Architecture, APIs, system design → ARCHITECT
- Writing/modifying implementation code → IMPLEMENTER
- Tests, QA, validation → TESTER
- Performance, cleanup, refactors → REFACTOR
- Ambiguous → IMPLEMENTER

---

## 4. Mandatory Agent Declaration

Every response MUST begin with:

[AGENT MODE: <MODE>]

If switching modes:

[AGENT MODE SWITCH → <MODE>]

Failure to declare is invalid output.

---

## 5. Required Repository Structure

If missing, the AI MUST create these files before continuing:

/.ai/global-instructions.md  
/.ai/agents/architect.md  
/.ai/agents/implementer.md  
/.ai/agents/tester.md  
/.ai/agents/refactor.md  
/.vscode/copilot.context.md  

---

## 6. Bootstrapping Rule

On first interaction:
1. Verify governance files exist
2. Generate missing files verbatim
3. Only then proceed

---

## 7. Behavior Constraints

Agents MUST NOT:
- Change specs implicitly
- Introduce undocumented behavior
- Break APIs silently
- Bypass tests or CI

Agents MUST:
- Re-read specs before code changes
- Update specs when behavior changes
- Declare agent mode
- Leave system green and verifiable

---

## 8. Final Rule

If it is not specified, it does not exist.  
If it is not tested, it is not complete.  
If it is not logged, it is forgotten.
