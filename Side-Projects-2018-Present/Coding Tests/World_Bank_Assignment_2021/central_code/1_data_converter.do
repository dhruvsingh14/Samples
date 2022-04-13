/******************************************************************************
* WBG STATA Assignment: 1 Data Converter 
* Dhruv Singh
* July 24th, 2021
*******************************************************************************/
set more off
clear

cd "C:\Dhruv\Data\World_Bank_Assignment"

* log file
cap log using "centralcode\converter.smcl", replace 

********************************************************************************
* Part 0: Converting data from csv to Stata 13
********************************************************************************

**************************************
* i) reading in main_dataset .csv data
**************************************
import delim using "1_converted_data\main_dataset.csv", clear

* labelling main dataset
label variable surveyid "SurveyId"
label variable userid "UserId"
label variable surveydate "Date of the survey"
label variable enumerator ""
label variable surveystarttime "Survey Start Time"
label variable surveystate "Survey State"
label variable v3_02 "Gender"
label variable v3_04 "Education Level"
label variable v3_04_otherspecify "Education Level other specified"
label variable v3_07b "Migrated to location"
label variable v3_06 "Move after March 1"
label variable v3_07 "Reason moving"
label variable v3_07_otherspecify "Reason moving other specified"
label variable v3_07a "Moved before/during lockdown"
label variable v3_07c "Reason moving before/during lockdown"
label variable v3_07c_otherspecify "Reason moving before/during lockdown other specified"
label variable v3_08a_1_a "Country move to abroad"
label variable v3_08a_1_a_otherspecify "Country move to abroad other specified"
label variable v3_09 "City/District/Village"
label variable v3_10 "Household size"
label variable v3_12 "Household member currently working as a migrant worker (another region or countr"
label variable v3_12a "Household member now at home"
label variable v3_13 "Migrant worker send/sent money"
label variable v3_13b "Respondent ever work abroad"
label variable v3_14 "At least one member use banking/financial services"
label variable v3_15 "At least one member use mobile money"
label variable weight ""
label variable week ""
label variable covid_deterioration "COVID related deterioration in labor activity"
label variable v4_01 "is the bread winner"
label variable v4_02 "number of earnings contributors in the household"
label variable v4_03_1 "Household Income from"
label variable v4_03_2 "Household Income from"
label variable v4_03_3 "Household Income from"
label variable v4_03_4 "Household Income from"
label variable v4_03_5 "Household Income from: Cereal and vegetable (non-cash crop) based agriculture"
label variable v4_03_6 "Household Income from: Selling livestock products [meat / milk / ghee / egg / fi"
label variable v4_03_7 "Household Income from: Cash and high value crops"
label variable v4_03_8 "Household Income from: Daily wage labour [agriculture]"
label variable v4_03_9 "Household Income from: Daily wage labour [non-agriculture]"
label variable v4_03_10 "Household Income from: Salaries from government and I/NGO"
label variable v4_03_11 "Household Income from: Salaries from private companies"
label variable v4_03_12 "Household Income from: Business and trade [small]"
label variable v4_03_13 "Household Income from: Business and trade [medium and large]"
label variable v4_03_77 "Household Income from: Remittance"
label variable v4_03_66 "Household Income from: Tourism"
label variable v4_03_8888 "Household Income from: Transportation"
label variable v4_03_9999 "Household Income from: Fishing/Fisheries"
label variable v4_03_otherspecify "Household Income from: Other"
label variable v4_04 "Work for pay in the last 7 days: None"
label variable v4_04a "Temporaly absent at job in the last 7 days: DON'T KNOW"
label variable v4_05 "Work since Jan 2020: REFUSED"
label variable v4_06 "Last month work for pay since Jan 2020: Other specified"
label variable v4_07 "Reasons stop working: BUSINESS/GOV CLOSED DUE TO COVID"
label variable v4_07a_1 "Reasons stop working: BUSINESS/GOV CLOSED FOR ANOTHER REASON"
label variable v4_07a_2 "Reasons stop working: QUARANTINED"
label variable v4_07a_3 "Reasons stop working: NOT ABLE TO GO TO WORK DUE TO MOVEMENT RESTRICTIONS"
label variable v4_07a_4 "Reasons stop working: FIRED"
label variable v4_07a_5 "Reasons stop working: OLD AGE"
label variable v4_07a_6 "Reasons stop working: STUDENT"
label variable v4_07a_7 "Reasons stop working: TOO YOUNG"
label variable v4_07a_8 "Reasons stop working: HOUSEWIFE/HOUSEHOLD WORK"
label variable v4_07a_9 "Reasons stop working: RETIREMENT"
label variable v4_07a_10 "Reasons stop working: OTHER PERSONAL LEAVE/REASON"
label variable v4_07a_11 "Reasons stop working: VACATION HOLIDAYS"
label variable v4_07a_12 "Reasons stop working: SICKNESS / ILLNESS / ACCIDENT"
label variable v4_07a_13 "Reasons stop working: SEASONAL WORKER/ NOT FARMING SEASON"
label variable v4_07a_14 "Seek a job in the last 7 days: Other"
label variable v4_07a_77 "Expect to start work again: DON'T KNOW"
label variable v4_07a_8888 "Reason not seek a job: REFUSED"
label variable v4_07a_9999 "Reason not seek a job Other specified: Other specified"
label variable v4_07a_otherspecify "Income range paid: Daily"
label variable v4_08 "Income range paid: Weekly"
label variable v4_09 "AmountPaidLastMonth: Monthly"
label variable v4_10 "Monthly range paid last month: Monthly"
label variable v4_10_otherspecify "Hours worked past 7 days: Weekly"
label variable v4a_01 "Reasons operations decreased: Workers cannot come to work"
label variable v4a_30 "Reasons operations decreased: Had to lay off workers/could not pay wages"
label variable v4a_04 "Reasons operations decreased: Government announced a lockdown"
label variable v4a_03a "Reasons operations decreased: Not enough clients/customers"
label variable v4a_05 "Reasons operations decreased: Not enough inputs/supplies/raw materials"
label variable v4a_05_otherspecify "Reasons operations decreased: Can't travel/ transport goods for trade"
label variable v4a_06 "Reasons operations decreased: Difficulty repaying loans or other debt obligation"
label variable v4a_08 "Reasons operations decreased: Difficulty raising capital through business loans"
label variable v4a_09_1 "Reasons operations decreased: Changed hours of operation"
label variable v4a_09_2 "Revenue for the last 30 days is more: Other"
label variable v4a_09_3 ""
label variable v4a_09a "How long expect to continue running the business: REFUSED"
label variable v4a_09b "Able to sell products through the usual channels (local markets: Other specified"
label variable v4a_09c "Agribusiness adjustments: Use of phone for marketing / placing orders / customer"
label variable v4a_10 "Agribusiness adjustments: Use of Internet / online social media / specialized ap"
label variable v4a_10a "Agribusiness adjustments: Switched to delivery service only"
label variable v4a_10b "Agribusiness adjustments: Switched product/service offering "
label variable v4a_11 "Gvt support policies: Other"
label variable v4a_12 "Gvt support policies: DON'T KNOW"
label variable v4a_12a "Gvt support policies: REFUSED"
label variable v4a_12b "Gvt support policies: Other specified"
label variable v4a_15 "Gvt support policies: SMALL BUSINESS LOANS/GRANTS PROGRAMS"
label variable v4a_16 "Gvt support policies: TAX CUTS FOR SMALL BUSINESSES"
label variable v4a_17a_1 "Gvt support policies:  INTEREST SUBSIDY"
label variable v4a_17a_2 "Gvt support policies: MARKET LINKAGE FACILITATION"
label variable v4a_17a_3 "Gvt support policies: FACILITATE TRANSPORTATION OF GOODS"
label variable v4a_17a_4 "Gvt support policies: INPUTS FOR AGRICULTURE AND /OR FISHING [SEED/FERTILIZER/FO"
label variable v4a_17a_5 "Gvt support policies: Other"
label variable v4a_17a_6 "Would continue with current job or go back to previous work: NO HELP NEEDED"
label variable v4a_17a_7 "Household worry would run out of food over the last 7 days: DON'T KNOW"
label variable v4a_17a_8 "Household reduced purchase/consumption of\xa0preferred\xa0food\xa0because of budget over: REFUSED"
label variable v4a_17a_9 "Household ran out of food and money to buy more over the last 7 days: Other specified"
label variable v4a_17a_77 "Reasons operations decreased"
label variable v4a_17a_8888 "Reasons operations decreased"
label variable v4a_17a_9999 "Reasons operations decreased"
label variable v4a_17a_otherspecify "Reasons operations decreased"
label variable v4a_19 "Revenue for the last 30 days is more"
label variable v4a_20 "How long expect to continue running the business"
label variable v4a_21 "Able to sell products through the usual channels (local markets"
label variable v4a_22 "Changes in the prices for products for this time of year (Agribusiness)"
label variable v4a_23 "Perform the normal activities (Agribusiness)"
label variable v4a_24 "Operations as usual (Agribusiness)"
label variable v4a_25_1 "Agrobusiness adjustments"
label variable v4a_25_2 "Agribusiness adjustments"
label variable v4a_25_3 "Agribusiness adjustments"
label variable v4a_25_4 "Agribusiness adjustments"
label variable v4a_25_77 "Agribusiness adjustments"
label variable v4a_25_8888 "Agribusiness adjustments"
label variable v4a_25_9999 "Agribusiness adjustments"
label variable v4a_25_otherspecify "Agribusiness adjustments"
label variable v4a_26_1 "Gvt support policies"
label variable v4a_26_2 "Gvt support policies"
label variable v4a_26_3 "Gvt support policies"
label variable v4a_26_4 "Gvt support policies"
label variable v4a_26_5 "Gvt support policies"
label variable v4a_26_6 "Gvt support policies"
label variable v4a_26_7 "Gvt support policies"
label variable v4a_26_8 "Gvt support policies"
label variable v4a_26_77 "Gvt support policies"
label variable v4a_26_66 "Gvt support policies"
label variable v4a_26_8888 "Gvt support policies"
label variable v4a_26_9999 "Gvt support policies"
label variable v4a_26_otherspecify "Gvt support policies"
label variable v4a_27 "Would continue with current job or go back to previous work"
label variable v6_01b "Household worry would run out of food over the last 7 days "
label variable v6_01c "Household reduced purchase/consumption of\xa0preferred\xa0food\xa0because of budget over"
label variable v6_01d "Household ran out of food and money to buy more over the last 7 days"
label variable v6_02_1 "In an emergency expense could solve with Own Savings"
label variable v6_02_2 "In an emergency expense could solve with Relatives/friends with interest"
label variable v6_02_3 "In an emergency expense could solve with Relatives/friends without interest"
label variable v6_02_4 "In an emergency expense could solve with Bank loan/credit card"
label variable v6_02_5 "In an emergency expense could solve with NGO/CBO loan"
label variable v6_02_6 "In an emergency expense could solve with Savings group"
label variable v6_02_7 "In an emergency expense could solve with Money lender"
label variable v6_02_8 "In an emergency expense could solve with Shopkeeper"
label variable v6_02_9 "In an emergency expense could solve with Pawn farm animals/equipment"
label variable v6_02_10 "In an emergency expense could solve with Pawn house/land"
label variable v6_02_11 "In an emergency expense could solve with Pawn other property"
label variable v6_02_12 "In an emergency expense could solve with Advance salary / borrow from employer"
label variable v6_02_77 "In an emergency expense could solve with Other"
label variable v6_02_66 "In an emergency expense don�t have any source/I will not be able to get the mone"
label variable v6_02_8888 "In an emergency expense DON'T KNOW how to solve"
label variable v6_02_9999 "In an emergency expense REFUSED how to solve"
label variable v6_02_otherspecify "In an emergency expense could solve with other specified"
label variable v6_03 "How long household is able to meet basic needs "
label variable v6_04 "Household pay rent for dwelling"
label variable v6_05 "Household managed to pay the rent last month"
label variable v6_06 "Household received assistance from Government/NGOs since March 1 2020"
label variable v6_08 "Household received assistance from Government/NGOs before March 1 2020"
label variable v6_11_otherspecify "Most helpful assistance would be Other specified"
label variable count ""

* saving out data in .dta format
save "1_converted_data\main_dataset.dta", replace

*******************************************
* ii) reading in new observations .csv data
*******************************************
import delim using "1_converted_data\\new_observations.csv", clear

* labelling new observations
label variable surveyid "SurveyId"
label variable userid "UserId"
label variable surveydate "Date of the survey"
label variable enumerator ""
label variable surveystarttime "Survey Start Time"
label variable surveystate "Survey State"
label variable v3_02 "Gender"
label variable v3_03 "Age"
label variable v3_04 "Education Level"
label variable v3_04_otherspecify "Education Level other specified"
label variable v3_07b "Migrated to location"
label variable v3_06 "Move after March 1"
label variable v3_07 "Reason moving"
label variable v3_07_otherspecify "Reason moving other specified"
label variable v3_07a "Moved before/during lockdown"
label variable v3_07c "Reason moving before/during lockdown"
label variable v3_07c_otherspecify "Reason moving before/during lockdown other specified"
label variable v3_08a_1_a "Country move to abroad"
label variable v3_08a_1_a_otherspecify "Country move to abroad other specified"
label variable v3_09 "City/District/Village"
label variable v3_10 "Household size"
label variable v3_12 "Household member currently working as a migrant worker (another region or countr"
label variable v3_12a "Household member now at home"
label variable v3_13 "Migrant worker send/sent money"
label variable v3_13b "Respondent ever work abroad"
label variable v3_14 "At least one member use banking/financial services"
label variable v3_15 "At least one member use mobile money"
label variable weight ""
label variable week ""
label variable covid_deterioration "COVID related deterioration in labor activity"
label variable v4_01 "is the bread winner"
label variable v4_02 "number of earnings contributors in the household"
label variable v4_03_1 "Household Income from"
label variable v4_03_2 "Household Income from"
label variable v4_03_3 "Household Income from: Cereal and vegetable (non-cash crop) based agriculture"
label variable v4_03_4 "Household Income from: Selling livestock products [meat / milk / ghee / egg / fi"
label variable v4_03_5 "Household Income from: Cash and high value crops"
label variable v4_03_6 "Household Income from: Daily wage labour [agriculture]"
label variable v4_03_7 "Household Income from: Daily wage labour [non-agriculture]"
label variable v4_03_8 "Household Income from: Salaries from government and I/NGO"
label variable v4_03_9 "Household Income from: Salaries from private companies"
label variable v4_03_10 "Household Income from: Business and trade [small]"
label variable v4_03_11 "Household Income from: Business and trade [medium and large]"
label variable v4_03_12 "Household Income from: Remittance"
label variable v4_03_13 "Household Income from: Tourism"
label variable v4_03_77 "Household Income from: Transportation"
label variable v4_03_66 "Household Income from: Fishing/Fisheries"
label variable v4_03_8888 "Household Income from: Other "
label variable v4_03_9999 "Household Income from: None"
label variable v4_03_otherspecify "Household Income from: DON'T KNOW"
label variable v4_04 "Work for pay in the last 7 days: REFUSED"
label variable v4_04a "Temporaly absent at job in the last 7 days: Other specified"
label variable v4_05 "Reasons stop working: BUSINESS/GOV CLOSED DUE TO COVID"
label variable v4_06 "Reasons stop working: BUSINESS/GOV CLOSED FOR ANOTHER REASON"
label variable v4_07 "Reasons stop working: QUARANTINED"
label variable v4_07a_1 "Reasons stop working: NOT ABLE TO GO TO WORK DUE TO MOVEMENT RESTRICTIONS"
label variable v4_07a_2 "Reasons stop working: FIRED"
label variable v4_07a_3 "Reasons stop working: OLD AGE"
label variable v4_07a_4 "Reasons stop working: STUDENT"
label variable v4_07a_5 "Reasons stop working: TOO YOUNG"
label variable v4_07a_6 "Reasons stop working: HOUSEWIFE/HOUSEHOLD WORK"
label variable v4_07a_7 "Reasons stop working: RETIREMENT"
label variable v4_07a_8 "Reasons stop working: OTHER PERSONAL LEAVE/REASON"
label variable v4_07a_9 "Reasons stop working: VACATION HOLIDAYS"
label variable v4_07a_10 "Reasons stop working: SICKNESS / ILLNESS / ACCIDENT"
label variable v4_07a_11 "Reasons stop working: SEASONAL WORKER/ NOT FARMING SEASON"
label variable v4_07a_12 "Reasons stop working: Other"
label variable v4_07a_13 "Reasons stop working: DON'T KNOW"
label variable v4_07a_14 "Seek a job in the last 7 days: REFUSED"
label variable v4_07a_77 "Expect to start work again: Other specified"
label variable v4_07a_8888 "Amount paid typical: Daily"
label variable v4_07a_9999 "Provide monthly range paid before lockdown: Weekly"
label variable v4_07a_otherspecify "Income range paid: Monthly"
label variable v4_08 "AmountPaidLastMonth: Monthly"
label variable v4_09 "Provide monthly range paid last month: Weekly"
label variable v4_10 "Reasons operations decreased: Workers cannot come to work"
label variable v4_10_otherspecify "Reasons operations decreased: Had to lay off workers/could not pay wages"
label variable v4a_01 "Reasons operations decreased: Government announced a lockdown"
label variable v4a_30 "Reasons operations decreased: Not enough clients/customers"
label variable v4a_04 "Reasons operations decreased: Not enough inputs/supplies/raw materials"
label variable v4a_03a "Reasons operations decreased: Can't travel/ transport goods for trade"
label variable v4a_05 "Reasons operations decreased: Difficulty repaying loans or other debt obligation"
label variable v4a_05_otherspecify "Reasons operations decreased: Difficulty raising capital through business loans "
label variable v4a_06 "Reasons operations decreased: Changed hours of operation"
label variable v4a_08 "Reasons operations decreased: Other"
label variable v4a_09_1 "Reasons operations decreased: DON'T KNOW"
label variable v4a_09_2 "Revenue for the last 30 days is more: REFUSED"
label variable v4a_09_3 "Other specified"
label variable v4a_09a "Agribusiness adjustments: Use of phone for marketing / placing orders / customer"
label variable v4a_09b "Agribusiness adjustments: Use of Internet / online social media / specialized ap"
label variable v4a_09c "Agribusiness adjustments: Switched to delivery service only"
label variable v4a_10 "Agribusiness adjustments: Switched product/service offering "
label variable v4a_10a "Agribusiness adjustments: Other"
label variable v4a_10b "Agribusiness adjustments: DON'T KNOW"
label variable v4a_11 "Gvt support policies: REFUSED"
label variable v4a_12 "Gvt support policies: Other specified"
label variable v4a_12a "Gvt support policies: SMALL BUSINESS LOANS/GRANTS PROGRAMS"
label variable v4a_12b "Gvt support policies: TAX CUTS FOR SMALL BUSINESSES"
label variable v4a_15 "Gvt support policies: DIRECT CASH TRANSFERS TO BUSINESS OWNERS"
label variable v4a_16 "Gvt support policies:  WAGE SUBSIDY PROGRAMS"
label variable v4a_17a_1 "Gvt support policies:  INTEREST SUBSIDY"
label variable v4a_17a_2 "Gvt support policies: MARKET LINKAGE FACILITATION"
label variable v4a_17a_3 "Gvt support policies: FACILITATE TRANSPORTATION OF GOODS"
label variable v4a_17a_4 "Gvt support policies: INPUTS FOR AGRICULTURE AND /OR FISHING [SEED/FERTILIZER/FO"
label variable v4a_17a_5 "Gvt support policies: Other"
label variable v4a_17a_6 "Gvt support policies: NO HELP NEEDED"
label variable v4a_17a_7 "Gvt support policies: DON'T KNOW"
label variable v4a_17a_8 "Would continue with current job or go back to previous work: REFUSED"
label variable v4a_17a_9 "Household worry would run out of food over the last 7 days: Other specified"
label variable v4a_17a_77 "Reasons operations decreased"
label variable v4a_17a_8888 "Reasons operations decreased"
label variable v4a_17a_9999 "Reasons operations decreased"
label variable v4a_17a_otherspecify "Reasons operations decreased"
label variable v4a_19 "Revenue for the last 30 days is more"
label variable v4a_20 "How long expect to continue running the business"
label variable v4a_21 "Able to sell products through the usual channels (local markets"
label variable v4a_22 "Changes in the prices for products for this time of year (Agribusiness)"
label variable v4a_23 "Perform the normal activities (Agribusiness)"
label variable v4a_24 "Operations as usual (Agribusiness)"
label variable v4a_25_1 "Agrobusiness adjustments"
label variable v4a_25_2 "Agribusiness adjustments"
label variable v4a_25_3 "Agribusiness adjustments"
label variable v4a_25_4 "Agribusiness adjustments"
label variable v4a_25_77 "Agribusiness adjustments"
label variable v4a_25_8888 "Agribusiness adjustments"
label variable v4a_25_9999 "Agribusiness adjustments"
label variable v4a_25_otherspecify "Agribusiness adjustments"
label variable v4a_26_1 "Gvt support policies"
label variable v4a_26_2 "Gvt support policies"
label variable v4a_26_3 "Gvt support policies"
label variable v4a_26_4 "Gvt support policies"
label variable v4a_26_5 "Gvt support policies"
label variable v4a_26_6 "Gvt support policies"
label variable v4a_26_7 "Gvt support policies"
label variable v4a_26_8 "Gvt support policies"
label variable v4a_26_77 "Gvt support policies"
label variable v4a_26_66 "Gvt support policies"
label variable v4a_26_8888 "Gvt support policies"
label variable v4a_26_9999 "Gvt support policies"
label variable v4a_26_otherspecify "Gvt support policies"
label variable v4a_27 "Would continue with current job or go back to previous work"
label variable v6_01b "Household worry would run out of food over the last 7 days "
label variable v6_01c "Household reduced purchase/consumption of\xa0preferred\xa0food\xa0because of budget over "
label variable v6_01d "Household ran out of food and money to buy more over the last 7 days"
label variable v6_02_1 "In an emergency expense could solve with Own Savings"
label variable v6_02_2 "In an emergency expense could solve with Relatives/friends with interest"
label variable v6_02_3 "In an emergency expense could solve with Relatives/friends without interest"
label variable v6_02_4 "In an emergency expense could solve with Bank loan/credit card"
label variable v6_02_5 "In an emergency expense could solve with NGO/CBO loan"
label variable v6_02_6 "In an emergency expense could solve with Savings group"
label variable v6_02_7 "In an emergency expense could solve with Money lender"
label variable v6_02_8 "In an emergency expense could solve with Shopkeeper"
label variable v6_02_9 "In an emergency expense could solve with Pawn farm animals/equipment"
label variable v6_02_10 "In an emergency expense could solve with Pawn house/land"
label variable v6_02_11 "In an emergency expense could solve with Pawn other property"
label variable v6_02_12 "In an emergency expense could solve with Advance salary / borrow from employer"
label variable v6_02_77 "In an emergency expense could solve with Other"
label variable v6_02_66 "In an emergency expense don�t have any source/I will not be able to get the mone"
label variable v6_02_8888 "In an emergency expense DON'T KNOW how to solve"
label variable v6_02_9999 "In an emergency expense REFUSED how to solve"
label variable v6_02_otherspecify "In an emergency expense could solve with other specified"
label variable v6_03 "How long household is able to meet basic needs "
label variable v6_04 "Household pay rent for dwelling"
label variable v6_05 "Household managed to pay the rent last month"
label variable v6_06 "Household received assistance from Government/NGOs since March 1 2020"
label variable v6_08 "Household received assistance from Government/NGOs before March 1 2020"
label variable v6_11_otherspecify "Most helpful assistance would be Other specified"
label variable count ""

* saving out data in .dta format
save "1_converted_data\new_observations.dta", replace

log close






























