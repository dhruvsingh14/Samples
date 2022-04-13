
/*
Will you keep track of the number of people who pass by? 
Probability of donating = #of people who donate/#of potential donors (those who see the sign). 

Your outcome variables are two: 
(1) Probability of donating. this could be #donated/#asked and #donated/#who passed by. 
(2) Average amount donated. this could be conditional on being asked and unconditional on having seen the sign.
*/
****************************************
clear all
****************************************
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use combined.dta, clear
drop _merge Note survey_note

bys meal_hall_date obs_id: gen  asked = _N
bys meal_hall_date obs_id: gen  donated_id = 1 if amount!= 0
bys meal_hall_date obs_id: egen givers = total(donated_id)
drop donated_id

gen     day_num = 1 if day == "Monday"
replace day_num = 2 if day == "Tuesday"
replace day_num = 3 if day == "Wednesday"
replace day_num = 4 if day == "Thursday"
replace day_num = 5 if day == "Friday"
labmask day_num, values(day)

* (1) Probability of donating in 5 minutes.
gen prob_donation_1 = asked/passersby    // #asked/#who passed by
gen prob_donation_2 = givers/passersby  // #donated/#who passed by

la var asked     "#asked in 5-min sessions"
la var passersby "#passersby in 5-min sessions"
la var givers    "#givers in 5-min sessions"
la var prob_donation_1 "#asked/#who passed by"
la var prob_donation_2 "#givers/#who passed by"

* Hunger_R or Hunger can affect the total observations after collapsing
* 1st collapsing from individual-lv to session-lv
collapse (mean) asked passersby givers amount_aggr Male prob_donation_*, by (day day_num meal_hall_date obs_id Hunger_R date hall_num hall meal_num meal)
save aggrdata.dta, replace

********************************************************************************  
	clear all
************************************* Test ************************************* 
	use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
	ttest asked, by(Hunger_R)       // p = 0.7030 
	ttest passersby, by(Hunger_R)   // p = 0.7433 
	ttest givers, by(Hunger_R)      // p = 0.05 **
	ttest amount_aggr, by(Hunger_R) // p = 0.7420 
	
********************************************************************************  
	clear all
************************** Time-pressure Test (Chi-square) *********************
	use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear
    sort meal_hall_date
	gen frequ = 1
	
	preserve
	collapse (count) frequ, by (Hunger_R meal_num time_pressure)
    keep if Hunger == 1
	ren frequ frequ_meal_h1
	la var frequ_meal_h1 "freq by hunger and meal (Hunger)"
	drop Hunger_R
	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
	save frequ_hun_by_time.dta, replace
	restore
	
	collapse (count) frequ, by (Hunger_R meal_num time_pressure)
    keep if Hunger == 0
	ren frequ frequ_meal_h0
	la var frequ_meal_h0 "freq by hunger and meal (Sated)"	
	drop Hunger_R
	merge 1:1 meal_num time_pressure using frequ_hun_by_time.dta, nogen
	drop if time_pressure == .
	
	egen frequ_meal = rsum(frequ*)
	la var frequ_meal "freq by meal only, not hunger"
	bys  time_pressure: egen  frequ_all = total(frequ_meal)
	bys  time_pressure: egen  frequ_h1 = total(frequ_meal_h1) //collapse over meal
	bys  time_pressure: egen  frequ_h0 = total(frequ_meal_h0)
	la var frequ_h0 "freq by hunger only, not meal (Sated)"
	la var frequ_h1 "freq by hunger only, not meal (Hunger)"	
	sort meal_num time_pressure
	save frequ_hun_by_time.dta, replace

	
	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
	use frequ_hun_by_time.dta, replace
	sort meal_num time_pressure	
	list 
	// Using variable frequ_meal, testing whether there is variation in measured time_pressure over meal shifts.
 	// all reject the distribution equality hypothesis.
	
		*Pearson chi2(4) =  26.5317   Pr =  0.000
		*likelihood-ratio chi2(4) =  22.7790   Pr =  0.000
		chitesti 25 32 51 50 19 \ 177*16/228 177*25/228 177*85/228 177*68/228 177*34/228  // 177\228 Breakfast \ Dinner
		
		*Pearson chi2(4) =  24.4227   Pr =  0.000
		*likelihood-ratio chi2(4) =  23.1812   Pr =  0.000
		chitesti 16 26 51 69 38 \ 200*25/177 200*32/177 200*51/177 200*50/177 200*19/177  // 200\177 Lunch \ Breakfast
		
		*Pearson chi2(4) =  16.8602   Pr =  0.002
		*likelihood-ratio chi2(4) =  15.5817   Pr =  0.004
		chitesti 16 25 85 68 34 \ 228*16/200 228*26/200 228*51/200 228*69/200 228*38/200  // 228\200 Dinner \ Lunch

********************************************************************************  
	clear all
**************************** Gross Traffic Test (KS/T/Wilcoxon) ****************		
	use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
	la var amount_aggr "Donations by 5-min session"
	la var Hunger_R "Hunger/Sated"
	la var meal_num "Meal Shift"
	la var 	passersby "passersby per 5-min session"

	set graph on
	forval i = 1/3 {
	histogram passersby if meal_num == `i', bin(15) saving("g`i'",replace) xtitle("`i'") ylabel(0(0.02)0.1,labsize(small))
	local dd `"`dd' "g`i'""' 
	}
	graph combine `dd', col(2) altshrink imargin(0 0 0 0) graphregion(margin(l=10 r=10))  ///
	title("Distribution of Gross Traffic by Meal Shift", size(small)) 
	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
	graph export "Traffic_meal.png",replace	
	erase "g1.gph"   
    erase "g2.gph" 
    erase "g3.gph" 
	
	
	// testing whether the gross traffic varied by meal shift, this is done to lend support
	// on using the meal shift as a proxy for time variation.
	
	ranksum passersby if meal_num == 1 | meal_num == 2, by (meal_num) //0.0000
	ranksum passersby if meal_num == 2 | meal_num == 3, by (meal_num) //0.3121
	ranksum passersby if meal_num == 1 | meal_num == 3, by (meal_num) //0.0000
	
	ttest 	passersby if meal_num == 1 | meal_num == 2, by (meal_num) //0.0000
	ttest 	passersby if meal_num == 2 | meal_num == 3, by (meal_num) //0.0717
	ttest 	passersby if meal_num == 1 | meal_num == 3, by (meal_num) //0.0000
	
********************************************************************************  
	clear all
* Correlatin Test between Self-reported Time-pressure and Hunger lv (spearman/Chisq) *
	use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear	

//  results suggest that can not accept the independence hypotheses for lunch and dinner
    spearman time_pressure hunger_lv if meal_num == 1, matrix stats(rho p) //rho=-0.0117 p=0.8776 
    spearman time_pressure hunger_lv if meal_num == 2, matrix stats(rho p) //rho=0.1791  p=0.0112
    spearman time_pressure hunger_lv if meal_num == 3, matrix stats(rho p) //rho=0.1929  p=0.0035
	
    spearman time_pressure hunger_lv if meal_num == 2 | meal_num == 3, matrix stats(rho p) //rho=0.1854 p=0.0001

*-------------------------------------------------------------------------------*
	use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear	   
	sort meal_hall_date
	gen frequ = 1
	
	preserve
	collapse (count) frequ, by (meal_num time_pressure)
	sort meal_num time_pressure 
	ren  time_pressure scale
	ren  frequ time_meal 
	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
	save frequ_meal_by_time.dta, replace
	restore
	
	collapse (count) frequ, by (meal_num hunger_lv)
	sort meal_num hunger_lv
	ren  hunger_lv scale
	ren  frequ hunger_meal 
	merge 1:1 meal_num scale using frequ_meal_by_time.dta, nogen
	drop if scale == .
	
	la var hunger_meal "mass by meal"
	la var time_meal "mass by meal"

	bys scale : egen hunger = total(hunger_meal) 
	bys scale : egen time = total(time_meal) 
	sort meal_num scale
	
	la var hunger  "overall"
	la var time    "overall"		
    save frequ_meal_by_time.dta, replace

 	
	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
	use frequ_meal_by_time.dta, replace
	sort meal_num scale	
	list 
	
	// test if the two categorical variables hunger and time follow the same distribution.
	// all reject the distribution equality, but can not accept the independence hypotheses.
	
		chitesti 27 30 36 53 31 \ 25 32 51 50 19  // 177 Breakfast: hunger \ time
		chitesti 48 25 45 40 42 \ 16 26 51 69 38  // 200 Lunch: hunger \ time
		chitesti 41 39 63 42 43 \ 16 25 85 68 34  // 228 Dinner: hunger \ time	
		
		chitesti 116 94 144 135 116 \ 57 83 187 187 91  //605 Overall: hunger \ time			
	
********************************************************************************  
	clear all
************************* Donation Distribution Test (Wilcoxon) ****************
	use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
	la var  amount_aggr "Donations by 5-min session"
	la var  Hunger_R "Hunger/Sated"
	la var  meal_num "Meal Shift"
	la var 	passersby "passersby per 5-min session"

   	ranksum amount_aggr if meal_num == 1 | meal_num == 2, by (meal_num)   
	ranksum amount_aggr if meal_num == 2 | meal_num == 3, by (meal_num)   
	ranksum amount_aggr if meal_num == 1 | meal_num == 3, by (meal_num)   
	
	
********************************************************************************  
  clear all
************************************* Graphs ***********************************
 
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear
  la var time_pressure "Self-reported Time Pressure in Scale of 1 - 5"
  la var meal_num "Meal Shift" 
  hist time_pressure, ylabel(,grid) by(Hunger_R meal_num) note("1 Not at all;    5 Extremely busy.")
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "time_pressure_dist.png", replace 
  
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear
  la var time_pressure "Self-reported Time Pressure in Scale of 1 - 5"
  hist time_pressure, ylabel(,grid) by(Hunger_R) note("1 Not at all; 5 Extremely busy.")
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "time_pressure_dist_TC.png", replace
 
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear
  la var time_pressure "Self-reported Time Pressure in Scale of 1 - 5"
  la var meal_num "Meal Shift" 
  hist time_pressure, ylabel(,grid) by(meal_num) note("1 Not at all;    5 Extremely busy.") 
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "time_pressure_dist_meal.png", replace 
  ************
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear
  la var hunger_lv "Self-reported Hunger Level in Scale of 1 - 5"
  la var meal_num "Meal Shift"  
  hist hunger_lv,  ylabel(,grid) by(Hunger_R meal_num) note("1 No,not particularly hungry; 5 Yes,I'm starving.", size(vsmall))
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "hunger_lv_dist.png", replace

  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/combined.dta", clear
  la var hunger_lv "Self-reported Hunger Level in Scale of 1 - 5"
  hist hunger_lv,  ylabel(,grid) by(Hunger_R) note("1 No, not particularly hungry; 5 Yes, I'm starving.")
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "hunger_lv_dist_TC.png", replace
  ************
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
  la var amount_aggr "Donations by 5-min session"
  la var Hunger_R "Hunger/Sated"
  la var meal_num "Meal Shift" 
  hist amount_aggr, ylabel(0(0.05)0.3,grid) by(Hunger_R , row(1)) 
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "donation_dist_TC.png", replace
  
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
  la var amount_aggr "Donations by 5-min session"
  la var Hunger_R "Hunger/Sated"
  la var meal_num "Meal Shift" 
  hist amount_aggr, bin(20) ylabel(0(0.1)0.5,grid) by(Hunger_R meal_num)
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "donation_dist.png", replace
  
  use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
  la var amount_aggr "Donations by 5-min session"
  la var Hunger_R "Hunger/Sated"
  la var meal_num "Meal Shift" 
  hist amount_aggr, bin(20) ylabel(0(0.1)0.5,grid) by(meal_num)
  cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
  graph export "donation_dist_meal.png", replace
  
/*
use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
graph bar (mean) asked passersby , over(Hunger_R) bargap(+20) ///
legend(pos(10) ring(0) row(2) label(1 "# of asked per 5-min session") label(2 "# of passersby per 5-min session") )    ///
ytitle("") title("Total traffic (Passersby, Asked)")    ///
subtitle("by hunger condition") ///
bar(1, color(orange*0.5)) bar(2, color(blue*0.4))
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
graph export "Figure_1.png", replace
*/

* 2nd collapsing from session-lv to generate mean and sd and N
clear all
use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
#delimit
collapse (mean) mn_asked = asked mn_passersby = passersby mn_givers = givers mn_amt_aggr = amount_aggr  
         (sd)   sd_asked = asked sd_passersby = passersby sd_givers = givers sd_amt_aggr = amount_aggr   
		 (count) N = asked , by (Hunger_R);
#delimit cr		 
keep Hunger_R N *_asked *_passersby
ren mn_asked mn1
ren sd_asked sd1
ren mn_passersby mn2
ren sd_passersby sd2
reshape long mn sd, i(Hunger_R) j(varr)
gen hi  = mn + 1.96*(sd/sqrt(N))
gen low = mn - 1.96*(sd/sqrt(N))
la def varr 1 "asked" 2 "passersby"
la val varr varr
gen     id = varr + 1 if Hunger_R == 0
replace id = varr + 4 if Hunger_R == 1
sort Hunger_R varr 
list id  varr Hunger_R, sepby(Hunger_R)
replace id = id - 0.2 if varr == 1
#delimit
twoway (bar mn id if Hunger_R == 0 & varr == 1, bcolor(orange*0.6)  ) 
       (bar mn id if Hunger_R == 0 & varr == 2, bcolor(blue*0.4)  )  
	   (bar mn id if Hunger_R == 1 & varr == 1, bcolor(orange*0.6)  )  
	   (bar mn id if Hunger_R == 1 & varr == 2, bcolor(blue*0.4)  )  
	   (rcap hi low id, lcolor(black)),  
	   xlabel(2.5 "Sated" 5.5 "Hunger", noticks)  
	   title("Total traffic (Passersby, Respondent)")  ytitle("Number of people")  
	   subtitle("by hunger condition") xtitle("") note("Note: Erros bars represent the 95% confidence interval.", size(small))
	   legend(pos(6) ring(1) row(1) order(1 "respondent per 5-min session" 2 "passersby per 5-min session") size(small));
#delimit cr
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
graph export "Figure_1.png", replace

/*
use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
graph bar (mean) givers amount_aggr , over(Hunger_R) bargap(+20) ///
legend(pos(10) ring(0) row(2) label(1 "# of givers per 5-min session") label(2 "donations per 5-min session") )    ///
ytitle("") title("Total giving (Givers, Donations)")    ///
subtitle("by hunger condition") ///
bar(1, color(lavender )) bar(2, color(gold))
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
graph export "Figure_2.png", replace
*/

clear all
use "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/aggrdata.dta", clear
#delimit
collapse (mean) mn_asked = asked mn_passersby = passersby mn_givers = givers mn_amt_aggr = amount_aggr  
         (sd)   sd_asked = asked sd_passersby = passersby sd_givers = givers sd_amt_aggr = amount_aggr   
		 (count) N = asked , by (Hunger_R);
#delimit cr		 
keep Hunger_R N *_givers *_amt_aggr
ren mn_givers mn1
ren sd_givers sd1
ren mn_amt_aggr mn2
ren sd_amt_aggr sd2
reshape long mn sd, i(Hunger_R) j(varr)
gen hi  = mn + 1.96*(sd/sqrt(N))
gen low = mn - 1.96*(sd/sqrt(N))
la def varr 1 "Givers" 2 "Donation"
la val varr varr
gen     id = varr + 1 if Hunger_R == 0
replace id = varr + 4 if Hunger_R == 1
sort Hunger_R varr 
list id  varr Hunger_R, sepby(Hunger_R)
replace id = id - 0.2 if varr == 1
#delimit
twoway (bar mn id if Hunger_R == 0 & varr == 1, bcolor(lavender)) 
       (bar mn id if Hunger_R == 0 & varr == 2, bcolor(gold)) 
	   (bar mn id if Hunger_R == 1 & varr == 1, bcolor(lavender))  
	   (bar mn id if Hunger_R == 1 & varr == 2, bcolor(gold))  
	   (rcap hi low id, lcolor(black)),  ylabel(0(1)5)
	   xlabel(2.5 "Sated" 5.5 "Hunger", noticks)  
	   title("Total giving (Givers, Donations)") ytitle("Number of givers/$")    
	   subtitle("by hunger condition") xtitle("") note("Note: Erros bars represent the 95% confidence interval.", size(small))
	   legend(pos(2) ring(0) row(2) order(1 "givers per 5-min session" 2 "donations per 5-min session") size(small));
#delimit cr
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
graph export "Figure_2.png", replace

******************************************************************************** 
clear all
***************************** Table 2 (per 5-min session)*********************** 
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use aggrdata.dta, clear

la var asked     "\# of respondent in 5-min sessions"
la var passersby "\# of passersby in 5-min sessions"
la var givers    "\# of givers in 5-min sessions"
la var amount_aggr "Average Donation in 5-min sessions"
la var Male      "Male"
la var prob_donation_1 "Ratio of respondent to passersby"
la var prob_donation_2 "Ratio of givers to passersby"
la var meal_num "Meal"
labmask(meal_num), values(meal)
la var hall_num "Dining Hall"
labmask(hall_num), values(hall)
la var Hunger_R "Hunger Condition"
la var day_num "Day"

gen    hall_date = hall + date
encode hall_date, gen(hall_date_num)

encode meal_hall_date, gen(meal_hall_date_num)
encode date, gen(date_num)
 
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"

qui reg passersby       Hunger_R  i.meal_num i.hall_num i.day_num, cluster(meal_hall_date) 
est sto m1 
estadd local fixed "Yes"
qui reg asked           Hunger_R  Male passersby i.meal_num  i.hall_num i.day_num, cluster(meal_hall_date)
est sto m2
estadd local fixed "Yes"
qui reg givers          Hunger_R  Male passersby i.meal_num  i.hall_num i.day_num, cluster(meal_hall_date)
est sto m3
estadd local fixed "Yes"
qui reg amount_aggr     Hunger_R  Male passersby i.meal_num  i.hall_num i.day_num, cluster(meal_hall_date)
est sto m4
estadd local fixed "Yes"
qui reg prob_donation_1 Hunger_R  Male passersby i.meal_num  i.hall_num i.day_num, cluster(meal_hall_date)
est sto m5
estadd local fixed "Yes"
qui reg prob_donation_2 Hunger_R  Male passersby i.meal_num   i.hall_num i.day_num, cluster(meal_hall_date)
est sto m6
estadd local fixed "Yes"
esttab m*, label  

esttab m* using "Table2.tex", replace  keep(Hunger_R Male passersby 2.meal_num 3.meal_num _cons)  ///
title("OLS Regressions of Total Traffic and Giving per 5-min Session in Hunger Condition")  ///
addnote("Standard Errors are clustered at Meal-Dining Hall-Date and shown in the parenthesis. All specifications control for Weekday and Dining Hall fixed effect.") ///
depvars cells(b(star fmt(%9.3f)) se(par)) stats(fixed r2_a N, fmt(%f %9.3f %9.0g)   ///
labels("Weekday and Dining Hall fixed effect" adj.R-squared Observations))  ///
starlevels(* 0.1 ** 0.05 *** 0.01) legend label 
est clear

********************************************************************************
clear all
*********************** Table 3 (individual-level: conditional)*****************
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use combined.dta, clear
drop _merge Note survey_note

bys  meal_hall_date obs_id: gen  asked = _N
bys  meal_hall_date obs_id: gen  donated_id = 1 if amount!= 0
bys  meal_hall_date obs_id: egen givers = total(donated_id)
drop donated_id

gen     day_num = 1 if day == "Monday"
replace day_num = 2 if day == "Tuesday"
replace day_num = 3 if day == "Wednesday"
replace day_num = 4 if day == "Thursday"
replace day_num = 5 if day == "Friday"
labmask day_num, values(day)

* (1) Probability of donating in 5 minutes.
gen prob_donation_1 = asked/passersby    // #asked/#who passed by
gen prob_donation_2 = givers/passersby  // #donated/#who passed by

la var asked     "\# of asked in 5-min sessions"
la var passersby "\# of passersby in 5-min sessions"
la var givers    "\# of givers in 5-min sessions"
la var prob_donation_1 "Ratio of asked to passersby"
la var prob_donation_2 "Ratio of givers to passersby"

* (2) Average amount donated, conditional on being asked
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"
gen    faminc = log(Median)
la var faminc "log of Median Income"
la var hunger_lv "Hunger level"
la var time_pressure "Time Pressure"
la var meal_num "Meal Session"
la var hall_num "Sbisa Dining Hall"
gen    hall_day = hall + day
encode hall_day, gen(hall_day_num)

gen    hall_date = hall + date
encode hall_date, gen(hall_date_num)

encode meal_hall_date, gen(meal_hall_date_num)
encode date, gen(date_num)
/*
gen     hunger_lv_r = (hunger_lv == 4 |hunger_lv == 5)
replace hunger_lv_r = . if hunger_lv == 3
*/

tab meal_num, gen (meal_)
tab hunger_lv, gen (hunger_lv_)

gen inter22 = hunger_lv_2 * meal_2
gen inter23 = hunger_lv_2 * meal_3

gen inter32 = hunger_lv_3 * meal_2
gen inter33 = hunger_lv_3 * meal_3

gen inter42 = hunger_lv_4 * meal_2
gen inter43 = hunger_lv_4 * meal_3

gen inter52 = hunger_lv_5 * meal_2
gen inter53 = hunger_lv_5 * meal_3


la var inter22 "Hunger lv 2 * Lunch session"
la var inter23 "Hunger lv 2 * Dinner session"
la var inter32 "Hunger lv 3 * Lunch session"
la var inter33 "Hunger lv 3 * Dinner session"
la var inter42 "Hunger lv 4 * Lunch session"
la var inter43 "Hunger lv 4 * Dinner session"
la var inter52 "Hunger lv 5 * Lunch session"
la var inter53 "Hunger lv 5 * Dinner session"
la var Hunger_R "Hunger Condition"


***********************
qui reg amount  Hunger_R i.meal_num i.hall_num  i.day_num, cluster(meal_hall_date_num) 
est sto m0
estadd local fixed1 "Yes"
estadd local fixed2 "No"

qui reg amount  hunger_lv, cluster(meal_hall_date_num) 
est sto m1
estadd local fixed1 "No"
estadd local fixed2 "No"

qui reg amount  hunger_lv  i.meal_num i.hall_num  i.day_num Male, cluster(meal_hall_date_num) 
est sto m3
estadd local fixed1 "Yes"
estadd local fixed2 "No"

qui reg amount  hunger_lv  i.meal_num i.hall_day_num Male, cluster(meal_hall_date_num) 
est sto m4
estadd local fixed1 "No"
estadd local fixed2 "Yes"

qui reg amount  i.hunger_lv i.meal_num  i.hall_day_num, cluster(meal_hall_date_num) 
est sto m5
estadd local fixed1 "No"
estadd local fixed2 "Yes"

*****including self-reported time presure measure.*****
qui reg hunger_lv time_pressure i.meal_num i.hall_num  i.day_num , cluster(meal_hall_date_num) 
est sto m6
estadd local fixed1 "Yes"
estadd local fixed2 "No" 

qui reg amount  hunger_lv time_pressure i.meal_num i.hall_num  i.day_num Male, cluster(meal_hall_date_num) 
est sto m7
estadd local fixed1 "Yes"
estadd local fixed2 "No"
test hunger_lv=time_pressure

qui reg amount  i.hunger_lv i.time_pressure i.meal_num  i.hall_day_num, cluster(meal_hall_date_num) 
est sto m8
estadd local fixed1 "No"
estadd local fixed2 "Yes"
test 5.hunger_lv = 5.time_pressure

qui reg amount  time_pressure i.meal_num i.hall_num  i.day_num Male, cluster(meal_hall_date_num) 
est sto m9
estadd local fixed1 "Yes"
estadd local fixed2 "No"

esttab m*, label

esttab m* using "Table3_timeNhunger.tex", replace  drop(*hall_day_num *day_num 1bn.meal_num 0bn.hall_num 1bn.hunger_lv ) ///
title("OLS Regressions of Amount of Individual Donation by Hunger Condition, Self-reported Hunger Level and Time Pressure(Conditional)")  ///
addnote("Standard Errors are clustered at Meal-Dining Hall-Date and shown in the parenthesis.") ///
depvars cells(b(star fmt(%9.3f)) se(par)) stats(fixed1 fixed2 r2_a N, fmt(%f %f %9.3f %9.0g)    ///
labels("Weekday and Dining Hall fixed effect" "Weekday $\times$ Dining Hall fixed effect" adj.R-squared Observations)) ///
starlevels(* 0.1 ** 0.05 *** 0.01) legend label 
est clear

********************************************************************************
clear all
*********** Table 4 (individual-level: unconditional): Data Expansion **********
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use  combined.dta, clear
drop _merge Note 

bys  meal_hall_date obs_id: gen  asked = _N
bys  meal_hall_date obs_id: gen  donated_id = 1 if amount!= 0
bys  meal_hall_date obs_id: egen givers = total(donated_id)
drop donated_id
save expanded.dta, replace

cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use expanded.dta, clear

gen		 passnoask = passersby - asked
collapse (mean)passnoask, by (meal_hall_date obs_id meal meal_num date hall hall_num Hunger)
replace  passnoask = 0 if passnoask < 0
drop if  passnoask == 0
expand   passnoask
gen      amount = 0
drop     passnoask
append   using "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data/expanded.dta"

sort 	 meal_hall_date obs_id
keep     meal_hall_date meal_num obs_id meal hall date Hunger Hunger_R hall_num amount day passersby asked givers survey_note
replace  Hunger = Hunger_R if survey_note != ""
drop     Hunger_R
ren      Hunger Hunger_R

replace day = "Monday"    if date == "0402" | date == "0416" 
replace day = "Tuesday"   if date == "0403" | date == "0417"
replace day = "Wednesday" if date == "0404"
replace day = "Thursday"  if date == "0405" | date == "0419"
replace day = "Friday"    if date == "0420"

gen     day_num = 1 if day == "Monday"
replace day_num = 2 if day == "Tuesday"
replace day_num = 3 if day == "Wednesday"
replace day_num = 4 if day == "Thursday"
replace day_num = 5 if day == "Friday"
labmask day_num, values(day)

sort meal_hall_date obs_id
drop passersby
bys  meal_hall_date obs_id: gen passersby = _N

gen  tmp = (asked != .)
drop asked 
ren  tmp  asked

replace amount = 0 if amount == .
drop    givers
gen     givers = (amount != 0)
drop    survey_note
save    expanded.dta, replace
*********** Table 3 (individual-level: unconditional): Probit and LPM **********
clear all
cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use expanded.dta, clear

gen    hall_day = hall + day
encode hall_day, gen(hall_day_num)
encode meal_hall_date, gen(meal_hall_date_num)

la var asked "Respond to solicitor"
la var givers "Giving nonzero donations"
la var amount "Donations per person"
la var Hunger_R "Hunger Condition"

tab meal_num, gen (meal_)
gen inter1 = Hunger_R * meal_1
gen inter2 = Hunger_R * meal_2
gen inter3 = Hunger_R * meal_3

la var inter1 "Hunger * Breakfast shift"
la var inter2 "Hunger * Lunch shift"
la var inter3 "Hunger * Dinner shift"

	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"

    cap log close
	log using "posttable/expand_results12.log", replace
    local depvars1 "asked givers"
	
	postfile values str50 rowKey spec1 spec2 using "posttable/probit_results1", replace

	foreach var of varlist `depvars1'{
	// probit
	di ""
	di "******************************"
	di ""
	di "Outcome `var': No interaction"
	di "******************************"
	di ""
	di "xi: dprobit `var' Hunger_R i.meal_num i.hall_num  i.day_num, cluster(meal_hall_date_num) "
	xi: dprobit `var' Hunger_R i.meal_num i.hall_num  i.day_num, cluster(meal_hall_date_num)
	
	matrix define A = e(dfdx)
	matrix define B = e(se_dfdx)
	matrix define C = e(N)
	matrix define P = e(p)
	
	local B1_`var' = A[1,1]
	local SE1_`var'= B[1,1]
	
	local B2_`var' = A[1,2]
	local SE2_`var'= B[1,2]
	
	local B3_`var' = A[1,3]
	local SE3_`var'= B[1,3]
	
	local N_`var'  = C[1,1]	
	
	local P1_`var'  = P[1,1]
	local P2_`var'  = P[1,2]
	local P3_`var'  = P[1,3]	
	}
	post values ("Hunger")      (`B1_asked')   (`B1_givers')  
	post values ("SE")          (`SE1_asked')  (`SE1_givers') 
	post values ("P-value")     (`P1_asked')   (`P1_givers') 
	
	post values ("Lunch")       (`B2_asked')   (`B2_givers')
	post values ("SE")          (`SE2_asked')  (`SE2_givers')
	post values ("P-value")     (`P2_asked')   (`P2_givers') 
	
	post values ("Dinner")      (`B3_asked')   (`B3_givers')
	post values ("SE")          (`SE3_asked')  (`SE3_givers')
	post values ("P-value")     (`P3_asked')   (`P3_givers') 
	
	post values ("obs")         (`N_asked')    (`N_givers')	
	postclose values

	postfile values str50 rowKey spec1 spec2 using "posttable/probit_results2", replace
	foreach var of varlist `depvars1'{
	// probit
	di ""
	di "***************************"
	di ""
	di "Outcome `var': Interaction"
	di "***************************"
	di ""

	di "xi: dprobit `var' Hunger_R i.meal_num inter2 inter3 i.hall_num  i.day_num, cluster(meal_hall_date_num) "
	xi: dprobit `var' Hunger_R i.meal_num inter2 inter3 i.hall_num  i.day_num, cluster(meal_hall_date_num)	
	
	matrix define A = e(dfdx)
	matrix define B = e(se_dfdx)
	matrix define C = e(N)
	matrix define P = e(p)
	
	local B1_`var' = A[1,1]
	local SE1_`var'= B[1,1]
	
	local B2_`var' = A[1,2]
	local SE2_`var'= B[1,2]
	
	local B3_`var' = A[1,3]
	local SE3_`var'= B[1,3]

	local B4_`var' = A[1,4]
	local SE4_`var'= B[1,4]	
	
	local B5_`var' = A[1,5]
	local SE5_`var'= B[1,5]	
	
	
	local N_`var'  = C[1,1]	
	
	local P1_`var'  = P[1,1]
	local P2_`var'  = P[1,2]
	local P3_`var'  = P[1,3]
	local P4_`var'  = P[1,4]
	local P5_`var'  = P[1,5]	
	
	}
	post values ("Hunger")      (`B1_asked')   (`B1_givers')  
	post values ("SE")          (`SE1_asked')  (`SE1_givers') 
	post values ("P-value")     (`P1_asked')   (`P1_givers') 
	
	post values ("Lunch")       (`B2_asked')   (`B2_givers')
	post values ("SE")          (`SE2_asked')  (`SE2_givers')
	post values ("P-value")     (`P2_asked')   (`P2_givers') 
	
	post values ("Dinner")      (`B3_asked')   (`B3_givers')
	post values ("SE")          (`SE3_asked')  (`SE3_givers')
	post values ("P-value")     (`P3_asked')   (`P3_givers') 

	post values ("Inter2")      (`B4_asked')   (`B4_givers')
	post values ("SE")          (`SE4_asked')  (`SE4_givers')
	post values ("P-value")     (`P4_asked')   (`P4_givers') 	
	
	post values ("Inter3")      (`B5_asked')   (`B5_givers')
	post values ("SE")          (`SE5_asked')  (`SE5_givers')
	post values ("P-value")     (`P5_asked')   (`P5_givers') 	
		
	post values ("obs")         (`N_asked')    (`N_givers')	
	postclose values
	**************************	**************************	**************************
	
	
	local depvars2 "asked givers amount"
	foreach var of varlist `depvars2' {
	// lpm
	di ""
	di "*****************************"
	di ""
	di "Outcome `var': No interaction"
	di "*****************************"
	di ""
	di "reg `var' Hunger_R i.meal_num i.hall_num  i.day_num, cluster(meal_hall_date_num) "
	    reg `var' Hunger_R i.meal_num i.hall_num  i.day_num, cluster(meal_hall_date_num) 
  
	est sto m_`var'_1
	
	di ""
	di "*************************"
	di ""
	di "Outcome `var': Interaction"
	di "*************************"
	di ""

	di "reg `var' Hunger_R i.meal_num i.hall_num inter2 inter3 i.day_num, cluster(meal_hall_date_num) "
		reg `var' Hunger_R i.meal_num i.hall_num inter2 inter3 i.day_num, cluster(meal_hall_date_num) 
    
	est sto m_`var'_2

		
	}
	esttab m*, label
	
	esttab m* using "posttable/lpm_results_all.tex", replace keep(Hunger_R 2.meal_num 3.meal_num inter2 inter3 _cons) ///
	title("Response Rate and Giving in Hunger Condition (Unconditional)")       ///
	addnote("Standard Errors are clustered at Meal-Dining Hall-Date and shown in the parenthesis. All specifications control for Weekday and Dining Hall fixed effect.") ///
    depvars cells(b(star fmt(%9.3f)) se(par)) stats( r2_a N, fmt(%9.3f %9.0g)      ///
	labels(adj.R-squared Observations)) ///
	starlevels(* 0.1 ** 0.05 *** 0.01) legend label collabels(none)
	est clear
 
	cap log close

********************************************************************************  
clear all
**************************************** Table 1 ******************************* 
* Summary Statistics.
* Note: in regressions there seven people respond to us after meal when it is hunger treatment,
*       or respond to us before meal when it is actually sated treatment.

cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Data"
use expanded.dta, clear
gen traffic = 1


	cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper"

    cap log close
	log using "posttable/summary.log", replace
	
*	local samples "& givers != 0"
 	local samples "& asked != 0"

	postfile values str50 rowKey Sated Hunger using "posttable/summary", replace
 
    forval i = 0/1{
	di ""
	di "********************************************************************"
	di "su traffic if Hunger_R == `i'"
	su traffic if Hunger_R == `i'
	
	local N_t_tot`i'  = r(N)
	local mn_t_tot`i'' = r(mean)
	local se_t_tot`i' = r(sd)/sqrt(r(N))
	
		
	local N_amt_tot`i'  = r(N)
	local mn_amt_tot`i'' = r(mean)
	local se_amt_tot`i' = r(sd)/sqrt(r(N))
	
	
	forval j = 1/3{
	di ""
	di "*********************************************************************"
	di "su traffic if Hunger_R == `i' & meal_num == `j'"
	su traffic if Hunger_R == `i' & meal_num == `j'  // 	
	
    local N_t`i'`j'  = r(N)
	local mn_t`i'`j' = r(mean)
	local se_t`i'`j' = r(sd)/sqrt(r(N))
	di ""
	di "*********************************************************************"
	di "su amount  if Hunger_R == `i' & meal_num == `j' `samples'"
	su amount  if Hunger_R == `i' & meal_num == `j' `samples' // control-breakfast control-lunch control-dinner
	
    local N_amt`i'`j'  = r(N)
	local mn_amt`i'`j' = r(mean)
	local se_amt`i'`j' = r(sd)/sqrt(r(N))
	
	}
	}
	
	post values ("Breakfast")	(`N_t01')    (`N_t11')
	post values ("Lunch")	    (`N_t02')    (`N_t12')
	post values ("Dinner")	    (`N_t03')    (`N_t13') 
	post values ("Total")	    (`N_t_tot0') (`N_t_tot1') 
	
	post values ("Breakfast Mean Amount")	(`mn_amt01')    (`mn_amt11')
	post values ("SE")	                    (`se_amt01')    (`se_amt11')	
	
	post values ("Lunch Mean Amount")	    (`mn_amt02')    (`mn_amt12')
	post values ("SE")	                    (`se_amt02')    (`se_amt12')
	
	post values ("Dinner Mean Amount")	    (`mn_amt03')    (`mn_amt13') 
	post values ("SE")	                    (`se_amt03')    (`se_amt13')
	
	postclose values
	cap log close


 cd "/Volumes/Research/Dropbox/2018 Spring/Field Experiments - 2018/Field Experiment Group Project/Procedure materials/Paper/posttable"
 use summary.dta, clear
 format Sated Hunger %9.3f
 listtab rowKey Sated Hunger using summary_raw.tex,  delim(&) rs(tabular) replace


/*
gen White = (race == "White") 
replace White = 1 if race == "White/Hispanic"































































