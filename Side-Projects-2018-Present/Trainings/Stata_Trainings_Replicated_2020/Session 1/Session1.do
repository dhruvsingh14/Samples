/******************************************************************************

* FMG STATA Walkthrough: Session 1
* Dhruv Singh
* Mar 30th, 2020

Topics:

1 Best Data Practices

2 Introduction to STATA: directories, import/export datasets in different 
  formats, basic commands to explore datasets, annotation, data cleaning, labels

3 Basic Data Manipulation: generating new variables, if/if else statements, 
  and/or conditions, preserve/restore 
*******************************************************************************/

/*

Nice quote:

"All happy families are alike; each unhappy family is unhappy in its own way.”

- Tolstoy



"As noted by Leo Tolstoy in the opening of his novel Anna Karenina, ‘Happy 
families are all alike; every unhappy family is unhappy in its own way.’ Recent 
psychological research suggests that Tolstoy's observation even holds true in 
the broadest formulation that different pieces of positive information are alike
whereas different pieces of negative information are negative in their own way.
We argue that this similarity asymmetry is a robust and general characteristic 
of the environment humans live in, observable across various research domains"

Alves, Hans, Alex Koch, and Christian Unkelbach. "Why Good Is More Alike Than 
Bad: Processing Implications." Trends in Cognitive Sciences (2017)

# The man is an intellectual, what can i say? #


We can say the same about data:

"All happy .do/.dta files are alike; each unhappy .do/.dta file is unhappy in 
its own way.”

- Anonymous 
happy = tidy?
*/



/*******************************************************************************
1. Introduction to STATA:
*******************************************************************************/
/*

COMMAND: You can tell Stata what to do by typing in commands. Click inside the 
		 command window and type  

RESULTS: Here Stata displays the commands followed by the output that Stata has 
		 produced. 

VARIABLES: Lists all the variables in the dataset. The variable window can act 
		   as a shortcut for creating commands. Try clicking on one of the 
		   variables. It should appear in the command window, eliminating the 
		   need for you to write it out.

REVIEW: Lists all your prior commands. You can copy/paste commands from here

DATA BROWSWER: view your data, including variable names, labels, and their 
			   values


******STATA FILES*******

* datasets: .dta 
* do files: .do
* log files: .smcl / .log

*/
/*******************************************************************************
2. STATA Directories:
*******************************************************************************/

/* 
pwd 
This commands let's you know your current working directory:
*/

pwd

/* 
cd 
You can use this command to change working directory.
*/

*Example 

cd "C:/Dhruv/misc/data/misc/Stata_Trainings/Dhruv_Singh_Stata_Trainings_Replicated/Session 1/Data"
*IMP: change the username before running this

* Note: If your directory_name contains embedded spaces, remember to enclose 
*       it in double quotes.

 
dir
*display filenames and folders in current working directory



* cd ..
*will move you up one directory


/*******************************************************************************
3. LOADIND DATASETS:
*******************************************************************************/

clear
*This command removes data and value labels from memory


* use
* This command is used to load .dta files

*Example

use FinancialData.dta, clear

*import
* This command is used to load/import excel files
*import excel using excel1.xls, firstrow clear 

/*
-you can even tell stata to open a specific sheet in excel (option: sheet(sheet#)
or to only import data starting from a specific cell (option: cellrange(startcell:endcell) 
-excel files imported often have the variable names in the first row. 
you tell stata to define variable names by the first row in excel by adding the option firstrow
*/




********************************************************************************
*4. Saving datasets 
********************************************************************************

*save & replace
* to save a new dataset

*save dataset1_new.dta, replace


*export
*same as import function

export excel using excel1_new.xls, replace firstrow(var) //if you want first row in excel to be the variable names

* this is a useful command / outputting excel w/ labels as opposed to varnames
export excel using fin_data.xls, replace firstrow(varlab) //if you want first row in excel to be the variable labels 

*in this case it will be the same because variable names = variable labels

*You can also export only certain variables ,ie a subset
*export excel make price mpg rep78 using excel1_new.xls, replace 




********************************************************************************
*5. Exploring Data 
********************************************************************************
/*
describe
Itproduces a summary of the dataset in memory or of the data stored in a 
Stata-format dataset.
*/

describe


/*
codebook
It examines the variable names, labels, and data to produce a codebook 
describing the dataset. If no varlist is specified, summary statistics are 
calculated for all the variables in the dataset.
*/

codebook
* naics standard industrial codes
codebook siccode1
* states
codebook addressstate_ds

/*
summarize: 
It calculates and displays a variety of univariate summary statistics.  If no 
varlist is specified, summary statistics are calculated for all the variables in 
the dataset.
*/

summarize
* checking total assets in billions
summarize ta2008
summarize ta2008, d
summarize addressstate_ds

* Only numeric variables

/*
list:
It displays the values of variables.  If no varlist is specified, the values 
 of all the variables are displayed.
*/

list ticker name ta2008 roe2008 tdtc2008 mcap2008 in 1/10 // first ten rows displayed



/*
tabulate (one-way)
It produces a one-way table of frequency counts.
*/

tab addressstate_ds

/*
tabulate (two way)
it produces a two-way table of frequency counts, along with various measures of 
association, including the common Pearson's chi-squared, the likelihood-ratio 
chi-squared, Cramér's V, Fisher's exact test, Goodman and Kruskal's gamma, 
and Kendall's tau-b.
*/

tab siccode1 addressstate_ds
tab siccode1 addressstate_ds, row
tab siccode1 addressstate_ds, column

/*
count
It counts the number of observations that satisfy the specified conditions.  
If no conditions are specified, count displays the number of observations in 
the data.
*/

count 
count if ta2008>2.18e+09 // can actually use scientific notation for calculations!


/*
display
displays strings and values of scalar expressions.  display produces output 
from the programs that you write.

It's not just a calculator!
*/


/*******************************************************************************
*6. GENERATING NEW VARIABLES AND DATA CLEANING 
*******************************************************************************/

/*
generate:
creates a new variable.  The values of the variable are specified by =exp.
*/

gen price1=.
gen price2=""

/*
drop
drop eliminates variables or observations from the data in memory.
*/

drop price1 price2

/*
keep
oppositie of drop command.
*/

*
sysuse pop2000, clear
*

/*
recode
It changes the values of numeric variables according to the rules specified.
Values that do not meet any of the conditions of the rules are left unchanged, 
unless an otherwise rule is specified.
*/

recode agegrp (1=2)

/*
replace
It changes the contents of existing variable
*/

replace agegrp=4 if agegrp<4


/*******************************************************************************
*6. IMPOSING CONDITIONS
*******************************************************************************/
sysuse auto, clear

*IF
* if at the end of a command means the command is to use only the data specified.

summarize price if foreign ==0
summarize price if foreign ==1

*AND condition (&)
summ price if foreign ==0 & rep78==3


*OR condition (|)
summ price if foreign ==0 | rep78==3



/*******************************************************************************
*7. ANNOTATION
*******************************************************************************/

/*
Hello, World!
*/


* Hello, World

// Hello, World


*/
********************************************************************************
*8. Labels & Value labels 
********************************************************************************

use intro.dta, clear

** a. Labels 
/*In the browse window, you can see on the right the variable names, 
and a label for each variable (variable label). */

*The labels are assigned to the names in the following command: 
label variable id "" //to label variable called hhid 
*You can change a variable's label as many times as you want, it's automatically replaced 
label variable id "Unique Dtudent ID"

** b. Value labels
/*Some variables are numeric such as income.
Other variables are numeric, but they really refer to categories (categorical variables)
Examples include: variable called female, defined as 1=female and 0=male. 
We assigned value labels to categorical variables to make analysis easier and avoid typos. 
This is done by first defining the value label, then assigning it to a variable. */

label define gender 1 "Female" 0 "Male" //gender is the name of the value label
label values female "gender" //here the variable is called female. 

labelbook

*********************************************************************************/
*9. Wildcards in variable names:
*********************************************************************************/
/*Stata has characters called wildcards, these are mainly "*" and "?" 
These allow you to quickly call for variables that share a common part of their names.
For example, if you want to browse variables of household number, village, and region.
And you know that all of these end with the suffix _id (for example: hh_id village_id region_id)
You can then use:*/

/*The * mean ANYTHING. So any variable that ends with _id will be browsed

The difference between * and ? is that * has no limit on the number of characters.
for example, hhid_id has 4 characters before _id (h h i d)
 whie village_id has 7 characters. The asterix * covers them both. 

However, if you only want variables that have a specific number of characters before _id, you can use the ? wildcards.
? means that the character can be anything, but it represents one and only one character */ 

codebook ???e
codebook *e

********************************************************************************
*10. Variables & observations order:
********************************************************************************
*When browsing your data, you can see that variables always appear in the same order
*Some examples: 
order name
order school id name
order name, last 

*This new order will be preserved as long as you're working with the dataset, and if you save the new dataset 
*This is a permanent change that you make (you can re-order, of course) 


*You can also sort your observations in different order. 
*Observations are usually sorted so that all observations belonging to the same region, village, household, for example,
*appear right after each other. 
*If that's not the case in your dataset, you can fix that by the sort command. ex:
sort school id  
*Your dataset would look like this:
/*
region_id		village_id 		hhid 	 
1					1			 1	
1					1			 2
1					2			 1
1					2			 2

Sort always sorts in ascending order. Sometimes you might want to sort in descending order 
In that case you use gsort and add a minus sign in front of the variable, ex:*/
gsort -attendance


gsort -attendance -reading -math 

//run it mulitple times and see what happens to first 5 obs


/********************************************************************************
*11. Shortcuts
********************************************************************************

*In dofile: To run a command, select it from do file and type control+d 
*In command window: to retrieve the last commands you entered in the command window, type pageup / pagedown buttons on keyboard 
*All commands have shortcuts. You can look these up using the help files. 
*Instead of typing variable names yourself (esp for complicated / unintuitive names)
 avoid typos by clicking on the variable name in the browse window, control+c -->copies name 

********************************************************************************
*12. Logfiles 
********************************************************************************

Nothing you view on a command window can be checked by anyone after you exit stata (especially for
descriptive / browsing commands, as these don't make any changes to the data)
A way to fix that is to save everything you see in a log file. 
This is automatically done through by adding the following two lines at the beginning and end of your dofile
Run these commands before and after your code, respectively, saves the log file */
cap log close 
log using "long_{today's date}.log", replace 
*rest of your dofile*
cap log close 

*better to enter dates in the format YYYYMMDD so that they're automatically sorted by most recent 

/*******************************************************************************
13. Best Data Practices
*******************************************************************************/

*Code and Data for the Social Sciences: A Practitioner’s Guide
* Link: https://www.brown.edu/Research/Shapiro/pdfs/CodeAndData.pdf


* Focus on the following: 

*	 1) Automation:

*	 2) Vesrion Control

*	 3) Directories

*	 4) Documentation

*	 5)  Code Style
