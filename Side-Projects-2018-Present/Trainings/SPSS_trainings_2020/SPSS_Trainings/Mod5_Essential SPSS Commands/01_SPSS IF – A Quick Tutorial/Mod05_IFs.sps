***************************************************************************************************************
PROJECT:            SPSS Trainings 
PROGRAM:          Module05_IFs
PROGRAMMER:   D. Singh, Fors Marsh Group
CHANGE LOG:     12/2/2019   -Program created
***************************************************************************************************************.

**************************************************************************************************************
DIRECTORY
**************************************************************************************************************.
cd 'C:\Dhruv\Dec\Week1\data_training\SPSS\SPSS_Beginners_Tutorials\Mod5_Essential SPSS Commands\01_SPSS IF – A Quick Tutorial'.


******************************************************************************************
IMPORT WEB DATASET
******************************************************************************************.
get file="bank.sav".

dataset name BANK window=asis.
dataset activate BANK window=asis.

******************************************************************************************
CREATING FLAG VARIABLE(S)
******************************************************************************************.

*Create new variable holding only zeroes. 
compute born80s = 0.

*Set value to 1 if respondent born between 1980 and 1989.
if(range(xdate.year(dob),1980,1989)) born80s = 1.
execute.

*Optionally: add value labels.
add value labels born80s 0 'Not born during 80s' 1 'Born during 80s'.


******************************************************************************************
REPLACING OUTLIER VALUES WITH CORRECTED UNIT
******************************************************************************************.

*Sort cases descendingly on weekly hours.
sort cases by whours (d).

*Divide 160 or more hours by 4.33 (average weeks per month).
if(whours >= 160) whours = whours / 4.33.
execute.

* Alternative code for same purpose.
* recodes values manually, not conditionally.
recode whours (160 = 36.95)(180 = 41.57).


******************************************************************************************
COMPUTE CONDITIONAL VARIABLES
******************************************************************************************.

* declaring empty variable.
compute fulltime = 0.

* setting fulltime binary equal to 1 based on gender and work hr constraints.
if(gender = 0 & whours >= 36) fulltime = 1.
if(gender = 1 & whours >= 40) fulltime = 1.

* value labels.
add value labels fulltime 0 'Not working fulltime' 1 'Working fulltime'.

* checking output from compute and if.
means whours by gender by fulltime
/cells min max mean stddev.


******************************************************************************************
DO IFS
******************************************************************************************.

*DO IF: respondents meeting both conditions get result_1.
do if(overall >= 8).
compute job_sat = 0.
recode job_sat (0 = 3).
else if(overall<=4). /*excludes cases meeting condition_1.
recode job_sat (0 = 1).
end if.

*IF: respondents meeting both conditions get result_2.
if(overall >= 8) job_sat = 3.
if(overall<=4) job_sat = 1. /*includes cases meeting condition_1.

* this above code is not running!
* good attempt at the logic though


* attempting to recode system missing values.
recode job_sat (sysmis = 0).
if(sysmis(job_sat)) job_sat = 0.


* incorprating multiple conditions into recoding variable.

if(gender = 0 & whours >= 36) fulltime = 1.



******************************************************************************************
USING RECODES 
******************************************************************************************.

*Recode whours into fulltime for everyone.
recode whours (40 thru hi = 1)(else = 0) into fulltime2.

*Apply different recode for female respondents.
do if(gender = 0).
recode whours (36 thru hi = 1)(else = 0) into fulltime2.
end if.

*Optionally, add value labels.
add value labels fulltime2 0 'Not working fulltime' 1 'Working fulltime'.

*Quick check.
means whours by gender by fulltime2
/cells min max mean stddev.





































******************************************************************************************
EXPORT BANK MODIFIED
******************************************************************************************.
dataset activate BANK window=asis.
save outfile="Bank_mod.sav" /compressed.
execute.

