---
paths:
  - "papers/**/manuscript/**"
  - "papers/**/manuscript/*.tex"
  - "**/lit-review/**"
  - "Bibliography_base.bib"
alwaysApply: false
---

# Literature Review Protocol

**Applies to:** Literature review sections of all economics papers.
**Companion:** `.claude/rules/manuscript-writing.md` for structure and citation style.

---

## 1. Literature Review Purpose

A literature review serves three functions in an economics paper:

1. **Position the contribution:** Show where this paper fits in the existing knowledge
2. **Establish the gap:** What question remains unanswered? Why does it matter?
3. **Guide the reader:** Prepare the reader for the empirical strategy by showing what others have found

**The review is not a summary of every paper on the topic.** It is a selective, critical synthesis organized around ideas, not around individual papers.

---

## 2. Organization Principle: Organize by Mechanism, Not by Paper

### Wrong structure (paper-by-paper):
```
Chetty et al. (2011) found X. 
Card and Krueger (1994) found Y.
...
```

### Correct structure (mechanism-by-mechanism):
```
Three mechanisms have been proposed for how minimum wages affect employment:

First, the substitution effect: higher wages make labor more expensive 
relative to capital, leading firms to automate or restructure (Acemoglu 
and Restrepo 2019). Consistent with this, Autor et al. (2016) find 
that binding minimum wages increase robot adoption at the firm level.

Second, the scale effect: higher wages increase total labor costs, 
reducing output and thus employment (Winter 2022). This mechanism 
predicts larger effects in labor-intensive industries.

Third, monopsony effects: if employers have wage-setting power, minimum 
wages can increase both wages and employment by reducing the wedge 
between marginal revenue product and wages (Card et al. 2019).
```

**Rule:** Group papers by the mechanism or question they address. Within each group, briefly compare findings and note where they differ and why.

---

## 3. Gap Identification Method

### The gap formula:
1. **What do we know?** (from reviewed literature)
2. **What is unknown?** (the gap)
3. **Why does it matter?** (the contribution)

### Example:
```
Prior work has established that minimum wages increase wages for 
low-wage workers (Dube et al. 2016). However, less is known about 
how minimum wages affect the composition of employment—whether they 
disproportionately affect certain types of workers. This matters 
because compositional effects could explain why measured employment 
effects are small even when wage effects are large.
```

### Types of gaps:
- **Identification gap:** No credible causal estimate exists
- **External validity gap:** Known effects in one context, unknown in another
- **Mechanism gap:** Effect is known, mechanism is not
- **Heterogeneity gap:** Average effect known, heterogeneity unknown

---

## 4. Citation Standards in Economics

### Author-year style (AER format):
```
(Acemoglu and Restrepo 2019)
Acemoglu and Restrepo (2019) find...
```

### With page numbers (for specific claims):
```
(Acemoglu and Restrepo 2019, 12)  [page 12]
Autor et al. (2020, Table 2)      [specific table]
```

### For specific empirical results:
```
Card and Krueger (1994, 777) report a 2.7 percent increase in 
employment following the New Jersey minimum wage increase.
```

### Multiple citations:
```
(Acemoglu and Restrepo 2019; Autor et al. 2020; Bloom et al. 2023)
```

### When to cite:
- When making a factual claim about what prior research found
- When positioning against or building on prior work
- When justifying an empirical strategy (prior papers used the same data)
- **Do not cite:** common knowledge, widely known facts, things the reader could find in any textbook

---

## 5. JEL Code Filtering

When searching for literature, use JEL codes to narrow results:

| JEL Code | Topic |
|---|---|
| J23 | Labor demand |
| J31 | Wage level and structure |
| J38 | Wage differentials |
| R23 | Urban employment |
| H22 | Fiscal incidence |
| I18 | Health economics |

**Search strategy:**
1. Start with top journals (AER, QJE, JPE, ECMA, ReStud, AER:Insights)
2. Add NBER working papers (recent, often pre-publication)
3. Use Google Scholar with JEL filter
4. Check citations of key papers (forward citations)
5. Use RePEc for ranking and related papers

---

## 6. Literature Review Length

| Paper type | Length |
|---|---|
| Short (ReStud) | 500-1,000 words |
| Medium (AER, QJE) | 1,000-1,500 words |
| Long (JPE, ECMA) | 1,500-2,000 words |

**Rule:** Every paragraph must either (a) establish a fact about the world, (b) describe a prior finding, or (c) identify a gap. If a paragraph does none of these, cut it.

---

## 7. Synthesis Principles

### Show disagreement when it exists:
```
The literature is mixed on whether minimum wages reduce employment. 
While Card and Krueger (1994) find no negative effect in the restaurant 
industry, more recent work using administrative data (Cengiz et al. 2019) 
finds negative effects concentrated among the lowest-wage establishments.
```

### Acknowledge limitations of prior work:
```
This literature has two limitations. First, most studies rely on 
cross-sectional variation in minimum wages, which may conflate the 
effect of minimum wages with state-level economic trends. Second, 
few studies examine heterogeneous effects across firm types.
```

### Transition to your contribution:
```
This paper addresses both limitations by using a difference-in-differences 
design with longitudinal firm data that tracks employment composition.
```

---

## 8. What to Include in the Introduction vs. Literature Review Section

**Introduction:** Brief positioning (2-3 paragraphs) — no more than the reader needs to understand why the paper matters. The full literature review goes in its own section.

**Literature Review section:** Comprehensive but selective. Covers all relevant prior work, organized by mechanism.

---

## 9. Common Errors

1. **Listing papers instead of synthesizing:** "Paper A did X. Paper B did Y." → "Two mechanisms have been proposed: X and Y."
2. **Outdated citations:** Check that your key citations are from the last 10 years for empirical papers
3. **Missing recent work:** Always do a fresh search before writing; the literature moves fast
4. **Citation without context:** Don't just name-drop papers; explain what they found and why it's relevant
5. **Over-citing:** If you cite more than 3 papers for a single point, you probably have a vague point

---

## 10. Literature Search Workflow

### Step 1: Core papers
Start with 3-5 seminal papers on your topic. Read their references.

### Step 2: Search
Use Google Scholar, RePEc, NBER. Use JEL codes and keywords.

### Step 3: Organize
As you read, organize by:
- Mechanism (your primary organization)
- Methodology (DiD, IV, RDD)
- Context (country, time period, industry)

### Step 4: Write
Draft the review organized by mechanism, not by paper.

### Step 5: Update
After writing results, check if any new literature appeared. Update the review accordingly.

---

## 11. Citation Manager Integration

Keep your bibliography in `Bibliography_base.bib` (root). All cite keys follow the pattern:
```
FirstauthorYEAR_shorttitle
Example: cardkrueger1994minwage
```

Update the bib file as you read. Use `bibtool` or similar to keep it clean.