##########################
# 1.2: Portfolio Returns #
##########################

# can set stock ticker macros here
# objective: to decide on reliable etfs to invest in

#######################
# importing libraries #
#######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
import matplotlib.pyplot as plt

############################################
# importing stock data of choice: spy, qqq #
############################################
tickers = ['SPY', 'QQQ']

sec_data = pd.DataFrame()

# examining behavior over ten years '07 to '17
for t in tickers:
    sec_data[t] = wb.DataReader(t, data_source='yahoo', start='2007-1-1')['Adj Close']

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

################################
# mean - volatility comparison #
################################
# printing consecutive
sec_returns['SPY'].mean()*250
sec_returns['QQQ'].mean()*250

# printing returns together, adding extra bracket to increase dimension
print(sec_returns[['SPY', 'QQQ']].mean()*250)

# printing volatility together
print(sec_returns[['SPY', 'QQQ']].std()*250*0.5)














# in order to display plot within window
# plt.show()
