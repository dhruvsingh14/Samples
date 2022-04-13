** MY NOTES: we start by examining overall frequency tabulations for ordinal variables

*Show both values and value labels in succeeding outp.
set tnumbers both.
*Basic frequency table for q1. 
frequencies q1 to q9.


** MY NOTES: we then set non response and agnostic categories to missing, eg: don't know

*Set 11 as user missing value for q1. 
missing values q1 to q9 (11).
*Rerun frequencies table. 
frequencies q1 to q9.

** MY NOTES: tabulating numerics to detect outliers and set to missing

*Run basic histogram over working hours per week. 
frequencies whours 
/format notable 
/histogram.


** MY NOTES: trimming outliers produces a much more sensible distrubtion

*Set 50 hours per week or more as user missing. 
missing values whours (50 thru hi).

*Rerun histogram. 
frequencies whours /format notable /histogram.

** MY NOTES: checking weight and filter settings before running frequency tabulations

SHOW WEIGHT FILTER N.

** MY NOTES: N column shows number of present values per var (out of total of 464)

*Check missing values per variable. 
descriptives q1 to q9.

*Note: difference / delta (464 - N) = number of missing values.

** MY NOTES: var N listwise indicates complete cases, some commands restrict to these complete cases

** MY NOTES: where n is close to 0 for a variable, ie, high level of missingness, may make sense to drop var from analysis

** MY NOTES: can create a var for storing missing values per variable, as follows:

*Create new variable holding number of missing values. 
count mis_1 = q1 to q9 (missing).
*Set description of mis_1 as variable label. 
variable labels mis_1 'Missing values over q1 to q9'. 
*Inspect frequency distribution missing values. 
frequencies mis_1.

** MY NOTES: the above block creates a variable that counts # missing values per row
** MY NOTES: for most records this is 0, so a freq tab shows 0 to have the highest freq, followed by 1 missing var, then 2 and so on

** MY NOTES: producing a correlation matrix. Pairwise exclusion includes all cases w/ notes on msising values.
correlations q1 to q9.

** MY NOTES: restricting to complete cases. Also called listwise exclusion.
correlations q1 to q9 /missing listwise.

** MY NOTES: pairwise exclusion of missing vals uses diff subsets of data based on analysis.


*Right way to compute mean. 
compute mean_a = mean(q1 to q9).
*Compute mean - wrong way 1. 
compute mean_b = (q1 + q2 + q3 + q4 + q5 + q6 + q7 + q8 + q9) / 9.
*Compute mean - wrong way 2. 
compute mean_c = sum(q1 to q9) / 9.
*Check results. 
descriptives mean_a to mean_c.





