####################################
# Data Converter: Stata 15 to .csv #
####################################
# libraries
import pandas as pd

##################################################
# reading in main dataset, and converting to csv #
##################################################
df = pd.read_stata('0_raw_data\main_dataset.dta')

print(df.head())
print(df.shape)

df.to_csv('1_converted_data\main_dataset.csv', index=False)

##########################################################
# reading in new observation data, and converting to csv #
##########################################################
df2 = pd.read_stata('0_raw_data\\new_observations.dta')

print(df2.head())
print(df2.shape)

df2.to_csv('1_converted_data\\new_observations.csv', index=False)



































# plt.show()
