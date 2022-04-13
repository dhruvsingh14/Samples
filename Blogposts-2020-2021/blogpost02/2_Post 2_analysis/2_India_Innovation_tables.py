###############################
# India Innovation: July 2020 #
###############################
# importing libraries
import numpy as np
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

#######################
# Table1: Correlation #
#######################



######################
# Table2: Regression #
######################














# in order to display plot within window
# plt.show()
