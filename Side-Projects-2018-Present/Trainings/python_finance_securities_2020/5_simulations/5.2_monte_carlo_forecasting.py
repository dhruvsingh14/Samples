################################
# 5.2: Predicting Stock Prices #
################################

#######################
# importing libraries #
#######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
import matplotlib.pyplot as plt
from scipy.stats import norm

######################################
# Importing and Storing Stock Prices #
######################################
ticker = 'SPY'
data = pd.DataFrame()
data[ticker] = wb.DataReader(ticker, data_source='yahoo', start='2007-1-1')['Adj Close']

#########################################
# Plotting Historical Data: Past 10 yrs #
#########################################

# estimating historical log returns over past 10 yrs
log_returns = np.log(1 + data.pct_change())
print(log_returns.tail())

# plotting SPY's price, past 10 yrs
data.plot(figsize=(10,6));
plt.show()

# plotting log returns, past 10 yrs
log_returns.plot(figsize=(10,6));
plt.show()


#################################
# Preparing for Brownian Motion #
#################################

# calculating mean
u = log_returns.mean()
print(u)

# calculating variance
var = log_returns.var()
print(var)
# not annualizing, predicting daily instead

# calculating 'drift' from mean and var
drift = u - (0.5 * var)
print(drift)


# std dev for brownian motion
stdev = log_returns.std()
print(stdev)


###########################################
# Creating Random Simulated Matrix Arrays #
###########################################

# all withing 95% confidence interval
print(type(drift))
print(type(drift))

np.array(drift)

print(drift.values)
print(stdev.values)

# checking width in std devs. of 95% conf interval
norm.ppf(0.95)

# generating 10 x 2 matrix for arrays
x = np.random.rand(10, 2)
norm.ppf(x)

# matrix of values showing dist from mean
Z = norm.ppf(np.random.rand(10,2))
Z

# upcoming 1000 days
t_intervals = 1000

# 10 simulations
iterations = 10

# stock price prediction formula
daily_returns = np.exp(drift.values + stdev.values * norm.ppf(np.random.rand(t_intervals, iterations)))

# matrix containing daily returns
print(daily_returns)


##################################
# Predicting a Daily Stock Price #
##################################

# creating a price list, using 1st stock price
S0 = data.iloc[-1]
print(S0)

price_list = np.zeros_like(daily_returns)
print(price_list)

# replacing daily stock price - with zeros - then simulations

# simulating row 1
price_list[0] = S0
print(price_list)

# completing price list and verifying
for t in range(1, t_intervals):
    price_list[t] = price_list[t-1] * daily_returns[t]

print(price_list)

# plotting 10 simulations of SPY stock price
plt.figure(figsize=(10,6))
plt.plot(price_list);

plt.show()






































































# in order to display plot within window
# plt.show()
