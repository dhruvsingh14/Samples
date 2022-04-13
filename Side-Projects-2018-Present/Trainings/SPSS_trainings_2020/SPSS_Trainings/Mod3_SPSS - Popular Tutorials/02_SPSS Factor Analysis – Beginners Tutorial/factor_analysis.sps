** MY NOTES: examining underlying factors responsible for variations in dole dataset

*Show variable names, values and labels in output tab 

set
tnumbers both /* show values and value labels in output tables */
tvars both /* show variable names but not labels in output tables */
ovars names. /* show variable names but not labels in output outline */

*Basic frequency tables with bar charts.
frequencies v1 to v20
/barchart.

** MY NOTES: quick descriptive statistics above show to look out for non answer and syst. missing vals whenever desc. stats. run.

*Set 8 ('No answer') as user missing value for all va.
missing values v1 to v20 (8).
*Inspect valid N for each variable. 
descriptives v1 to v20.

** MY NOTES: only 149 out of 388 complete cases

*Show both variable names and labels in output.

set tvars both.

*Initial factor analysis as pasted from menu.

FACTOR
/VARIABLES v1 v2 v3 v4 v5 v6 v7 v8 v9 v11 v12 v13 v14 v16 v17 v20
/MISSING PAIRWISE /*IMPORTANT!*/
/PRINT INITIAL CORRELATION EXTRACTION ROTATION
/FORMAT SORT BLANK(.30)
/PLOT EIGEN
/CRITERIA MINEIGEN(1) ITERATE(25)
/EXTRACTION PC
/CRITERIA ITERATE(25)
/ROTATION VARIMAX
/METHOD=CORRELATION.



*Create factors as means over variables per factor.

compute fac_1 = mean(v16,v13,v17,v2,v9).
compute fac_2 = mean(v3,v1,v5,v20).
compute fac_3 = mean(v11,v7,v6,v8).
compute fac_4 = mean(v4,v14,v12).

*Label factors.

variable labels
fac_1 'Clarity of information'
fac_2 'Decency and appropriateness'
fac_3 'Helpfulness contact person'
fac_4 'Reliability of agreements'.

*Quick check.

descriptives fac_1 to fac_4.
