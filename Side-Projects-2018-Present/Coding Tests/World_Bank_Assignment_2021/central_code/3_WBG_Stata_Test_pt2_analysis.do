/******************************************************************************
* WBG STATA Assignment: 2.2 Data Analysis
* Dhruv Singh
* July 24th, 2021
*******************************************************************************/
set more off
clear

cd "C:\Dhruv\Data\World_Bank_Assignment"

* log file
cap log using "centralcode\analysis.smcl", replace 

********************************************************************************
* Part 2: Data Analysis
********************************************************************************

*********************************
* a) selecting relevant variables
*********************************

* reading in combined .dta
use "2_edited_data\main_dataset_age_new.dta",clear

* keeping relevant variables 
keep covid_deterioration v3_02 v3_04 v3_09 v3_10 age v6_02_1

****************************
* b) tabulating relationship
****************************

* crosstabs and exporting
* ssc install asdoc
asdoc tab covid_deterioration v3_02
asdoc tab covid_deterioration v3_04
asdoc tab covid_deterioration v3_09
asdoc tab covid_deterioration v3_10
asdoc tab covid_deterioration v6_02_1
asdoc tab covid_deterioration age

* frequency tabs
tab v3_02

tab v3_04

tab v3_09

tab v3_10

tab age

tab v6_02_1

* binning data / creating categorical variables

* gender
gen gender_num = 0 
replace gender_num = 1 if v3_02 == "FEMALE"

* education
gen educ_num = 0 /* No class passed/pre-schooling | Other [Specify] */
replace educ_num = 1 if v3_04 == "PSC/PEC/equivalent" | ///
						v3_04 == "Class 1" | ///
						v3_04 == "Class 2"
					
replace educ_num = 2 if v3_04 == "JSC/equivalent" | ///
						v3_04 == "Class 3" | ///
						v3_04 == "Class 4"

replace educ_num = 3 if v3_04 == "SSC/equivalent" | ///
						v3_04 == "Class 6" | ///
						v3_04 == "Class 7"

replace educ_num = 4 if v3_04 == "HSC/equivalent" | ///
						v3_04 == "Class 9"
						
replace educ_num = 5 if v3_04 == "Technical Education" | ///
						v3_04 == "Vocational"

replace educ_num = 6 if v3_04 == "Nursing" | ///
						v3_04 == "Graduate/equivalent"

replace educ_num = 7 if v3_04 == "Post graduate/equivalent" | ///
						v3_04 == "Engineering" | ///
						v3_04 == "Medical"
						
tab educ_num						

* city/district/village
gen cdv = 0
replace cdv = 1 if v3_09 == "District town"
replace cdv = 2 if v3_09 == "Capital City/City"

tab cdv


* leaving household size as is
* leaving age as is

* covid deterioration
gen covid_det = 0
replace covid_det = 1 if covid_deterioration == "Faced deterioration"
tab covid_det

* emergency funds
gen emerg = 0
replace emerg = 1 if v6_02_1 == "Yes"
tab emerg
						
* correlations
corr covid_det v3_10

corr covid_det age

* writing out final dataset
save "2_edited_data\final_dataset.dta", replace


******************************
* c) labor force participation
******************************

* reading in combined .dta
use "2_edited_data\main_dataset_age_new.dta",clear

* generating labor force variable using worked in last 7 days 
* or seeking employment in last 7 days
gen labor_force = 0
replace labor_force = 1 if v4_04 == "YES" | v4_07a_14 == "Yes"

* 3802 changes made / 7692
* 49.4279%

*****************************
* d) linear probability model
*****************************

* reading in final dataset .dta
use "2_edited_data\final_dataset.dta",clear


* keeping relevant variables 
keep covid_det age gender_num educ_num cdv v3_10 emerg 

asdoc reg covid_det age gender_num educ_num cdv v3_10 emerg 


log close




