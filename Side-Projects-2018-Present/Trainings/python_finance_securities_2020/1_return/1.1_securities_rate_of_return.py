####################################
# 1.1.: Securities Rates of Return #
####################################

# can set macros here
# objective: to decide on reliable etfs to invest in

#######################
# importing libraries #
#######################
import numpy as np
from pandas_datareader import data as wb
import matplotlib.pyplot as plt

#######################################
# importing stock data of choice: s&p #
#######################################
SPY = wb.DataReader('SPY', data_source='yahoo', start='1995-1-1')
SPY.head()
#print(SPY.tail())
# data has been corroborated

#####################################
# calculating simple rate of return #
#####################################
# using adjusted closing price

#########
# daily #
#########
# adding calculated column

# .shift function allows us to create a lag of 1
SPY['simple_return'] = (SPY['Adj Close'] / SPY['Adj Close'].shift(1)) - 1
#print:
SPY['simple_return']

###########################
# plotting daily change % #
###########################
SPY['simple_return'].plot(figsize=(8, 5))
#plt.show()
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
# plt.show()

# mean log returns - daily
log_return_d = SPY['log_return'].mean()
print(log_return_d)

# mean log returns - annualized
log_return_a = SPY['log_return'].mean() * 250
print(log_return_a)

# rounding annualized figure
print(str(round(log_return_a * 100, 5)) + ' %')

################################
# bonus: tracking index ticker #
################################




























# in order to display plot within window
# plt.show()
