/*
Will you keep track of the number of people who pass by? 
Probability of donating = #of people who donate/#of potential donors (those who see the sign). 

Your outcome variables are two: 
(1) Probability of donating. this could be #donated/#asked and #donated/#who passed by. 
(2) Average amount donated. this could be conditional on being asked and unconditional on having seen the sign.
*/

/*

clear all
//cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
cd "C:\Users\dhruv\Dropbox\2018 Spring\Field Experiments - 2018\Field Experiment Group Project\Procedure materials\Data"

import excel "RawData_Aggregate.xlsx", sheet("Data") firstrow
save "RawData_Aggregate.dta", replace

*/

clear all
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
//cd "C:\Users\dhruv\Dropbox\2018 Spring\Field Experiments - 2018\Field Experiment Group Project\Procedure materials\Data"
use "RawData_Aggregate.dta", clear

egen donation   = rsum(Dona_Cash   Dona_Card)
gen meal_num = 1 if meal == "Breakfast"
replace meal_num = 2 if meal == "Lunch"
replace meal_num = 3 if meal == "Dinner"
labmask(meal_num), values(meal)
la var meal_num "Meal Shift"
la var donation "Donations by 5-min sessions"
encode day, gen(day_num)

 la define Hunger 1 "Hunger" 0 "Sated"
 la val Hunger Hunger
 la var meal "Session"
 la var Hunger "Hunger/Sated"

gen temp_l = time if meal == "Lunch"
gen temp_b = time if meal == "Breakfast"
gen temp_d = time if meal == "Dinner"
encode temp_l, gen(lunch_time)
encode temp_b, gen(breakfa_time)
encode temp_d, gen(dinner_time)
drop temp_*

gen fire_alarm = (meal_hall_date=="Breakfa-Commons-0403")


ranksum donation, by(Hunger)
ttest donation, by(Hunger)

//power twomeans 1.635417 1.453571, sd1(.2154272) sd2(.338706)

// Graphing for the distribution of people passing by
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Presentation"

 * Breakfast
 graph bar (mean) peoplecount if meal == "Breakfast", over(time, label(angle(45) labsize(vsmall)))  ///
       title("Breakfast Session", size(medsmall)) ytitle("# of people passing by")
 graph export "Peoplecount_Breakfast.png",replace
 
 * Lunch
 graph bar (mean) peoplecount if meal == "Lunch", over(time, label(angle(45) labsize(vsmall)))  ///
       title("Lunch Session", size(medsmall)) ytitle("# of people passing by")
 graph export "Peoplecount_Lunch.png",replace
	   
 * Dinner
 graph bar (mean) peoplecount if meal == "Dinner", over(time, label(angle(45) labsize(vsmall)))  ///
       title("Dinner Session", size(medsmall)) ytitle("# of people passing by")
 graph export "Peoplecount_Dinner.png",replace


*keep if (lunch_time >= 2 & lunch_time <= 14)| (breakfa_time >= 7 ///
*& breakfa_time <= 20) | (dinner_time >= 3 & dinner_time <= 14)

//"11:41-11:45" 2 "12:36-12:40" 14
//"07:56-08:00" 7 "09:01-09:05" 20
//"05:21-05:25" 3 "06:16-06:20" 14

gen Breakfast = (meal_num == 1)
gen Lunch     = (meal_num == 2)
gen Dinner    = (meal_num == 3)

gen inter_B   = Hunger * Breakfast
gen inter_L   = Hunger * Lunch
gen inter_D   = Hunger * Dinner 

tobit donation  Hunger##meal_num i.day_num peoplecount fire_alarm,  ll 
tobit donation  Hunger Lunch Dinner inter_L inter_D i.day_num peoplecount,  ll 
tobit donation  Hunger  inter_L inter_D i.day_num peoplecount,  ll 
tobit donation  Hunger  i.meal_num i.day_num peoplecount,  ll 


reg donation  Hunger##meal_num i.day_num peoplecount fire_alarm
reg donation  Hunger Lunch Dinner inter_L inter_D i.day_num peoplecount fire_alarm
reg donation  Hunger  inter_L inter_D i.day_num peoplecount


tobit donation i.meal_num i.day_num peoplecount fire_alarm,  ll 
reg donation Lunch Dinner i.day_num peoplecount fire_alarm













































