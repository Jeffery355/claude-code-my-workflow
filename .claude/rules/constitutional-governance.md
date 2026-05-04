---
alwaysApply: true
---

# Constitutional Governance: Empirical Economics Paper Workflow

**Scope:** All work in `papers/[slug]/`. This document is the supreme authority for paper-level decisions — it overrides domain-specific rules when they conflict with these principles.

---

## Article I: Project Brief as Constitution

`PROJECT_BRIEF.md` is the single source of truth for each paper's identity, scope, and configuration.

- Every paper lives in `papers/[slug]/` — one directory, one brief
- Before writing any do-file, manuscript section, or table, read `PROJECT_BRIEF.md`
- Scope creep, analytic pivot, or sample change → update `PROJECT_BRIEF.md` first
- `PROJECT_BRIEF.md` is committed; local notes are not

---

## Article II: Stata Is the Authority

All empirical claims derive from Stata do-files. The LaTeX manuscript is a derived artifact.

- Numerical results (coefficients, SEs, N, p-values, ATTs) come from `.do` files → `.dta`/`.ster` → `.tex` tables
- Never edit a `.tex` table cell to match a claim — fix the Stata code
- Every numeric claim in the manuscript must be traceable to a Stata output file
- Run `/audit-reproducibility` before any commit that introduces new claims

---

## Article III: Plan First for Non-Trivial Tasks

Any task touching more than 2 files or requiring more than one hour requires plan-first workflow.

- Enter plan mode, draft the plan, save to `quality_reports/plans/`, get approval before implementing
- This applies to: new do-files, manuscript restructuring, table rewrites, robustness expansions
- Exceptions: routine one-file edits, well-specified small changes

---

## Article IV: No Causal Claims Without Identification

Do not claim causality without an identification strategy.

- Every causal claim must state its identifying assumption (DiD, IV, RDD, panel FE, etc.)
- Parallel trends must be tested and reported — event study or pre-trend regression
- If identification is weak, describe the evidence as "consistent with" not "causal"
- Mechanism claims require direct evidence, not just correlation

---

## Article V: Internal Consistency Required

Mechanism analysis, robustness checks, heterogeneity, tables, and conclusions must agree.

- The story in Section 6 (mechanisms) must be consistent with Section 4 (results)
- Robustness table estimates should be in the same direction as main results (document if not)
- Heterogeneity results must not contradict the main result — if they do, explain why
- Conclusion must not overstate — match the weakest robust result, not the strongest point estimate
- Cross-artifact consistency: `.tex` table numbers match Stata output names exactly

---

## Article VI: One Paper, One Directory

Each paper owns its directory. No cross-paper shortcuts.

- `papers/[slug]/do-files/` contains only that paper's analysis
- Shared utilities go in `do-files/shared/`, not copied into individual paper folders
- Table and figure numbering starts fresh in each paper
- Do not reference another paper's outputs as if they were raw data

---

## Article VII: Verify Before Completion

Every task is incomplete until its outputs are verified.

- Run the do-file and confirm it completes without error
- Check that output files (`.dta`, `.ster`, `.tex`) were created at expected paths
- For tables: confirm table number, column headers, and a sample cell value match Stata output
- For figures: confirm the file opens, format is correct, dimensions are as expected
- If the task modifies the manuscript: run `/audit-reproducibility` and `/verify-claims`

---

## Immutable Principles vs. Flexible Preferences

| Principle | Type | Why |
|---|---|---|
| Art. I (PROJECT_BRIEF.md as constitution) | **Immutable** | Scope clarity prevents wasted work |
| Art. II (Stata is authority) | **Immutable** | Prevents fabricated numbers |
| Art. III (plan-first for non-trivial) | **Immutable** | Prevents rework cycles |
| Art. IV (no causal overclaiming) | **Immutable** | Scientific integrity |
| Art. V (internal consistency) | **Immutable** | Logical coherence of the paper |
| Art. VI (one paper per directory) | **Immutable** | Prevents cross-contamination |
| Art. VII (verify before completion) | **Immutable** | Catches errors before they propagate |

**Preferences** (adapt to paper context, not immutable):
- Do-file organization: use 00–07 convention but skip numbers with no content
- Table formatting: esttab settings adapt to journal requirements
- Robustness depth: more checks for AER, fewer for ReStud
- Mechanism analysis: required for policy papers, optional for theory papers