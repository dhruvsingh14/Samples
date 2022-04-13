###################################
# 3.1: Efficient Frontier: Part I #
###################################

#######################
# importing libraries #
#######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
import matplotlib.pyplot as plt

##################################
# importing stock data of choice #
##################################
assets = ['SPY', 'QQQ', 'VOO']

pf_data = pd.DataFrame()

# examining behavior over 8 years: '12 to present (voo only started in 2012,
                                            # can go further back if need be)
for a in assets:
    pf_data[a] = wb.DataReader(a, data_source='yahoo', start='2012-1-1')['Adj Close']

# printing closing prices
print(pf_data.tail())

# checking dimensions
print(pf_data.shape)

###################################
# plotting stock data: normalized #
###################################

# checking % gains from t = 0, here 2012 (normalizing data)
print(pf_data / pf_data.iloc[0] * 100)

# plotting % changes (normalizing data)
(pf_data / pf_data.iloc[0] * 100).plot(figsize=(10, 5))
plt.show()

###############
# log returns #
###############

# to obtain efficient frontier, will need log returns
log_returns = np.log(pf_data / pf_data.shift(1))

# avg log returns over 8 yrs
print(log_returns.mean() * 250)

# covariance matrix between log returns over 8 yrs
print(log_returns.cov() * 250)

# correlation matrix between log returns over 8 yrs
print(log_returns.corr())

######################
# generating weights #
######################

# storing number of assets in a variable
num_assets = len(assets)
print(num_assets)

# creating n random weights for n assets
# arr = np.random.random(3)
# print(arr)

# this following line of manual code may or may not add to 1
# arr[0] + arr[1] + arr[2]

# want weights, randomly assigned, that add to 1
weights = np.random.random(num_assets)
weights /= np.sum(weights)
print(weights)

# checking if summation adds to 1:
print(weights[0] + weights[1] + weights[2])

























# in order to display plot within window
# plt.show()
