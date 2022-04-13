/******************************************************************************
* CBS STATA Test: 
* Dhruv Singh
* April 2nd, 2020
*******************************************************************************/
set more off
clear

cd "C:\Dhruv\misc\data\misc\Stata_Trainings\Stata test"

* Log file
cap log using "statatest.smcl", replace 

* Reading in Data
import delim using "inequality_survey.csv" , clear

********************************************************************************
* Question 1: checking for outliers
********************************************************************************
sort participantid

* converting string to category
encode question, gen(ques_num)

drop customreportid responsemethod question receivedatcst

* reshape long to wide
reshape wide response polltype, i(participantid) j(ques_num)


* tabulating and cleaning free text responses
tab response1
replace response1 = subinstr(response1, "times", "",.)
replace response1 = subinstr(response1, " ", "",.)
replace response1 = subinstr(response1, ",", "",.)
replace response1 = subinstr(response1, "x", "",.)
replace response1 = subinstr(response1, "more", "",.)
replace response1 = subinstr(response1, "X", "",.)
replace response1 = subinstr(response1, "timed", "",.)
replace response1 = subinstr(response1, "Times", "",.)
replace response1 = subinstr(response1, "Middleis60kbottomis20ksolet'ssayabout3-4", "",.)
tab response1

destring response1 , gen(response1_new)
sum response1_new,d
tab response1


hist response1_new if response1_new <= 20

tab response2
replace response2 = subinstr(response2, "%", "",.)
replace response2 = subinstr(response2, " ", "",.)
replace response2 = subinstr(response2, "times", "",.)
replace response2 = subinstr(response2, "x", "",.)
replace response2 = subinstr(response2, "more", "",.)
replace response2 = subinstr(response2, "X", "",.)
replace response2 = subinstr(response2, "Times", "",.)
replace response2 = subinstr(response2, "No", "",.)
replace response2="" if participantid==341098

* summary response 2
tab response2
destring response2, gen(response2_new)
sum response2_new,d
hist response2_new if response2_new <= 50


tab response7
replace response7 = subinstr(response7, "%", "",.)
replace response7 = subinstr(response7, " ", "",.)
replace response7 = subinstr(response7, "3-Feb", "",.)
replace response7 = subinstr(response7, "Low", "",.)
replace response7="" if participantid==543645
tab response7

destring response7, gen(response7_new)
tab response7

sum response2_new,d
hist response2_new if response2_new <= 100

* encoding responses
foreach response in response1 response2 response3 response4 response5 ///
                    response6 response7 response8 response9 response10{

					encode `response', gen(`response'_num)		

}


* summarizing data
foreach response in response1_num response2_num response3_num response4_num response5_num ///
                    response6_num response7_num response8_num response9_num response10_num{

					summarize `response', d
		

}


********************************************************************************
* Question 2: summarizing using histograms
********************************************************************************
* plotting histograms
foreach response in response1_num response2_num response3_num response4_num response5_num ///
                    response6_num response7_num response8_num response9_num response10_num{

					hist `response'
					graph export "`response'.png"
		

}


********************************************************************************
* Question 3: cross-tabs
********************************************************************************
egen resp1cat = cut(response1_new), at(2.5,7.5,25)
egen resp2cat = cut(response2_new), at(2.5,7.5,25,75)
egen resp7cat = cut(response7_new), at(10,20,30,40)

* redistribution vs perceptions cross tabs
tab response9_num response4_num
tab response9_num response5_num
tab response9_num response6_num

tab response9_num resp1cat
tab response9_num resp2cat

tab response10_num resp1cat
tab response10_num resp2cat



********************************************************************************
* Question 4: regression analysis
********************************************************************************
pwcorr

reg response9_num response1_num response2_num response3_num response4_num ///
					response5_num response6_num response7_num response8_num 

reg response10_num response1_num response2_num response3_num response4_num ///
					response5_num response6_num response7_num response8_num 


log close
