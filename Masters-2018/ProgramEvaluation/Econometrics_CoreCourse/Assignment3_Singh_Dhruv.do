clear
capture cd "\\toaster\homes\d\h\dhnsingh\nt\Spring 2018\Ecmt 676\HW3"
if c(username)=="davidpritchard" {
cd "C:\Users\davidpritchard\Desktop\ECMT 676\Homework 3"
}


****//estimate using reg DD//***
capture program drop regDD
program regDD, rclass
syntax, shock(real)
drop _all

set obs 4000

gen t=. //time period 
forvalues j=1(1)10 {
 forvalues i=0(10)3990 {
  local k=`j'+`i'
  replace t=`j' in `k'
  }
}

gen Post=0 //pre-post variable
forvalues k=7(1)10 {
 forvalues i=0(10)3990 {
  local j=`k'+`i'
  replace Post=1 in `j'
  }
}

gen Treat=0 //treated group
forvalues i=2001(1)4000 {
 replace T=1 in `i'
}

gen i=. 
forvalues j=0(1)399 {
 forvalues k=1(1)10 {
  local l=`j'*10+`k'
  local m=`j'+1
  replace i=`m' in `l'
  }
}

gen did = Treat*Post //interaction term

gen e = rnormal(0,sqrt(2))

gen Y = 0.5 + 1.5*Treat + 2*Post + 3*did + Treat*t*`shock' + e //DiD regression equation

xtset i t 
xtreg Y Treat Post did, fe vce(robust)

return scalar beta3=_b[did] //beta3hat
return scalar t3= (_b[did]-3)/(_se[did])

end

forvalues i=1(1)7{
local shock=(`i'-4)*.2
simulate beta3`i'=r(beta3) t3`i'=r(t3), saving(results`i',replace) reps(500): regDD, shock(`shock') 
}


use "results1.dta", clear

forvalues j=2(1)7{
append using "results`j'"
save "results`j'.dta", replace
rm "results`j'.dta"
}


//Summarizing beta3's across each trend
summarize b*

/*
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      beta31 |        500    .0008476    .0962397  -.4392968   .2552676
      beta32 |        500    1.004972    .0924612   .7480349   1.259648
      beta33 |        500    2.000643    .0934979   1.734368   2.313417
      beta34 |        500    3.005897    .0901631   2.751287   3.251722
      beta35 |        500    3.999825    .0916899   3.739374   4.363932
-------------+---------------------------------------------------------
      beta36 |        500    4.996053    .0886236   4.738881   5.223842
      beta37 |        500    6.002617    .0905271   5.711314   6.293496
*/


//Summarizing t stat that for rejected nulls
forvalues i=1(1)7 {
summarize t3`i' if abs(t3`i')>1.96
}

/*
    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
         t31 |        500   -32.95097    1.542725  -39.78943  -29.34086
         t32 |        500   -21.92548    1.281072  -25.09448  -18.36934
         t33 |        500   -10.96384    1.109383   -13.9774  -6.971105
         t34 |         21    .0779658    2.281245  -2.614095   2.631437
         t35 |        500     10.9624    1.048522   7.740109   14.13325
-------------+---------------------------------------------------------
         t36 |        500    21.90933    1.145963    18.3207   25.62891
         t37 |        500    33.04517    1.529601   28.54823   39.18332
*/


//For trend 4, null is only rejected 4% of the time 
//In all other cases, null is rejected 100% of the time.


erase results1.dta




