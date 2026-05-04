# CLAUDE.MD — Academic Economics Research Template

**Project:** Reusable template for empirical economics papers
**Purpose:** Stata-based econometric analysis, journal-style manuscript writing, publication-ready tables/figures
**Branch:** main

---

## Core Principles

- **Plan first** — enter plan mode before non-trivial tasks; save plans to `quality_reports/plans/`
- **Verify after** — run audit-reproducibility and verify every numeric claim before committing
- **Stata is source of truth** — all numerical results derive from Stata do-files; LaTeX manuscript is derived
- **Quality gates** — nothing ships below 80/100
- **[LEARN] tags** — when corrected, save `[LEARN:category] wrong → right` to [MEMORY.md](MEMORY.md)

Cross-session context lives in [MEMORY.md](MEMORY.md); past plans, specs, and session logs are in [quality_reports/](quality_reports/).

---

## Three-Layer Architecture

This template has three layers:

| Layer | Purpose | Location |
|---|---|---|
| **Global rules** | Standards for ALL economics projects | `.claude/rules/` |
| **Project configuration** | ONE file to configure a new paper | `PROJECT_BRIEF.md` (root) |
| **Reusable templates** | Manuscripts, tables, do-files, checklists | `templates/`, `do-files/shared/` |

See [NEW_ECON_PAPER_GUIDE.md](NEW_ECON_PAPER_GUIDE.md) for the full onboarding guide.

---

## Folder Structure

```
[PROJECT]/
├── PROJECT_BRIEF.md              # ONE config file per paper (fill this to start)
├── NEW_ECON_PAPER_GUIDE.md       # Onboarding guide (read this first)
├── CLAUDE.md                     # This file
├── .claude/                      # Rules, skills, agents, hooks
├── Bibliography_base.bib         # Centralized bibliography
├── papers/                       # PRIMARY — one subdir per paper
│   └── [slug]/
│       ├── manuscript/           # LaTeX manuscript
│       ├── tables/               # Regression tables (.tex)
│       ├── figures/              # Figures (.pdf, .png)
│       ├── do-files/             # Stata do-files
│       ├── logs/                 # Stata .log files (gitignored)
│       └── outputs/              # Saved results for audit (.dta, .ster)
├── do-files/
│   └── shared/                   # Shared Stata utilities
├── templates/                    # Reusable templates
├── scripts/                      # Utility scripts
├── quality_reports/              # Plans, session logs, merge reports
├── Slides/                       # (preserved) Lecture slides (Beamer)
├── Quarto/                       # (preserved) Quarto slide decks
└── explorations/                 # Research sandbox
```

**Note:** `Slides/` and `Quarto/` are preserved for teaching materials. The primary artifact for economics papers is `papers/[slug]/`.

---

## Commands

```bash
# Stata — run full analysis pipeline
stata -b do papers/[slug]/do-files/00_master.do

# Stata — run specific do-file
stata -b do papers/[slug]/do-files/03_regressions.do

# LaTeX — compile manuscript (3-pass)
cd papers/[slug]/manuscript
pdflatex [slug].tex
bibtex [slug]
pdflatex [slug].tex
pdflatex [slug].tex

# Quality checks
/audit-reproducibility papers/[slug]/manuscript/[slug].tex papers/[slug]/outputs/
/verify-claims papers/[slug]/manuscript/[slug].tex

# Proofread
/proofread papers/[slug]/manuscript/[slug].tex

# Pre-submission
# See templates/quality-checklist.md
```

---

## Quality Thresholds (advisory)

| Score | Checkpoint | Meaning |
|-------|------|---------|
| 80 | Commit | Good enough to save |
| 90 | PR | Ready for deployment |
| 95 | Excellence | Aspirational |

Enforced by `/commit` (halts + asks for override); not enforced by a git pre-commit hook.

---

## Skills Quick Reference

| Command | What It Does |
|---------|-------------|
| `/init-econ-paper` | Scaffold new paper from PROJECT_BRIEF.md |
| `/data-analysis --lang stata [goal]` | Stata analysis pipeline (default for economics) |
| `/data-analysis --lang r [goal]` | R analysis pipeline |
| `/review-paper [file]` | Manuscript review (single / --adversarial / --peer) |
| `/seven-pass-review [file]` | Seven-pass adversarial manuscript review |
| `/audit-reproducibility [manuscript] [outputs]` | Cross-check numeric claims vs Stata output |
| `/verify-claims [file]` | Chain-of-Verification fact-check |
| `/respond-to-referees [report] [manuscript]` | R&R cross-reference + response draft |
| `/lit-review [topic]` | Literature search + synthesis |
| `/research-ideation [topic]` | Research question generation |
| `/interview-me [topic]` | Interactive research interview |
| `/preregister [--style osf\|aspredicted\|aea-rct]` | Draft preregistration document |
| `/proofread [file]` | Grammar/typo/overflow review |
| `/compile-latex [file]` | 3-pass XeLaTeX + bibtex (for Beamer slides) |
| `/deploy [LectureN]` | Render Quarto + sync to docs/ |
| `/slide-excellence [file]` | Combined multi-agent slide review |
| `/validate-bib` | Cross-reference citations |
| `/learn [skill-name]` | Extract discovery into persistent skill |
| `/context-status` | Show session health + context usage |
| `/commit [msg]` | Stage, commit, PR, merge |

---

## Key Rules (Economics Papers)

| Rule | Purpose |
|---|---|
| `.claude/rules/econometrics-standards.md` | DiD, IV, RDD, panel FE standards; SE clustering |
| `.claude/rules/stata-conventions.md` | Do-file organization (00–07), header boilerplate |
| `.claude/rules/manuscript-writing.md` | AER/QJE/JPE/ECMA paper structure |
| `.claude/rules/single-source-of-truth.md` | Stata do-files are authoritative; LaTeX derives |
| `.claude/rules/cross-artifact-review.md` | Stata ↔ LaTeX consistency |
| `.claude/rules/literature-review-protocol.md` | Organize by mechanism, not by paper |
| `.claude/rules/mechanism-analysis-protocol.md` | M→X→Y chain, direct measurement + interaction + falsification |
| `.claude/rules/robustness-check-protocol.md` | Pre-registration, placebo tests, sensitivity analysis |

---

## Stata Do-File Organization (Per Paper)

```
[slug]/do-files/
  00_master.do      # Sets globals, calls all do-files in order
  01_clean.do        # Data import, cleaning, variable construction
  02_descriptives.do # Summary statistics, balance tests
  03_regressions.do  # Main regressions
  04_tables.do        # Esttab/outreg table generation
  05_figures.do       # Graph generation
  06_robustness.do    # Robustness and placebo tests
  07_mechanisms.do    # Mechanism analysis
```

Run full pipeline: `stata -b do papers/[slug]/do-files/00_master.do`

---

## Papers Directory Structure

```
papers/[slug]/
├── manuscript/
│   ├── [slug].tex      # Main manuscript
│   └── abstract.tex    # Separate abstract file
├── tables/
│   ├── README.md        # Table index
│   ├── T1_summary_stats.tex
│   ├── T2_main_results.tex
│   └── T3_heterogeneity.tex
├── figures/
│   ├── README.md        # Figure index
│   ├── F1_event_study.pdf
│   └── F2_placebo.pdf
├── do-files/
│   ├── 00_master.do
│   ├── 01_clean.do
│   └── ... (through 07)
├── logs/               # .log files (gitignored)
├── outputs/            # .dta, .ster files for audit
└── README.md           # Paper-level overview
```

---

## Global Rules Reference

| Rule | What it covers |
|---|---|
| `econometrics-standards.md` | Panel FE, DiD, IV, RDD; SE clustering; multiple testing |
| `stata-conventions.md` | Do-file numbering, header boilerplate, path globals, log management |
| `manuscript-writing.md` | Abstract framework, intro structure, results, robustness, conclusion |
| `literature-review-protocol.md` | Gap identification, citation standards, JEL codes |
| `mechanism-analysis-protocol.md` | M→X→Y chain, mediation, falsification tests |
| `robustness-check-protocol.md` | Pre-registration, placebo tests, RDD bandwidth, DiD event study |
| `r-code-conventions.md` | R for figures/robustness only; Stata is primary |

## References

| Reference | What it contains |
|---|---|
| `econometrics-reference.md` | Stata commands (xtreg, ivreg2, rdrobust, csdid); code snippets |
| `journal-profiles.md` | Calibration for peer review (AER, QJE, JPE, ECMA, ReStud) |

---

*For onboarding: see [NEW_ECON_PAPER_GUIDE.md](NEW_ECON_PAPER_GUIDE.md)*
*For Stata command reference: see [econometrics-reference.md](.claude/references/econometrics-reference.md)*