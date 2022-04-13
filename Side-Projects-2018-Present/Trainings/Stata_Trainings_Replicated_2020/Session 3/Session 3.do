/******************************************************************************

* gui2de STATA Tutorial: Session 2
* Ali Hamza
* Feb 10th, 2017

Topics:

1.	Interoperability: c-class values.

2.	String Variables: fuzzy matching (matchit, reclink, reclink2), string cleaning (regexm) 

3.	Misc STATA Commands: preserve/restore, capture, assert

4.	User written commands: IPA github page, ado files and other useful user-written commands (orth_out, randomize etc) 

5.	Best Data Practices 2.0

*******************************************************************************/
set more off
clear
capture log close

********************************************************************************
*1 INTEROPERABILITY: c-class variables
********************************************************************************

/*
c-class values:
they are designed to provide one all-encompassing way to access system parameters
and settings, including system directories, system limits etc
*/

*Example
creturn list

*Objective: You should be able to run my do file without changing a single line 
*			of code

*Solution: You can do this using c(username) & if/else statements:

********************Setting Working Directory**********************************

/*
IMPORTANT: ALWAYS use forward slash in folder/file paths becasue:
1) windows can read both forward/back slash in file paths but Mac can only
   process forward slash.
2) "Beware the backstabbing backslash" (http://www.stata-journal.com/sjpdf.html?articlenum=pr0042)
   ___^^Read it after the tutorial_____
*/



*Approach 1

*Ali Hamza 1 (Windows)
if c(username)=="ah1152" {
	global user "C:/Users/ah1152/Box Sync/"
}

* Ali Hamza 2 (MacOS)
else if c(username)=="Zambeel" {
	global user "/Users/Zambeel/Box Sync/"
}

* Beatrice Leydier
else if c(username)=="Pytha" {
	global user "C:/Users/Pytha/Box Sync"
}

* Grady Killeen
else if c(username)=="Grady" {
	global user "C:/Users/Grady/Box Sync"
}

* Andreas Niederwieser
else if c(username)=="Andreas" {
	global user "C:/Users/Andreas/Box Sync"
}


* Shashank Rai (MacOS)
else if c(username)=="shashankrai" {
	global user "/Users/shashankrai/Box Sync"
}

* Jessica Hickle
else if c(username)=="JEHickle" {
	global user "/Users/JEHickle/Box Sync"
}
* Chris Gray
else if c(username)=="Chris" {
	global user "C:/Users/Chris/Box Sync"
}

* 	Kaitlyn Turner
else if c(username)=="kaitlynturner" {
	global user "/Users/kaitlynturner/Box Sync"
}

*Zachary Scherer
else if c(username)=="zach" {
	global user "/Users/zach/Box Sync"
}

*	Timothy Clay 
else if c(username)=="timmyclay" {
	global user "/Users/timmyclay/Box Sync"
}

* 	Chinmaya Holla
else if c(username)=="hollappa" {
	global user "C:/Users/hollappa/Box Sync"
}

* 	Anna Konstantinova
else if c(username)=="annak" {
	global user "C:/Users/annak/Box Sync"
}

*Evan Waddill 
else if c(username)=="Evan" {
	global user "C:/Users/Evan/Box Sync"
}

* Richard Appell 
else if c(username)=="Rappell" {
	global user "/Users/Rappell/Box Sync/"
}

* Shardul Oza
else if c(username)=="sko11" {
	global user "C:/Users/sko11/Box Sync"
}

* Sakari Deichsel 
else if c(username)=="Sakari" {
	global user "C:/Users/Sakari/Documents/Box Sync"
}

*Naziza Ahmad
else if c(username)=="HP" {
	global user "C:/Users/HP/Documents/Box Sync" 
}
*^^DOUBLE CHECK

* everyone else who didn't send me their username and folder path
else {
	global user "Enter_Sync_Folder_Address_here"
	}
**

cd "$user"





*Alt-Approach

if c(os)=="Windows" {
	global user "C:/Users/`c(username)'/Box Sync"
	}

else {
	global user "/Users/`c(username)'/Box Sync"
	}

cd "$user"

/*Issues with this code:
 This code is based on following two assumptions which might not always be true:
	1)We only have Windows or MacOS machines
	2)Everyone's Box Sync folder is names exactly the same.
*/


******************************Log Files*****************************************

* How to name log file
* Example: [do file name]_[date]_[your initials] => session3_20170210_AH

*Approach 1
log using "gui2de STATA Tutorials/Session 3/Logs/session3_20170210_AH", replace
	
	display "Hello, World"

log close


* Approach 2 (use globals)

global log "gui2de STATA Tutorials/Session 3/Logs/session3_20170210_AH"
log using "$log", replace

	display "Hello, World"

log close

/*
Capture:
capture executes command, suppressing all its output (including error messages, if any) 
*/

*Approach 3 (use capture & globals)
global log "gui2de STATA Tutorials/Session 3/Logs/session3_20170210_AH"
capture log close
log using "$log", replace

	display "Hello, World"

log close




*Aproach 4 (use capture, globals AND c-class values)


capture log close //in case log is already open
*Use c class variables to automatically include date/time/username in the log file name
local date: di %tdCCYY.NN.DD date(c(current_date),"DMY")
local date: subinstr local date "." "", all
local time: di %tchham Clock(c(current_time),"hms")
local time: subinstr local time " " "", all
*defining log names using date and time 
global log "gui2de STATA Tutorials/Session 3/Logs/session3_`date'_`time'_`c(username)'.smcl"
log using "$log", replace

*




*Approach 5 ( use capture, globals, c-class values AND local switch it turn it on/off)
local start_log "On"
if "`start_log'" == "On" {
capture log close //in case log is already open
*Use c class variables to automatically include date/time/username in the log file name
local date: di %tdCCYY.NN.DD date(c(current_date),"DMY")
local date: subinstr local date "." "", all
local time: di %tchham Clock(c(current_time),"hms")
local time: subinstr local time " " "", all
*defining log names using date and time 
global log "gui2de STATA Tutorials/Session 3/Logs/session3_`date'_`time'_`c(username)'.smcl"

log using "$log", replace
}
*


*******************************************************************************
*Important resources on how to deal with date/time:
{
/*
http://www.stata.com/manuals13/u24.pdf
http://www.stata.com/manuals13/ddatetimetranslation.pdf#ddatetimetranslation
http://www.stata.com/manuals13/ddatetime.pdf#ddatetime
http://www.stata.com/manuals13/ddatetimebusinesscalendars.pdf#ddatetimebusinesscalendars
*/
}
*

********************************************************************************
*2 STRING VARIABLES: Fuzzy Matching (and regexm)
********************************************************************************

/*
regexm(s,re)
performs a match of a regular expression and evaluates to 1 if regular 
expression re is satisfied by the ASCII string s; otherwise, 0
*/


*Example1:
global project_e "gui2de STATA Tutorials/Session 3/Data/project_u.dta"

use "$project_e", clear

*correct answer is 7:25 am for mq10

gen mq10_new =""
replace mq10_new = "7:25am" if regexm(mq10,"7:25")
replace mq10_new = "7:25am" if regexm(mq10,"7hrs")
replace mq10_new = "7:25am" if regexm(mq10,"7.25") | regexm(mq10,"725")
replace mq10_new = "" if regexm(mq10,"pm")
replace mq10_new = "" if regexm(mq10,"p.m")
*example:


*Example2:
global project_t "gui2de STATA Tutorials/Session 3/Data/project_t.dta" 
use "$project_t", clear

*registration number for vehicles registered in Tanzania should look like:
* regnum = T123ABC
gen correct_regnum = regexm(regnum,"^T[0-9][0-9][0-9][A-Z][A-Z][A-Z]$")


*****************************
*Approximate String Matching: 
*****************************


/*
Approximate String Matching: 
Fuzzy String Matching is basically rephrasing the YES/NO “Are string A and 
string B the same?” as “How similar are string A and string B?”
*/

*there are a lot of STATA commands for it: matchit, reclink, reclink2
*but you can get better results by some data cleaning + merge

*Example:

		global popdensity "gui2de STATA Tutorials/Session 3/Data/CIV_populationdensity.dta"
		global section0  "gui2de STATA Tutorials/Session 3/Data/Section 0.dta" 
		global temp1 "gui2de STATA Tutorials/Session 3/Data/temp1.dta"
		
		use "$popdensity", clear

		keep if regexm(NOMCIRCONSCRIPTION, "DEPARTEMENT")==1
		//keeping only "Departement" names. I am assuming that all departments have 
		//"departement" in their names. We have 108 such observations
                                        
		global popdensity "gui2de STATA Tutorials/Session 3/Data/CIV_populationdensity.dta"
		global section0  "gui2de STATA Tutorials/Session 3/Data/Section 0.dta" 
		global temp1 "gui2de STATA Tutorials/Session 3/Data/temp1.dta"
		
		use "$popdensity", clear

		keep if regexm(NOMCIRCONSCRIPTION, "DEPARTEMENT")==1
		//keeping only "Departement" names. I am assuming that all departments have 
		//"departement" in their names. We have 108 such observations

		local removechars " " " "DEPARTEMENT" "DE" "D'" " " "
		foreach i of local removechars  {
			replace NOMCIRCONSCRIPTION = subinstr(NOMCIRCONSCRIPTION,"`i'","",.)
		}
		//removing "departement, de, d' and spaces from departement's names

		replace NOMCIRCONSCRIPTION=lower(NOMCIRCONSCRIPTION)
		//lower case to match ENV format
		rename NOMCIRCONSCRIPTION departement

		/*
		NOTE: There are 108 distinct departements in pop_density files and 107 in 
		ENV. Even after cleaning departement names, we can only match 104 names.

		unmatched departements are due to different spellings, see below:

		departement(ENV)    department (Pop_denssity)
		arrha				arrah
		sandegue			sangue
		sassandra			dusassandra
							gbeleban    (NOT in ENV dataset, ignore it)

		Changing the names of departements in pop-density file as we don't want to
		make any changes in ENV dataset
		*/

		replace departement="arrha" if departement=="arrah"
		replace departement="sandegue" if departement=="sangue"
		replace departement="sassandra" if departement=="dusassandra"

		rename POPULATION population
		rename SUPERFICIEKM2 areasqkm
		rename DENSITEAUKM pop_density

		save "$temp1", replace

		use "$section0", clear

		decode b06_departemen, gen(departement)

		merge m:1 departement using "$temp1"
		/*
			Result                           # of obs.
			-----------------------------------------
			not matched                             1
				from master                         0  (_merge==1)
				from using                          1  (_merge==2)

			matched                            12,899  (_merge==3)
			-----------------------------------------
		*/
		drop if _merge==2 //dropping the extra department from pop_density file

		summ _merge
		assert `r(N)'==12899 //Just to make sure we have the entire ENV dataset.
		local removechars " " " "DEPARTEMENT" "DE" "D'" " " "
		foreach i of local removechars  {
			replace NOMCIRCONSCRIPTION = subinstr(NOMCIRCONSCRIPTION,"`i'","",.)
		}
		//removing "departement, de, d' and spaces from departement's names

		replace NOMCIRCONSCRIPTION=lower(NOMCIRCONSCRIPTION)
		//lower case to match ENV format
		rename NOMCIRCONSCRIPTION departement

		/*
		NOTE: There are 108 distinct departements in pop_density files and 107 in 
		ENV. Even after cleaning departement names, we can only match 104 names.

		unmatched departements are due to different spellings, see below:

		departement(ENV)    department (Pop_denssity)
		arrha				arrah
		sandegue			sangue
		sassandra			dusassandra
							gbeleban    (NOT in ENV dataset, ignore it)

		Changing the names of departements in pop-density file as we don't want to
		make any changes in ENV dataset
		*/

		replace departement="arrha" if departement=="arrah"
		replace departement="sandegue" if departement=="sangue"
		replace departement="sassandra" if departement=="dusassandra"

		rename POPULATION population
		rename SUPERFICIEKM2 areasqkm
		rename DENSITEAUKM pop_density

		save "$temp1", replace

		use "$section0", clear

		decode b06_departemen, gen(departement)

		merge m:1 departement using "$temp1"
		/*
			Result                           # of obs.
			-----------------------------------------
			not matched                             1
				from master                         0  (_merge==1)
				from using                          1  (_merge==2)

			matched                            12,899  (_merge==3)
			-----------------------------------------
		*/
		drop if _merge==2 //dropping the extra department from pop_density file

		summ _merge
		assert `r(N)'==12899 //Just to make sure we have the entire ENV dataset.

*************

/*
Assert:
It verifies that exp is true.  If it is true, the command produces no output.  
If it is not true, assert informs you that the "assertion is false" and issues a
return code of 9
*/


*****************************
*Approximate String Matching:
*****************************
*In a lot of cases we can't use merge/data cleaning and have to rely on 
*fuzzy matching.

*Example: Tanzania Election data:
*Issue: We have election data from 1995, 2000, 2005, 2010 and 2015. We want to 
*match politicians who ran in multiple elections.

global election "gui2de STATA Tutorials/Session 3/Data/Tanzania_Election.dta"
global temp_95 "gui2de STATA Tutorials/Session 3/Data/temp_1995.dta"
global temp_00 "gui2de STATA Tutorials/Session 3/Data/temp_2000.dta"

use "$election", clear
rename *, lower
gen serial=_n

preserve
	keep if year==1995
	keep serial candidate
	save "$temp_95", replace //1222 obs
restore

preserve
	keep if year==2000
	keep serial candidate
	save "$temp_00", replace //1222 obs
restore


use "$temp_95", clear

cap ssc install matchit
cap ssc install freqindex


*match 2000 to 1995 data set
matchit serial candidate using "$temp_00", idusing(serial) txtusing(candidate)


keep if similscore>=0.63 

*sort by 1995 serial number, keep only best match 
gsort serial -similscore
duplicates drop serial, force
gsort -similscore
*sort by 2000 serial number, keep only best match
gsort serial1 -similscore
duplicates drop serial1, force
gsort -similscore




*Example 2:
global endline_clean "gui2de STATA Tutorials/Session 3/Data/endline_clean.dta"
global test_score_clean "gui2de STATA Tutorials/Session 3/Data/test_score_clean.dta"
global merge_scores "gui2de STATA Tutorials/Session 3/Data/merged_scores.dta"

clear
gen temp=.
save "$merge_scores", emptyok replace

use "$endline_clean", clear

levelsof schoolname, loc(schoolnames)

foreach school in `schoolnames' {
		*saving endline students scores for that school
		use "$endline_clean", clear
		keep if schoolname=="`school'"
		tempfile endline_`school'
		save `endline_`school''
			
		*saving admin students scores for that school	
		use "$test_score_clean", clear
		keep if schoolname=="`school'"
		tempfile admin_`school'
		save `admin_`school''
			
		*matching admin and endline
		use `endline_`school'', clear
		matchit id_endline childname using `admin_`school'', idusing(id_test) txtusing(childname)
		gen schoolname="`school'"
		append using "$merge_scores"
			
		save "$merge_scores", replace
	}	
*

gsort id_endline -similscore
duplicates drop id_endline, force //1721 obs dropped


//records from using dataset(test data), are best matches for multiple records 
//from master file (i.e. endline_score). Dropping duplicates with lower similscore
gsort id_test -similscore
duplicates drop id_test, force //140 obs dropped

gsort -similscore
format %30s childname* 


*IMPORTANT: EYEBALL THE DATA before using this cutoff
*****************************************************
//br
keep if similscore>0.62 




*******************************************************************************
* ado files
*******************************************************************************
/*
Their are two STATA programming languages:
1) ado : based on STATA commands, you can write scripts and programs to automate
reproducible analyses and to add new features to STATA

2) MATA: is a byte-compiled language with syntax similar to C/C++, but with
extensive matrix capabilities. The two languages can interact with each other

Resources: Programming Stata

For ado: http://www.stata.com/manuals13/u18.pdf#u18ProgrammingStata
For MATA: http://www.stata.com/manuals14/m.pdf

Misc:
http://www.stata.com/manuals14/p.pdf
http://www.stata.com/manuals14/d.pdf
http://www.stata.com/manuals14/u.pdf
*/



************************************
*defining a program
************************************

*Define a program that tells us the number of negative values for each variable

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


************************************
*Saving it as a separate do file
************************************

do "gui2de STATA Tutorials/Session 3/gui2de_neg"


************************************
*Saving it as an ado file
************************************

/*save the following code as .ado


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
*/

*And then save it in the following folder STATA14/ado/base/g

use "$popdensity", clear
gui2de_neg SUPERFICIEKM2 DENSITEAUKM POPULATION

***********************************




*******************************************************************************
* BEST DATA PRACTICES 2.0
*******************************************************************************
/*
I have tried to keep these general enough but different PIs and projects will 
have different procedures, so check with your PI first.
*/





/*
HEADER: Your do file should always have a header containing 
        basic info (author, date, input, output

		
		
*Example 1:

		/*****************************HEADER*******************************************
		Author: Ali Hamza
		Date: Feb 10th, 2017

		Project: High Hopes

		Objective: Random assignment into treatment/control group using baseline data
				   for Project XYZ

		Input Files:
		1) baseline survey: [add a couple of line about the dataset e.g. This data was 
							 collected in 2015 in Nyeri, Kisumu and Kilifi counties in
							Kenya. It's a student level data collected from 413 schools
							with 4074 observations]

		2) Dataset 2        [brief description]


		Output Files:
		1) treatment_assignment.dta [brief description]
		********************************************************************************/

		
		
*Example 2:

		/*******************************************************************************
		 Master do-file for record matching procedure.

		 Step 1 of 3 of matching procedure: cleannames.do

		 This dofile cleans and formats the names that will be used for matching.
		 New, clean name variables are added to existing data sets.
		 No other changes are made to existing data sets.
		 New data sets are saved with _match.dta added to existing filename.
		 New data sets are saved in Stata 12 format for compatibility with cluster software

		 Step 2 of 3 of matching procedure: rankmatches.do
		 
		 Define distance measure used to quantify the closeness of two observations.
		 For each record in master data, calculate distance to every record in using data.
		 Rank matches and keep the best 20 potential matches for each master record.
		 All names are replaced in the using data.
		 Save new data set: closest_20_matches.dta 

		 Step 3 of 3 of matching procedure: choosematches.do

		 Choose best match for each master record.
		 Begin with data set where each master record has 20 potential matches.
		 Find the pair with the minimum match distance in the entire data set.
		 Save that pair as a match.
		 Remove the record from the using file from the list of potential matches for all other pairs. 
		 Continue until all master records have either been matched or have had all of their potential matches removed.
		 Save record mapping file as final_matches.dta

		*******************************************************************************/		

*/




*************
/*AUTOMATION:
	1)	do file should work from start to end without any errors and should
		produce the results in the required format (i.e. don't copy/paste into 
		excel, use export options in STATA)
	2)  Use c-class values and relative folder paths for interoperability so
		that other RAs/PIs can run the do file without changing a single line
		code
*/

*************
/*FOLDER STRUCTURE:
	Strictly follow the project directory structures, don't save files in the 
	wrong folders e.g. For project HH, we have 3 stages of data:
		Raw => Clean => final analysis
	Do not save modified data in raw folder. Get familiar with the folder
	structure so that you know where to save files.
	
	IMPORTANT: NEVER edit the raw files and save them. If you REALLY have to,
			   talk to your PI first.
		*/
		
*************
/* DOCUMENTATION/COMMENTS:
	1) Always add comments in your do file for:
	
	yourself: you might not remember why you did X in your do file if you 
			  revisit your do file after 6 months.
	
	others:   Other RAs should be able to understand your code (and reason behind it)
			  without asking you a single question.
				
	DOCUMENT.EVERY.SINGLE.THING.
	
Example:


		Note1: There are 2 sous prefecture that don't get decoded correctly:
		sa�oua =>2706  33 obs
		za�bo => 1706  12 obs
		We have to remove special symbols. use spellings that are used in pop_density.dta
		*/

		cap replace sous_prefecture="saioua" if b07_souspref==2706 //33 changes
		cap replace sous_prefecture="zaibo" if b07_souspref==1706 //12 changes

		/*
		Note2: Bongo doesn't get matched correctly as it is in Grand Bassam dept in 
		pop_density.dta while it is in Adiake departement in ENV. PI XYZ confirmed it in an
		email (dated Dec 7th, 2015) that it's a mistake in ENV and we should replace
		departement to Grand Bassam for Bongo sous prefecture in ENV data.
		*/

		cap replace departement="grand-bassam" if sous_prefecture=="bongo"

		
*************		
/*TIDY DO FILES:
Use indent, line breaks, CAPs etc to make your code easy to read.
*/


************
/*TODOs:
Use TODO comments for code that is temporary, a short-term solution, or 
good-enough but not perfect  TODOs should include the string TODO in all caps, 
[followed by a colon], followed by the name, e-mail address, or other identifier
 of the person who can best provide context about the problem referenced by the 
 TODO,..... A comment explaining what there is to do is required. The main 
 purpose is to have a consistent TODO format that can be searched to find the 
 person who can provide more details upon request. A TODO is not a commitment 
 that the person referenced will fix the problem. Thus when you create a TODO, 
 it is almost always your name that is given…. 
If your TODO is of the form "At a future date do something" make sure that you 
either include a very specific date ("Fix by November 2009") or a very specific 
event ("Remove this code when all clients can handle XML responses.").".

*/


log close



