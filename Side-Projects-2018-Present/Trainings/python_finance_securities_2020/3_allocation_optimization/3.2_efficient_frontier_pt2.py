####################################
# 3.2: Efficient Frontier: Part II #
####################################

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
assets = ['SPY', 'QQQ', 'VOO', 'IWF']

pf_data = pd.DataFrame()

# examining behavior over 8 years: '12 to present (voo only started in 2012,
                                            # can go further back if need be)
for a in assets:
    pf_data[a] = wb.DataReader(a, data_source='yahoo', start='2012-1-1')['Adj Close']

###############
# log returns #
###############

# to obtain efficient frontier, will need log returns
log_returns = np.log(pf_data / pf_data.shift(1))

######################
# generating weights #
######################

# storing number of assets in a variable
num_assets = len(assets)

# want weights, randomly assigned, that add to 1
weights = np.random.random(num_assets)
weights /= np.sum(weights)

#############################
# expected portfolio return #
#############################
print(np.sum(weights * log_returns.mean() * 250))

###############################
# expected portfolio variance #
###############################
print(np.dot(weights.T, np.dot(log_returns.cov() * 250, weights)))

#################################
# expected portfolio volatility #
#################################
print(np.sqrt(np.dot(weights.T, np.dot(log_returns.cov() * 250, weights))))

######################
# simulating weights #
######################

pfolio_returns = []
pfolio_volatilities = []

# simulating weights
for x in range (1000):
    weights = np.random.random(num_assets)
    weights /= np.sum(weights)
    # append method helps generate and store simulations
    pfolio_returns.append(np.sum(weights * log_returns.mean()) * 250)
    pfolio_volatilities.append(np.sqrt(np.dot(weights.T, np.dot(log_returns.cov() * 250, weights))))

# converting weights generated to a numpy array
pfolio_returns = np.array(pfolio_returns)
pfolio_volatilities = np.array(pfolio_volatilities)

print(pfolio_returns, pfolio_volatilities)

















# in order to display plot within window
# plt.show()
