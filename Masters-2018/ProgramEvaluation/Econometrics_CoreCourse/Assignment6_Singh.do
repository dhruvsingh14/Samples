set more off
clear

capture cd "\\toaster\homes\d\h\dhnsingh\nt\Spring 2018\Ecmt 676\HW6"
if c(username)=="davidpritchard" {
cd " C:\Users\davidpritchard\Assignment 6
}
cap mkdir Output_Singh

log using Assignment6, replace

use stardata
*10,807 total observations

*replacing mathk, readk:
sum mathk if mathk==999 
replace mathk=. if mathk==999 //5,317 changes
sum readk if readk==999
replace readk=. if readk==999 //5,398 changes

*replacing math1-3, read1-3:
forvalues i = 1(1)3 {
replace math`i'=. if math`i'==999
replace read`i'=. if read`i'==999
}

*creating percentiles for class type reg and reg/aide
pctile mathkpct=mathk if ctypek==2|ctypek==3, nq(100)
pctile readkpct=readk if ctypek==2|ctypek==3, nq(100)

forvalues i = 1(1)3 {
pctile math`i'pct=math`i' if ctype`i'==2|ctype`i'==3, nq(100)
pctile read`i'pct=read`i' if ctype`i'==2|ctype`i'==3, nq(100)
}

*assigning to cutoffs 
xtile mathkperc=mathk if ctypek~=9, cutpoints(mathkpct)
xtile readkperc=readk if ctypek~=9, cutpoints(readkpct)

forvalues i = 1(1)3 {
xtile math`i'perc=math`i' if ctype`i'~=9, cutpoints(math`i'pct)
xtile read`i'perc=read`i' if ctype`i'~=9, cutpoints(read`i'pct)
}

//**PART 1**//
//**Descriptive Statistics**//

*1a
*generating indicator var for free/reduced price lunch for each grade
replace sesk=. if sesk==9
gen freelunchk=1 if sesk==1
replace freelunchk=0 if sesk==2

forvalues i = 1(1)3 {
replace ses`i'=. if ses`i'==9
gen freelunch`i'=1 if ses`i'==1
replace freelunch`i'=0 if ses`i'==2
}

*generating indicator for white or asian student for each grade
replace race=. if race==9
gen white_asian=1 if race==1|race==3
replace white_asian=0 if race==2|race==4|race==5|race==6

*generating age in 85 var
* Create age variable, year of birth, quarter of birth, month of birth
replace yob=. if yob==9999
replace qob=. if qob==99

gen mob=.
replace mob=1.5 if qob==1
replace mob=4.5 if qob==2
replace mob=7.5 if qob==3
replace mob=10.5 if qob==4 
gen agein1985=1985-yob+(9-mob)/12 

*generating attrition for each grade
gen attritionk=0
replace attritionk=1 if stark==2

forv i = 1(1)3 {
gen attrition`i'=0
replace attrition`i'=1 if star`i'==2
}

*generating mean scores as per footnote 11
gen mnscorek=(readkperc+mathkperc)/2
replace mnscorek=readkperc if mathkperc==.
replace mnscorek=mathkperc if readkperc==.

forvalues i = 1(1)3 {
gen mnscore`i'=(read`i'perc+math`i'perc)/2
replace mnscore`i'=read`i'perc if math`i'perc==.
replace mnscore`i'=math`i'perc if read`i'perc==.
}

sum freelunchk freelunch1 freelunch2 freelunch3 white_asian  ///
	agein1985 attritionk attrition1 attrition2 attrition3  	 ///
	mnscorek mnscore1 mnscore2 mnscore3

*1b
table ctypek, c(mean freelunchk mean freelunch1 mean freelunch2 mean freelunch3 mean white_asian)
table ctypek, c(mean agein1985 mean attritionk mean attrition1 mean attrition2 mean attrition3)
table ctypek, c(mean mnscorek mean mnscore1 mean mnscore3)

*1c
*asian or white teacher var for each grade
replace tracek=. if tracek==9
forv i = 1(1)3 {
replace trace`i'=. if trace`i'==9
}

gen white_asian_teacherk=0
replace white_asian_teacherk=1 if tracek==1|tracek==3

forv i = 1(1)3 {
gen white_asian_teacher`i'=0
replace white_asian_teacher`i'=1 if trace`i'==1|trace`i'==3
}
						
*indicator for teacher with at least masters for each grade
replace hdegk=. if hdegk==9
forv i = 1(1)3 {
replace hdeg`i'=. if hdeg`i'==9
}

gen teacher_has_mastersk=0
replace teacher_has_mastersk=1 if hdegk>=3

forv i = 1(1)3 {
gen teacher_has_masters`i'=0
replace teacher_has_masters`i'=1 if hdeg`i'>=3
}
								
*replacing missing values for teacher experience
replace totexpk=. if totexpk==99
forv i = 1(1)3 {
replace totexp`i'=. if totexp`i'==99
}

table ctypek, c(mean white_asian_teacherk mean white_asian_teacher1 mean white_asian_teacher2 mean white_asian_teacher3)
table ctypek, c(mean teacher_has_mastersk mean teacher_has_masters1 mean teacher_has_masters2 mean teacher_has_masters3)
table ctypek, c(mean totexpk mean totexp1 mean totexp2 mean totexp3)

*1d									
*For following 3 vars we test differences between treated and untreated:
*total experience; masters degree; white/asian teacher

//indicators for treatment groups
replace ctypek=. if ctypek==9
forv i = 1(1)3 {
replace ctype`i'=. if ctype`i'==9
}

gen smallk=0 //small class
replace smallk=1 if ctypek==1

gen regulark=0 //regular class
replace regulark=1 if ctypek==2

gen regaidek=0 //regaide class
replace regaidek=1 if ctypek==3

forv i = 1(1)3 {
gen small`i'=0 //small class
replace small`i'=1 if ctype`i'==1

gen regular`i'=0 //regular class
replace regular`i'=1 if ctype`i'==2

gen regaide`i'=0 //regaide class
replace regaide`i'=1 if ctype`i'==3
}

//regression using reg+aide as baseline comparison group
reg freelunchk smallk regulark, cluster(schidk)
outreg2 using doc1.xls, replace ctitle(lunchk) label
reg totexpk smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(texpk) label
reg teacher_has_mastersk smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(teduck) label
reg white_asian_teacherk smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(tracek) label
reg white_asian smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(racek) label
reg mnscorek smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(mnscorek) label
reg attritionk smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(attritionk) label
reg agein1985 smallk regulark, cluster(schidk)
outreg2 using doc1.xls, append ctitle(agein85k) label

forv i = 1(1)3 {
reg freelunch`i' small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(lunch`i') label
reg totexp`i' small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(texp`i') label
reg teacher_has_masters`i' small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(teduc`i') label
reg white_asian_teacher`i' small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(trace`i') label
reg white_asian small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(race`i') label
reg mnscore`i' small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(mnscore`i') label
reg attrition`i' small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(attrition`i') label
reg agein1985 small`i' regular`i', cluster(schid`i')
outreg2 using doc1.xls, append ctitle(agein85`i') label
}

/*regressions indicate that being in a small and regular class is 
significantly correlated with having a white/asian teacher, a teacher with
a masters, and a teacher with more experience, compared with a regaide class*/
/*except in one case: regular1~totexp1*/

//regression using small as baseline comparison group
reg freelunchk regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, replace ctitle(lunchk) label
reg totexpk regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(texpk) label
reg teacher_has_mastersk regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(teduck) label
reg white_asian_teacherk regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(tracek) label
reg white_asian regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(racek) label
reg mnscorek regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(mnscorek) label
reg attritionk regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(attritionk) label
reg agein1985 regulark regaidek, cluster(schidk)
outreg2 using doc2.xls, append ctitle(agein85k) label

forv i = 1(1)3 {
reg freelunch`i' regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(lunch`i') label
reg totexp`i' regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(texp`i') label
reg teacher_has_masters`i' regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(teduc`i') label
reg white_asian_teacher`i' regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(trace`i') label
reg white_asian regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(race`i') label
reg mnscore`i' regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(mnscore`i') label
reg attrition`i' regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(attrition`i') label
reg agein1985 regular`i' regaide`i', cluster(schid`i')
outreg2 using doc2.xls, append ctitle(agein85`i') label
}

/*not significantly correlated in regulark~totexpk, or regaide1~totexp1
or regular2~totexp2 or regular3~totexp3*/
/*significant correlated between regular, regaide and totexp, masters, white/asian
in all other cases, relative to being in small class*/

//regression using regular as baseline comparison group
reg freelunchk smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, replace ctitle(lunchk) label
reg totexpk smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(texpk) label
reg teacher_has_mastersk smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(teduck) label
reg white_asian_teacherk smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(tracek) label
reg white_asian smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(racek) label
reg mnscorek smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(mnscorek) label
reg attritionk smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(attritionk) label
reg agein1985 smallk regaidek, cluster(schidk)
outreg2 using doc3.xls, append ctitle(agein85k) label

forv i = 1(1)3 {
reg freelunch`i' small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(lunch`i') label
reg totexp`i' small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(texp`i') label
reg teacher_has_masters`i' small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(teduc`i') label
reg white_asian_teacher`i' small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(trace`i') label
reg white_asian small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(race`i') label
reg mnscore`i' small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(mnscore`i') label
reg attrition`i' small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(attrition`i') label
reg agein1985 small`i' regaide`i', cluster(schid`i')
outreg2 using doc3.xls, append ctitle(agein85`i') label
}
/*not significant for smallk~totexpk, or small2~totexp2, or small3~totexp3*/
/*overall, it appears as though being assigned to a certain class types can
affect the type of teacher characteristics of a student*/

*2a
/*no, I don't agree*/
/*since there are coefficients stat sign, it suggests some class types are 
more likely to have a teacher with white_asian teacher, with more totexp, 
or with a masters or more.*/

*2b
xi i.schidk, noomit
xi i.schid1, noomit
xi i.schid2, noomit
xi i.schid3, noomit

//regression using reg+aide as baseline comparison group, fe
reg freelunchk smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, replace ctitle(lunchk fe) label
reg totexpk smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(texpk fe) label
reg teacher_has_mastersk smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(teduck fe) label
reg white_asian_teacherk smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(tracek fe) label
reg white_asian smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(racek fe) label
reg mnscorek smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(mnscorek fe) label
reg attritionk smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(attritionk fe) label
reg agein1985 smallk regulark i.schidk, cluster(schidk)
outreg2 using doc4.xls, append ctitle(agein85k fe) label

forv i = 1(1)3 {
reg freelunch`i' small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(lunch`i' fe) label
reg totexp`i' small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(texp`i' fe) label
reg teacher_has_masters`i' small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(teduc`i' fe) label
reg white_asian_teacher`i' small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(trace`i' fe) label
reg white_asian small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(race`i' fe) label
reg mnscore`i' small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(mnscore`i' fe) label
reg attrition`i' small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(attrition`i' fe) label
reg agein1985 small`i' regular`i' i.schid`i', cluster(schid`i')
outreg2 using doc4.xls, append ctitle(agein85`i' fe) label
}

//regression using small as baseline comparison group, fe
reg freelunchk regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, replace ctitle(lunchk fe) label
reg totexpk regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(texpk fe) label
reg teacher_has_mastersk regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(teduck fe) label
reg white_asian_teacherk regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(tracek fe) label
reg white_asian regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(racek fe) label
reg mnscorek regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(mnscorek fe) label
reg attritionk regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(attritionk fe) label
reg agein1985 regulark regaidek i.schidk, cluster(schidk)
outreg2 using doc5.xls, append ctitle(agein85k fe) label

forv i = 1(1)3 {
reg freelunch`i' regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(lunch`i' fe) label
reg totexp`i' regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(texp`i' fe) label
reg teacher_has_masters`i' regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(teduc`i' fe) label
reg white_asian_teacher`i' regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(trace`i' fe) label
reg white_asian regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(race`i' fe) label
reg mnscore`i' regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(mnscore`i' fe) label
reg attrition`i' regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(attrition`i' fe) label
reg agein1985 regular`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc5.xls, append ctitle(agein85`i' fe) label
}

//regression using regular as baseline comparison group, school fixed effects
reg freelunchk smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, replace ctitle(lunchk fe) label
reg totexpk smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(texpk fe) label
reg teacher_has_mastersk smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(teduck fe) label
reg white_asian_teacherk smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(tracek fe) label
reg white_asian smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(racek fe) label
reg mnscorek smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(mnscorek fe) label
reg attritionk smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(attritionk fe) label
reg agein1985 smallk regaidek i.schidk, cluster(schidk)
outreg2 using doc6.xls, append ctitle(agein85k fe) label

forv i = 1(1)3 {
reg freelunch`i' small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(lunch`i' fe) label
reg totexp`i' small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(texp`i' fe) label
reg teacher_has_masters`i' small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(teduc`i' fe) label
reg white_asian_teacher`i' small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(trace`i' fe) label
reg white_asian small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(race`i' fe) label
reg mnscore`i' small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(mnscore`i' fe) label
reg attrition`i' small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(attrition`i' fe) label
reg agein1985 small`i' regaide`i' i.schid`i', cluster(schid`i')
outreg2 using doc6.xls, append ctitle(agein85`i' fe) label
}

*2c
/*difference by of teacher characteristic by class type does not disappear but
is reduced after accounting for school fixed effects*/

*3a: focusing on 1st grade
reg mnscore1 small1 regaide1, cluster(schid1)
outreg2 using doc7.xls, replace ctitle(mnscore r1) label

reg mnscore1 small1 regaide1 i.schid1, cluster(schid1)
outreg2 using doc7.xls, append ctitle(mnscore r2) label

gen girl=0
replace girl=. if sex==9
replace girl=1 if sex==2

reg mnscore1 small1 regaide1 white_asian girl freelunch1 i.schid1, cluster(schid1)
outreg2 using doc7.xls, append ctitle(mnscore r3) label

reg mnscore1 small1 regaide1 white_asian girl freelunch1 white_asian_teacher1 ///	
	teacher_has_masters1 totexp1 i.schid1, cluster(schid1)
outreg2 using doc7.xls, append ctitle(mnscore r4) label

*3b
/*being in a small classroom in the first grade correlates with a 9.036 unit
increase in mnscore1, and being in a reg+aide classroom is correlated with a
2.861 unit increase in mnscore1, relative to being in a regular class, all 
else constant.*/

*3c
/*including race and gender of student causes the coefficients to shrink, 
however, including other covariates does not affect the coefficients much.//
*/
/*there is no selection on observables*/

*3d
/*yes, the fact that assignment is random indicates coefficients will not 
change from including more covariates*/

*3e
/*test scores being noisy measure means coefficients will change with including
more covariates*/

*4a
reg ctype1 small1 regaide1, cluster(schid1)
outreg2 using doc8.xls, replace ctitle(csize r1) label

reg ctype1 small1 regaide1 i.schid1, cluster(schid1)
outreg2 using doc8.xls, append ctitle(csize r2) label

reg ctype1 small1 regaide1 white_asian girl freelunch1 i.schid1, cluster(schid1)
outreg2 using doc8.xls, append ctitle(csize r3) label

reg ctype1 small1 regaide1 white_asian girl freelunch1 white_asian_teacher1 ///	
	teacher_has_masters1 totexp1 i.schid1, cluster(schid1)
outreg2 using doc8.xls, append ctitle(csize r4) label

*4c
gen newin1=0
replace newin1=1 if small1==1&smallk==0

ivregress 2sls mnscore1 i.schid1 (ctype1 = small1 regaide1), cluster(schid1)
outreg2 using doc9.xls, replace ctitle(iv r1) label
ivregress 2sls mnscore1 white_asian i.schid1 (ctype1 = small1 regaide1), cluster(schid1)
outreg2 using doc9.xls, append ctitle(iv r2) label
ivregress 2sls mnscore1 white_asian girl yob i.schid1 (ctype1 = small1 regaide1), cluster(schid1)
outreg2 using doc9.xls, append ctitle(iv r3) label
ivregress 2sls mnscore1 white_asian girl white_asian_teacher1 ///
		teacher_has_masters1 totexp1 i.schid1 (ctype1 = small1 regaide1), cluster(schid1)
outreg2 using doc9.xls, append ctitle(iv r4) label

*4d
/*it is mentioned that parents might have lobbied to get their children in a 
different class, regardless of assignment to treatment. This might have 
invalidated random assignment, and the exclusion restriction.*/

forv i=1(1)9{
erase doc`i'.xls
erase doc`i'.txt
}


log close















								
		

