# Mechanism Analysis Protocol

**Applies to:** Mechanism analysis sections in empirical economics papers.
**Companion:** `.claude/rules/econometrics-standards.md` for identification, `.claude/rules/manuscript-writing.md` for writing.

---

## 1. What Is a Mechanism?

A mechanism explains **how** an effect occurs. It is not the effect itself.

**Example:**
- **Effect:** Minimum wages reduce employment
- **Mechanism:** Firms substitute capital for labor when wages rise

**The mechanism is the causal chain between treatment (minimum wage increase) and outcome (employment change).**

---

## 2. Mechanism vs. Heterogeneity

| Concept | Definition | Example |
|---|---|---|
| Mechanism | How does X affect Y? | Capital substitution as the channel |
| Heterogeneity | For whom does X affect Y? | Larger effects for low-skill workers |

Both are important, but they answer different questions. Do not conflate them.

---

## 3. Theoretical Framework First

Before testing mechanisms empirically, you must have a theoretical story:

1. **State the mechanism clearly:** "I argue that the effect operates through M"
2. **Show the causal chain:** Treatment → M → Outcome
3. **Derive predictions:** If M is the mechanism, we should observe X
4. **Identify necessary conditions:** What must be true for this mechanism to operate?

**Use a diagram (M → X → Y) to illustrate the mechanism.**

---

## 4. Testing Mechanisms: Three Approaches

### 4.1 Direct Measurement

Measure the proposed mediator directly and test if it changes with treatment.

**Example (minimum wage → employment):**
```
Test: Does treatment increase capital intensity?
If yes: Capital substitution is a plausible mechanism
If no: Capital substitution cannot explain the effect
```

**DiD specification:**
```stata
*  Direct measurement approach
reg capital_intensity treat post i.unit i.time, cluster(unit)
```

**Limitations:**
- mediator may be measured with error
- treatment may affect mediator through multiple pathways

### 4.2 Mediation Analysis (Baron-Kenny and Extensions)

Decompose the total effect into (a) effect through mediator, (b) direct effect.

**Standard approach (Baron and Kenny 1986):**
```stata
*  Step 1: Total effect
reg y t, robust

*  Step 2: Mediator equation
reg m t, robust

*  Step 3: Both
reg y t m, robust
```

**Problems with Baron-Kenny:**
- Assumes no treatment × mediator interaction
- Assumes no confounding of mediator-outcome relationship
- Does not identify causal effects under interference

**Better approaches:**
- Imai et al. (2010) causal mediation analysis: `medeff` Stata package
- Hicks and Dubey (2022) for sensitivity analysis

### 4.3 Interaction / Heterogeneity by Mechanism

Test if the treatment effect is larger when the mechanism is more present.

**Example:**
```
If capital substitution is the mechanism, effects should be larger in 
capital-intensive industries.
```

**Specification:**
```stata
reg y t c.t#c.capital_intensity i.unit i.time, cluster(unit)
```

**Interpretation:** A positive interaction means the mechanism is more active where capital intensity is high.

---

## 5. Falsification Tests for Mechanisms

Every mechanism claim should be accompanied by a falsification test.

### Types of falsification:

**Placebo mechanism:** Test if an unrelated mechanism responds to treatment
```
If capital substitution is real, a placebo mechanism (e.g., advertising intensity) 
should not change with minimum wages.
reg placebo_m t, robust
```

**Temporal precedence:** The mechanism should move before or at the same time as the outcome
```
If capital investment is the mechanism, investment should increase before 
employment decreases.
```

**Cross-validation:** If mechanism M predicts effect, forcing M to vary should change the effect
```
Compare firms with high vs. low capital adjustment costs — effect should be 
smaller where adjustment costs are high.
```

---

## 6. Required Evidence for Mechanism Claims

| Claim type | Required evidence |
|---|---|
| M mediates the effect | (1) M changes with treatment; (2) effect shrinks when controlling for M |
| M moderates the effect | (3) Treatment effect varies with M (interaction test) |
| M is necessary | (4) No effect when M cannot operate (falsification test) |

**Minimum standard:** At least two of these tests should support the mechanism.

---

## 7. Presenting Mechanism Results

Structure the section:

```
6. Mechanism Analysis
  6.1 Theoretical Framework (describe the mechanism with diagram)
  6.2 Direct Measurement (test if M changes with treatment)
  6.3 Interaction Test (does effect vary with M)
  6.4 Falsification (placebo, temporal precedence, cross-validation)
  6.5 Discussion (what does this tell us about the mechanism?)
```

---

## 8. Common Errors

1. **Conflation:** Calling heterogeneity "mechanism analysis" when it's not testing causal pathways
2. **Omitted direct effect:** Not discussing what the effect is if the mechanism explains only part of it
3. **Correlation as mechanism:** Showing that M and Y are correlated is not sufficient — M must change with treatment
4. **Underpowered mediation:** Mediation tests often require more power than main effect tests
5. **No falsification:** Every mechanism claim requires at least one falsification test

---

## 9. What to Do When Mechanisms Don't Work

**If direct measurement fails:**
- The mechanism may be wrong
- Measurement error in mediator
- Multiple mechanisms operating simultaneously

**If interaction is not significant:**
- May be underpowered
- Mechanism may operate equally across all values of M
- Try continuous vs. binary split of M

**If falsification fails:**
- The mechanism is not supported — do not claim it as the explanation
- Consider alternative mechanisms

**Rule:** If the mechanism analysis fails, acknowledge it honestly. Do not omit the section or dress it up to look more conclusive than it is.

---

## 10. Journal Standards

| Journal | Mechanism analysis expectation |
|---|---|
| AER | Strong mechanism section required, especially for policy papers |
| QJE | Theory and evidence tightly integrated |
| ECMA | Structural estimation of mechanisms expected |
| ReStud | Reduced-form mechanisms with empirical identification |
| JPE | Depends on paper type |

---

## 11. Mechanism Diagram Template

Use a causal chain diagram:

```
[TREATMENT] → [M (Mediator)] → [OUTCOME]
     ↓               ↓
  [Direct]      [Confounders?]
```

In LaTeX (using tikz):
```latex
\begin{tikzpicture}[node distance=2cm]
\node (T) [draw] at (0,0) {Treatment};
\node (M) [draw] at (3,0) {Mediator M};
\node (Y) [draw] at (6,0) {Outcome Y};
\node (D) [draw, dashed] at (3,-1.5) {Direct effect};
\draw[->] (T) -- (M);
\draw[->] (M) -- (Y);
\draw[->, dashed] (T) -- (D);
\draw[->, dashed] (D) -- (Y);
\end{tikzpicture}
```

Use `.claude/references/tikz-snippets/dag-mediation.tex` as starting point.