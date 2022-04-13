########################################
# Week 2.2: Pie, Box, Scatter, Bubble  #
########################################

# importing libraries
import numpy as np
import pandas as pd
import xlrd

#############
# Read Data #
#############
# read url
df_pp = pd.read_csv('Prisoner_Populations.csv')

# print('Data read into a pandas dataframe!')

# checking first 5 rows
df_pp.head()
df_pp.tail()

#######
# EDA #
#######

# checking dimensions
df_pp.shape

#############
# Reshaping #
#############

# resetting index to unique country name
df_pp.set_index('Jurisdiction', inplace=True)
df_pp.head()

# preparing to visualize canadian data:
# by first adding a column for total immigration for 1980-2013
df_pp['Total'] = df_pp.sum(axis=1)
df_pp.head()

# printing m by n
# print('data dimensions:', df_can.shape) # sick command for printing dimensionality

# creating a varlist that can be used to call colnmaes while plotting or subsetting
# capturing list of years, for category visualization
years = list(map(str, range(1978, 2016)))
years

#####################################
# Visualizing Data using Matplotlib #
#####################################

# importing libs
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.style.use('ggplot')


################
# Scatter Plot #
################

# collapsing each year column into a single aggregated row
df_tot = pd.DataFrame(df_pp[years].sum(axis=0))
print(df_tot.head())

# Changing year types to int, to measure incremental effects when regressing
df_tot.index = map(int, df_tot.index)

# resetting the index to reframe it as a column
df_tot.reset_index(inplace = True)

# renaming columns
df_tot.columns = ['year', 'total']

# viewing the final outputted dataset creation
print(df_tot.head())

# finally, compiling our plot

df_tot.plot(kind='scatter', x='year', y='total', figsize=(10, 6), color='darkblue')

plt.title('Total Inmates In and Out of Jail from 1978 - 2016')
plt.xlabel('Year')
plt.ylabel('Number of Inmates')
plt.show()

################################
# Q4: Scatterplot of prisoners #
################################

# subsetting to Admissions
df_adm = df_pp.loc[['Total Admissions'], years]
df_adm.head()


# summing numbers across the years for these three countries
df_total = pd.DataFrame(df_adm[years].sum(axis=0))

# Changing year types to int, to measure incremental effects when regressing
df_total.index = map(int, df_total.index)

# resetting the index in place
df_total.reset_index(inplace = True)

# renaming columns to year and total
df_total.columns = ['year', 'total']

# displaying our resulting dataframe
df_total.head()


# generating the scatterplot total vs year

df_total.plot(kind='scatter', x='year', y='total', figsize=(10, 6), color='darkblue')

plt.title('Total Admissions to Prisons Nationwide from 1978 - 2016')
plt.xlabel('Year')
plt.ylabel('Number of Admissions')

plt.show()

################
# Bubble Plots #
################

# fetching the data for argentina and brazil
df_pp_t = df_pp[years].transpose() # transposing our data

# Changing year types to int, to measure incremental effects when regressing
df_pp_t.index = map(int, df_pp_t.index)

# relabelling the index name prior to resetting it
df_pp_t.index.name = 'Year'
# resetting the index in place
df_pp_t.reset_index(inplace = True)

# displaying our resulting dataframe
df_pp_t.head()

# now, normalizing Incarcerated and Releases data to make it comparable
# to be utilized in plots
norm_incarcerated = (df_pp_t['Total Incarcerated'] - df_pp_t['Total Incarcerated'].min()) / (df_pp_t['Total Incarcerated'].max() - df_pp_t['Total Incarcerated'].min())
norm_releases = (df_pp_t['Total Releases'] - df_pp_t['Total Releases'].min()) / (df_pp_t['Total Releases'].max() - df_pp_t['Total Releases'].min())

# now, setting up our scatterplot for the respective countries

ax0 = df_pp_t.plot(kind='scatter',
                    x='Year',
                    y='Total Incarcerated',
                    figsize=(14, 8),
                    alpha=0.5,
                    color='green',
                    s=norm_incarcerated * 2000 + 10, # pass in weights
                    xlim=(1978, 2016)
                    )

ax1 = df_pp_t.plot(kind='scatter',
                    x='Year',
                    y='Total Releases',
                    alpha=0.5,
                    color="blue",
                    s=norm_releases * 2000 + 10,
                    ax = ax0 # anchoring axes to combine plots
                    )

ax0.set_ylabel('Number of Immigrants')
ax0.set_title('Total numbers of Incarcerated and Releases from 1978 - 2016')
ax0.legend(['Total Incarcerated', 'Total Releases'], loc='upper left', fontsize='x-large')

plt.show()

'''
####################################
# Q5: China and India Bubble Plots #
####################################

# fetching the data for china and india:

# now, normalizing China and India data to make it comparable
# to be utilized in plots
norm_china = (df_can_t['China'] - df_can_t['China'].min()) / (df_can_t['China'].max() - df_can_t['China'].min())
norm_india = (df_can_t['India'] - df_can_t['India'].min()) / (df_can_t['India'].max() - df_can_t['India'].min())

# now, setting up our scatterplot for the respective countries
ax0 = df_can_t.plot(kind='scatter',
                    x='Year',
                    y='China',
                    figsize=(14, 8),
                    alpha=0.5,
                    color='green',
                    s=norm_china * 2000 + 10, # pass in weights
                    xlim=(1975, 2015)
                    )

ax1 = df_can_t.plot(kind='scatter',
                    x='Year',
                    y='India',
                    alpha=0.5,
                    color="blue",
                    s=norm_india * 2000 + 10,
                    ax = ax0 # anchoring axes to combine plots
                    )

ax0.set_ylabel('Number of Immigrants')
ax0.set_title('Immigration From China and India from 1980 - 2013')
ax0.legend(['China', 'India'], loc='upper left', fontsize='x-large')

plt.show()
'''
































# in order to display plot within window
# plt.show()
