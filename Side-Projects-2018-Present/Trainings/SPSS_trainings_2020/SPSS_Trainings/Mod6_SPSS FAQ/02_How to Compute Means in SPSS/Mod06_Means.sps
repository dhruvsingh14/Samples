***************************************************************************************************************
PROJECT:            SPSS Trainings 
PROGRAM:          Module05_Filters
PROGRAMMER:   D. Singh, Fors Marsh Group
CHANGE LOG:     01/22/2019   -Program created
***************************************************************************************************************.

**************************************************************************************************************
DIRECTORY
**************************************************************************************************************.
cd 'C:\Dhruv\misc\data\SPSS_Trainings\Mod6_SPSS FAQ\02_How to Compute Means in SPSS'.

******************************************************************************************
IMPORT CONVERT STRINGS DATASET
******************************************************************************************.
get file="restaurant.sav".

dataset name RESTAURANT window=asis.
dataset activate RESTAURANT window=asis.

******************************************************************************************
PART I: INSPECTING DATA
******************************************************************************************.
* show data values and value labels in output tables.
set tnumbers both.

* quick data check.
frequencies v1 to v5.

******************************************************************************************
PART II: SETTING MISSING VALUES
******************************************************************************************.
* set 6 as user missing value.
missing values v1 to v5 (6).

* check again.
frequencies v1 to v5.

******************************************************************************************
PART III: COMPUTING MEANS OVER VARIABLES
******************************************************************************************.
* compute mean over v1, v2, v3, v4 and v5.
compute happy1 = mean(v1, v2, v3, v4, v5).
execute.

* alternative: use TO keyword for specifying variables.
compute happy2 = mean(v1 to v5).
execute.


******************************************************************************************
PART IV: MISSING VALUES - EXCLUDE CASES W/ MANY MISSINGS
******************************************************************************************.
* compute mean only for cases having at least 3 valid.
compute happy3 = mean.3(v1 to v5).
execute.

* alternative way to exclude cases having fewer than 3 valid values over v1 to v5.
if (nvalid (v1 to v5) >= 3) happy4 = mean(v1 to v5).
execute.


******************************************************************************************
PART V: COMPUTING VERTICAL MEANS
******************************************************************************************.
* show only value labels (no data values) in output tables.
set tnumbers labels.

* report means for gender separately.
means v1 v2 by gender / cells means.

* add mean over v1 as new variable to data.
aggregate outfile * mode addvariables
/mean_1 = mean(v1).

* add means over v2 to v5 for genders separately as new variables to data.
aggregate outfile * mode addvariables
/break gender
/mean_2 to mean_5 = mean(v2 to v5).







