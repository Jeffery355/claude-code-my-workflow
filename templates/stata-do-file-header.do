*  [FILENAME].do
*  [BRIEF DESCRIPTION OF WHAT THIS FILE DOES]
*  Author: [Your Name]
*  Created: [YYYY-MM-DD]
*  Last modified: [YYYY-MM-DD]
*  Paper: [PAPER TITLE]
*  Output: [WHAT THIS FILE PRODUCES]

*  ============================================================
*  BOILERPLATE
*  ============================================================
version 17
clear all
cap log close
set more off

*  Optional: Add personal utilities to adopath
*  adopath++ "/path/to/do-files/shared"

*  ============================================================
*  PATHS — Set in 00_master.do, uncomment if running standalone
*  ============================================================
*  global ROOTDIR  "/path/to/papers/[slug]"
*  global DATADIR   "$ROOTDIR/data"
*  global OUTDIR    "$ROOTDIR/outputs"
*  global TABLEDIR  "$ROOTDIR/tables"
*  global FIGDIR    "$ROOTDIR/figures"
*  global LOGDIR    "$ROOTDIR/logs"

*  ============================================================
*  LOG FILE
*  ============================================================
log using "$LOGDIR/[filename].log", text replace

*  ============================================================
*  BODY
*  ============================================================
*  [YOUR CODE HERE]

*  ============================================================
*  END
*  ============================================================
log close