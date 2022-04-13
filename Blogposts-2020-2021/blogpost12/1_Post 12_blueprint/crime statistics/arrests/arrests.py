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
df_arr = pd.read_csv('Arrests_total.csv')

# print('Data read into a pandas dataframe!')

# checking first 5 rows
print(df_arr.head())
print(df_arr.tail())


#######
# EDA #
#######

# tabulating basic info about our dataframe
df_arr.info()

# investigating columns and metadata
df_arr.columns.values

# this lists row indices
df_arr.index.values

# returns columns and indices types / classes
type(df_arr.columns)
type(df_arr.index)

# converting columns, and indices to lists
df_arr.columns.tolist()
df_arr.index.tolist()

# checking type post - list conversion
type(df_arr.columns.tolist())
type(df_arr.index.tolist())

# checking dimensions
df_arr.shape

# preparing to visualize  data:

# by first adding a column for total arrests for 1980-2014
df_arr['Total'] = df_arr.sum(axis=1)

# tabulating null cells
df_arr.isnull().sum()

# printing dataset metrics
df_arr.describe()

# setting index to be the country names
df_arr.set_index('Offense', inplace=True)
df_arr.head(3)

#######################
# Highest Crime Types #
#######################
df_arr_sorted = df_arr.sort_values('Total', ascending=False)
df_arr_sorted
print(df_arr_sorted.head())

df_arr_top5 = df_arr_sorted.iloc[[2,3,4,5,7]]
print(df_arr_top5)

# capturing list of years, for category visualization
years = list(map(str, range(1980, 2014)))
years

df_arr_top5 = df_arr_top5.loc[:,years]
print(df_arr_top5)

df_arr_top5 = df_arr_top5.transpose()
print(df_arr_top5.head())


## comparing top5 immigration trends!
df_arr_top5.plot(kind='line')
plt.title('Arrests from Top 5 Crime Types')
plt.ylabel('Number of arrests')
plt.xlabel('Years')
plt.show()





















# in order to display plot within window
# plt.show()
