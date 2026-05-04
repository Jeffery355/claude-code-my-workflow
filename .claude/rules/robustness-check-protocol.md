---
paths:
  - "papers/**/manuscript/**"
  - "papers/**/do-files/06_robustness.do"
  - "PROJECT_BRIEF.md"
  - "**/*robustness*"
  - "**/*sensitivity*"
alwaysApply: false
---

# Robustness Check Protocol

**Applies to:** Robustness and sensitivity analysis in all empirical economics papers.
**Companion:** `.claude/rules/econometrics-standards.md` for SE conventions, `.claude/rules/manuscript-writing.md` for presentation.

---

## 1. Purpose of Robustness Checks

Robustness checks test whether your main results are **stable to alternative specifications, samples, and methods**. They defend against:

- Specification search / p-hacking concerns
- Omitted variable bias
- Sample selection issues
- Measurement error
- Identification assumption violations

**A robustness check that passes strengthens credibility. A robustness check that fails reveals a limitation.**

---

## 2. When to Pre-Register

**Strong recommendation:** Pre-register robustness checks for your primary outcomes.

**Pre-registration platforms:**
- AEA RCT Registry (for experiments): `https://www.socialscienceregistry.org/`
- AsPredicted (for observational studies): `https://aspredicted.org/`
- OSF Preregistration (for any study): `https://osf.io/prereg/`

**What to pre-register:**
- Primary and secondary outcomes
- Pre-specified robustness checks (with hypotheses)
- Sample and time period
- Analysis plan (specifications, clustering)

**Do not pre-register:** Exploratory robustness checks (new robustness tests you discover during analysis are fine as long as you label them as such).

---

## 3. Standard Robustness Categories

### Category 1: Alternative Specifications

| Check | What it tests |
|---|---|
| OLS vs. fixed effects | Sensitivity to functional form and FE structure |
| Different SE clustering | Clustering level affects significance |
| Alternative time windows | Pre- or post-period choices |
| Different dependent variable transformation | log vs. level vs. discrete |
| Additional controls | Omitted variable bias |
| Outlier removal | Sensitivity to influential observations |

### Category 2: Alternative Samples

| Check | What it tests |
|---|---|
| Exclude one state/industry at a time | Geographic/industry heterogeneity |
| Exclude one year at a time | Temporal shocks |
| Restrict to balanced panel | Sample composition effects |
| Alternative sample definition | Measurement error in treatment |

### Category 3: Placebo Tests

**Shock timing placebo:**
```
Use a pre-treatment period as a "fake" treatment period.
If parallel trends hold, there should be no effect in pre-treatment periods.
```

**Spatial placebo:**
```
Apply treatment to a region that did not actually receive it.
If the effect is real, placebo should show no effect.
```

**Variable placebo:**
```
Replace the treatment variable with an irrelevant variable.
If results disappear with irrelevant variable, they are not artifacts.
```

### Category 4: Alternative Identification

| Strategy | Alternative |
|---|---|
| DiD | Callaway-Sant'Anna (2021) for heterogeneous effects |
| DiD | Event study with different lead/lag window |
| IV | Reduced form (omit first stage) |
| IV | LIML estimator (for weak instruments) |
| RDD | Different bandwidth selection |
| RDD | Different polynomial order |
| RDD | Exclude observations near cutoff (donut hole) |
| RDD | Placebo cutoffs |

---

## 4. How Many Robustness Checks?

**Minimum standard:** 5-7 robustness checks in the main paper.

**AER expectation:** 10+ robustness checks in Online Appendix.

**Rule:** Report all robustness checks, not just the ones that "pass." A check that fails is important information — include it.

---

## 5. Reporting Format

### Table format (preferred for main paper):
```
Table 4: Robustness Checks — Main Result
\endfirsthead
\hline
 & (1) & (2) & (3) & (4) \\
 & Base & +Controls & Excl. TX & Event Study \\
\hline
Treatment & 0.04** & 0.03** & 0.05*** & 0.03** \\
 & (0.01) & (0.01) & (0.02) & (0.01) \\
N & 10,000 & 10,000 & 9,500 & 10,000 \\
\hline
\end{longtable}
\note{Base: baseline specification. +Controls: adds demographic controls. 
Excl. TX: excludes Texas. Event study: uses event study instead of simple DiD.}
```

### Paragraph format (for extended robustness):
```
The results are robust to: (1) including demographic controls 
(columns 2); (2) excluding Texas, which had the largest minimum wage 
increase (column 3); and (3) using an event study specification 
(column 4). The Callaway-Sant'Anna (2021) estimator also yields a 
similar point estimate (Table A5).
```

---

## 6. Multiple Testing in Robustness

When running many robustness checks, consider multiple testing correction.

**If pre-specified:** Use Benjamini-Hochberg procedure to control FDR.

**If not pre-specified:** Report unadjusted p-values but note the number of tests. Do not selectively report only "passing" checks.

---

## 7. Sensitivity Analysis

### Parametric sensitivity:
```
Vary the control variables included in the regression.
Start with minimal set, add controls one at a time.
Plot coefficients as controls are added.
```

### Extreme bounds analysis:
```
Report the range of estimates across all reasonable specifications.
If the range crosses zero, the result is not robust.
```

### Rosenbaum sensitivity (for matched samples):
```
Test how large a hidden bias would need to be to change the conclusion.
`rbounds` command in Stata for propensity score matched samples.
```

---

## 8. RDD-Specific Robustness

| Check | Command |
|---|---|
| Different bandwidths | `rdrobust y x, bw(all)` or manually set |
| Different kernels | triangular vs. uniform vs. epanechnikov |
| Different polynomial order | `p(1)` vs. `p(2)` vs. `p(3)` |
| Donut hole exclusion | `rdrobust y x, cutoff(0.01)` to exclude near cutoff |
| Placebo cutoffs | Run RDD at 5 other points where there is no real cutoff |
| McCrary sorting test | `rddensity x` |

---

## 9. DiD-Specific Robustness

| Check | Command / Method |
|---|---|
| Callaway-Sant'Anna | `csdid y t x, vce(cluster unit)` |
| Event study | Plot all leads and lags |
| Pre-trend test | Joint test that all pre-treatment coefficients = 0 |
| Placebo treatment timing | Assign fake treatment in pre-period |
| Exclude early adopters | If treatment timing varies |
| Roth (2022) pre-trends | Pre-trend test with proper inference |

---

## 10. Presentation Hierarchy

**In main paper (Tables 4-6):**
- Most important robustness checks (5-7)
- Short table format

**In Online Appendix (Tables A5-A10):**
- Extended robustness
- All alternative specifications
- All placebo tests

**In text:**
- Summary of robustness findings
- Reference to appendix for details
- Honest discussion of what is robust and what is not

---

## 11. What to Do When Robustness Fails

**If the result disappears:**
1. Report it honestly (this is the correct finding)
2. Investigate why — the alternative specification may be more appropriate
3. Discuss the implications: what does this mean for interpretation?

**If the result changes but remains significant:**
1. Report the range of estimates
2. Discuss which specification is most credible given your context

**Rule:** Never selectively omit failed robustness checks. A failed robustness check is informative — it tells the reader where the result is fragile.

---

## 12. Quality Checklist for Robustness

- [ ] Pre-registered checks documented
- [ ] All robustness checks reported (not just passing ones)
- [ ] Multiple testing correction applied if many tests run
- [ ] Placebo tests included
- [ ] RDD bandwidth sensitivity included
- [ ] Alternative sample restrictions included
- [ ] Alternative identification strategy compared (Callaway-Sant'Anna for DiD)
- [ ] Coefficients plotted across specifications if many robustness checks