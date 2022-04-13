#######################
# 2.1: Portfolio Risk #
#######################

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
tickers = ['QQQ', 'VOO', 'SPY']

sec_data = pd.DataFrame()

# examining behavior over ten years '07 to '17
for t in tickers:
    sec_data[t] = wb.DataReader(t, data_source='yahoo', start='2007-1-1')['Adj Close']


# storing logarithmic returns data in a new table
sec_returns = np.log(sec_data / sec_data.shift(1))

#################
# SPY: Variance #
#################
SPY_var = sec_returns['SPY'].var()
SPY_var

# spy variance annualized
SPY_var_a = sec_returns['SPY'].var() *250
SPY_var_a

#################
# QQQ: Variance #
#################
QQQ_var = sec_returns['QQQ'].var()
QQQ_var

# qqq variance annualized
QQQ_var_a = sec_returns['QQQ'].var() *250
QQQ_var_a


# Covariance between 2 stocks: Cov(SPY,QQQ)
cov_matrix = sec_returns.cov()
cov_matrix

# covariance annualized
cov_matrix_a = sec_returns.cov() * 250
cov_matrix_a


# Correlation between 2 stocks: Corr(SPY,QQQ)
# remember this is the correlation bw returns, not prices
# though returns is what we care most about
corr_matrix = sec_returns.corr()
print(corr_matrix)

###################################
# Portfolio Risk: 3 stock example #
###################################
# assigning current portfolio's weights
weights = np.array([0.36, 0.31, 0.30]) # update weights as they vary

# calculating portfolio variance
pfolio_var = np.dot(weights.T, np.dot(sec_returns.cov() * 250, weights))
print(pfolio_var)

# checking portfolio's volatility
pfolio_vol = (np.dot(weights.T, np.dot(sec_returns.cov() * 250, weights))) ** 0.5
print(pfolio_vol)

# printing volatility as a percentage
print (str(round(pfolio_vol, 5) * 100) + ' %')
















# in order to display plot within window
# plt.show()
