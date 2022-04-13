clear
capture cd "\\toaster\homes\d\h\dhnsingh\nt\Spring 2018\Ecmt 676\HW4"
if c(username)=="davidpritchard" {
cd "C:\Users\davidpritchard\Desktop\ECMT 676\ Homework\Assignment 4"
}


/*PART I*/

capture program drop autocorr
program autocorr, rclass
drop _all
set obs 3000

gen i=. 
forvalues j=0(1)199 {
 forvalues k=1(1)15 {
  local l=`j'*15+`k' 
  local m=`j'+1  
  replace i=`m' in `l' 
  }
}

gen t=. 
forvalues j=1(1)15 {
 forvalues i=0(15)2985 {
  local k=`j'+`i' 
  replace t=`j' in `k'
  }
}

gen u = rnormal(0,1)

gen e = .
replace e = u if t==1
forvalues j=2(1)15 {
 forvalues i=0(15)2985 {
  local k=`j'+`i' 
  replace e = 0.25*u + 0.75*e[_n-1] in `k'
  }
}

gen alphat=. 
forvalues j=1(1)15 {
  replace alphat = rnormal(0,4) in `j'
}

forv j=1(1)15 { 
 forv k=1(1)199 {
  local l=`j'+`k'*15
  replace alphat=alphat[`j'] in `l'
 }
}

gen alphai=.

forv k=0(1)199 { 
 local l=`k'*15+1
 replace alphai=rnormal(4,10) in `l'
}

forv j=2(1)15 {
 forv k=0(1)199 {
  local l=`j'+`k'*15
  local m=1+`k'*15
 replace alphai=alphai[`m'] in `l'
 }
}


gen Treat=0 
forvalues i=1500(1)3000 { 
 replace Treat=1 in `i' if t>6 
}


gen Y = alphai  + alphat + 2*Treat + e    

reg Y Treat i.i i.t, vce(robust) // reg 2: heteroskestic error
return scalar theta2=_b[Treat] //theta hat
return scalar std_er2= _se[Treat]
return scalar tstat2= (_b[Treat]-2)/(_se[Treat])
*test Treat=2

xtset i //declare to be panel 
xtreg Y Treat i.t , fe //reg 1: iid 
return scalar theta1=_b[Treat] //theta hat
return scalar std_er1= _se[Treat]
return scalar tstat1= (_b[Treat]-2)/(_se[Treat])
*test Treat=2


xtreg Y Treat i.t, fe vce(cluster i) // reg 3: cluster
return scalar theta3=_b[Treat] //theta hat
return scalar std_er3= _se[Treat]
return scalar tstat3= (_b[Treat]-2)/(_se[Treat])
*test Treat=2

end

simulate theta1=r(theta1) std_er1=r(std_er1) tstat1=r(tstat1) theta2=r(theta2) std_er2=r(std_er2) tstat2=r(tstat2) theta3=r(theta3) std_er3=r(std_er3) tstat3=r(tstat3), saving(estimation,replace) reps(1000): autocorr

sum theta1 std_er1
sum tstat1 if abs(tstat1)>1.96

sum theta2 std_er2
sum tstat2 if abs(tstat2)>1.96

sum theta3 std_er3
sum tstat3 if abs(tstat3)>1.96

/*
. sum theta1 std_er1

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      theta1 |      1,000     2.00147    .0797528   1.689727   2.302912
     std_er1 |      1,000    .0310088      .00096   .0282548     .03434

. sum tstat1 if abs(tstat1)>1.96

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      tstat1 |        454    .1020068     3.62596  -9.502542   9.847495

 
. sum theta2 std_er2

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      theta2 |      1,000     2.00147    .0797528   1.689727   2.302912
     std_er2 |      1,000    .0328706    .0010997    .029932   .0367938

. sum tstat2 if abs(tstat2)>1.96

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      tstat2 |        426    .1022247    3.498894  -8.914904    9.24557

 
. sum theta3 std_er3

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      theta3 |      1,000     2.00147    .0797528   1.689727   2.302912
     std_er3 |      1,000    .0777835    .0039719   .0655885   .0905474

. sum tstat3 if abs(tstat3)>1.96

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      tstat3 |         54    .4842814    2.383751  -3.831891   4.003952


Clustering the panel produces estimations closest to the actual value, and 
rejects the null the least number of times.

Therefore, when there is autocorrelation we should use robust standard error
clustering on the individual.
*/


/*PART II to IV*/

capture program drop ashenfelter
program ashenfelter, rclass
drop _all
set obs 3000

gen i=. 
forvalues j=0(1)199 {
 forvalues k=1(1)15 {
  local l=`j'*15+`k' 
  local m=`j'+1  
  replace i=`m' in `l' 
  }
}

gen t=. 
forvalues j=1(1)15 {
 forvalues i=0(15)2985 {
  local k=`j'+`i' 
  replace t=`j' in `k'
  }
}

gen u = rnormal(0,1)

gen e = .
replace e = u if t==1
forvalues j=2(1)15 {
 forvalues i=0(15)2985 {
  local k=`j'+`i' 
  replace e = 0.25*u + 0.75*e[_n-1] in `k'
  }
}

gen alphat=. 
forvalues j=1(1)15 {
  replace alphat = rnormal(0,4) in `j'
}

forv j=1(1)15 { 
 forv k=1(1)199 {
  local l=`j'+`k'*15
  replace alphat=alphat[`j'] in `l'
 }
}

gen alphai=.

forv k=0(1)199 { 
 local l=`k'*15+1
 replace alphai=rnormal(4,10) in `l'
}

forv j=2(1)15 {
 forv k=0(1)199 {
  local l=`j'+`k'*15
  local m=1+`k'*15
 replace alphai=alphai[`m'] in `l'
 }
}

gen Treat=0
gen Y = alphai  + alphat + 2*Treat + e    
summarize Y if t==6, d
return scalar p50=r(p50) //median

forv j=7(1)15 {
 forv k=0(1)199 {
  local l=`j'+`k'*15
  local n=`k'*15+6
  replace T=1 in `l' if Y[`n']<`r(p50)' //conditional treatment
 }
}

replace Y = alphai + alphat + 2*Treat + e
xtset i t
xtreg Y Treat i.t, fe vce(robust)
return scalar theta1=_b[Treat]
return scalar std_er1=_se[Treat]
return scalar tstat1= (_b[Treat]-2)/(_se[Treat])


gen earlyTrtmt=0 //ashenfelter dip
forvalues j=0(1)199 {
local k=`j'*15+7
local l=`k'-1
replace earlyTrtmt=1 in `l' if Treat[`k']==1
}

xtreg Y earlyTrtmt Treat i.t, fe vce(robust)
return scalar theta2=_b[Treat]
return scalar std_er2=_se[Treat]
return scalar tstat2= (_b[Treat]-2)/(_se[Treat])

return scalar tstat3= (_b[earlyTrtmt]-0)/(_se[earlyTrtmt])

end

simulate theta1=r(theta1) std_er1=r(std_er1) tstat1=r(tstat1) theta2=r(theta2) std_er2=r(std_er2) tstat2=r(tstat2) tstat3=r(tstat3), saving(estimation2,replace) reps(500): ashenfelter

sum theta1 std_er1
sum tstat1 if abs(tstat1)>1.96

sum theta2 std_er2
sum tstat2 if abs(tstat2)>1.96

sum tstat3 if abs(tstat3)>1.96

/*
. sum theta1 std_er1

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      theta1 |        500    2.019067     .077002   1.763654   2.226247
     std_er1 |        500    .0780417    .0039333   .0676755   .0892347

. sum tstat1 if abs(tstat1)>1.96

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      tstat1 |         28    1.666612    1.683998  -2.831313   2.881588

. 
. sum theta2 std_er2

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      theta2 |        500    2.019058    .0853628   1.737409   2.245779
     std_er2 |        500    .0864213    .0043826   .0748781    .097811

. sum tstat2 if abs(tstat2)>1.96

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      tstat2 |         27    1.498872    1.859281  -2.825096   2.932902

. 
. sum tstat3 if abs(tstat3)>1.96

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
      tstat3 |         32     .065206    2.382746  -2.639289   3.727577

	  
Accouting for the ashenfelter dip slightly reduces the number of rejections
but not by much.
*/

erase estimation.dta
erase estimation2.dta


