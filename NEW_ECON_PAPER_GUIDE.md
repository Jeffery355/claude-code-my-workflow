# How to Start a New Economics Paper with This Template

**Purpose:** This guide explains how to use this template to start a new empirical economics paper from scratch. Read it once, then follow the steps.

---

## Overview

This template uses a **three-layer architecture**:

| Layer | What it is | Where it lives |
|---|---|---|
| **Global rules** | Standards that apply to ALL papers | `.claude/rules/` |
| **Project configuration** | ONE file per paper: everything specific to this paper | `PROJECT_BRIEF.md` (root) |
| **Reusable templates** | Do-file boilerplate, manuscript skeleton, table templates | `templates/`, `do-files/shared/` |

---

## Step-by-Step: Start a New Paper

### Step 1: Fill in PROJECT_BRIEF.md

Copy `templates/PROJECT_BRIEF.md` to the repository root and name it `PROJECT_BRIEF.md`:

```bash
cp templates/PROJECT_BRIEF.md PROJECT_BRIEF.md
```

Fill in every field:
- **Title:** Full paper title (used for directory slug)
- **Short slug:** kebab-case version (e.g., `effect-minimum-wage-employment`)
- **Research question:** What are you asking?
- **Data:** What dataset are you using?
- **Key variables:** Treatment, outcome, controls
- **Identification strategy:** DiD? IV? RDD? Panel FE?
- **Target journal:** AER / QJE / JPE / ECMA / ReStud

> **This is the only file you need to configure per paper.** Everything else derives from it.

### Step 2: Run /init-econ-paper

Once `PROJECT_BRIEF.md` is filled in, invoke:

```
/init-econ-paper
```

This will create the full directory structure at `papers/[slug]/`:
- `manuscript/` — LaTeX manuscript skeleton
- `tables/` — Table index and output directory
- `figures/` — Figure output directory
- `do-files/` — All 8 do-files (00_master.do through 07_mechanisms.do) with boilerplate
- `logs/` — (gitignored) Stata log files
- `outputs/` — Saved regression results for audit

### Step 3: Configure Data Paths in 00_master.do

Open `papers/[slug]/do-files/00_master.do` and set:
- `DATADIR`: where your raw data lives
- `ROOTDIR`: the path to `papers/[slug]`
- Any other path globals you need

```stata
global DATADIR  "/path/to/your/data"
global ROOTDIR  "/Users/you/my-project/papers/[slug]"
```

### Step 4: Write Your Do-Files

Follow the numbering: `01_clean.do` → `02_descriptives.do` → etc.

**Each do-file follows the boilerplate from `templates/stata-do-file-header.do`:**
- Header with filename, purpose, paper title
- `version 17`, `clear all`, `cap log close`, `set more off`
- Log file creation
- Body
- `log close` at end

**Shared utilities** (like `esttab_config.do`, `graph_settings.do`) live in `do-files/shared/` and are accessible via `adopath++` from any do-file.

### Step 5: Generate Tables and Figures

**Tables:** Stata → LaTeX via `esttab`. Each table .tex file should be self-contained and compilable.

**Figures:** Stata → PDF via `graph export` or R → PDF via `ggsave`.

All tables go in `papers/[slug]/tables/`. All figures go in `papers/[slug]/figures/`.

**Update the README indexes** (`tables/README.md`, `figures/README.md`) as you add them.

### Step 6: Write the Manuscript

The manuscript skeleton at `papers/[slug]/manuscript/[slug].tex` follows the standard economics paper structure:

1. **Abstract** (250 words max for AER)
2. **Introduction** (hook → gap → contribution → roadmap)
3. **Theoretical Mechanism** (M → X → Y chain with diagram)
4. **Data and Empirical Strategy** (data source, variables, identification)
5. **Results** (main tables/figures, event study)
6. **Robustness Checks** (alternative specs, placebo tests)
7. **Mechanism Analysis** (direct measurement, interaction, falsification)
8. **Conclusion** (summary, implications, limitations, future work)
9. **References**

Use `templates/regression-table.tex` as the starting point for each table.

### Step 7: Pre-Register (Recommended)

If you have pre-specified hypotheses, register them before analyzing:

```bash
# AEA RCT Registry (for experiments)
# https://www.socialscienceregistry.org/

# AsPredicted (for observational)
# https://aspredicted.org/

# OSF Preregistration (for any study)
# https://osf.io/prereg/
```

Document your pre-registration in `PROJECT_BRIEF.md` under "Hypotheses."

### Step 8: Run Quality Checks Before Committing

Use `/audit-reproducibility` and `/verify-claims` before committing:

```
/audit-reproducibility papers/[slug]/manuscript/[slug].tex papers/[slug]/outputs/
/verify-claims papers/[slug]/manuscript/[slug].tex
/proofread papers/[slug]/manuscript/[slug].tex
```

Use `templates/quality-checklist.md` as your pre-submission checklist.

---

## Worked Example: A DiD Paper with CPS Data

### 1. Fill PROJECT_BRIEF.md

```
Title: The Effect of Minimum Wage Increases on Employment
Short slug: effect-minimum-wage-employment
Research question: Does raising the minimum wage reduce employment?
Data: CPS (Current Population Survey), 1990-2019
Identification: Difference-in-differences (state × year)
Target journal: AER
```

### 2. Run /init-econ-paper

```
/init-econ-paper
```

Creates `papers/effect-minimum-wage-employment/`

### 3. Configure 00_master.do

```stata
global DATADIR  "/Users/you/data/CPS"
global ROOTDIR  "/Users/you/my-project/papers/effect-minimum-wage-employment"
```

### 4. Write 01_clean.do

```stata
*  01_clean.do
*  Data import and cleaning for minimum wage paper
*  Paper: The Effect of Minimum Wage Increases on Employment

version 17
clear all
cap log close
set more off

log using "$LOGDIR/01_clean.log", text replace

*  Load raw CPS data
use "$DATADIR/cps_1990_2019.dta", clear

*  Create treatment indicator (state minimum wage > federal)
gen treat = (state_min_wage > federal_min_wage) & year >= effective_year

*  Create outcome variable
gen ln_employment = ln(employment)

*  Create time since treatment variable
gen t = year - effective_year

log close
```

### 5. Write 03_regressions.do

```stata
*  03_regressions.do
*  Main DiD regressions

log using "$LOGDIR/03_regressions.log", text replace

eststo clear

*  Basic DiD
reg ln_employment treat i.state i.year, robust cluster(state)
eststo main_basic

*  TWFE
reg ln_employment treat i.state i.year, cluster(state)
eststo main_twfe

*  Event study
gen rel_year = year - effective_year
tab rel_year, gen(rel_)
reg ln_employment rel_2-rel_-1 rel1-rel5 i.state i.year, cluster(state)
eststo event_study

log close
```

### 6. Generate tables and write manuscript

Follow the template conventions. Always cross-reference: every table and figure must appear in the manuscript text.

---

## Key Rules to Remember

| Rule | File | What it says |
|---|---|---|
| Stata is source of truth | `.claude/rules/single-source-of-truth.md` | All numbers derive from Stata, not hand-entered into LaTeX |
| Do-file organization | `.claude/rules/stata-conventions.md` | 00_master through 07_mechanisms, header boilerplate, log management |
| Econometrics standards | `.claude/rules/econometrics-standards.md` | SE clustering, parallel trends, F-stat thresholds |
| Manuscript structure | `.claude/rules/manuscript-writing.md` | AER/QJE/JPE structure, abstract framework |
| Pre-registration | `.claude/rules/robustness-check-protocol.md` | Pre-register primary outcomes and tests |
| Mechanism analysis | `.claude/rules/mechanism-analysis-protocol.md` | M→X→Y chain, direct measurement + interaction + falsification |
| Cross-artifact review | `.claude/rules/cross-artifact-review.md` | Stata output must match LaTeX table cells |

---

## Quick Reference: Commands

```bash
# Scaffold new paper
cp templates/PROJECT_BRIEF.md PROJECT_BRIEF.md
# (fill in PROJECT_BRIEF.md)
./init-econ-paper

# Run full analysis pipeline
stata -b do papers/[slug]/do-files/00_master.do

# Compile manuscript
pdflatex manuscript.tex && bibtex manuscript && pdflatex manuscript && pdflatex manuscript

# Quality checks
/audit-reproducibility papers/[slug]/manuscript/[slug].tex papers/[slug]/outputs/
/verify-claims papers/[slug]/manuscript/[slug].tex

# Proofread
/proofread papers/[slug]/manuscript/[slug].tex

# Pre-submission checklist
# (see templates/quality-checklist.md)
```

---

## Folder Structure Summary

```
my-project/
├── PROJECT_BRIEF.md           ← ONE config file per paper (you fill this)
├── CLAUDE.md                  ← This file (workflow guide)
├── NEW_ECON_PAPER_GUIDE.md    ← This guide
├── Bibliography_base.bib      ← All citations
├── .claude/
│   ├── rules/                 ← Global rules (economics standards)
│   ├── skills/                ← Skills including /init-econ-paper
│   └── references/            ← Stata command reference
├── templates/                 ← Reusable templates
├── do-files/
│   └── shared/                ← Shared Stata utilities (esttab_config.do, etc.)
├── papers/
│   └── [slug]/               ← Your paper's home
│       ├── manuscript/
│       ├── tables/
│       ├── figures/
│       ├── do-files/
│       ├── logs/             (gitignored)
│       └── outputs/
└── Slides/                    ← (preserved for teaching materials)
    Quarto/                    ← (preserved for teaching materials)
```

---

*For full details on any step, see the rules referenced in "Key Rules to Remember" above.*
*Last updated: 2026-05-04*