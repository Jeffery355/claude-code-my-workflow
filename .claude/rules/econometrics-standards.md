# Econometrics Standards

**Applies to:** All empirical economics projects using Stata.
**Reference:** `.claude/references/econometrics-reference.md` for command syntax.

---

## 1. Identification Strategies

### 1.1 Difference-in-Differences (DiD)

**Parallel trends assumption (required):**
- Pre-treatment balance tests on outcome trends (event study or pre-trend regression)
- Report p-value from joint test that all pre-treatment coefficients = 0
- If parallel trends violated: report sensitivity or use alternative identification

**Specification standards:**
- Two-way fixed effects (TWFE): `reg y t x i.unit i.time` or `xtreg y t x i.unit i.time, fe`
- Callaway-Sant'Anna (2021) non-parametric: `csdid y t x, vce(cluster unit)` for heterogeneous treatment effects
- Imputation estimator (Baker et al. 2022): `did_imputation y t x` for parallel trends violation

**Clustering:**
- Cluster at unit level by default for DiD
- Two-way clustering (`vce(cluster unit time)`) when treatment timing varies across units

**Journal-specific (AER):**
- Report number of units, time periods, clusters
- Report pre-treatment outcome means by group
- Event study plot with 95% CI is standard

### 1.2 Panel Data (Fixed Effects)

**Unit fixed effects:**
- `xtreg y x, fe` is standard for balanced panels
- `reg y x i.unit, robust` for unbalanced or when HDWiM is needed
- `areg y x, absorb(unit)` for memory efficiency on large datasets

**Time fixed effects:**
- Include `i.time` or `F.time` indicators
- TWFE: `xtreg y x i.time, fe` or `reg y x i.unit i.time`

**Double-demeaned (de Chaisemartin & Ramirez)**

For TWFE with treatment timing variation and heterogenous effects:
```
did_multilateral_treatment y t x, vce(cluster unit)
```

**Standard errors:**
- Cluster at unit level: `xtreg y x, fe cluster(unit)`
- Cluster at unit × time level for serial correlation: `vce(cluster unit)`
- Wild cluster bootstrap for few clusters (<50): `boottest x, reps(9999) cluster(unit)`

### 1.3 Instrumental Variables (IV)

**First stage:**
- Report F-statistic of excluded instruments (Stock-Yogo threshold: 10)
- Weak instruments: Cragg-Donald Wald F-stat, Anderson-Rubin test
- When weak: Anderson-Rubin confidence sets, liml estimator

**Second stage:**
- `ivreg2 y (x = z), robust first` — report first stage F, Hansen J overid test
- `estat firststage` — show first stage results table

**Post-estimation:**
- `estat endogenous` — Hausman test for endogeneity
- `ivqte` — for quantile treatment effects

**Journal-specific (ECMA):**
- Show reduced-form results alongside first stage
- Report Anderson-Rubin test for weak instruments (not just Cragg-Donald)

### 1.4 Regression Discontinuity (RDD)

**Bandwidth selection:**
- Imbens-Kalyanaraman (2012): `rdbwselect y x, kernel(triangular)`
- Alternative: MSE-optimal bandwidth from `rdrobust`
- Report: bandwidth, kernel, polynomial order

**Validation checks:**
- McCrary sorting test: `rddensity x, platform(plot)`
- Donut hole (exclude observations very close to cutoff): sensitivity test
- Placebo cutoffs at different values

**Specification:**
- Local polynomial: `rdrobust y x, kernel(triangular) p(1)` (linear) or `p(2)` (quadratic)
- Bias-corrected confidence intervals: `rdrobust y x, bwselect(bc)` (MSE-optimal) or `cerrd` (coverage error optimal)
- For sharp RDD: `rdrobust y x, scalefh(0)`
- For fuzzy RDD: `rdrobust y x, fuzzy(t)`

**Publication:**
- Publish: bandwidth, kernel, polynomial order, running variable range
- Bin scatter plot with fitted polynomial is standard
- Effect at boundary with 95% CI must be reported

---

## 2. Standard Error Conventions

| Clustering level | When to use | Command |
|---|---|---|
| Unit (firm/worker/county) | Unit-level treatment variation | `cluster(unit)` |
| Unit × Time | Panel with serial correlation | `cluster(unit time)` |
| Two-way | Both unit and time variation | `cluster(unit)` with unit FE + time FE |
| Conley-Tipton-Mills | Spatial correlation with decay | `conley` (Spatial HAC) |

**No clustered SEs:** When treatment is randomly assigned and no serial correlation concern.

**Robust vs Clustered:**
- Use `robust` (HC1) only when clustering is inappropriate (i.e., iid errors)
- Clustered is almost always preferred in panel settings

---

## 3. Multiple Testing Correction

**When needed:** Multiple outcomes, multiple subgroups, multiple hypotheses.

**Procedures:**
- Bonferroni: reject if p < 0.05/k (k = number of tests)
- Holm-Bonferroni: step-down procedure (less conservative than Bonferroni)
- Benjamini-Hochberg (BH): controls FDR at 5% (more powerful for many tests)
- Romano-Wolf: adjusted p-values via resampling (Stata: `rwolf` package)

**Standard:** Report unadjusted p-values with note on multiple testing. If pre-registered, use BH procedure.

**Pre-registration:** Specify primary outcomes and pre-specified tests in pre-registration document.

---

## 4. Parallel Trends Testing (DiD)

### Required checks:
1. **Event study plot:** Plot coefficients on leads (pre-treatment periods)
2. **Joint test:** F-test that all lead coefficients = 0 (report p-value)
3. **Pre-treatment means:** Table of means by group in pre-treatment period
4. **Pre-treatment trends:** Test that outcome growth rates are parallel pre-treatment

### Reporting standard:
```
"Figure 2 shows the event study. All pre-treatment leads are statistically 
indistinguishable from zero (joint test p = 0.FIGNUM). Treatment and control 
groups had similar pre-treatment outcome levels and trends."
```

---

## 5. Effect Size Reporting

**Always report:**
- Point estimate (coefficient)
- Standard error (clustered or robust)
- 95% confidence interval
- N (total), N_clusters, number of treated/control

**Economic significance:**
- Explain magnitude in terms of standard deviation of outcome
- If applicable: dollar value, percentage of mean, share of variance explained

**AER standard:**
- Table column: dependent variable name, sample period, number of observations, number of clusters
- Notes: sample restrictions, clustering level, fixed effects