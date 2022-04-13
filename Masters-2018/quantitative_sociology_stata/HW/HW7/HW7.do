use nsfg, clear //shows using svy vs non survey

svyset [pweight=finalwgt], strata(sest) psu(secu)

*1.1.
svy: mean hieduc age_a hispanic intact18 dadhsgrad

*1.2.
sum hieduc age_a hispanic intact18 dadhsgrad

*1.4.
svy: logit hieduc age_a hispanic intact18 dadhsgrad

*1.5.
logit hieduc age_a hispanic intact18 dadhsgrad


use vttown, clear //showing regress using ols vs logistic, to estimate dichotomous dependent variable.

*2.1.
reg meetings lived

predict meetingsfit

twoway scatter meetings lived || lfit meetingsfit lived

*2.2.
logit meetings lived

predict meetingslogithat

twoway scatter meetingslogithat meetings lived, connect(l i) msymbol(i O) sort ylabel(0 1)

