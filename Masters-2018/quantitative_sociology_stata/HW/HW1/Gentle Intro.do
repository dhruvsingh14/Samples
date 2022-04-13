sysuse cancer, clear
summarize
summarize age drug
histogram age
histogram age, width(2.5) start(45) frequency title(Age distribution of Participants in Cancer Study) note(Data: Sample cancer dataset) legend(on) scheme(s1mono)
//can just use dialogue box to generate above settings


label define sex 1 "Male" 2 "Female"
label values gender sex

use questionnaire9, clear

label define sex 1 "Male" 2 "Female"
label values gender sex

label define rating 1 "Very Poor" 2 "Poor" 3 "Ok" 4 "Good" 5 "Very Good" -9 "Missing"
label values sch_st rating
label values sch_com rating

label define harsh 1 "Much too lenient" 2 "Too lenient" 3 "About right" 4 "Too harsh" 5 "Much too harsh" -9 "Missing"
label values prison harsh


label define conserv 1 "Very Liberal" 2 "Liberal" 3 "Moderate" 4 "Conservative" 5 "Very Conservative" -9 "Missing"
label values conserv conserv

summarize

numlabel _all, add

list

describe
notes

browse, nolabel
*edit, nolabel

save "questionnaire9.dta", replace







