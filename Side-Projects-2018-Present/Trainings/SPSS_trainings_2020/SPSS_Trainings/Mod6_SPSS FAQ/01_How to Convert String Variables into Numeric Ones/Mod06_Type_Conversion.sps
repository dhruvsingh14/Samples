***************************************************************************************************************
PROJECT:            SPSS Trainings 
PROGRAM:          Module05_Filters
PROGRAMMER:   D. Singh, Fors Marsh Group
CHANGE LOG:     01/22/2019   -Program created
***************************************************************************************************************.

**************************************************************************************************************
DIRECTORY
**************************************************************************************************************.
cd 'C:\Dhruv\misc\data\SPSS_Trainings\Mod6_SPSS FAQ\01_How to Convert String Variables into Numeric Ones'.

******************************************************************************************
IMPORT CONVERT STRINGS DATASET
******************************************************************************************.
get file="convert-strings.sav".

dataset name CONVERT window=asis.
dataset activate CONVERT window=asis.

******************************************************************************************
PART I: DEMONSTRATING INCOMPLETE CONVERSIONS, SYSMISS
******************************************************************************************.
* set empty strings as user missing value for s3.
missing values s3('').

* inspect frequency table for s3.
frequencies s3.

* now manually convert s3 to numeric under variable view.

* inspect result.
descriptives s3.

* N = 444 instead of 459. That is, 15 values failed to convert and we've no clue why.
frequencies s3.

******************************************************************************************
PART II: CONVERTING USING ALTER TYPE COMMAND, BEST PRACTICE
******************************************************************************************.
* close data without saving and repen before proceeding.
dataset close CONVERT.
get file="convert-strings.sav".
dataset name CONVERT window=asis.
dataset activate CONVERT window=asis.

* convert all variables in one go.
alter type s1 to s3 (f1) s4 (f6.3).

* inspect descriptives.
descriptives s1 to s4.

******************************************************************************************
PART III: SOLUTION 2, COPY AND CONVERT STRING VARS
******************************************************************************************.
* close data without saving and reopen before proceeding.

* dataset close and open.
dataset close CONVERT.
get file="convert-strings.sav".
dataset name CONVERT window=asis.
dataset activate CONVERT window=asis.

* copy all string variables.
string c1 to c4 (a7).
recode s1 to s4 (else = copy) into c1 to c4.

* convert variables into numeric.
alter type s1 to s3 (f1) s4 (f6.3).

* for each variable, flag conversion failures: cases where converted value is system missing by original value is not empty.
do repeat #conv = s1 to s4 / #ori  = c1 to c4 / #flags = flag1 to flag4.
if(sysmis(#conv) and #ori <> '') #flags = 1.
end repeat.

* if N>0, conversion failures occured for some variable.
descriptives flag1 to flag4.

******************************************************************************************
PART IV: VISUALLY INSPECTING DATA THAT FAILS TO CONVERT
******************************************************************************************.
* visually inspect why valyes fail to convert.
sort cases by flag3(d).

* some values flagged with 'a'.
sort cases by flag4 (d).

* some values flagged with 'a' through 'e'.

******************************************************************************************
PART V: REMOVE ILLEGAL CHARACTERS, COPY AND CONVERT
******************************************************************************************.
* close data without saving and reopen before proceeding.

* dataset close and open.
dataset close CONVERT.
get file="convert-strings.sav".
dataset name CONVERT window=asis.
dataset activate CONVERT window=asis.

* copy all stringvars.
string c1 to c4 (a7).
recode s1 to s4 (else = copy) into c1 to c4.

* remove 'a' from a3.
compute s3 = replace(s3, 'a', '').

* remove 'a' through 'e' from s4.
do repeat #char = 'a' 'b' 'c' 'd' 'e'.
compute s4 = replace(s4, #char, '').
end repeat.

* try and convert variable again.
alter type s1 to s3 (f1) s4 (f6.3).

* flag conversion failures again.
do repeat #conv = s1 to s4 / #ori = c1 to c4 / #flags = flag1 to flag4.
if(sysmis(#conv) and #ori <> '') #flags = 1.
end repeat.

* inspect if conversion succeeded.
descriptives flag1 to flag4.

* N = 0 for all flag variables so we're done.

* Delete copied and flag variables.


































