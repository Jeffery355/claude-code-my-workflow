# Econometrics Reference: Stata Commands

**Companion:** `.claude/rules/econometrics-standards.md` — conceptual standards.

This file is a practical command reference. For theory and standards, see econometrics-standards.md.

---

## 1. Panel Data

### Fixed Effects (FE)

```stata
*  Unit fixed effects (within estimator)
xtreg y x, fe

*  Unit + time fixed effects (TWFE)
xtreg y x i.time, fe

*  With clustered SEs
xtreg y x i.time, fe cluster(unit)

*  Areg (memory-efficient for large datasets)
areg y x i.time, absorb(unit)

*  Double-demeaned (manual FE)
*  Requires center variables manually
```

### Random Effects

```stata
xtreg y x, re
xtreg y x, re cluster(unit)
hausman varename  // Hausman test: FE vs RE
```

---

## 2. Difference-in-Differences

### Basic DiD

```stata
*  Two-way FE (simple)
reg y t treatment i.unit i.time, robust

*  With unit-level clustering
reg y t treatment i.unit i.time, cluster(unit)

*  With two-way clustering
reg y t treatment i.unit i.time, cluster(unit time)
```

### Event Study

```stata
*  Generate leads and lags
gen rel_year = year - treatment_year
tab rel_year, gen(rel_)

*  Event study regression
reg y rel_2-rel_-1 rel1-rel5 i.unit i.time, cluster(unit)
```

### Callaway-Sant'Anna (2021) — Heterogeneous Effects

```stata
*  Install: ssc install csdid, replace

csdid y t x, vce(cluster unit)
estat simple  // ATT estimates

csdid y t x, vce(cluster unit) long
*  long: uses "not-yet-treated" as comparison group
```

### Imputation Estimator (Baker et al. 2022)

```stata
*  Install: ssc install did_imputation, replace

did_imputation y t x, auto(1) // auto sets number of pre-periods
```

### TWFE with Treatment Timing Variation

```stata
*  de Chaisemartin and Ramirez (2021)
did_multilateral_treatment y t x, vce(cluster unit)

*  Goodman-Bacon decomposition
help ddidrom // Bacon decomposition
```

---

## 3. Instrumental Variables

### 2SLS

```stata
*  Basic 2SLS
ivreg2 y (x = z), robust first

*  With first stage F-stat
ivreg2 y (x = z), robust first

*  With unit + time FE
ivreg2 y (x = z) i.unit i.time, robust first

*  Clustered
ivreg2 y (x = z) i.unit i.time, cluster(unit) first
```

### First Stage Diagnostics

```stata
estat firststage, all
*  Shows: partial R2, F-stat, Cragg-Donald stat, stock-yogo threshold

*  Weak instrument tests
*  Cragg-Donald F-stat (Stock-Yogo: 10% maximal IV size)
*  Anderson-Rubin test for underidentification
```

### Post-Estimation

```stata
*  Endogeneity test (Hausman)
estat endogenous

*  Overidentification test (Sargan-Hansen J)
estat overid

*  Quantile treatment effects
ivqte y, quantile(0.25 0.5 0.75) iv(x = z)
```

---

## 4. Regression Discontinuity

### Sharp RDD

```stata
*  Basic (MSE-optimal bandwidth)
rdrobust y x, kernel(triangular)

*  With bias-corrected CI
rdrobust y x, bwselect(bc)

*  With placebo cutoffs
rdrobust y x if abs(x) < 1, cutoff(-0.5)  // placebo at -0.5
```

### Fuzzy RDD

```stata
rdrobust y x, fuzzy(t)  // t is endogenous treatment, x is running variable
```

### Bandwidth Selection

```stata
*  IK (Imbens-Kalyanaraman)
rdbwselect y x, kernel(triangular)

*  MSE-optimal vs CER (coverage error optimal)
rdrobust y x, bwselect(mserd)  // MSE-optimal
rdrobust y x, bwselect(cerrd)    // Coverage error optimal
```

### Sorting Test

```stata
*  McCrary (2008) sorting test
rddensity x, platform(plot)
*  plot: generates density plot
```

### Manipulation Test

```stata
*  For many cutoff points
rdrobust y x, covs(cutoff_var)  // with covariate-adjusted
```

---

## 5. Standard Error Adjustments

### Clustered

```stata
*  Single clustering
reg y x, cluster(unit)

*  Two-way clustering
*  Install: ssc install ivreg2, replace first
ivreg2 y x i.unit i.time, cluster(unit time)
```

### Conley (Spatial HAC)

```stata
*  Install: ssc install conley, replace

*  Spatial correlation with distance cutoff
conley y x, cutlag(500) epsg(4326) // 500km cutoff, lat/lon coords
```

### Wild Cluster Bootstrap

```stata
*  Install: ssc install boottest, replace

*  For few clusters (<50)
boottest x, reps(9999) cluster(unit) // wild cluster bootstrap
boottest x, reps(9999) cluster(unit) stat(wald) // Wald statistic
```

---

## 6. Post-Estimation and Table Generation

### Esttab Basic

```stata
*  Install: ssc install estout, replace

eststo clear
reg y x1, robust
eststo m1
reg y x1 x2, robust
eststo m2

esttab m1 m2 using "$TABLEDIR/table1.txt", replace ///
  star(* 0.10 ** 0.05 *** 0.01) ///
  b(%9.3f) se(%9.3f) ///
  nogaps compress
```

### Esttab Publication Quality

```stata
esttab m1 m2 using "$TABLEDIR/table1.tex", replace ///
  booktabs nonumbers ///
  star(* p<0.10 ** p<0.05 *** p<0.01) ///
  coeflabels(x1 "Treatment" x2 "Control") ///
  keep(x1 x2) ///
  prehead(\begin{table}[htbp]\centering\caption{Main Results}\begin{tabular}{lcc}) ///
  postfoot(\bottomrule\end{tabular}}\notes{Clustered SEs in parentheses. * p<0.10, ** p<0.05, *** p<0.01}%)
```

### Store Regression Results for Audit

```stata
*  Save coefficient + SE as dataset
parmest, saving("$OUTDIR/reg_main.dta", replace)

*  Later reload for audit
use "$OUTDIR/reg_main.dta", clear
list parm seq
```

---

## 7. Multiple Testing Correction

### Benjamini-Hochberg

```stata
*  For pre-registered hypotheses
*  Install: ssc install qvalue, replace

*  After running multiple regressions
matrix pvals = [0.03, 0.12, 0.04, 0.25]
qvalue pvals, gen(q) printer
*  q: adjusted q-values (FDR-adjusted)
*  reject if q < 0.05
```

### Romano-Wolf

```stata
*  Install: ssc install rwolf, replace

*  After estimating
boottest x1, reps(9999) cluster(unit) adj
boottest x2, reps(9999) cluster(unit) adj
*  rwolf performs multiple testing adjustment
```

---

## 8. Parallel Trends Testing

### Event Study Pre-Trends

```stata
*  Test joint significance of all pre-treatment leads
testparm rel_m3 rel_m2 rel_m1
*  Report: F-stat, p-value

*  Plot event study
coefplot, by(label) xline(0) keep(rel_*)
```

### Pre-Trend Balance Test

```stata
*  For continuous outcome
reg pre_outcome treatment, robust

*  For binary outcome
logit pre_outcome treatment, robust
```

---

## 9. Heterogeneity Analysis

### By Group

```stata
*  Interaction approach
reg y c.treatment##c.group i.unit i.time, cluster(unit)

*  Separate regressions by group
bysort group: reg y t x i.unit i.time, cluster(unit)
```

### By Time

```stata
*  Post-treatment effect by year
reg y t#year i.unit i.time, cluster(unit)
```

### Continuous Moderator

```stata
*  Continuous interaction
reg y c.treatment##c.moderator i.unit i.time, cluster(unit)

*  Visualize: plot effect across moderator values
margins, at(moderator=(range)) dydx(treatment)
marginsplot
```

---

## 10. Summary Statistics

```stata
*  Basic summary
sum y x1 x2

*  By group
bysort treatment: sum y x1 x2

*  Table output
estpost summarize y x1 x2, detail
esttab, cells(mean sd) nogaps
```

---

## 11. Data Cleaning Programs

### Winsorization

```stata
*  Install: ssc install winsor2, replace

winsor2 y x1 x2, cuts(1 99) suffix(_w)
*  Winsorizes at 1st and 99th percentiles
```

### Outlier Removal

```stata
*  Remove observations beyond 3 SD
bysort group: egen mean_y = mean(y)
bysort group: egen sd_y = sd(y)
gen y_outlier = (y < mean_y - 3*sd_y | y > mean_y + 3*sd_y)
drop if y_outlier
```

---

## 12. Common Problems and Solutions

### Error: "repeated keywords"
You used `robust` twice. In `ivreg2`, either use `robust` OR `cluster()`.

### Error: "varlist required"
The `areg` syntax is `areg y x, absorb(unit)`. NOT `areg y x i.unit`.

### Warning: "weak instruments"
Run `ivreg2` with `first` option. Check F-stat > 10 (Stock-Yogo threshold). If weak, use LIML: `ivreg2 y (x = z), liml`.

### Warning: "normality rejected"
This is common in large samples. Check residual plots for outliers. It's not necessarily a problem in large N.

### Panel data: "no observations"
Check if your panel variable is properly set: `xtset unit year`. Also check for string vs. numeric variable issues.

---

## 13. Reference Quick Lookup

| Concept | Command |
|---|---|
| FE | `xtreg y x, fe` |
| TWFE | `xtreg y x i.time, fe` |
| Clustered SE | `, cluster(unit)` |
| Event study | `reg y rel_* i.unit i.time` |
| Callaway-Sant'Anna | `csdid y t x, vce(cluster unit)` |
| IV | `ivreg2 y (x = z), robust first` |
| First stage F | `estat firststage, all` |
| RDD | `rdrobust y x, kernel(triangular)` |
| Bandwidth | `rdbwselect y x, kernel(triangular)` |
| McCrary | `rddensity x, platform(plot)` |
| Outreg | `esttab, star(* p<0.10 ** p<0.05 *** p<0.01)` |
| Winsorize | `winsor2 y, cuts(1 99)` |