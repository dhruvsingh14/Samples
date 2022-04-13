log using mec_mkt_rsrch, replace
set maxvar 30000


*1 reading in ind level data in csv, exporting to dta

insheet using "E:\TheMonthInReview\wk1\ind_level_subset.csv", comma

drop v1

* eg
tab yr_applied product, row
tab branch yr_applied if product == "Cook Stove", row



generate v2 = date(applied, "YMD")
format %td v2
hist v2


hist count yr_applied
