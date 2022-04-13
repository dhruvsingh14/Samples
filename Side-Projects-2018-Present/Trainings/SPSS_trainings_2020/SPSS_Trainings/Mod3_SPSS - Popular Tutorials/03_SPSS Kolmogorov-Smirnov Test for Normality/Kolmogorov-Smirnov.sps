** MY NOTE: mapping / charting dist to see normality visually

*Run basic histograms for inspecting if distributions look plausible.

frequencies r01 to r05
/format notable
/histogram normal.

*Note that some distributions do not look plausible at all!

** MY NOTE: using KS test to check for probability of more than 0.05 (signifiance) and hence probability

*One-sample Kolmogorov-Smirnov test from analyze - nonparametric tests - legacy dialogs - 1 sample ks-test.

NPAR TESTS
/K-S(NORMAL)=r01 r02 r03 r04 r05
/MISSING ANALYSIS.

*Only reaction time 4 has p > 0.05 and thus seems normally distributed in population.
*One-sample Kolmogorov-Smirnov test from analyze - descriptive statistics - explore.

** MY NOTE: sign level > 0.05 implies normal distribution.
EXAMINE VARIABLES=r01 r02 r03 r04 r05
/PLOT BOXPLOT NPPLOT
/COMPARE GROUPS
/STATISTICS NONE
/CINTERVAL 95
/MISSING PAIRWISE /*IMPORTANT!*/
/NOTOTAL.

*Shorter version.

EXAMINE VARIABLES r01 r02 r03 r04 r05
/PLOT NPPLOT
/missing pairwise /*IMPORTANT!*/.


