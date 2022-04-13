sysuse auto
browse 
describe
notes

***Part I****

*Q1
sort mpg
list make if mpg>=28 //this lists 11 cars, (only asked for 10) due to eql. vals.


***Part II****


use science4, clear

*Q1
describe 


*Q3
tab mmale, missing

*Q4
tab fellow, missing

*Q5
list enrol in 1/15

*Q6
list enrol if female==1

*Q7
tab female mmale

*Q8
gen isfac = (work==1) if work<.

label variable isfac "Scientist is faculty member in university"
label define isfac 0 "NotFac" 1 "Faculty"
label values isfac isfac

*Q8a
tab isfac 
tab work
tabulate isfac work, missing

*Q8b
tabulate female work, missing

*Q9
sum cit6, d

*Q10
sum cit3, d

*Q11
dotplot cit6

*Q13
list female if cit6==143
tab female if cit6==143
sum female if cit6==143

list isfac if cit6==143

*Q14a
graph twoway scatter cit9 pub9

*Q14b
corr cit9 pub9

*Q15
graph twoway scatter cit1 cit3
corr cit1 cit3







