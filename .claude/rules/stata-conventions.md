# Stata Do-File Conventions

**Applies to:** All Stata code in `papers/[slug]/do-files/` and `do-files/shared/`.
**Companion:** `.claude/references/econometrics-reference.md` for command syntax.

---

## 1. Do-File Organization (Per Paper)

Each paper has 8 numbered do-files. Run them in order via `00_master.do`.

```
[slug]/
  do-files/
    00_master.do       # Sets globals, calls all do-files in order
    01_clean.do        # Data import, cleaning, variable construction
    02_descriptives.do # Summary statistics, balance tests
    03_regressions.do  # Main regressions (all specifications)
    04_tables.do       # Esttab/outreg table generation
    05_figures.do      # Graph generation
    06_robustness.do   # Robustness and placebo tests
    07_mechanisms.do   # Mechanism analysis
```

**Global path structure in `00_master.do`:**
```stata
global ROOTDIR     "/path/to/papers/[slug]"
global DATADIR    "$ROOTDIR/data"
global OUTDIR     "$ROOTDIR/outputs"
global TABLEDIR   "$ROOTDIR/tables"
global FIGDIR     "$ROOTDIR/figures"
global LOGDIR     "$ROOTDIR/logs"
global DOFILEDIR  "$ROOTDIR/do-files"
```

---

## 2. Header Boilerplate (Every Do-File)

```stata
*  [FILENAME].do
*  [BRIEF DESCRIPTION]
*  Author: [Your Name]
*  Created: [YYYY-MM-DD]
*  Last modified: [YYYY-MM-DD]
*  Paper: [PAPER TITLE]
*  Output: [WHAT THIS FILE PRODUCES]

version 17
clear all
cap log close
set more off

*  Optional: adopath
adopath++ "$DOFILEDIR/shared"  // for shared utilities
```

---

## 3. Log Management

**Log file naming:**
```
log using "$LOGDIR/[filename].log", text replace
```

**Log directory is gitignored** (contains potentially large .log files).

**At end of every do-file:**
```stata
log close
```

---

## 4. Shared Utilities (`do-files/shared/`)

Place reusable utilities here. Every paper's do-files can access them via `adopath++`.

| File | Purpose |
|---|---|
| `esttab_config.do` | Global esttab settings: significance stars, booktabs, keep(constant) |
| `graph_settings.do` | Graph scheme, font defaults, color palette |
| `robustness_wrapper.do` | Wrapper program for common robustness checks |
| `cleaning_helpers.do` | programs for recurring data tasks |

**Example shared utility (esttab_config.do):**
```stata
*  esttab_config.do
*  Configure esttab defaults for publication-quality tables

global star " * p<0.10 ** p<0.05 *** p<0.01"
global tableoptions " booktabs nonumbers compress label substitute(`star' `star') "
global tableoptions_nodv " booktabs nonumbers compress label "
```

---

## 5. Data Input Conventions

**Raw data:** Always read from `$DATADIR/`. Never modify raw data files.

**Cleaning pipeline:**
1. Read raw → create `clean_*.dta` in outputs/
2. Clean → `analysis_sample.dta` in outputs/
3. Regressions use `analysis_sample.dta`

**Do not** overwrite raw data. If cleaning requires irreversible steps, document clearly.

---

## 6. Regression Output Storage

**Store results:** After each regression, save to `.ster` files or `.dta` for audit-reproducibility.

```stata
eststo clear
reg y x i.unit i.time, robust
eststo main_`spec'
estout using "$TABLEDIR/reg_`spec'.txt", replace

*  Save for reproducibility audit
parmest, saving("$OUTDIR/reg_`spec'.dta", replace)
```

**Table directory:** Only .tex or .txt output files go in `tables/`. Intermediate .dta files go in `outputs/`.

---

## 7. Variable Naming Conventions

| Type | Convention | Example |
|---|---|---|
| Treatment | `treatment` or `treat` | `gen treat = (policy == 1)` |
| Outcome | `outcome` or descriptive | `gen ln_wage = ln(wage)` |
| Control | `ctrl_*` or `x_*` | `gen ctrl_age = age` |
| Fixed effects | `i.unit`, `i.time`, `fe_*` | `i.unit i.time` |
| Interaction | `int_*` or `x*y` | `gen int_xw = x * w` |
| Placebo | `placebo_*` | `gen placebo_y = lead_10` |

---

## 8. Comment Standards

- Header comment (see boilerplate above) in every file
- Section breaks: `*  === SECTION NAME ===`
- Inline comments for non-obvious decisions: `*  why this filter applied`
- No TODO comments — use `// FIXME` for known issues

---

## 9. Error Handling

```stata
cap log close
cap {
    *  main logic here
}
if _rc != 0 {
    di as error "Error in `c(mode)': _rc = _rc"
    exit _rc
}
log close
```

---

## 10. Execution Order

**To run full analysis:**
```stata
do "$DOFILEDIR/00_master.do"
```

**To run specific section only:**
```stata
do "$DOFILEDIR/03_regressions.do"    // main results only
do "$DOFILEDIR/06_robustness.do"    // robustness only
```

---

## 11. Stata Version Compatibility

- Use `version 17` or later (Unicode support, frames)
- If code must run on earlier version, note in header
- When sharing code (e.g., for replication), include version requirement