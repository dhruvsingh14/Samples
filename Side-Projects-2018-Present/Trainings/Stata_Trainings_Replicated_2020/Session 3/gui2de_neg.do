

capture program drop gui2de_neg
program define gui2de_neg
syntax [varlist] [if] [in]

foreach var in `varlist' {
qui inspect `var'
if r(N_neg) == 0 {
disp "`var' is positive for all observations"
}
else {
disp as err "`var' is negative for `r(N_neg)' observation(s)"
}
}
end
*

use "$popdensity", clear
gui2de_neg SUPERFICIEKM2 DENSITEAUKM POPULATION
