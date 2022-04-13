#####################
# 4.1: Stock Beta's #
#####################

#######################
# importing libraries #
#######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
# import matplotlib.pyplot as plt

##################################
# importing stock data of choice #
##################################
tickers = ['SPY', 'QQQ', 'VOO', 'IWF']
data = pd.DataFrame()

# stock beta: variation of stock wrt to mkt, is calculated for 5 yrs at a time
# beta = cov (stock/mkt)/ var(mkt)
for t in tickers:
    data[t] = wb.DataReader(t, data_source='yahoo', start='2015-1-1', end='2019-12-31')['Adj Close']

###############
# sec returns #
###############
sec_returns = np.log(data / data.shift(1))

######################
# covariance of data #
######################
cov = sec_returns.cov() * 250
print(cov)

# pulling cov wrt mkt for qqq
cov_with_market = cov.iloc[0,1]
print(cov_with_market)

market_var = sec_returns['QQQ'].var() * 250
print(market_var)

#################
# beta of stock #
#################
# stock beta measures volatility
qqq_beta = cov_with_market / market_var
print(qqq_beta)

##########################
# stock: expected return #
##########################
# using 5% as a value for risk premium for stock
qqq_er = 0.025 + qqq_beta * 0.05
print(qqq_er)

# returned value is roi for given stock


##########################
# obtaining Sharpe ratio #
##########################

# subtracting 10 year government bonds from numerator
# denominator = annualized std deviation of stock
Sharpe = (qqq_er - 0.025) / (sec_returns['QQQ'].std() * 250 ** 0.5)
print(Sharpe)

# sharpe ratio of qqq is roughly 21%




























































# in order to display plot within window
# plt.show()
