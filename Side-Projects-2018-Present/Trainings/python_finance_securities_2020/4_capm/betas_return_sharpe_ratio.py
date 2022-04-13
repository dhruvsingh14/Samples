#####################
# 5.1: Stock Beta's #
#####################

######################
# importing libraries #
######################
import numpy as np
import pandas as pd
from pandas_datareader import data as wb
import matplotlib.pyplot as plt

############################################
# importing stock data of choice: spy, qqq #
############################################
tickers = ['QQQ', 'VOO', 'SPY']

sec_data = pd.DataFrame()

# examining behavior over ten years '07 to '17
for t in tickers:
    sec_data[t] = wb.DataReader(t, data_source='yahoo', start='2007-1-1')['Adj Close']


















# in order to display plot within window
# plt.show()
