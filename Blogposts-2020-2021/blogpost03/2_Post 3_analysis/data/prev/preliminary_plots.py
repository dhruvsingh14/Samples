#######################################################
# Blogpost 3: Educational Data, Compare and Contrast  #
#######################################################
# importing libraries
import numpy as np
import pandas as pd


#############
# Read Data #
#############
# read educ data
df_educ = pd.read_csv("educ_data.csv")

# checking first 5 rows
print(df_educ.head())
print(df_educ.tail())

#######
# EDA #
#######

# checking dimensions
print(df_educ.shape)

#############
# Reshaping #
#############

# keeping necessary columns
df_educ = df_educ[['Year', 'Country', 'unemp_fem', 'unemp_male', 'unemp_tot',
                    'pop_growth', 'pop', 'internet_users', 'labor_foce_fem',
                    'labor_force', 'mortality', 'gdp_mkt', 'gdp_pcap', 'gni',
                    'lower_secondary_dur', 'post_secondary_dur', 'pre-primary_dur',
                    'primary_dur', 'secondary_dur',	'upper_secondary_dur',
                    'govt_exp_educ_perc_gdp']]

print(df_educ.head())

# importing libs
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.style.use('ggplot')

# grouping data by countries
df_unemp = df_educ.groupby('Country', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
type(df_educ.groupby('Country', axis=0))
print(df_unemp.head())

# pie chart
df_unemp['internet_users'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )
plt.title('Govt. Exp by Country [1970 - 2016]')
plt.axis('equal') # sets pie into a circle type shape
plt.show()


# boxplot
df_fem_unemp = df_educ[df_educ['Year'] > 1990]

# resetting index to unique country name
df_fem_unemp.set_index('Year', inplace=True)
#print(df_educ.head())

# plotting countries' spreads side by side
df_fem_unemp = df_fem_unemp[['Country', 'govt_exp_educ_perc_gdp']]
print(df_fem_unemp.head())



df_fem_unemp = df_fem_unemp.pivot(columns='Country', values='govt_exp_educ_perc_gdp')
print(df_fem_unemp)

df_fem_unemp.plot(kind='box', figsize=(8,6))

plt.title('Box plot of Chinese, Indian, and U.S. Govt. Exp from 1970 - 2016')
plt.ylabel('Govt. Exp')

plt.show()
# distribution is wayy wider for China.


# unemployment line plots
(df_fem_unemp).plot(figsize=(10, 5))
# Set title and labels for axes
plt.title('Govt. Exp')
plt.xlabel('Date')
plt.ylabel('Govt. Exp')
plt.show()




'''
other variables of interest:

	tertiary_grad	tertiary_grad_fem	gross_enrolment_ratio	gross_enrolment_ratio_secondary	gross_enrolment_ratio_tertiary

pt_ratio_pre-primary	pt_ratio_primary	pt_ratio_secondary	pt_ratio_tertiary	unschooled_primary_perc	sch_life_exp_primary	sch_life_exp_secondary	sch_life_exp_tertiary

mobility_in_num	total_net_enrolment_primary	total_net_enrolment_primary_gpi

govt_education_expenditure_perc

lower_secondary_dur	post_secondary_dur	pre-primary_dur	primary_dur	secondary_dur	upper_secondary_dur	mobility_in_num	total_net_enrolment_primary	total_net_enrolment_primary_gpi
'''



































# in order to display plot within window
# plt.show()
