clear
capture cd "\\toaster\homes\d\h\dhnsingh\nt\Spring 2018\Ecmt 676\HW2"
if c(username)=="davidpritchard" {
cd "C:\Users\davidpritchard\Desktop\ECMT 676\Homework\Assignment 2"
}


****Part I****
****//estimate using OLS//***
capture program drop ols
program ols, rclass
syntax, beta2(real)
drop _all
set obs 100
gen Z = rnormal(0,1)
gen u = rnormal(0,1)
gen e = rnormal(0,1)
gen v = rnormal(0,1)
local beta0=0.6
local beta1=2 //true value
local beta2=1.2
gen X = 0.8*Z + 0.5*u + v
gen Y = `beta0'+`beta1'*X + `beta2'*u + e
reg Y X
return scalar beta1=_b[X]
//for Y to yield unbiased est of beta1, beta2=0 must be true
end

simulate beta1=r(beta1) /*beta2=r(beta2)*/, saving(results,replace) reps(1000): ols, beta2(1.2)




*****Part II****
****//checking the est from regression Y on X-hat//***
gen Z = rnormal(0,1)
gen u = rnormal(0,1)
gen e = rnormal(0,1)
gen v = rnormal(0,1)
local beta0=0.6
local beta1=2 //true value
local beta2=1.2
gen X = 0.8*Z + 0.5*u + v
*gen Y= `beta0'+`beta1'*X + `beta2'*u + e
gen Y = 0.6 + 2*X + 1.2*u + e
reg X Z
predict Xhat
reg Y Xhat
//checking comparison with beta1 estimates fom ols
gen beta1hat=_b[Xhat]
*mean(beta1)



****Part III***
****//estimate using IV//***
capture program drop iv
program iv, rclass
syntax, beta2(real)
drop _all
set obs 100
gen Z = rnormal(0,1)
gen u = rnormal(0,1)
gen e = rnormal(0,1)
gen v = rnormal(0,1)
local beta0=0.6
local beta1=2 //true value
local beta2=1.2
gen X = 0.8*Z + 0.5*u + v
gen Y= `beta0'+`beta1'*X + `beta2'*u + e
ivregress 2sls Y (X = Z) 
return scalar beta1=_b[X]
end

simulate beta1=r(beta1) /*beta2=r(1.2)*/, saving(results2,replace) reps(1000): iv, beta2(1.2)







