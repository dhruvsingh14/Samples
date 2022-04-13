####################################
# Variable Labels Stata 15 to .csv #
####################################
# initiating data converter
import pandas as pd
import csv

##########################################################
# reading in main dataset labels, and converting to csv #
##########################################################
itr = pd.read_stata(r'0_raw_data\main_dataset.dta', iterator=True)
itr.variable_labels()

print(type(itr))

#####################################################################
# reading in new observations dataset labels, and converting to csv #
#####################################################################
itr2 = pd.read_stata(r'0_raw_data\\new_observations.dta', iterator=True)
print(itr2.variable_labels())

print(type(itr2))
































# plt.show()
