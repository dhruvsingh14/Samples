* cd "C:\Users\dhnsingh\Documents\day2"

* starter code// intro
set logtype text 
capture log close
log using fed_log, replace text
set linesize 80
set scheme s2color
clear all
macro drop _all

* Part I *
/*
* use fed.dta
codebook
notes
* restricting variables
keep YY1 Y1 hhsex age educ married kids race income checking internet
save fed_data.dta, replace
svyset YY1
* checking acct and internet tabulations
sum checking, d
sum internet, d 
* creating elementary variable
gen fin_sec = 0
replace fin_sec = 1 if checking > 50000 & internet == 1
*/
* here we are defining financiallly secure individuals as those 
* who have more than 50,000 in their checking accounts, 
* and use the internet to conduct their banking services


* Part II *
use fed_data.dta
* labelling some variables
label var YY1 "ID1"
label var Y1 "ID2"
label var hhsex "Head of Household Sex"
label var age "Age in Years"
label var educ "Years of Education"
label var married "Marital Status"
label var kids "Number of Children"
label var race "Race/Ethnicity"
label var income "Income in Dollars, annually"
label var internet "Internet Banking"
label var checking "Checking Account Amount"

* labelling values
label define sex 1 "Male" 2 "Female", replace
label values hhsex sex 

* checking age spread
sum age, d
hist age // more or less normally distributed

* generating categorical variable based on age
gen age_categ = ""
replace age_categ = "Younger" if age <= 40
replace age_categ = "Mid" if age > 40 & age <= 54
replace age_categ = "Later" if age > 54 & age <= 64
replace age_categ = "Older" if age > 64
 
* labelling race values
label define racial_categ 1 "White" 2 "Black" 3 "Hispanic" 5 "Other"
label values race racial_categ // for now keeping race as a num var

* Part III: Summary Statistics: Univariate
sum age, d

/*
		Age in Years
				
	Percentiles	Smallest
1%	22	18
5%	26	18
10%	30	18	Obs	31,240
25%	40	18	Sum of Wgt.	31,240

50%	54		Mean	52.70359
		Largest	Std. Dev.	16.21476
75%	64	95
90%	74	95	Variance	262.9183
95%	80	95	Skewness	.0415392
99%	88	95	Kurtosis	2.312033
*/

// Mean and median are roughly similar, signalling normaly distribution

tab hhsex 
*roughly 70% of households are headed by a male


sum educ, d
// here even though mean and median are similar, there is skewness

* list can be used to to check the outliers, and faulty values
list if educ < 0
sum if educ == 14

* on avg, ppl w/ 14 yrs of schooling, have 100 k in their checking accounts
* and 2 million in hh income annually
* typically white male, age 58, and with kids

* testing skewness for edu
sktest educ
sktest age // a bit tricky, hopefully won't be on the test

* Part IV: Two way descriptive statistics, Bivariate/Multivariate
gen inc_quartiles = ""
replace inc_quartiles = "quartile_1" if income < 31392
replace inc_quartiles = "quartile_2" if income >= 31392 & income < 69264 
replace inc_quartiles = "quartile_3" if income >= 69264 & income < 163034
replace inc_quartiles = "quartile_4" if income >= 163034

tab inc_quartiles

* cross-tabs
tab inc_quartiles race

/*
inc_quarti |               Race/Ethnicity
       les |     White      Black   Hispanic      Other |     Total
-----------+--------------------------------------------+----------
quartile_1 |     4,416      1,817      1,164        414 |     7,811 
quartile_2 |     5,150      1,290      1,082        285 |     7,807 
quartile_3 |     5,895        833        628        450 |     7,806 
quartile_4 |     6,940        237        185        454 |     7,816 
-----------+--------------------------------------------+----------
     Total |    22,401      4,177      3,059      1,603 |    31,240 
*/

tabulate race, summarize(income)
/*
          |    Summary of Income in Dollars,
Race/Ethnic |              annually
        ity |        Mean   Std. Dev.       Freq.
------------+------------------------------------
      White |   1039350.4   6382705.4      22,401
      Black |   144540.19   1169202.3       4,177
   Hispanic |   97603.575   373379.37       3,059
      Other |   499996.86   2306589.9       1,603
------------+------------------------------------
      Total |   799817.44   5461925.7      31,240
*/


tabulate inc_quartile, summarize(age) //avg age for each quartile is roughly 50
									// with avg age for quartile 4 at 58
									
* twoway table by race and age
tabulate race age_categ, summarize (income)									

/*
Race/Ethni |                age_categ
      city |     Later        Mid      Older    Younger |     Total
-----------+--------------------------------------------+----------
     White | 1301272.3  941539.94  1553346.5  153741.05 | 1039350.4
           | 5012483.2  5506168.8  9634644.4  890382.81 | 6382705.4
           |      5770       5409       6399       4823 |     22401
-----------+--------------------------------------------+----------
     Black | 117617.21  67651.339  195430.81  203236.35 | 144540.19
           | 590727.64  86675.752  1001493.6  1828581.6 | 1169202.3
           |       751       1292        730       1404 |      4177
-----------+--------------------------------------------+----------
  Hispanic | 214522.84  90385.743  131319.53  49606.327 | 97603.575
           | 725255.16  328394.65  423603.56  37590.586 | 373379.37
           |       455       1039        360       1205 |      3059
-----------+--------------------------------------------+----------
     Other | 1179042.6  465805.94  792869.63  136313.89 | 499996.86
           | 5190650.9  1060595.1  1975412.6  369972.05 | 2306589.9
           |       254        565        201        583 |      1603
-----------+--------------------------------------------+----------
     Total | 1105637.1  666741.27  1337993.6  145487.65 | 799817.44
           | 4609224.5  4470457.5  8813856.9  1036609.7 | 5461925.7
           |      7230       8305       7690       8015 |     31240
*/

// older whites have about $1,553,346 on average
// younger hispanics, about $49,606 on average

* time for a quick duplicate check
duplicates report

* Part 5: Twoway plots
twoway scatter income age
sum income if income < 3000000
twoway (scatter income age if income < 3000000) (lfit income age)

ssc install binscatter
binscatter income age // shows a clear positive correlation

* Part 6: Correlations (must be num vars) and Covariances 
correlate income age race educ kids internet checking hhsex

* strongest correlations b/w income and education, but also checking accounts

/*
             |   income      age     race     educ     kids internet checking    hhsex
-------------+------------------------------------------------------------------------
      income |   1.0000
         age |   0.0807   1.0000
        race |  -0.0510  -0.1870   1.0000
        educ |   0.1144   0.0554  -0.1391   1.0000
        kids |   0.0045  -0.3395   0.1210  -0.0541   1.0000
    internet |   0.0403  -0.2882  -0.0389   0.3443   0.1303   1.0000
    checking |   0.2362   0.0503  -0.0340   0.0685  -0.0148   0.0168   1.0000
       hhsex |  -0.0683   0.0117   0.0469  -0.0978  -0.0519  -0.1431  -0.0421   1.0000
*/

correlate income age race educ kids internet checking hhsex, covariance

// covariance matrix is below
/*
            |   income      age     race     educ     kids internet checking    hhsex
-------------+------------------------------------------------------------------------
      income |  3.0e+13
         age |  7.1e+06  262.918
        race |  -286683 -3.12295  1.06041
        educ |  1.7e+06   2.5098 -.400576  7.81928
        kids |  27534.8 -6.22537   .14089 -.171166  1.27893
    internet |  83603.9 -1.77674 -.015222  .365981  .056037  .144525
    checking |  7.9e+11   502481 -21544.7   118010 -10320.2  3934.65  3.8e+11
       hhsex |  -157682  .080168  .020424 -.115668 -.024817    -.023 -10959.9  .178821
*/
// again the signs of the values are a good indicator of the direction of the relation

* pearson's and spearman's are more advanced commands for correlational matrices
* log transformations are another advanced function to be performed as needed


/** DAY 3 **/
save fed_data1
use fed_orig, clear

* preparing to merge
keep YY1 Y1 thrift trusts debt
save fed_data2

merge 1:1 YY1 Y1 using fed_data1

* lastly practising running a tabulation of missing vars
sum if 

* neat package for missing values
search mdesc

mdesc
