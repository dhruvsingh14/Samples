libname MSA 
	"C:\Users\dhnsingh\Desktop\Fall 2016 TAMU\Economic Analytics (673)\HW2";

proc sort data=msa.msa_income_data out=work.popsort;
	by region descending population;
	where region_pop_rank<=5;
run;

*pt. 1;
*ODS PDF file="C:\Users\dhnsingh\Desktop\Fall 2016 TAMU\Economic Analytics (673)\HW2.pdf";
ODS EXCEL file="C:\Users\dhnsingh\Desktop\Fall 2016 TAMU\Economic Analytics (673)\HW2.xlsx";
options (sheet_interval='PROC');

proc print data=work.popsort noobs sumlabel='Region Sum' 
		grandtotal_label='Grand Total';
	*pt. 2, 6;
	title 'Five Largest Metropolitan Statistical Areas by BEA Region';
	*pt. 7;
	title3 '2014 Population and Income Estimates';
	footnote 'Population estimates from U.S. Census Bureau';
	*pt. 8;
	footnote2 
		'Per capita personal income estimates from U.S. Bureau of Economic Analysis';
	var metropolitan_statistical_area population per_capita_personal_income;
	*pt. 3;
	format population comma12. per_capita_personal_income dollar12.;
	*pt. 4;
	label Per_capita_personal_income='Per Capita Personal Income';
	*pt. 5;
	by region;
	sum population;
run;

proc means data=msa;
	class region;
	var Per_capita_personal_income;
run;

ods excel close;

proc summary data=msa nway;
	class region;
	var Per_capita_personal_income;
	output out=r_out mean=std.=min=max=/autoname;
run;