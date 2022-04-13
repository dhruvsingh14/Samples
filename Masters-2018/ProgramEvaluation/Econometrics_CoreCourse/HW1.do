*program drop pt1
*clear all
*cls

capture program drop pt1
program pt1, rclass
syntax, beta2(real)
drop _all
set obs 5000
gen Z = rnormal(0,1)
gen u = rnormal(0,1)
gen e = rnormal(0,1)
local beta0=0.6
local beta1=1.5
gen X = 0.9*Z + 0.7*u
gen Y= `beta0'+`beta1'*X + `beta2'*u + e
reg Y X
return scalar beta1=_b[X]
return scalar beta2=`beta2'
end

local i=0

forvalues beta2=-1(0.1)1{
local i=`i'+1
simulate beta1=r(beta1) beta2=r(beta2), saving(results,replace) reps(30): pt1, beta2(`beta2')
tempfile beta`i'
save beta`i', replace
clear
}

forvalues i=1(1)21{
use "results.dta", clear
append using "beta`i'"
save "results.dta", replace
rm "beta`i'.dta"
}

//here's part II with a smaller effect of ommitted var.
capture program drop pt2
program pt2, rclass
syntax, beta2(real)
drop _all
set obs 5000
gen Z = rnormal(0,1)
gen u = rnormal(0,1)
gen e = rnormal(0,1)
local beta0=0.6
local beta1=1.5
gen X = 0.9*Z + 0.1*u
gen Y= `beta0'+`beta1'*X + `beta2'*u + e
reg Y X
return scalar beta1=_b[X]
return scalar beta2=`beta2'
end

local i=0

forvalues beta2=-1(0.1)1{
local i=`i'+1
simulate beta1=r(beta1) beta2=r(beta2), saving(results2,replace) reps(30): pt2, beta2(`beta2')
tempfile beta`i'
save beta`i', replace
clear
}

forvalues i=1(1)21{
use "results2.dta", clear
append using "beta`i'"
save "results2.dta", replace
rm "beta`i'.dta"
}























