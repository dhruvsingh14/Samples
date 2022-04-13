*2) 
use States, clear

*2a)
sort region

by region:sum income


*2b)
gen west=0 
replace west=1 if region==1

gen northeast=0 
replace northeast=1 if region==2

gen south=0 
replace south=1 if region==3

gen midwest=0 
replace midwest=1 if region==4

reg income west south midwest


*3a)
reg energy green

*3b)
reg energy green toxic miles

*3c)
reg energy green toxic miles, beta

