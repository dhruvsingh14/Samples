// Exploring dataset containing World Bank Indicators data //


use WDI_data, clear
set more off


// Part 1: tabulating regions and income group //

* obs
count 

* categories per var listed
tab region
tab incomegroup


// Part 2: scope of data, # vars, # obs

des

// Part 3: central tendency, for gdp vs mortality, scatter plot //

sum GDP_pc mort_rate_under5
scatter GDP_pc mort_rate_under5


// Part 4: comparing averages of male and female literacy //

sum lit_rate_fem_adult lit_rate_male_adult

* generating var for gender gap in education rate
gen diff_rate = lit_rate_male_adult - lit_rate_fem_adult

* sum gap by region, and income group
bys region: sum diff_rate lit_rate_fem_adult lit_rate_male_adult
bys incomegroup: sum diff_rate lit_rate_fem_adult lit_rate_male_adult


// Part 5: comparing fem lit rate for low and high income countries

gsort GDP_pc
sum lit_rate_fem_adult mort_rate_under5 GDP_pc if GDP_pc>18000
sum lit_rate_fem_adult mort_rate_under5 GDP_pc if GDP_pc<1400

// Part 6: income dispersion, mean>>median

sum GDP_pc, detail

// Part 7: positive correlation fem lit rate and gdp

reg lit_rate_fem_adult GDP_pc


// Part 9: negative correlation b/w lit rate and mortality

reg mort_rate_under5 lit_rate_fem_adult
scatter mort_rate_under5 lit_rate_fem_adult

// Part 11: negative correlation b/w paved road and energy use //
//		 negative correlation b/w improved water and mortality //
		
reg road_pave_perc energy_use
sum HIV_prevalence
reg mort_rate_male imp_water_access_perc
