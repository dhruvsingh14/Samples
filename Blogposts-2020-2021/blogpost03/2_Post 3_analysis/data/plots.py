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
df_educ = df_educ[['Year', 'Country',
                    'unemp_fem', 'unemp_male', 'unemp_tot',
                    'pop_growth', 'pop',
                    'internet_users', 'labor_foce_fem',
                    'labor_force', 'mortality',
                    'gdp_mkt', 'gdp_pcap', 'gni',
                    'lower_secondary_dur',
                    'post_secondary_dur',
                    'pre-primary_dur',
                    'primary_dur', 'secondary_dur',
                    'upper_secondary_dur',
                    'govt_exp_educ_perc_gdp',
                    'tertiary_grad', 'tertiary_grad_fem',
                    'gross_enrolment_ratio',
                    'gross_enrolment_ratio_secondary',
                    'gross_enrolment_ratio_tertiary',
                    'pt_ratio_pre-primary',
                    'pt_ratio_primary', 'pt_ratio_secondary',
                    'pt_ratio_tertiary',
                    'unschooled_primary_perc',
                    'sch_life_exp_primary',
                    'sch_life_exp_secondary',
                    'sch_life_exp_tertiary',
                    'mobility_in_num',
                    'total_net_enrolment_primary',
                    'total_net_enrolment_primary_gpi',
                    'govt_education_expenditure_perc',
                    'lower_secondary_dur',
                    'post_secondary_dur',
                    'pre-primary_dur',
                    'primary_dur', 'secondary_dur',
                    'upper_secondary_dur',
                    'mobility_in_num',
                    'total_net_enrolment_primary',
                    'total_net_enrolment_primary_gpi']]



print(df_educ.head())

# importing libs
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.style.use('ggplot')

x = df_educ

# grouping data by countries
#x = df_educ.groupby('Country', axis=0)

# year subset
x = x[x['Year'] > 1990]

#x = x[(x['Year'] >= 2003) & (x['Year'] <= 2011)]

# resetting index to unique country name
x.set_index('Year', inplace=True)


# selecting var
x = x[['Country', 'gdp_pcap']]
print(x.head())

# transposing var
x = x.pivot(columns='Country', values='gdp_pcap')
print(x.head())


# var line plots
(x).plot(figsize=(10, 5))
# Set title and labels for axes
plt.title('var trend')
plt.xlabel('Date')
plt.ylabel('var trend')
plt.show()






































# in order to display plot within window
# plt.show()
