###############################
# India Innovation: July 2020 #
###############################
# importing libraries
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd

################################
# Importing Innovation Dataset #
################################
# reading in, printing
df_inov = pd.read_csv("India_Combined_InnovationDataset.csv")
print(df_inov.head())

######################
# Data Preprocessing #
######################

# code for listing all variables:
# <insert here>

# returns types of columns and indices
print(type(df_inov.columns))
print(type(df_inov.index))

# printing out dimensions
print(df_inov.shape)

#####################
# Plot1: Employment #
#####################

# keeping select columns, and years from 1991 - present
df_emp = df_inov[['year', 'emp_agriculture_perc', 'emp_industry_perc', 'emp_services_perc']]
df_emp = df_emp[(df_emp['year'] > 1991) & (df_emp['year'] < 2018)]

# setting index to be the year
df_emp.set_index('year', inplace=True)
print(df_emp.head())

# changing index to integer for plotting
df_emp.index = df_emp.index.map(int)

# overlayed area plot
'''
df_emp.plot(kind='area',
            stacked=False,
            figsize=(20, 10), # tells what size to adjust window to
            )
plt.title('Employment Trends by Sector')
plt.ylabel('% of Workforce')
plt.xlabel('Years')
plt.show()
'''

################
# Plot2.1: GDP #
################
# printing options out
plt.style.available

# ggplot library within python
mpl.style.use(['ggplot'])

# selecting india's gdp data
df_gdp = df_inov[['year', 'GDP_current_USD', 'agriculture_perc_GDP', 'industry_perc_GDP', 'services_perc_GDP']]
df_gdp = df_gdp[df_gdp['year'] <= 2019]
print(df_gdp.head())

# setting index to be the year
df_gdp.set_index('year', inplace=True)
print(df_gdp.head())

# converting index to integer
df_gdp.index = df_gdp.index.map(int)

# plotting GDP trends over the years
'''
df_gdp['GDP_current_USD'].plot(kind='line')

plt.title('Indian GDP: 1960 - Present')
plt.ylabel('GDP in Current USD')
plt.xlabel('Years')
plt.text(1990, 3.28e+11, 'Trade Liberalization')

plt.show()
'''

##########################
# Plot2.2: GDP by Sector #
##########################
# gdp by sector
df_gdp = df_gdp.drop(['GDP_current_USD'], axis=1)

# Plotting GDP Trends by Sector: Lineplot
'''
df_gdp.plot(kind='line')
plt.title('% GDP Contribution by Sector')
plt.ylabel('% of GDP')
plt.xlabel('Years')
plt.show()
'''

# Plotting GDP Trends by Sector: Areaplot, overlayed
# using alpha transparency value=.45, and scripting layer instead of obj. or. layer
'''
df_gdp.plot(kind='area',
            alpha=0.45, # 0-1 scale, default a= 0.5
            stacked=False, # overlays plots
            figsize=(20, 10), # tells what size to adjust window to
            )
plt.title('% GDP Contribution by Sector')
plt.ylabel('% GDP')
plt.xlabel('Years')
plt.show()
'''

#########################
# Plot3: Patent Numbers #
#########################
# selecting india's patent data
df_pat = df_inov[['year', 'patent_applications']]
df_pat = df_pat[(df_pat['year'] >= 1980) & (df_pat['year'] <= 2018)]
print(df_pat.head())

# setting index to be the year
df_pat.set_index('year', inplace=True)
print(df_pat.head())

# converting index to integer
df_pat.index = df_pat.index.map(int)

# plotting bar chat of patent applications
df_pat.plot(kind='bar', figsize=(10, 6),
            color='mediumseagreen', rot=90)
plt.xlabel('Year')
plt.ylabel('Number of Patents')
plt.title('Patent Trends in India from 1983 - Present')
# using arrow annotation
plt.annotate('', # blank, no text here
             xy=(38, 16250), # places head of arrow here
             xytext=(20, 2220), # places base of arrow here
             xycoords='data',
             arrowprops=dict(arrowstyle='->', connectionstyle='arc3', color='blue', lw=2)
)
# using text annotation
plt.annotate('2000 - 2020 Innovation Boom', # text to display
             xy=(28, 30), # starts text here
             rotation=55.5, # matches arrow head, using trial and error
             va='bottom', # text vertically bottom aligned
             ha='left', # text vertically left aligned
             )
plt.show()

#############################
# Plot4: Business Formation #
#############################
# selecting india's business formation data
df_bus = df_inov[['year', 'businesses_registered_number']]
df_bus = df_bus[(df_bus['year'] >= 2006) & (df_bus['year'] <= 2018)]
print(df_bus.head())

# setting index to be the year
df_bus.set_index('year', inplace=True)
#print(df_bus.head())

# converting index to integer
df_bus.index = df_bus.index.map(int)

# plotting horizontal plot with barh
df_bus.plot(kind='barh', figsize=(10, 10), color='coral')

plt.xlabel('Business Formation')
plt.ylabel('Year')
plt.title('Number of Businesses Registered from 2006 - Present')

plt.show()

#######################################
# Plot5: Ease of Doing Business Index #
#######################################
# selecting india's business formation data
df_ebi = df_inov[['year', 'doing_business_index']]
df_ebi = df_ebi[(df_ebi['year'] >= 2006) & (df_ebi['year'] <= 2020)]
print(df_ebi.head())

# setting index to be the year
df_ebi.set_index('year', inplace=True)
#print(df_bus.head())

# converting index to integer
df_ebi.index = df_ebi.index.map(int)

# plotting horizontal plot with barh
df_ebi.plot(kind='barh', figsize=(10, 10), color='darkslateblue')

plt.xlabel('Rankings')
plt.ylabel('Year')
plt.title('India Ease of Doing Business Index Rankings from 2006 - Present')

plt.show()



















# in order to display plot within window
# plt.show()
