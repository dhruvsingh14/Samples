
/*
Will you keep track of the number of people who pass by? 
Probability of donating = #of people who donate/#of potential donors (those who see the sign). 

Your outcome variables are two: 
(1) Probability of donating. this could be #donated/#asked and #donated/#who passed by. 
(2) Average amount donated. this could be conditional on being asked and unconditional on having seen the sign.
*/


clear all
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Input"
import excel "SurveyData_J.xlsx", sheet("Sheet1") firstrow
tostring time_pressure preferred_donation_time, replace
save "RawData_Individual.dta", replace

import excel "SurveyData_DS.xlsx", sheet("Sheet1") firstrow clear
tostring time_pressure, replace
append using "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Input/RawData_Individual.dta"
tostring hunger_level, replace
save "RawData_Individual.dta", replace


import excel "SurveyData_JK.xlsx", sheet("Sheet1") firstrow clear
tostring time_pressure preferred_donation_time Zipcode, replace
append using "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Input/RawData_Individual.dta"
ren meal_hall_day meal_hall_date
save "RawData_Individual.dta", replace
********************************************************************************
********************************************************************************

clear all
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Input"
use "RawData_Individual.dta", clear

gen date = substr(meal_hall_date,-4,4)
gen Hunger =(date == "0402"| date == "0403"| date == "0404"| date == "0405")
replace Hunger = 1 - Hunger

gen Hunger_R = Hunger if survey_note == ""
replace Hunger_R = 1 if survey_note == "No eat"
replace Hunger_R = 0 if survey_note == "Old woman, already ate, didn't survey"
replace Hunger_R = 0 if survey_note == "Already Ate"
replace Hunger_R = 0 if survey_note == "Already Ate, donated before and donate again/ suddenly came out from Sbisa and went inside again"
replace Hunger_R = Hunger if Hunger_R == .
replace OldSurvey = 0 if OldSurvey == .
****************************************
* This is an outlier
replace  time_pressure = "4" if time_pressure == "4/5/6"
destring time_pressure, replace

#delimit
la define time_pressure
1 "Not at all"
2 "2"
3 "Neutral"
4 "4"
5 "Extremely busy";
la val time_pressure time_pressure;
#delimit cr
****************************************
gen hunger_old = hunger_level if OldSurvey == 1

* This is an outlier
replace hunger_old = "4" if hunger_level == "2/4"
destring hunger_old, replace

#delimit
la def hunger_old
1 "Starving"
2 "2"
3 "Neutral"
4 "4"
5 "Not hunger";
la val hunger_old hunger_old;
#delimit cr

gen hunger_sated = hunger_level if OldSurvey == 0 & date == "0405" 
destring hunger_sated, replace
#delimit
la def hunger_sated
1 "No, I did not eat much."
2 "2"
3 "3"
4 "4"
5 "Yes, I've had a plenty of food.";
la val hunger_sated hunger_sated;
#delimit cr
egen hunger_full = rsum(hunger_old hunger_sated)
replace hunger_full = . if hunger_full == 0
replace hunger_full = 6 - hunger_full 

la val hunger_full
drop hunger_old hunger_sated 

gen hunger_hunger = hunger_level if OldSurvey == 0 & (date == "0416"| date == "0417"|date == "0419"|date == "0420")
destring hunger_hunger, replace
#delimit
la define hunger_hunger
1 "No, not particularly hungry."
2 "2"
3 "3"
4 "4"
5 "Yes, I'm starving.";
la val hunger_hunger hunger_hunger;
#delimit cr
la val hunger_full hunger_hunger

egen hunger_lv = rsum(hunger_full hunger_hunger)
replace hunger_lv = . if hunger_lv == 0
la val hunger_lv hunger_hunger

drop hunger_full hunger_hunger hunger_level

****************************************
gen pet = ( petting == "Y")
drop petting
la def pet 1 "Y" 0 "N"
la val pet pet

gen Male = ( sex == "M")
drop sex
la def Male 1 "M" 0 "F"
la val Male Male

la var meal "Shift"
la var Hunger "Hunger/Sated"
la var Hunger_R "Hunger/Sated"
la def Hunger 1 "Hunger" 0 "Sated"
la val Hunger Hunger
la val Hunger_R Hunger
la var amount "donation by person"

gen     meal_num = 1 if meal == "Breakfast"
replace meal_num = 2 if meal == "Lunch"
replace meal_num = 3 if meal == "Dinner"
labmask(meal_num), values(meal)

cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
merge m:1 meal_hall_date obs_id using "RawData_Aggregate.dta", nogen
merge m:1 Zipcode using "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/census/MedianZIP-3.dta" 
drop if _merge == 2

//merge m:1 Zipcode using "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/census/combined_ziptoinc_short.dta" 
//drop if _merge == 2

la var Mean "Mean household income 2006-2010"
la var Median "Median household income 2006-2010"

sort  meal_hall_date obs_id 
la var Dona_Cash "aggregate by session"
la var Dona_Card "aggregate by session"
la var obs_id "session id (by 5 mins)"

egen amount_aggr = rsum(Dona_Card Dona_Cash)
la var amount_aggr "by 5 min sessions"

gen hall_num = (hall == "Sbisa")
la def hall 1 "Sbisa" 0 "Commons"
la val hall_num hall

ren peoplecount  passersby
order meal_hall_date meal_num day time obs_id meal hall date Hunger Hunger_R ///
time_pressure hunger_lv preferred_donation_time pet race Male amount amount_aggr Dona_Cash ///
Dona_Card passersby Median Mean Pop City State Zipcode OldSurvey _merge Note survey_note

save combined.dta, replace



























