* cd "C:\Users\dhnsingh\Documents\stata_guide"

set logtype text 
capture log close
log using dsx, replace text

version 15.1

set linesize 80
set scheme s2color

clear all
macro drop _all

  //task: tabulating and troubleshooting errors
  //#1
* sysuse auto.dta, clear
edit
save student, replace

tab make foreign, row nolabel





log close
exit
