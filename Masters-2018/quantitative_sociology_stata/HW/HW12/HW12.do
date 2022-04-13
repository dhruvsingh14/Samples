use taiwan-hw12.dta

desc

drop if int1<1
stset int1 event1

*1a
sts graph

*1b
sts list

*1c
stcox ageinv wedu2 wedu3 smallct, nohr
stcox, hr

*2
drop _all

use taiwan-hw12.dta
drop if int2 <1
drop if int2 ==.

stset int2 event2

stcox ageinv wedu2 wedu3 smallct, nohr
stcox, hr

*3a
stcox ageinv wedu2 wedu3 smallct son1, nohr

*3b
stcox, hr
