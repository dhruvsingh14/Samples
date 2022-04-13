#############################
# US vs. India Covid Relief #
#############################
# importing libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#################################
# Importing Covid Cases Dataset #
#################################
# importing library
import wget

# downloading owid data, and saving
# url = 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
# wget.download(url, 'covid-data.csv')

# reading in, printing
df_cov = pd.read_csv("covid-data.csv")
print(df_cov.head())

######################
# Data Preprocessing #
######################

# returns columns and indices types / classes
type(df_cov.columns)
type(df_cov.index)

# converting columns, and indices to lists
df_cov.columns.tolist()
df_cov.index.tolist()

# checking type post - list conversion
print(type(df_cov.columns.tolist()))
print(type(df_cov.index.tolist()))

# printing out dimensions
print(df_cov.shape)

#############################################
# Keeping Relevant Variables and Subsetting #
#############################################
# keeping relevant variables
df_cov = df_cov[['location', 'date', 'total_cases', 'total_deaths',
            'population', 'gdp_per_capita']]
print(df_cov.head())

# setting index to be the country names
df_cov.set_index('location', inplace=True)
df_cov.head()

##########################
# Subset: US, India Data #
##########################
# us data: jan to july, daily
us_ind_cov = df_cov.loc[['United States', 'India']]
us_ind_cov

# replacing country index with dates
us_ind_cov.reset_index(level=0, inplace=True)
us_ind_cov.set_index('date', inplace=True)
print(us_ind_cov)

###################################################
# Plotting: US vs. India - Total Cases (Absolute) #
###################################################
# deaths_absolute
us_ind_cov2 = us_ind_cov[['location', 'total_cases']]
us_ind_cov2

# transposing
result = us_ind_cov2.pivot(columns='location', values='total_cases')
print(result)

# plotting absolute numbers
(result).plot(figsize=(10, 5))
# Set title and labels for axes
plt.title('Daily Total Cases \nCumulative, July 2020')
plt.xlabel('Date')
plt.ylabel('Covid Cases - US (total)')
plt.show()

####################################################
# Plotting: US vs. India - Total Deaths (Absolute) #
####################################################
# deaths_absolute
us_ind_cov2 = us_ind_cov[['location', 'total_deaths']]
us_ind_cov2

# transposing
result = us_ind_cov2.pivot(columns='location', values='total_deaths')
print(result)

# plotting absolute numbers
(result).plot(figsize=(10, 5))

# Set title and labels for axes
plt.title('Daily Total Deaths \nCumulative, July 2020')
plt.xlabel('Date')
plt.ylabel('Covid deaths - US (total)')
plt.show()

####################################################
# Plotting: US vs. India - Total Deaths (% change) #
####################################################
# plotting % changes (normalizing data)
# starting at right apr 9th onwards
(result / result.iloc[120] * 100).plot(figsize=(10, 5))
plt.title('Daily Total Deaths \n% change, July 2020')
plt.xlabel('Date')
plt.ylabel('Covid Cases - US (total)')
plt.show()





























'''
###########################################
# Plotting: US vs. India - GDP Per Capita #
###########################################
# deaths_absolute
us_ind_cov2 = us_ind_cov[['location', 'gdp_per_capita']]
us_ind_cov2

# transposing
result = us_ind_cov2.pivot(columns='location', values='gdp_per_capita')
print(result)

# plotting absolute numbers
(result).plot(figsize=(10, 5))
plt.show()


###################
# Subset: US Data #
###################
# us data: jan to july, daily
us_cov = df_cov.loc[['United States']]
print(us_cov)

# deaths_absolute
us_cov2 = us_cov[['date', 'total_deaths']]
print(us_cov2)

# plot1a: total deaths bar plot
fig, ax = plt.subplots(figsize=(12, 12))

# Add x-axis and y-axis
ax.bar(us_cov2['date'],
       us_cov2['total_deaths'],
       color='purple')

# Set title and labels for axes
ax.set(xlabel="Date",
       ylabel="Covid deaths - US (total)",
       title="Daily Total Deaths \nCumulative, July 2020")

plt.show()


######################
# Subset: India Data #
######################
# ind data: jan to july, daily
ind_cov = df_cov.loc[['India']]
print(ind_cov)

# deaths_absolute
ind_cov2 = ind_cov[['date', 'total_deaths']]
print(ind_cov2)


# plot1b: total deaths bar plot
fig, ax = plt.subplots(figsize=(12, 12))

# Add x-axis and y-axis
ax.bar(ind_cov2['date'],
       ind_cov2['total_deaths'],
       color='purple')

# Set title and labels for axes
ax.set(xlabel="Date",
       ylabel="Covid deaths - India (total)",
       title="Daily Total Deaths \nCumulative, July 2020")

plt.show()
'''









# in order to display plot within window
# plt.show()
