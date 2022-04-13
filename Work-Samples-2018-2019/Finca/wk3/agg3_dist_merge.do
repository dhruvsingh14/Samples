log using mec_mkt_rsrch, replace
set maxvar 30000

/*Section I*/

*1 reading in mec data in csv, exporting to dta

insheet using "E:\TheMonthInReview\wk3\monthly_products.csv", comma

replace branch = "Arsikere" if branch == "Arasikere"
replace branch = "Jamkhandi" if branch == "JAMKHANDI"
drop v1

save "monthly_products.dta", replace
outsheet using monthly_products.csv, comma replace
clear

*2 reading in districts data csv, saving as dta
insheet using "E:\TheMonthInReview\wk3\dist2_frmtd.csv", comma 
rename v2 branch
rename v3 district
drop v1

*3 merging

merge m:m branch using "monthly_products.dta"

drop if _merge == 1 //deleting row carrying colname as a value

drop _merge

outsheet using monthly_products2_dist.csv, comma replace
save "monthly_products2_dist.dta", replace

clear



tab yr_applied product, row





















insheet using "C:\Users\dhnsingh\Desktop\Finca\patch-2\coordinates.csv", comma 

replace location = "Chamarajanagar" if location == "Chamrajnagar"
replace location = "Chikkaballapura" if location == "Chickballapur"
replace location = "Davanagere" if location == "Davangere"
replace location = "Dharwad" if location == "Dharwar"
replace location = "Koppal" if location == "Kopbal"
replace location = "Udupi" if location == "Udipi"

drop v1

save "coordinates.dta", replace
clear

* merging next round, coordinates

use monthly_products.dta
drop v1 
rename district location

merge m:m location using "coordinates.dta"

tabulate location if _merge == 1

drop if _merge == 2

rename location district

rename branch location

rename _merge merge2

merge m:m location using "coordinates.dta"

drop if _merge == 2

outsheet using m_p_lt_lng.csv, comma replace

tab district if lt == .
