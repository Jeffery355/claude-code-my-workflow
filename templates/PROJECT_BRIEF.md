# Project Brief — [Paper Title]

**Copy this file to the repository root as `PROJECT_BRIEF.md` before running `/init-econ-paper`.**

**This is the ONE configuration file for your paper. Everything else derives from it.**

---

## Paper Metadata

**Title:** [Full paper title — will be used for directory slug and manuscript]

**Short slug:** [e.g., effect-minimum-wage-employment — for directory names, use kebab-case]

**Author(s):** [Your name, affiliation; co-authors]

**Target journal:** [AER / QJE / JPE / ECMA / ReStud / Other]

**Created:** [YYYY-MM-DD]

---

## Research Question

**Main question:** [One sentence. What is the economic question this paper answers?]

**Why it matters:** [2-3 sentences. What is the policy or scientific relevance?]

**Contribution:** [1-2 sentences. How does this advance the literature? What gap does it fill?]

---

## Data

**Primary data source:** [e.g., CPS, NLSY, SCF, administrative data, custom survey]

**Time period:** [e.g., 1990-2019, 2005-2022]

**Unit of observation:** [e.g., individuals, firms, counties, states]

**Sample size:** [Approximate N; can be updated after cleaning]

**Data access:** [Where the data is stored, any required credentials]

---

## Key Variables

**Treatment variable(s):**
- Name: [variable name in dataset]
- Definition: [how it is constructed]
- Source: [which dataset variable comes from]

**Outcome variable(s):**
- Name: [variable name]
- Definition: [how constructed, any transformations]
- Source: [which dataset]

**Control variables:**
| Variable | Definition | Source |
|---|---|---|
| [ctrl_1] | [description] | [source] |
| [ctrl_2] | [description] | [source] |
| ... | ... | ... |

**Fixed effects:**
- Unit FE: [Yes/No] — [e.g., firm, county, state]
- Time FE: [Yes/No] — [e.g., year, month, quarter]
- Other FE: [e.g., occupation × year, county × year]

---

## Identification Strategy

**Primary strategy:** [Choose one: Difference-in-Differences / Panel FE / IV / RDD / RCT / Other]

### For DiD:
- Treatment: [what is the treatment and when does it start]
- Control group: [what is the comparison group]
- Parallel trends assumption: [why is it plausible here]
- Pre-trend test plan: [event study / joint F-test / etc.]

### For Panel FE:
- Variation: [within-unit over time vs. cross-sectional]
- Endogeneity concern: [what is the threat]
- Solution: [how does FE address it]

### For IV:
- Instrument: [what is Z and why is it valid]
- First stage: [expected F-statistic]
- Overidentification: [testable or not]

### For RDD:
- Running variable: [what is the cutoff variable]
- Cutoff: [value where treatment changes]
- Bandwidth: [planned bandwidth selection method]

---

## Hypotheses (Optional — for pre-registration)

**H1:** [Primary hypothesis — e.g., "Minimum wage increases reduce employment"]

**H2:** [Secondary — e.g., "Effects are larger for low-wage industries"]

**H3:** [Tertiary — e.g., "Effects operate through capital substitution"]

---

## Current Task

**What needs to be done now:**

- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

**Blocked by:** [Any dependencies or data access issues]

**Next step:** [The most immediate action to take]

---

## Notes

[Any other project-specific information that should be remembered across sessions]

---

*Last updated: [YYYY-MM-DD]*
*Update this file as the project evolves — especially after data cleaning and identification decisions.*