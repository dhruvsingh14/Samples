############################################################################
# Economic and Political Freedom: Its Determinants, and Outcomes (Part II) #
############################################################################

# importing libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats

# read data
df = pd.read_csv("combined_data.csv", encoding= 'unicode_escape')
print(df.head())

# listing data type
print(df.dtypes)

# subsetting to relevant columns
df = df[[
    # overall
    'year', 'Country',

    # heritage
    'World.Rank', 'Region.Rank', 'X2020.Score',

    # fh1: democracy
    'Total.Score_democ', 'Status_democ',

    # fh2: global freedom
    'Total.Score_global_freedom', 'Status_global_freedom',

    # fh3: internet
    'Total.Score_internet', 'Status_internet',

    # cato
    'hf_score', 'hf_rank',

    # rsf
    'Rank2020', 'Score.2020',

    # wrp
    'economicFreedomIndex', 'humanFreedomIndex']]


print(df.head())

# listing data type
print(df.dtypes)
print(df.corr())


# converting types to float
df['hf_score'] = df['hf_score'].astype(float)
df['hf_rank'] = df['hf_rank'].astype(float)
df['Score.2020'] = df['Score.2020'].astype(float)

# listing data type
print(df.dtypes)
print(df.corr())

# now printing corr matrix for select columns of interest
print(df[['Total.Score_democ', 'hf_score', 'Rank2020', 'economicFreedomIndex']].corr())

# Positive linear relationship
# using economicFreedomIndex as a predictor of hf_score
'''
sns.regplot(x="economicFreedomIndex", y="hf_score", data=df)
plt.ylim(0,)
plt.show()
'''

# obtaining metrics on fit, such as strenght of correlation
df[["economicFreedomIndex", "hf_score"]].corr()

# running some descriptive stats
print(df.describe)


### categorical vars


# obtaining distinct values
print(df['Status_democ'].unique())

# creating a subset of dataframe
df_group_one = df[['Status_democ', 'Status_global_freedom', 'humanFreedomIndex']]
print(df_group_one)

# grouping results
df_group_one = df_group_one.groupby(['Status_democ'], as_index=False).mean()
print(df_group_one)

# grouping by multiple variables
df_gptest = df[['Status_democ', 'Status_global_freedom', 'humanFreedomIndex']]
grouped_test1 = df_gptest.groupby(['Status_democ', 'Status_global_freedom'], as_index=False).mean()
print(grouped_test1)

# creating a pivot table of means
grouped_pivot = grouped_test1.pivot(index='Status_democ', columns='Status_global_freedom')
print(grouped_pivot)

# filling missing cells in pivot with 0's
grouped_pivot = grouped_pivot.fillna(0)
print(grouped_pivot)



# creating subset
df_group_2 = df[['Status_democ', 'Status_global_freedom', 'humanFreedomIndex']]

# grouping by body style to determine price
df_group_2 = df_group_2.groupby(['Status_global_freedom'], as_index=False).mean()
print(df_group_2)

# Variables: global_freedom status and democracy_status vs human_freedom_index

# using the grouped results
plt.pcolor(grouped_pivot, cmap='RdBu')
plt.colorbar()
plt.show()

# now setting up intricacies of our plot
fig, ax = plt.subplots()
im = ax.pcolor(grouped_pivot, cmap='RdBu')

# label names
row_labels = grouped_pivot.columns.levels[1]
col_labels = grouped_pivot.index

# centering labels
ax.set_xticks(np.arange(grouped_pivot.shape[1]) + 0.5, minor=False)
ax.set_yticks(np.arange(grouped_pivot.shape[0]) + 0.5, minor=False)

# insert labels
ax.set_xticklabels(row_labels, minor=False)
ax.set_yticklabels(col_labels, minor=False)

# rotate label if too long
plt.xticks(rotation=90)

fig.colorbar(im)
plt.show()








# in order to display plot within window
# plt.show()
