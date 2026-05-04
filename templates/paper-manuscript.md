%  paper-manuscript.tex
%  LaTeX manuscript skeleton for empirical economics papers
%  Companion: .claude/rules/manuscript-writing.md, .claude/rules/econometrics-standards.md

\documentclass[12pt, reqno]{amsart}

%  Packages
\usepackage{amsmath, amssymb, amsthm, booktabs, graphicx, hyperref, xcolor}
\usepackage[usenames]{color}
\usepackage[margin=1in, textwidth=6.5in, textheight=9in]{geometry}
\usepackage{dcolumn}
\usepackage{caption}
\usepackage{subcaption}

%  Path to bibliography (configure in your local settings)
%  \bibliography{Bibliography_base}

%  Theorem environments (optional — delete if not needed)
\newtheorem{prop}{Proposition}
\newtheorem{assumption}{Assumption}
\newtheorem{cor}{Corollary}
\newtheorem{lma}{Lemma}
\newtheorem{thm}{Theorem}

%  Title block (replace with your paper's title)
\title{[Paper Title]%
  \thanks{[Author name, affiliation, email. For AER: include acknowledgments here.]}}

%  Author block (replace with your information)
\author{[Author Name]$^{1}$%
  \thanks{${}^1$[Institution]. Email: \texttt{email@domain.edu}.} %
  \and [Co-author]$^{2}$%
  \thanks{${}^2$[Institution]. Email: \texttt{email@domain.edu}.}}

%  Date
\date{\today}

%  Abstract (replace — 250 words max for AER)
\begin{abstract}
This paper estimates the effect of [treatment] on [outcome] using [identification strategy] with [data]. I find that [main result]. This effect is [heterogeneity/robustness]. These findings contribute to the literature on [topic].
\end{abstract}

%  JEL codes (replace with relevant codes)
 JEL codes: [e.g., J23, J31, R23]

%  Keywords
\keywords{[keyword 1], [keyword 2], [keyword 3]}

\begin{document}

%  Line numbering (optional — remove for final submission)
%  \linenumbers

%  ============================================================
%  SECTION 1: INTRODUCTION
%  ============================================================
\section{Introduction}
\label{sec:intro}

%  [HOOK — Paragraph 1]
%  Open with a real-world observation, puzzle, or policy question.
%  Make the reader care about the question.

%  [MOTIVATION AND GAP — Paragraphs 2-3]
%  What do we know? What's the gap? Why is it important?

%  [THIS PAPER — Paragraph 4]
%  State: (1) what you do, (2) what you find, (3) what the contribution is.

%  [ROADMAP — Paragraph 5, optional]
%  ``Section 2 describes the data. Section 3 presents the empirical strategy...''

%  ============================================================
%  SECTION 2: THEORETICAL MECHANISM
%  ============================================================
\section{Theoretical Mechanism}
\label{sec:theory}

%  [STATE THE MECHANISM]
%  State the mechanism clearly: M → X → Y

%  [BUILD THE LOGIC]
%  How does X lead to Y? What are the necessary conditions?

%  [TESTABLE PREDICTIONS]
%  What would we expect to observe if the mechanism is at work?

%  [RELATION TO ALTERNATIVES]
%  Why is this mechanism more plausible than alternatives?

%  Consider adding a causal diagram (M → X → Y) here.
%  Use tikz or include a standalone PDF figure.

%  ============================================================
%  SECTION 3: DATA AND EMPIRICAL STRATEGY
%  ============================================================
\section{Data and Empirical Strategy}
\label{sec:data}

\subsection{Data}
\label{sec:data:data}

%  [DATA SOURCE]
%  Name, time period, sample size, key variables

\subsection{Empirical Strategy}
\label{sec:data:strategy}

%  [IDENTIFICATION STRATEGY]
%  Explain why this strategy identifies the causal effect

%  [MAIN SPECIFICATION]
%  Show the regression equation

%  [VALIDITY CHECKS]
%  Pre-trend tests, balance tests, etc.

%  ============================================================
%  SECTION 4: RESULTS
%  ============================================================
\section{Results}
\label{sec:results}

%  [MAIN RESULT]
%  Table 2: Main results (effect size, direction, significance)

%  [EVENT STUDY / VISUAL]
%  Figure 2: Event study or other visual evidence

%  [HETEROGENEITY]
%  Tables 3-4: Heterogeneity by group/time

%  [MECHANISM]
%  (Can be separate Section 5 if preferred)

%  ============================================================
%  SECTION 5: ROBUSTNESS CHECKS
%  ============================================================
\section{Robustness Checks}
\label{sec:robustness}

%  [ALTERNATIVE SPECIFICATIONS]
%  Alternative control sets, functional forms

%  [ALTERNATIVE SAMPLES]
%  Excluding states/years, balanced panel

%  [PLACEBO TESTS]
%  Shock timing, spatial, variable placebos

%  [ALTERNATIVE IDENTIFICATION]
%  Callaway-Sant'Anna for DiD, different bandwidth for RDD

%  ============================================================
%  SECTION 6: MECHANISM ANALYSIS
%  ============================================================
\section{Mechanism Analysis}
\label{sec:mechanism}

%  [THEORETICAL FRAMEWORK]
%  Restate the mechanism with diagram

%  [DIRECT MEASUREMENT]
%  Does mediator change with treatment?

%  [INTERACTION TEST]
%  Does effect vary with mechanism strength?

%  [FALSIFICATION]
%  Placebo, temporal precedence, cross-validation

%  ============================================================
%  SECTION 7: CONCLUSION
%  ============================================================
\section{Conclusion}
\label{sec:conclusion}

%  [SUMMARY — 1 paragraph]
%  Restate the main finding

%  [IMPLICATIONS — 1-2 paragraphs]
%  What does this mean for policy/theory?

%  [LIMITATIONS — 1 paragraph]
%  Honest acknowledgment of what we cannot conclude

%  [FUTURE RESEARCH — 1 sentence]
%  What next?

%  ============================================================
%  REFERENCES
%  ============================================================
%  \bibliographystyle{aer}
%  \bibliography{Bibliography_base}

%  ============================================================
%  APPENDICES (Optional)
%  ============================================================
%  \appendix
%  \section*{Appendix}
%  \label{sec:appendix}

%  \subsection*{Proofs}
%  \subsection*{Additional Tables}
%  \subsection*{Additional Figures}

\end{document}