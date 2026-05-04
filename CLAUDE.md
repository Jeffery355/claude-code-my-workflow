# CLAUDE.MD — Academic Economics Research Template

**Project:** Reusable template for empirical economics papers
**Purpose:** Stata-based econometric analysis, journal-style manuscript writing, publication-ready tables/figures
**Branch:** main

---

## Core Principles

- **Plan first** — enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** — run `/audit-reproducibility` and verify every numeric claim before committing
- **Stata is source of truth** — all numerical results derive from Stata do-files; LaTeX manuscript is derived
- **Quality gates** — nothing ships below 80/100
- **[LEARN] tags** — save `[LEARN:category] wrong → right` to [MEMORY.md](MEMORY.md) when corrected

Cross-session context lives in [MEMORY.md](MEMORY.md); past plans and session logs in [quality_reports/](quality_reports/).

---

## Three-Layer Architecture

| Layer | Purpose | Location |
|---|---|---|
| **Global rules** | Standards for ALL economics projects | `.claude/rules/` |
| **Project configuration** | ONE file to configure a new paper | `PROJECT_BRIEF.md` (root) |
| **Reusable templates** | Manuscripts, tables, do-files, checklists | `templates/`, `do-files/shared/` |

See [NEW_ECON_PAPER_GUIDE.md](NEW_ECON_PAPER_GUIDE.md) for full onboarding.

---

## Folder Structure

```
[PROJECT]/
├── PROJECT_BRIEF.md              # ONE config file per paper
├── NEW_ECON_PAPER_GUIDE.md       # Onboarding guide
├── CLAUDE.md                     # This file
├── .claude/                      # Rules, skills, agents, hooks
├── Bibliography_base.bib         # Centralized bibliography
├── papers/                       # PRIMARY — one subdir per paper (see below)
│   └── [slug]/                   #   manuscript/, tables/, figures/, do-files/, logs/, outputs/
├── do-files/shared/              # Shared Stata utilities
├── templates/                    # Reusable templates
├── quality_reports/              # Plans, session logs, merge reports
├── Slides/                       # (preserved) Beamer lecture slides
├── Quarto/                       # (preserved) Quarto slide decks
└── explorations/                 # Research sandbox
```

Primary artifact for economics papers is `papers/[slug]/`.

---

## Essential Commands

```bash
# Stata pipeline
stata -b do papers/[slug]/do-files/00_master.do   # full pipeline
stata -b do papers/[slug]/do-files/03_regressions.do  # specific file

# LaTeX manuscript (3-pass)
cd papers/[slug]/manuscript && pdflatex [slug] && bibtex [slug] && pdflatex && pdflatex

# Quality checks
/audit-reproducibility papers/[slug]/manuscript/[slug].tex papers/[slug]/outputs/
/verify-claims papers/[slug]/manuscript/[slug].tex
```

---

## Quality Thresholds (advisory)

| Score | Checkpoint | Meaning |
|---|---|---|
| 80 | Commit | Good enough to save |
| 90 | PR | Ready for deployment |
| 95 | Excellence | Aspirational |

Enforced by `/commit` (halts + asks for override).

---

## Skills Quick Reference

| Command | What It Does |
|---|---|
| `/init-econ-paper` | Scaffold new paper from PROJECT_BRIEF.md |
| `/data-analysis --lang stata [goal]` | Stata analysis pipeline (default) |
| `/data-analysis --lang r [goal]` | R analysis pipeline |
| `/review-paper [file]` | Manuscript review (single / --adversarial / --peer) |
| `/seven-pass-review [file]` | Seven-pass adversarial manuscript review |
| `/audit-reproducibility [manuscript] [outputs]` | Cross-check numeric claims vs Stata output |
| `/verify-claims [file]` | Chain-of-Verification fact-check |
| `/respond-to-referees [report] [manuscript]` | R&R cross-reference + response draft |
| `/lit-review [topic]` | Literature search + synthesis |
| `/proofread [file]` | Grammar/typo/overflow review |
| `/slide-excellence [file]` | Combined multi-agent slide review |
| `/validate-bib` | Cross-reference citations |
| `/deploy [LectureN]` | Render Quarto + sync to docs/ |
| `/context-status` | Show session health + context usage |
| `/commit [msg]` | Stage, commit, PR, merge |

---

## Key Rules

Full details in `.claude/rules/`:

| Rule | Purpose |
|---|---|
| `econometrics-standards.md` | DiD, IV, RDD, panel FE; SE clustering; multiple testing |
| `stata-conventions.md` | Do-file organization (00–07), header boilerplate, log management |
| `manuscript-writing.md` | AER/QJE/JPE/ECMA paper structure; abstract framework |
| `single-source-of-truth.md` | Stata do-files are authoritative; LaTeX derives |
| `cross-artifact-review.md` | Stata ↔ LaTeX consistency; dependency graph |
| `literature-review-protocol.md` | Organize by mechanism, not by paper |
| `mechanism-analysis-protocol.md` | M→X→Y chain; direct measurement + interaction + falsification |
| `robustness-check-protocol.md` | Pre-registration, placebo tests, sensitivity analysis |
| `plan-first-workflow.md` | When to enter plan mode; spec-then-plan protocol |
| `meta-governance.md` | Working project vs. public template distinction |

---

## Stata Do-File Organization (Per Paper)

```
[slug]/do-files/
  00_master.do       # Sets globals, calls all do-files in order
  01_clean.do        # Data import, cleaning, variable construction
  02_descriptives.do # Summary statistics, balance tests
  03_regressions.do  # Main regressions (all specifications)
  04_tables.do       # esttab/outreg table generation
  05_figures.do      # Graph generation
  06_robustness.do   # Robustness and placebo tests
  07_mechanisms.do   # Mechanism analysis
```

Run full pipeline: `stata -b do papers/[slug]/do-files/00_master.do`

---

## Papers Directory Structure

```
papers/[slug]/
├── manuscript/      # [slug].tex + abstract.tex
├── tables/          # T1_*.tex, T2_*.tex, ...
├── figures/         # F1_*.pdf, F2_*.pdf, ...
├── do-files/        # 00_master.do through 07_mechanisms.do
├── logs/            # .log files (gitignored)
└── outputs/         # .dta, .ster files for audit
```

---

*Onboarding: see [NEW_ECON_PAPER_GUIDE.md](NEW_ECON_PAPER_GUIDE.md)*
*Stata command reference: see [.claude/references/econometrics-reference.md](.claude/references/econometrics-reference.md)*
*Journal calibration: see [.claude/references/journal-profiles.md](.claude/references/journal-profiles.md)*