# Manuscript Writing Standards

**Applies to:** All economics paper manuscripts in `papers/[slug]/manuscript/`.
**Companion:** `.claude/rules/econometrics-standards.md`, `.claude/rules/literature-review-protocol.md`.

---

## 1. Paper Structure (AER / QJE / JPE / ECMA / ReStud)

Standard sections (in order):

1. **Abstract** (150-300 words, 4 sentences)
2. **Introduction** (1,500-3,000 words)
3. **Theoretical Mechanism** OR **Conceptual Framework** (1,000-2,000 words)
4. **Data and Empirical Strategy** (2,000-4,000 words)
5. **Results** (2,000-5,000 words)
6. **Robustness Checks** (1,500-3,000 words)
7. **Mechanism Analysis** OR **Heterogeneity** (1,000-2,000 words)
8. **Conclusion** (500-1,000 words)
9. **References**
10. **Appendices** (Online Appendix, Proofs, Additional Tables/Figures)

---

## 2. Abstract (4-Sentence Framework)

Each sentence has a specific function:

1. **Question:** State the economic question and why it matters
2. **Method:** Describe the identification strategy and data
3. **Result:** Report the main finding (effect size, direction)
4. **Contribution:** State the contribution to the literature

**AER example structure:**
```
This paper estimates the effect of minimum wage increases on employment 
in the restaurant industry using a difference-in-differences design with 
state-level panel data from 1990-2019. I find that a $1 increase in the 
minimum wage reduces restaurant employment by 2.4 percent. This effect is 
concentrated among young workers and part-time employees. These findings 
contrast with previous research using cross-sectional methods.
```

**Length:** 150-300 words. AER specifies 250 words max; check your target journal.

**Do NOT include:**
- Citations in abstract
- abbreviations (spell out minimum wage, not MW)
- Table/figure references

---

## 3. Introduction Structure

### 3.1 The Hook (Paragraph 1)
Open with a real-world observation or puzzle. Make the reader care.

**Bad:** "Minimum wages have been studied extensively."
**Good:** "The Earned Income Tax Credit supplements wages for 10 million low-income workers. Despite its scale, little is known about how employers respond when their workers receive this income supplement."

### 3.2 Motivation and Gap (Paragraph 2-3)
What do we know? What's the gap? Why is it important?

### 3.3 This Paper (Paragraph 4)
State: (1) what you do, (2) what you find, (3) what the contribution is.

### 3.4 Roadmap (Paragraph 5, optional)
"Section 2 describes the data. Section 3 presents the empirical strategy..."

### 3.5 Length
- Short (ReStud): 1,500 words
- Medium (AER, QJE): 2,500 words
- Long (JPE): 3,000 words

---

## 4. Theoretical Mechanism

### Structure:
1. **State the mechanism:** "The mechanism I propose is X → Y"
2. **Build the logic:** How does X lead to Y? What are the necessary conditions?
3. **Testable predictions:** What would we expect to observe if the mechanism is at work?
4. **Relation to alternative mechanisms:** Why is this mechanism more plausible than alternatives?

### Writing style:
- Use "I argue that..." not "It is argued that..."
- State assumptions explicitly
- Use figures to illustrate causal chain (M → X → Y diagram)

---

## 5. Data and Empirical Strategy

### Required elements:
- **Data source:** Name, time period, sample size
- **Key variables:** Table 1 with variable names, definitions, summary stats
- **Sample restrictions:** Why observations are dropped (report counts)
- **Identification strategy:** Explain the strategy and why it identifies the causal effect
- **Main specification:** Show the regression equation
- **Parallel trends / validity checks:** Pre-trend tests, balance tests

---

## 6. Results Section

### Structure by identification type:

**DiD:**
- Main result (Table 2)
- Event study (Figure 2)
- Heterogeneity by group/time
- Mechanism (Section 7)

**IV:**
- Reduced form (Table 2, first column)
- First stage (Table 2, second column)
- 2SLS (Table 2, third column)
- F-statistic and overidentification test

**RDD:**
- Main result at cutoff (Table 2)
- Placebo cutoffs (Table 3)
- Bandwidth sensitivity (Table 3)
- McCrary test

### Required elements:
- Always report: N, mean, SD, min, max for main variables
- Always show: clustered standard errors in parentheses below coefficients
- Always include: significance stars with note at bottom
- Always include: dependent variable mean or SD in notes

---

## 7. Robustness Checks

### Standard robustness tests to include:

**DiD:**
- Alternative treatment definition (binary vs continuous)
- Alternative control group
- Excluding individual states/years
- Different time periods
- Event study with different lead/lag structure
- Callaway-Sant'Anna (2021) estimator comparison

**Panel:**
- Alternative fixed effects structure
- Different clustering levels
- OLS vs FE comparison
- Alternative sample restrictions

**IV/RDD:**
- Weak instrument tests
- Alternative bandwidth selection
- Placebo cutoffs
- Donut hole exclusion

---

## 8. Mechanism Analysis

### Structure:
1. **State mechanism:** "I now examine whether mechanism M explains the results"
2. **Testable prediction:** "If M is the mechanism, we should observe X"
3. **Empirical test:** Run the test, report results
4. **Discuss:** What do the results say about the mechanism?

### Common approaches:
- Mediation analysis (Baron-Kenny, causal mediation)
- Interaction tests (is effect larger when mechanism is more present?)
- Direct measurement (if mechanism variable is observable)

---

## 9. Conclusion

### Structure:
1. **Summary:** Restate the main finding (1 paragraph)
2. **Implications:** What does this mean for policy/theory? (1-2 paragraphs)
3. **Limitations:** Honest acknowledgment of what we cannot conclude (1 paragraph)
4. **Future research:** What next? (1 sentence)

### Do NOT:
- Introduce new results in the conclusion
- Use "In conclusion..."
- Overstate the generalizability

---

## 10. Tables and Figures

### Table structure:
- **Title:** "Table X: [Descriptive Title]"
- **Column headers:** Dependent variable and sample
- **Row stubs:** Independent variables
- **Notes:** Significance stars, data source, sample restrictions, clustering

### Figure structure:
- **Title:** "Figure X: [Descriptive Title]"
- **Axis labels:** Clear, with units
- **Legend:** If multiple series
- **Notes:** Sample, data source, dropped observations

### Cross-referencing:
- Every table/figure must be referenced in the text: "Table 2 shows..."
- Tables/figures should be interpretable without reading the full text

---

## 11. References

### Economics citation style (AER):

**In-text:** `Acemoglu and Restrepo (2019)` or `(Acemoglu and Restrepo 2019)`
**With page numbers:** `Acemoglu and Restrepo (2019, 12)`
**Multiple:** `Acemoglu and Restrepo 2019; Autor et al. 2020`

**Bibliography (AER format):**
```
Acemoglu, Daron, and Pascual Restrepo. 2019. "Automation and New Tasks: 
  How Technology Displaces and Reinstates Labor." Journal of Economic 
  Perspectives 33 (2): 3–30.
```

---

## 12. Journal-Specific Notes

| Journal | Word limit | Abstract | Notes |
|---|---|---|---|
| AER | No strict limit | 250 words | Data availability statement required |
| QJE | ~15,000 words | No limit | Online appendix strongly encouraged |
| JPE | ~12,000 words | 150 words | Very competitive |
| ECMA | ~12,000 words | 250 words | Strong structural emphasis |
| ReStud | ~10,000 words | 150 words | Applied micro focus |

---

## 13. LaTeX Structure

Use `booktabs` for tables. Never use vertical lines.

```latex
\begin{table}[htbp]
  \centering
  \caption{ Main Results }
  \begin{tabular}{lccc}
  \toprule
  & \multicolumn{3}{c}{Dependent Variable: Y} \\
  \cmidrule(lr){2-4}
  & (1) & (2) & (3) \\
  \midrule
  Treatment & 0.05*** & 0.04*** & 0.03** \\
            & (0.01)   & (0.01)   & (0.01)   \\
  \bottomrule
  \end{tabular}
  \notes{Significance: * p<0.10, ** p<0.05, *** p<0.01. 
         Clustered standard errors in parentheses.}
\end{table}
```

---

## 14. Common Errors to Avoid

1. **Run-on sentences:** Economics writing is direct. One idea per sentence.
2. **Passive voice:** "It is found" → "I find"
3. **Unnecessary jargon:** Define terms when first used
4. **Hedging without evidence:** "This may suggest" → only if you have no better evidence
5. **Citation density:** Don't cite everything. Cite the relevant papers that changed the field.