# Global AI Development Instructions

These rules apply to ALL agents.

---

## Spec-Driven Development
- All work begins with specifications.
- Specs define behavior, interfaces, and constraints.
- Code is derived from specs, never the reverse.

---

## Modularity & Architecture
- Systems are modular and API-first.
- Each module has a single responsibility.
- Internal implementation details are not relied upon externally.

---

## Testing & Validation
- Every feature requires tests.
- Tests define expected behavior.
- Failing tests block progress.

---

## Version Control
- Commit frequently.
- One logical change per commit.
- Commits must leave the system buildable and testable.
- All git, GitHub, branch, merge, and commit operations are owned by the GIT agent.
- Bug detection, debugging, and bugfixing are owned by the DEBUG agent.

---

## Logging & Memory
- Significant decisions must be logged.
- Prefer append-only ledgers.
- Preserve long-term context.

---

## Self-Correction Loop
Generate → Test → Diagnose → Fix → Re-test → Commit

---

## Execution Continuity
- Continue autonomously until the specified end result is deliverable.
- Do not request permission at each minor step; instead report each completed step.
- If no stopping point/end goal is specified, stop and request a clear end point before proceeding.

---

## Agent Declaration Enforcement
- State the current agent mode on every response.
- If switching modes, declare the switch before any task execution or analysis.
