/******************************************************************************
* WBG STATA Assignment: 2.1 Data Management
* Dhruv Singh
* July 24th, 2021
*******************************************************************************/
set more off
clear

cd "C:\Dhruv\Data\World_Bank_Assignment"

* log file
cap log using "centralcode\data_mgmt.smcl", replace 

********************************************************************************
* Part 1: Data Management
********************************************************************************

*************************
* a) reading in .csv data
*************************
import delim using "0_raw_data\respondent_age.csv", clear

* renaming age variable
rename v3_03 age

* saving out data in .dta format
save "2_edited_data\respondent_age.dta", replace

*************************
* b) reading in .dta data
*************************
use "1_converted_data\main_dataset.dta",clear

* adding source column 
gen source = 1

* merging
merge 1:1 surveyid userid using "2_edited_data\respondent_age.dta"

* dropping merge variable after checking
drop _merge

* writing out merged data
save "2_edited_data\main_dataset_age.dta", replace

********************************
* c) reading in new observations
********************************
use "1_converted_data\new_observations.dta",clear

* adding source column 
gen source = 2

* renaming age variable
rename v3_03 age

* converting v3_08a_1_a to string for append
tostring v3_08a_1_a v4a_05_otherspecify v4a_25_otherspecify, replace

* replacing "." with blank strings
replace v3_08a_1_a="" if v3_08a_1_a=="."
replace v4a_05_otherspecify="" if v4a_05_otherspecify=="."
replace v4a_25_otherspecify="" if v4a_25_otherspecify=="."

* writing out updated new observations data
save "2_edited_data\new_observations.dta", replace

*****************************
* c) reading in main datasets
*****************************
use "2_edited_data\main_dataset_age.dta",clear

* appending new observations
append using "2_edited_data\new_observations.dta"

* writing out appended data
save "2_edited_data\main_dataset_age_new.dta", replace

**********************************************
* d) encoding a the enumerator string variable
**********************************************
encode enumerator, gen(enum_id)

* dropping value labels to protect pii
label drop enum_id

* dropping enumerator variable to protect pii
drop enumerator

*********************************************
* e) converting surveydate to datetime format
*********************************************
gen surveydate2 = date(surveydate, "YMD")
replace surveydate2 = date(surveydate, "MDY") if source == 2
format surveydate2 %td

* extracting month from datetime variable
gen month=month(surveydate2)

************************************
* f) checking number of observations
************************************
count

* sampling 5% of our data without replacement
sample 5

* checking count
count

* keeping only relevant variables
keep userid surveyid surveydate2
rename surveydate2 surveydate

* exporting excel worksheet
export excel using "2_edited_data\survey_callbacks.xlsx", ///
				firstrow(variables) nolabel  replace

log close
