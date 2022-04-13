#######################################
# 5.3.1: Black Scholes Option Pricing #
#######################################

#######################
# importing libraries #
#######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
from scipy.stats import norm

######################################
# Computing Functions: For Intervals #
######################################
def d1(S, K, r, stdev, T):
    return (np.log(S / K) + (r + stdev ** 2 / 2) * T) / (stdev * np.sqrt(T))

def d2(S, K, r, stdev, T):
    return (np.log(S / K) + (r - stdev ** 2 / 2) * T) / (stdev * np.sqrt(T))

# using cumulative distribution function for Black Scholes

# tells how much of data lies below stated percentile, assuming normal distribution
print(norm.cdf(0))

print(norm.cdf(0.25))

print(norm.cdf(0.75))

print(norm.cdf(9))

####################################################
# Applying Interpolations to Compute Stock Pricing #
####################################################
# variables used for computation:

# current stock price, strike price,
# risk free rate, standard deviation,
# and time horizon in years
def BSM(S, K, r, stdev, T):
    return (S * norm.cdf(d1(S, K, r, stdev, T)))- (K * np.exp(-r * T) * norm.cdf(d2(S, K, r, stdev, T)))

ticker = 'SPY'

# assigning SPY stock price to a data frame
data = pd.DataFrame()
data[ticker] = wb.DataReader(ticker, data_source='yahoo', start='2007-1-1', end='2020-12-24')['Adj Close']

# extracting data
S = data.iloc[-1]
print(S)

# calculating log returns
log_returns = np.log(1 + data.pct_change())

# storing standard deviation of stock price
stdev = log_returns.std() * 250 ** 0.5
print(stdev)

# Calculate the Price of a Call Option
r = 0.025 # risk free rate, for 10 year treasury bond
K = 350.0 # assumed strike price
T = 1 # 1 year

# using formula
print(d1(S, K, r, stdev, T))

print(d2(S, K, r, stdev, T))

print(BSM(S, K, r, stdev, T))

# call option price is roughly 30 dollars

###############################
# 5.3.2: Euler discretization #
###############################
import numpy as np
import pandas as pd
from pandas_datareader import data as web
from scipy.stats import norm
import matplotlib.pyplot as plt

# pulling adjusted closing prices
ticker = 'SPY'
data = pd.DataFrame()
data[ticker] = web.DataReader(ticker, data_source='yahoo', start='2007-1-1', end='2020-12-24')['Adj Close']

# calculating log returns
log_returns = np.log(1 + data.pct_change())

# assigning variables for formula
r = 0.025 # risk free rate
stdev = log_returns.std() * 250 ** 0.5
print(stdev)

# checking data type is series
print(type(stdev))

# converting stdev to array
stdev = stdev.values
print(stdev)

# forecasting a year ahead
T = 1
t_intervals = 250
delta_t = T / t_intervals # scaling stock data timeframe
iterations = 10000

# random component
Z = np.random.standard_normal((t_intervals + 1, iterations)) # dimensions of matrix
S = np.zeros_like(Z)
S0 = data.iloc[-1]
S[0] = S0 # S is the price list

# loop to create iterations
for t in range(1, t_intervals + 1):
    S[t] = S[t-1] * np.exp((r - 0.5 * stdev ** 2) * delta_t + stdev * delta_t ** 0.5 * Z[t])

print(S)
print(S.shape) # 251 time intervals by 10000 simulations

# plotting
plt.figure(figsize=(10,6))
plt.plot(S[:,:10]); # plotting time intervals horizontally
plt.show() # display plot for first 10 simulations

#######################################
# 5.3.3: Euler discretization, Pt. II #
#######################################
# ensuring stock price is greater than strike price
p = np.maximum(S[-1] - 350, 0) # array of stock - strike difference
print(p)

print(p.shape) # same length as S matrix

# calculating price of the call option
C = np.exp(-r * T) * np.sum(p) / iterations
print(C) # price of the call option, using method 2







































# in order to display plot within window
# plt.show()
