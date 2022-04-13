
/******************************************************************************

* gui2de STATA Tutorial: Session 2
* Ali Hamza
* Feb 3rd, 2017

Topics:


1. Loops and Macros: global vs local, interoperability, indexing [_n], 
   saved results, loops (foreach, farval)

2. Generating new variables: egen options, bysort, recoding, decode/encode, destring 

3. Datasets commands: merge, append, reshape, cf 
 
*******************************************************************************/
set more off
clear
********************************************************************************
* MACROS:
********************************************************************************
/*
A macro is basically a symbol that you program Stata to read as something else; 
for example, if you tell Stata that X means "Apples", every time Stata sees X it 
knows that you really mean "Apples".
*/


********local Vs Global*************

/*
local:
Local macros are only visible locally, meaning within
the same program, do file, do-file editor contents or interactive
session
*/

/*
global:
Global macros are visible everywhere, or globally, meaning within any program, 
do file, or do-file editor contents and within an interactive session.  
*/

/*
The difference between local and global macros is that local macros are private 
and global macros
are public
*/

*Example

global X "Apples"
display "$X"

local X "Apples"
display "`X'"

*run line 56 & 57 together and then separately. Notice the difference! 


*Example (Global)

	global wd "C:/Users/ah1152/Box Sync/"
	*NOTE: Change ^^^THIS^^^

	use "$wd/gui2de STATA Tutorials/Session 2/Data/car_insurance", clear

	*OR I can define another global for the dataset:
	clear
	global insurance "$wd/gui2de STATA Tutorials/Session 2/Data/car_insurance"
	global project_t "$wd/gui2de STATA Tutorials/Session 2/Data/project_t"
	global project_e "$wd/gui2de STATA Tutorials/Session 2/Data/project_e"
	global project_educ "$wd/gui2de STATA Tutorials/Session 2/Data/project_educ"
	
	*load insurance data
	use "$insurance", clear
	
	*load project T data
	use "$project_t", clear
	

*Example (local)

	regress vin1q1_yes treat_makutano treat_mil treat_makutano_amt  treat_mil_amt age_in_years age_square secondaryschool wealth_index employed married television membership election_dummy , cluster(circlecode) 

	****running the same regression useing locals
	*Set locals for independent variables
	local treatment treat_makutano treat_mil treat_makutano_amt  treat_mil_amt
		
	*Set locals for constants
	local controls age_in_years age_square secondaryschool wealth_index ///
		employed married television membership election_dummy
	
	reg vin1q1_yes `treatment' `controls', cluster(circlecode) 



 ********************************************************************************
* LoopsL foreach & forvalues
********************************************************************************

/*
*foreach:
foreach repeatedly sets local macro lname to each element of the list and executes
the commands enclosed in braces.  The loop is executed zero or more times; it is 
executed zero times if the list is null or empty.
*/

*Example 1:

	foreach alphabet in a b c d e f g h i j k l m n o p q r s t u v x y z {
	display "`alphabet'"
	}
*
*Example 2:

	use "$project_t", clear
	*add "b_" prefix 
	foreach x in circlecode treatment age_in_years treat_makutano treat_mil ///
	treat_makutano_amt treat_mil_amt age_square secondaryschool wealth_index employed ///
	 married television membership election_dummy vin1q1_yes vin1q2_yes vin1q3_yes ///
	 vin1q4_yes {
	 rename `x' b_`x'
	 }
*	 
	 *using wildcard options
	 use "$project_t", clear
	 foreach x in * {
	 rename `x' b_`x'
	 }
*	 
*Example 3:
use "$project_t", clear

	foreach dep_var in vin1q1_yes vin1q2_yes vin1q3_yes vin1q4_yes{

		*Set locals for independent variables
		local treatment treat_makutano treat_mil treat_makutano_amt  treat_mil_amt
			
		*Set locals for constants
		local controls age_in_years age_square secondaryschool wealth_index ///
			employed married television membership election_dummy
		
		reg `dep_var' `treatment' `controls', cluster(circlecode) 
}
*


/*
forvalues:
forvalues repeatedly sets local macro lname to each element of range and executes
the commands enclosed in braces.  The loop is executed zero or more times.
*/

*Example 1:
	forvalues i=1/20{
	display `i'
	}
*

*Example 2:
	forvalues i=1 (2) 20{
	display `i'
	}
*

*Example 3 (calculating duration for each insurance plan
use "$insurance", clear
gen	policy_duration1 = expirydate1 - startdate1
gen	policy_duration2 = expirydate2 - startdate2
gen	policy_duration3 = expirydate3 - startdate3
gen	policy_duration4 = expirydate4 - startdate4
gen	policy_duration5 = expirydate5 - startdate5

/*
	"RULE OF THREE" (code duplication)
"You are allowed to copy and paste the code once, but that when the same code is 
replicated three times, it should be extracted into a new procedure.

Duplication in programming is almost always in indication of poorly designed 
code or poor coding habits. Duplication is a bad practice because it makes code 
harder to maintain." 
*/

*We can use forvalues loop to generate these 5 variables
use "$insurance", clear
forvalues i= 1/5 {
gen policy_duration`i' = (expirydate`i' - startdate`i')
}
*

********************************************************************************
* Indexing: Referring to observations, keeping, and dropping obs :
********************************************************************************

* _n refers to the number of the row 

use "$insurance", clear
gen obsnum=_n 
lab var obsnum "Observation number" 
order obsnum, first 


* writing _n refers to observations 
list if _n<50 //will browse the first 49 observations 

*dropping and keeping 
drop if _n>1000 
keep if _n<=100 //will keep the first 100 observatiosn 

*you can refer to certain values of variables in certain observations 

use "$insurance", clear

sort reg_marks
gen duplicate_reg=0
replace duplicate_reg=1 if  reg_marks[_n]==reg_marks[_n+1]
replace duplicate_reg=1 if  reg_marks[_n]==reg_marks[_n-1]



********************************************************************************
* egen (Extensions to generate)
********************************************************************************

use "$project_e", clear

gen total_score = (math_score + eng_score)


*mean
egen mean = mean(total_score)

*min
egen min = min(total_score)
*max
egen max = max(total_score)

*median
egen median = median(total_score)


********************************************************************************
* bysort
********************************************************************************

/*
It repeats the command for each group of observations for which the values of 
the variables in varlist are the same.
*/

use "$project_e", clear


bysort schoolcode: gen serial = _n
gen total_score = (math_score + eng_score)

*calculate mean, median, min, max for each school

*mean
bysort schoolcode: egen mean = mean(total_score)

*min
bysort schoolcode: egen min = min(total_score)
*max
bysort schoolcode: egen max = max(total_score)

*median
bysort schoolcode: egen median = median(total_score)

drop serial student_unique_id eng_score math_score total_score

duplicates drop

********************************************************************************
* recode, destring
********************************************************************************
use "$project_educ", clear

/*
Recode: 
It changes the values of numeric variables according to the rules specified. 
*/

*we have a dummy variable for male but we want to include a dummy variable female
*in our regression model. Using recode option

gen female=male
recode female (1=0) (0=1) 
tab male female

/*detring
It converts variables in varlist from string to numeric
*/

*age is a string vartiable 
destring(age), replace


********************************************************************************
* Datasets commands: merge, append, reshape, cf 
********************************************************************************

/*
*merge
 merge joins corresponding observations from the dataset currently in memory 
 (called the master dataset) with those from filename.dta (called the using 
 dataset), matching on one or more key variables.  merge can perform match
 merges (one-to-one, one-to-many, many-to-one, and many-to-many), which are 
 often called 'joins' by database people.
 */


*/
global baseline "$wd/gui2de STATA Tutorials/Session 2/Data/project_educ_baseline.dta"
global endline "$wd/gui2de STATA Tutorials/Session 2/Data/project_educ_endline.dta"

use "$baseline", clear

merge 1:1 student_id using "$endline"

*look at m:1, 1:m & m:m option

/*
Append:
append appends Stata-format datasets stored on disk to the end of the dataset 
in memory. 
*/

use "$baseline", clear

append using "$endline"
sort student_id

bysort student_id: egen baseline_score = max(total_M_B)
bysort student_id: egen endline_score = max(total_M_E)

drop total*


/*
reshape
It converts data from wide to long form and vice versa.
*/

*wide to long
webuse reshape1, clear
reshape long inc ue, i(id) j(year)


*long to wide
 reshape wide inc ue, i(id) j(year)
 
 
 /*
 cf:
 It compares varlist of the dataset in memory (the master dataset) with the 
 corresponding variables in filename (the using dataset)
 */
 
 global raw "$wd/gui2de STATA Tutorials/Session 2/Data/car_insurance_raw.dta"
 
 use "$insurance", clear
 
 cf _all using "$raw"
 
 *verbose gives a detailed listing, by variable, of each observation that differs.
 cf _all using "$raw", verbose
 
 







