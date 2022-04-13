%let path = C:/Users/dhnsingh/Documents;

libname cms "&path/Hospital_Revised_Flatfiles";
options validvarname=v7;

/* reading in csv values */
proc import datafile = "&path/Hospital_Revised_Flatfiles/Hospital General Information.csv" 
		dbms = csv
		out = claims_raw		 
		replace;
	guessingrows=max;
run;

/* exploratory */
proc print data = claims_raw (obs= 20);
run;

proc contents data = claims_raw varnum;
run;

proc freq data = claims_raw;
	tables state
			hospital_type
			hospital_ownership
			hospital_overall_rating 
			readmission_national_comparison/ nocum nopercent;
run;

proc print data = claims_raw;
	where hospital_overall_rating = '1';
run;

proc print data = claims_raw;
	where hospital_overall_rating = '5';
run;


/* removing any potenital duplicate records */
proc sort data = claims_raw 
		out = claims_nodup noduprecs;
	by _all_; /* sorting by all sorts on all columns, so dups rows are adjacent */
run;
	
proc sort data = claims_nodup;
	by incident_date;
run;

/* defining quality format */
proc format;
	value $quality '1' = 'Sub-Standard'
					'2' = 'Poor'
					'3' = 'Adequate'
					'4' = 'Good'
					'5' = 'Excellent';
run;

/* missing values */
data cms.claims_cleaned;
	set claims_nodup;
/* Recoding NA values */
	if Hospital_overall_rating in ("Not Available") then Hospital_overall_rating = "NA";
	if Mortality_national_comparison in ("Not Available") then Mortality_national_comparison = "NA";
	if Readmission_national_comparison in ("Not Available") then Readmission_national_comparison = "NA";
/* case change */
	Hospital_name = propcase(Hospital_name);
	Address = propcase(Address);
	City = propcase(City);
	County_name = propcase(County_name);
/* labels and formats */
	format hospital_overall_rating quality.;
	label Provider_ID = "Provider ID"
		Hospital_Name = "Hospital Name"
		ZIP_Code = "ZIP Code"
		County_Name = "County Name"
		Phone_Number = "Phone Number"
		Hospital_Type = "Hospital Type"
		Hospital_Ownership = "Hospital Ownership"
		Hospital_overall_rating = "Hospital overall rating"
		Mortality_national_comparison = "Mortality national comparison"
		Readmission_national_comparison = "Readmission national comparison";
/* dropping vars */
		drop emergency_services Meets_criteria_for_meaningful_u Hospital_overall_rating_footnot 
			Mortality_national_comparison_f-- var18 var20 -- var28;
run;

/* checking final data set for consistencies */
proc freq data = cms.claims_cleaned order = freq;
	tables Hospital_overall_rating*Mortality_national_comparison / nopercent nocum;
	where Hospital_overall_rating ne 'NA' and Mortality_national_comparison ne 'NA';
run;	

proc freq data = cms.claims_cleaned order = freq;
	tables Hospital_overall_rating*Readmission_national_comparison / nopercent nocum;
	where Hospital_overall_rating ne 'NA' and Readmission_national_comparison ne 'NA';
run;	

*******************************;
*          Report              ;
*******************************;
%let state=VA;
%let outpath=C:\Users\dhnsingh\Documents\HospitalCompareCase;
ods pdf file =  "&outpath/&state CompareReport.pdf" style=meadow pdftoc = 1;
ods noproctitle;

/* number of date issues overall */
ods proclabel "Overall Hospital Ratings in the Data";
title "Overall Hospital Ratings";
proc freq data = cms.claims_cleaned;
	table Hospital_overall_rating / missing nocum nopercent;
	where Hospital_overall_rating ne 'NA';
run;
title;

/* claims per year of incident date */
ods graphics on;
ods proclabel "Overall Hospitals By Ownership";
title "Overall Hospitals By Ownership";
proc freq data = cms.claims_cleaned;
	table Hospital_Ownership / nocum nopercent plots = freqplot;
run;
title;

/* relevant statistics by state using macros */
title "&state Hospitals Overview";
title "&state Ratings, Ownership, and Type";
proc freq data = cms.claims_cleaned order = freq;
	table Hospital_overall_rating Hospital_Type Hospital_Ownership / nocum nopercent;
	where state = "&state" and Hospital_overall_rating ne 'NA';
run;
title;

ods pdf close;
