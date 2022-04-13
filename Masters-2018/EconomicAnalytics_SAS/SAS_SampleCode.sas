/* Economic Analytics Assignment: Dhruv Singh; ECMT 673: Prof. Schulman  */
**************************************;
** Reading in oil haul data in texas *;
**************************************;
libname jan xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_01.xlsx";
libname feb xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_02.xlsx";
libname mar xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_03.xlsx";
libname apr xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_04.xlsx";
libname may xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_05.xlsx";
libname jun xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_06.xlsx";
libname jul xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_07.xlsx";
libname aug xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_08.xlsx";
libname sep xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_09.xlsx";
libname oct xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_10.xlsx";
libname nov xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_11.xlsx";
libname dec xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/Invoice2012_12.xlsx";
libname rates xlsx 
	"/folders/myfolders/CodingSample/OilHaulData/RateCategories.xlsx";
**************************************************;
* Subsetting to keep oil haul variables:          ;
* travel times, rates, destination, delivery date ;
**************************************************;

data jan.janKeep;
	set jan.jan;
	keep haul_date notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data feb.febKeep;
	set feb.feb;
	keep haul_date notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data mar.marKeep;
	set mar.mar;
	keep haul_date notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data apr.aprKeep;
	set apr.apr;
	keep haul_date notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data may.mayKeep;
	set may.may;
	keep haul_date notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data jun.junKeep;
	set jun.jun;
	keep start_date_time notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data jun.junKeep2 (rename=(Start_Date_Time=Haul_Date));
	set jun.junKeep;
run;

data jul.julKeep;
	set jul.jul;
	keep start_date_time notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data jul.julKeep2 (rename=(Start_Date_Time=Haul_Date));
	set jul.julKeep;
run;

data aug.augKeep;
	set aug.aug;
	keep start_date_time notes__hourly_time_split_loads__ driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data aug.augKeep2 (rename=(Start_Date_Time=Haul_Date));
	set aug.augKeep;
run;

data sep.sepKeep;
	set sep.sep;
	keep start_date_time notes__hourly_time_split_loads_0 driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data sep.sepKeep2 (rename=(Start_Date_Time=Haul_Date 
		notes__hourly_time_split_loads_0=notes__hourly_time_split_loads__));
	set sep.sepKeep;
run;

data oct.octKeep;
	set oct.oct;
	keep start_date_time notes__hourly_time_split_loads_0 driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data oct.octKeep2 (rename=(Start_Date_Time=Haul_Date 
		notes__hourly_time_split_loads_0=notes__hourly_time_split_loads__));
	set oct.octKeep;
run;

data nov.novKeep;
	set nov.nov;
	keep start_date_time notes__hourly_time_split_loads_0 driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data nov.novKeep2 (rename=(Start_Date_Time=Haul_Date 
		notes__hourly_time_split_loads_0=notes__hourly_time_split_loads__));
	set nov.novKeep;
run;

data dec.decKeep;
	set dec.dec;
	keep start_date_time notes__hourly_time_split_loads_0 driver__ driver lease__ 
		lease_name delivery_station base_rate;
run;

data dec.decKeep2 (rename=(Start_Date_Time=Haul_Date 
		notes__hourly_time_split_loads_0=notes__hourly_time_split_loads__));
	set dec.decKeep;
run;

******************************************;
** Creating categories by oil base rates *;
******************************************;

data Stack;
	set jan.janKeep feb.febKeep mar.marKeep apr.aprKeep may.mayKeep jun.junKeep2 
		jul.julKeep2 aug.augKeep2 sep.sepKeep2 oct.octKeep2 nov.novKeep2 dec.decKeep2;
	Week=Week(Haul_Date);
	Month=Month(Haul_Date);
	leasedest=catt(Lease_Name, Delivery_Station_);

	if find(upcase(notes__hourly_time_split_loads__), 'REJECT')then
		delete;

	if find(upcase(notes__hourly_time_split_loads__), 'SPLIT') then
		Split=1;
	else
		Split=0;

	if 1.34<=Base_Rate<=1.52 then
		Rate_Category=5;

	if 1.52<Base_Rate<=2.23 then
		Rate_Category=4;

	if 2.23<Base_Rate<=2.68 then
		Rate_Category=3.5;

	if 2.68<Base_Rate<=3.32 then
		Rate_Category=3;

	if 3.32<Base_Rate<=3.93 then
		Rate_Category=2.5;

	if 3.93<Base_Rate<=5.25 then
		Rate_Category=3;
	Driver_Utilization=1/Rate_Category;
run;

data S_0;
	set Stack;
	where split=0;
run;

data S_1;
	set Stack;
	where split=1;
run;

***************************************************;
** Creating report of hauls by category and month *;
***************************************************;

proc sort data=S_0 nodupkey;
	by Rate_Category;
run;

proc freq data=S_0;
	title "Split 0";
	by Month;
	tables Rate_Category;
run;

Proc means mean data=S_0;
	var Driver_Utilization;
	class Week Rate_Category;
run;

Proc means mean data=S_1;
	var Driver_Utilization;
	class Week Rate_Category;
run;