###################
# Part 1: Returns #
###################

# note the following is intended as a training
# and has borrowed generously from 365 careers' python for finance training
# the stocks picked here, while real, are not stocks that i hold
# and i am not liable for any investment decisions you make on your behalf.

#######################
# importing libraries #
#######################
import numpy as np
from pandas_datareader import data as wb
import matplotlib.pyplot as plt

#######################################
# importing stock data of choice: spy #
#######################################
SPY = wb.DataReader('SPY', data_source='yahoo', start='1995-1-1')
print(SPY.head())
print(SPY.tail())

#####################################
# calculating simple rate of return #
#####################################

# using adjusted closing price

#########
# daily #
#########

# adding calculated column

# shift function allows us to create a lag of 1
SPY['simple_return'] = (SPY['Adj Close'] / SPY['Adj Close'].shift(1)) - 1
# print:
SPY['simple_return']

###########################
# plotting daily change % #
###########################
SPY['simple_return'].plot(figsize=(8, 5))
plt.show()
# we see a sharp decline following 2008

# checking mean returns sometimes
avg_returns_d = SPY['simple_return']

# this includes non trading days
print(avg_returns_d)

##########
# Annual #
##########
# approximating to trading days ~ 250
avg_returns_a = SPY['simple_return'].mean() * 250
print(avg_returns_a)

# rounding and converting to a string percentage
print(str(round(avg_returns_a, 5) * 100) + ' %')

###############################
# Logarithmic rates of return #
###############################

print(SPY.head())

# calculating lagged log returns
SPY['log_return'] = np.log(SPY['Adj Close'] / SPY['Adj Close'].shift(1))
print(SPY['log_return'])

# plotting log returns data on a graph
SPY['log_return'].plot(figsize=(8, 5))
plt.show()

# mean log returns - daily
log_return_d = SPY['log_return'].mean()
print(log_return_d)

# mean log returns - annualized
log_return_a = SPY['log_return'].mean() * 250
print(log_return_a)

# rounding annualized figure
print(str(round(log_return_a * 100, 5)) + ' %')

#####################
# Portfolio Returns #
#####################

#######################
# importing libraries #
#######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
import matplotlib.pyplot as plt

######################################################
# importing stock data of choice: spy, qqq, voo, iwf #
######################################################
tickers = ['SPY', 'QQQ', 'VOO', 'IWF']

sec_data = pd.DataFrame()

# examining behavior over 2012 to present
for t in tickers:
    sec_data[t] = wb.DataReader(t, data_source='yahoo', start='2012-1-1')['Adj Close']

# print(sec_data.tail())

# storing logarithmic returns data in a new table
sec_returns = np.log(sec_data / sec_data.shift(1))
# print(sec_returns)

#######
# SPY #
#######
sec_returns['SPY'].mean()
# annualizing returns
sec_returns['SPY'].mean()*250

# checking standard deviation
sec_returns['SPY'].std()
# annualizing volatility
sec_returns['SPY'].std() * 250 ** 0.5

#######
# QQQ #
#######
sec_returns['QQQ'].mean()
# annualizing returns
sec_returns['QQQ'].mean()*250

# checking standard deviation
sec_returns['QQQ'].std()
# annualizing volatility
sec_returns['QQQ'].std() * 250 ** 0.5

#######
# VOO #
#######
sec_returns['VOO'].mean()
# annualizing returns
sec_returns['VOO'].mean()*250

# checking standard deviation
sec_returns['VOO'].std()
# annualizing volatility
sec_returns['VOO'].std() * 250 ** 0.5

#######
# IWF #
#######
sec_returns['IWF'].mean()
# annualizing returns
sec_returns['IWF'].mean()*250

# checking standard deviation
sec_returns['IWF'].std()
# annualizing volatility
sec_returns['IWF'].std() * 250 ** 0.5

################################
# mean - volatility comparison #
################################
# printing consecutive
sec_returns['SPY'].mean()*250
sec_returns['QQQ'].mean()*250
sec_returns['VOO'].mean()*250
sec_returns['IWF'].mean()*250

# printing returns together, adding extra bracket to increase dimension
print(sec_returns[['SPY', 'QQQ', 'VOO', 'IWF']].mean()*250)

# printing volatility together
print(sec_returns[['SPY', 'QQQ', 'VOO', 'IWF']].std()*250*0.5)

##########################
# Part 2: Portfolio Risk #
##########################

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
tickers = ['QQQ', 'VOO', 'SPY', 'IWF']

sec_data = pd.DataFrame()

# examining behavior 2012 onwards, since that's when voo begins
for t in tickers:
    sec_data[t] = wb.DataReader(t, data_source='yahoo', start='2012-1-1')['Adj Close']

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

#################
# VOO: Variance #
#################
VOO_var = sec_returns['VOO'].var()
VOO_var

# voo variance annualized
VOO_var_a = sec_returns['VOO'].var() *250
VOO_var_a

#################
# IWF: Variance #
#################
IWF_var = sec_returns['IWF'].var()
IWF_var

# iwf variance annualized
IWF_var_a = sec_returns['IWF'].var() *250
IWF_var_a

################
# COV: 4 funds #
################

# Covariance between 4 funds: Cov(SPY,QQQ,VOO,IWF)
cov_matrix = sec_returns.cov()
print(cov_matrix)

# covariance annualized
cov_matrix_a = sec_returns.cov() * 250
print(cov_matrix_a)

# Correlation between 4 stocks: Corr(SPY,QQQ,VOO,IWF)
# remember this is the correlation bw returns, not prices
# though returns is what we care most about
corr_matrix = sec_returns.corr()
print(corr_matrix)

###################################
# Portfolio Risk: 4 stock example #
###################################
# assigning current portfolio's weights
weights = np.array([0.25, 0.25, 0.25, 0.25]) # update weights as they vary

# calculating portfolio variance
pfolio_var = np.dot(weights.T, np.dot(sec_returns.cov() * 250, weights))
print(pfolio_var)

# checking portfolio's volatility
pfolio_vol = (np.dot(weights.T, np.dot(sec_returns.cov() * 250, weights))) ** 0.5
print(pfolio_vol)

# printing volatility as a percentage
print (str(round(pfolio_vol, 5) * 100) + ' %')

#####################################
# Part 3: Efficient Frontier, pt. i #
#####################################

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

# want weights, randomly assigned, that add to 1
weights = np.random.random(num_assets)
weights /= np.sum(weights)
print(weights)

# checking if summation adds to 1:
print(weights[0] + weights[1] + weights[2] + weights[3])

##############################
# Efficient Frontier, pt. ii #
##############################

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

# this prints a list of potential weights

###############################
# Efficient Frontier, pt. iii #
###############################

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

#######################
# simulated dataframe #
#######################
# assigning simulated weights to a dictionary
portfolios = pd.DataFrame({'Return': pfolio_returns, 'Volatility': pfolio_volatilities})

# printing dataframe head, and tail
print(portfolios.head())
print(portfolios.tail())


portfolios.plot(x='Volatility', y='Return', kind='scatter', figsize=(10,6));
plt.xlabel('Expected Volatility')
plt.ylabel('Expected Return')
plt.show()

#######################
# Part 4: Stock Betas #
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
tickers = ['SPY', 'QQQ', 'VOO', 'IWF']
data = pd.DataFrame()

# stock beta: variation of stock wrt to mkt, is calculated for 5 yrs at a time
# beta = cov (stock/mkt)/ var(mkt)
for t in tickers:
    data[t] = wb.DataReader(t, data_source='yahoo', start='2012-1-1', end='2019-12-31')['Adj Close']

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

###################################
# Part 5: Predicting Gross Profit #
###################################

#######################
# importing libraries #
#######################
import numpy as np
import matplotlib.pyplot as plt

#######################################
# simulation using last years revenue #
#######################################

# revenue and std dev as variables
rev_m = 170
rev_stdev = 20

# number of iterations
iterations =1000

# generating random normal distribution
rev = np.random.normal(rev_m, rev_stdev, iterations)
print(rev)
                       
# plotting our revenue simulations
plt.figure(figsize=(15,6))
plt.plot(rev)
plt.show()

#####################
# cogs calculations #
#####################

# since cogs is money spent, we make it a negative value
# setting roughly 60% of the revenue to cogs

COGS = - (rev * np.random.normal(0.6,0.1))

plt.figure(figsize=(15,6))
plt.plot(COGS)
plt.show()

print(COGS.mean())
print(COGS.std())

###################################
# Predicting Gross Profit, pt. ii #
###################################

# computing gross profit: revenue - cogs 
Gross_Profit = rev + COGS
Gross_Profit

plt.figure(figsize=(15,6))
plt.plot(Gross_Profit)
plt.show()

print(max(Gross_Profit))
print(min(Gross_Profit))

print(Gross_Profit.mean())
print(Gross_Profit.std())

# plotting the simulation, 1: with cuts 
plt.figure(figsize=(10,6));
plt.hist(Gross_Profit, bins = [40, 50, 60, 70, 90, 100, 110, 120]);
plt.show()

# plotting the simulation, 2: with bins assigned
plt.figure(figsize=(10,6));
plt.hist(Gross_Profit, bins = 20);
plt.show()


####################################
# Predicting Stock Prices, pt. iii #
####################################

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
data[ticker] = wb.DataReader(ticker, data_source='yahoo', start='2012-1-1')['Adj Close']

########################################
# Plotting Historical Data: Past 8 yrs #
########################################

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














