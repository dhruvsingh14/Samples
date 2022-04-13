################################################
# Week 1: Intro to Matplotlib and Line Graphs  #
################################################

# importing libraries
import numpy as np
import pandas as pd
import xlrd
import matplotlib as mpl
import matplotlib.pyplot as plt


#############
# Read Data #
#############
# read url
df_sr = pd.read_csv('Self_reports.csv')

# print('Data read into a pandas dataframe!')

# checking first 5 rows
print(df_sr.head())
print(df_sr.tail())


#######
# EDA #
#######

# tabulating basic info about our dataframe
df_sr.info()

# investigating columns and metadata
df_sr.columns.values

# this lists row indices
df_sr.index.values

# returns columns and indices types / classes
type(df_sr.columns)
type(df_sr.index)

# converting columns, and indices to lists
df_sr.columns.tolist()
df_sr.index.tolist()

# checking type post - list conversion
type(df_sr.columns.tolist())
type(df_sr.index.tolist())

# checking dimensions
df_sr.shape

# preparing to visualize  data:

# by first adding a column for total arrests for 1980-2014
df_sr['Total'] = df_sr.sum(axis=1)

# tabulating null cells
df_sr.isnull().sum()

# printing dataset metrics
df_sr.describe()

# setting index to be the country names
df_sr.set_index('Offense', inplace=True)
df_sr.head(3)

#######################
# Highest Crime Types #
#######################
df_sr_sorted = df_sr.sort_values('Total', ascending=False)
df_sr_sorted
print(df_sr_sorted.head())

df_sr_top5 = df_sr_sorted.iloc[[0,1,2,3,4]]
print(df_sr_top5)

# capturing list of years, for category visualization
years = list(map(str, range(1993, 2019)))
years

df_sr_top5 = df_sr_top5.loc[:,years]
print(df_sr_top5)

df_sr_top5 = df_sr_top5.transpose()
print(df_sr_top5.head())


## comparing top5 immigration trends!
df_sr_top5.plot(kind='line')
plt.title('Victimization by Top 5 Crime Types')
plt.ylabel('Number of Acts Perpetrated')
plt.xlabel('Years')
plt.show()





















# in order to display plot within window
# plt.show()
