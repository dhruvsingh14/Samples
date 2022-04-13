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
df_ins.set_index('Race', inplace=True)
df_ins.head()

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
import matplotlib.patches as mpatches # required for waffle charts

mpl.style.use('ggplot')

# print('Matplotlib version: ', mpl.__version__) # >= 3.1.3

#################
# Waffle Charts #
#################

# creating a new dataframe comrpising of nordic countries
df_wbh = df_ins.loc[['White', 'Black', 'Hispanic'], :]
df_wbh

#computing proportion of values to the whole
df_wbh = df_wbh[df_wbh["Coverage"] == "Not.covered"]

total_values = sum(df_wbh['Total'])
category_proportions = [(float(value) / total_values) for value in df_wbh['Total']]

# printing these proportions for each value of total yearly coverage
# relative to total coverage for race in usa

for i, proportion in enumerate(category_proportions):
    print (df_wbh.index.values[i] + ': ' + str(proportion))


# preparing to define the dimensions of our chart
width = 40 # width of chart
height = 10 # height of chart
total_num_tiles = width * height # total number of tiles in grid
# print ('Total number of tiles is ', total_num_tiles)

# computing tiles per category ((country+year total)/country total)
tiles_per_category = [round(proportion * total_num_tiles) for proportion in category_proportions]

# printing out our number of tiles per category

for i, tiles in enumerate(tiles_per_category):
    print (df_wbh.index.values[i] + ': ' + str(tiles))


# declaring empty matrix to prepare for waffle chart
waffle_chart = np.zeros((height, width))

# defining indices to loop through
category_index = 0
tile_index = 0

# populating the waffle chart
for col in range(width):
    for row in range(height):
        tile_index += 1

        # if the number for current category is equal to corresponding tiles..
        if tile_index > sum(tiles_per_category[0:category_index]):
            # .. proceed to next
            category_index += 1

        # setting class value to an integer
        waffle_chart[row, col] = category_index

# print ('Waffle chart populated!')
waffle_chart

# preparing to map waffle to a visual

fig = plt.figure()

# using matshow to display the waffle chart
colormap = plt.cm.coolwarm
plt.matshow(waffle_chart, cmap=colormap)
plt.colorbar()

plt.show()






