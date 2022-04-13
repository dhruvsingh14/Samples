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
years = list(map(str, range(2002, 2018)))
years

#####################################
# Visualizing Data using Matplotlib #
#####################################

# importing libs
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches # required for waffle charts

mpl.style.use('ggplot')

# print('Matplotlib version: ', mpl.__version__) # >= 3.1.3

####################
# Regression Plots #
####################

# importing seaborn
import seaborn as sns
# print('Seaborn installed and imported!')

# using the sum() method to get the total population per year
# in essence, collapsing by year,across all countries
df_h = df_ins[df_ins["Race"] == "Hispanic"]
df_h = df_h[df_h["Coverage"] == "Covered"]
print(df_h.head())

df_tot = pd.DataFrame(df_h[years].sum(axis=0))
print(df_tot.head())
print(df_tot.tail())

# changing year type to float to measure incremental change
df_tot.index = map(float, df_tot.index)

# resetting index to use as a column
df_tot.reset_index(inplace=True)

# renaming columns
df_tot.columns = ['year', 'total']
df_tot = df_tot[df_tot["year"] != 2009]

# viewing outputted dataframe
print(df_tot.head())
print(df_tot.tail())


# plot 1, using regplot
ax = sns.regplot(x='year', y='total', data=df_tot)
plt.show()



# plot 2, switching color to green
ax = sns.regplot(x='year', y='total', data=df_tot, color='green')
plt.show()



# plot 3, changing markers to + signs
ax = sns.regplot(x='year', y='total', data=df_tot, color='green', marker='+')
plt.show()



# plot 4, blowing up the plot size
plt.figure(figsize=(15,10))
ax = sns.regplot(x='year', y='total', data=df_tot, color='green', marker='+')
plt.show()


# plot 5, blowing up marker size, adding axis labels, title
plt.figure(figsize=(15,10))
ax = sns.regplot(x='year', y='total', data=df_tot, color='green', marker='+', scatter_kws={'s': 200})

ax.set(xlabel='Year', ylabel='Total Covered') # adding axes labels
ax.set_title('Total Coverage in Sample by Race (Hispanic) from 2002 - 2017') # add title
plt.show()


# plot 6, increasing font size of tickmark labels, title, axes
plt.figure(figsize=(15,10))
sns.set(font_scale=1.5)

ax = sns.regplot(x='year', y='total', data=df_tot, color='green', marker='+', scatter_kws={'s': 200})
ax.set(xlabel='Year', ylabel='Total Covered') # adding axes labels
ax.set_title('Total Coverage in Sample by Race (Hispanic) from 2002 - 2017') # add title

plt.show()

