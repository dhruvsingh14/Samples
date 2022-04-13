***************************************************************************************************************
PROJECT:            SPSS Trainings 
PROGRAM:          Module05_Filters
PROGRAMMER:   D. Singh, Fors Marsh Group
CHANGE LOG:     01/20/2019   -Program created
***************************************************************************************************************.

**************************************************************************************************************
DIRECTORY
**************************************************************************************************************.
cd 'C:\Dhruv\misc\data\SPSS_Trainings\Mod5_Essential SPSS Commands\02_SPSS FILTER – Quick & Simple Tutorial'.

******************************************************************************************
IMPORT BANK DATASET
******************************************************************************************.
get file="bank_clean.sav".

dataset name BANK window=asis.
dataset activate BANK window=asis.

******************************************************************************************
CREATING A NEW FILTER VARIABLE
******************************************************************************************.

*Create new variable holding number of missings over q1 to q9.
compute mis_1 = nmiss(q1 to q9).

*Apply variable label.
variable labels mis_1 'Number of missings on q1 to q9'.

*Check frequencies.
frequencies mis_1.

* recoding mis_1 into filter variable.
recode mis_1 (lo thru 2 = 1)(else = 0) into filt_1.

* apply variable label.
variable labels filt_1 'Filter out cases with 3 or more missings on q1 to q9'.

* Activate filter variable.
filter by filt_1.

* Reinspect number of missing over q1 to q9.
frequencies mis_1.

* NOTE:.
* filtering out 3 or more missings is much like adhering to a protocol of partial completes given a certain threshold.
* and filtering out responses below the minimal response threshold.

* deactivating filter.
filter off.


************************************************************
PART II OF ANALYSIS: FILTER ON 2 VARIABLES
************************************************************.
* show values and value label in subsequent output tables.
set tnumbers both. 

* show frequencies for job type per gender.
crosstabs gender by jtype.

* create filter variable holding only zeroes. 
* in other words - declare new variable.
compute filter_2 = 0.

* set filter to 1 for females in hob types 1 and 2.
if (gender = 0 & jtype <= 2) filt_2 = 1.

* apply variable label.
variable labels filter_2 'Filter in females working in sales and marketing.'

* activate filter.
filter by filt_2.

* confirm filter working properly.
crosstabs gender by jtype.

* Note: only 1 filter variable can be active at a time.
* deactivating filter variable.

filter off.

********************************************************************
PART III OF ANALYSIS: FILTER W/O FILTER VARIABLE 
********************************************************************.

* make following transformation(s) temporary.
temporary.

* delete cases unless gender = 1 & jtype = 3.
select if (gender = 1 & jtype = 3).

* cosstabs includes only males in IT and rolls back case selection.
crosstabs gender by jtype.

* crosstabs includes all cases again.
crosstabs gender by jtype.

********************************************************************
PART IV OF TRAINING: DATA AFFECTED BY FILTERS 
********************************************************************.
* reactivate female sales filter.
filter by filt_2.

* not affected by filter: add mean over q1 to q9 to data.
compute mean_1 = mean(q1 to q9).
execute.

* affected by filter: add case count to data.
aggregate outfile * mode addvariables
/ofreq = n.

* affected by filter: add z-scores salary to data.
descriptives salary
/save.

* affected by filter: add median groups salary to data.
rank salary
/ntiles(2) into med_salary.
























