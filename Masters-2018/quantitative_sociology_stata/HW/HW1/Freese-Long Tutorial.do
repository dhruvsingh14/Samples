***Part II***
***Freese-Long***

capture log, close
log using tutorial, text

use science4, clear
codebook, compact

summarize work
tabulate work, missing

dotplot pub1
graph export tutorial_dotplot.emf, replace

gen isfac = (work==1) if work<.
tabulate isfac work, missing

label variable isfac "Scientist is faculty member in university"
label define isfac 0 "NotFac" 1 "Faculty"
label values isfac isfac

tabulate isfac

tabulate job, missing
*left off on pg 77 creating an ordinal variable
