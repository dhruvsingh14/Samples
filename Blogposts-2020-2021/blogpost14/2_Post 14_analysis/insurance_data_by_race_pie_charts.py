###################
# Insurance Data  #
###################

# importing libraries
import numpy as np
import pandas as pd


#############
# Read Data #
#############
# read url
df_ins = pd.read_csv('insurance_data_wide.csv')

# print('Data read into a pandas dataframe!')

# checking first 5 rows
print(df_ins.head())
print(df_ins.tail())

# assigning column types to string, then rechecking
df_ins.columns = list(map(str, df_ins.columns))
print(all(isinstance(column, str) for column in df_ins.columns))

# resetting index to unique country name
# df_ins.set_index('Race', inplace=True)
# df_ins.head()

# preparing to visualize canadian data:
# by first adding a column for total coverage from 2002-2017
df_ins['Total'] = df_ins.sum(axis=1)
print(df_ins.head())

# creating a varlist that can be used to call colnmaes while plotting or subsetting
# capturing list of years, for category visualization
years = list(map(str, range(2002, 2017)))
years

#####################################
# Visualizing Data using Matplotlib #
#####################################

# importing libs
import matplotlib as mpl
import matplotlib.pyplot as plt

mpl.style.use('ggplot')

# print('Matplotlib version: ', mpl.__version__) # >= 3.1.3

########################
# Pie Charts i - White #
########################

df_w = df_ins[df_ins["Race"] == "White"]
df_w = df_w[(df_w["Coverage"] == "Covered") | (df_w["Coverage"] == "Not.covered")]

print(df_w.head())


# substitute df_w for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_w.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_w.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Coverage Rates of Sample Population by Race (White) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

#############################
# Pie Charts, pt ii - White #
#############################

df_w = df_ins[df_ins["Race"] == "White"]
df_w = df_w[(df_w["Coverage"] != "Covered") & (df_w["Coverage"] != "Not.covered")
                                             & (df_w["Coverage"] != "Total")]

print(df_w.head())


# substitute df_w for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_w.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_w.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Insurance of Sample Population by Race (White) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

########################
# Pie Charts i - Black #
########################

df_b = df_ins[df_ins["Race"] == "Black"]
df_b = df_b[(df_b["Coverage"] == "Covered") | (df_b["Coverage"] == "Not.covered")]

print(df_b.head())


# substitute df_b for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_b.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_b.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Coverage Rates of Sample Population by Race (Black) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

#############################
# Pie Charts, pt ii - Black #
#############################

df_b = df_ins[df_ins["Race"] == "Black"]
df_b = df_b[(df_b["Coverage"] != "Covered") & (df_b["Coverage"] != "Not.covered")
                                             & (df_b["Coverage"] != "Total")]

print(df_b.head())


# substitute df_b for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_b.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_b.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Insurance of Sample Population by Race (Black) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

########################
# Pie Charts i - Asian #
########################

df_a = df_ins[df_ins["Race"] == "Asian"]
df_a = df_a[(df_a["Coverage"] == "Covered") | (df_a["Coverage"] == "Not.covered")]

print(df_a.head())


# substitute df_a for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_a.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_a.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Coverage Rates of Sample Population by Race (Asian) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

#############################
# Pie Charts, pt ii - Asian #
#############################

df_a = df_ins[df_ins["Race"] == "Asian"]
df_a = df_a[(df_a["Coverage"] != "Covered") & (df_a["Coverage"] != "Not.covered")
                                             & (df_a["Coverage"] != "Total")]

print(df_a.head())


# substitute df_a for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_a.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_a.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Insurance of Sample Population by Race (Asian) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

########################
# Pie Charts i - Hispanic #
########################

df_h = df_ins[df_ins["Race"] == "Hispanic"]
df_h = df_h[(df_h["Coverage"] == "Covered") | (df_h["Coverage"] == "Not.covered")]

print(df_h.head())


# substitute df_h for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_h.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_h.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Coverage Rates of Sample Population by Race (Hispanic) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()

#############################
# Pie Charts, pt ii - Hispanic #
#############################

df_h = df_ins[df_ins["Race"] == "Hispanic"]
df_h = df_h[(df_h["Coverage"] != "Covered") & (df_h["Coverage"] != "Not.covered")
                                             & (df_h["Coverage"] != "Total")]

print(df_h.head())


# substitute df_h for df_ins for df_can at this point

# grouping by coverage, and summing within coverage
df_coverage = df_h.groupby('Coverage', axis=0).sum()

# output of groupby is a groupby type object
# summarizing along the vertical axis
print(type(df_h.groupby('Coverage', axis=0)))
print(df_coverage.head())

# autopct is a way to calculate and represent proportions

df_coverage['Total'].plot(kind='pie',
                            figsize=(5,6),
                            autopct='%1.1f%%', # adding in percentages
                            startangle=90,     # starting at 90 degrees
                            shadow=True,       # adding in shadow effects
                            )

plt.title('Insurance of Sample Population by Race (Hispanic) [2002 - 2017]')
plt.axis('equal') # sets pie into a circle type shape

plt.show()
