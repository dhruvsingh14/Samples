############################################
# Housing_Income: Simple Linear Regression #
############################################

# importing libraries
import matplotlib.pyplot as plt
import pandas as pd
import pylab as pl
import numpy as np

##################
# Importing Data #
##################
'''
# opening housing, income csv file and reading it into a variable called df
df = pd.read_csv("housing_inc.csv")

# checking dataset head
print(df.head())

#####################
# Exploration Phase #
#####################

# summarizing
print(df.describe())


# drilling down on certain features
cdf = df[['YEAR', 'Home_Value', 'Adjusted_Gross_Income', 'Number_of_Returns',
          'Total_Txbl_Inc_Amt', 'Num_Ret_w_Deductions']]

print(cdf.head(9))

# other columns
# Total_Deductions_Amt
# Num_Ret_w_St_Loc_Txs
# Total_St_Loc_Txs_Amt
# Num_Ret_w_Ttl_Tx_Crdt
# Total_Ttl_Tx_Crdt_Amt


# plotting each of our features in a panel histogram
viz = cdf[['Home_Value', 'Adjusted_Gross_Income',
           'Number_of_Returns', 'Total_Txbl_Inc_Amt',
           'Num_Ret_w_Deductions']]
viz.hist()
plt.show()


# housing vs income, scatter
plt.scatter(cdf.Adjusted_Gross_Income, cdf.Home_Value, color='blue')
plt.xlabel("Adjusted Gross Income")
plt.ylabel("Home Value Index")
plt.show()


# housing prices vs tax filers, scatter
plt.scatter(cdf.Number_of_Returns, cdf.Home_Value, color='blue')
plt.xlabel("Number of Returns")
plt.ylabel("Home Value Index")
plt.show()

# creating a test - train split in data (80 - 20)
msk = np.random.rand(len(df)) < 0.8
train = cdf[msk]
test = cdf[~msk]


############################
# Simple Linear Regression #
############################

## plotting training data ~ same scatter plots repeated for training and test datasets

# housing vs income, scatter
plt.scatter(train.Adjusted_Gross_Income, train.Home_Value, color='blue')
plt.xlabel("Adjusted Gross Income")
plt.ylabel("Home Value Index")
plt.show()


# checking and replacing nan values
print(np.any(np.isnan(train)))
print(np.all(np.isfinite(train)))

def clean_dataset(df):
    assert isinstance(df, pd.DataFrame), "df needs to be a pd.DataFrame"
    df.dropna(inplace=True)
    indices_to_keep = ~df.isin([np.nan, np.inf, -np.inf]).any(1)
    return df[indices_to_keep].astype(np.float64)

clean_dataset(train)
train = train.reset_index()

# modeling using sklearn
from sklearn import linear_model
regr = linear_model.LinearRegression()
train_x = np.asanyarray(train[['Adjusted_Gross_Income']])
train_y = np.asanyarray(train[['Home_Value']])
regr.fit (train_x, train_y)

# The coefficients
print ('Coefficients: ', regr.coef_)
print ('Intercept: ', regr.intercept_)

# Plot outputs
# plotting fitted line over our data

# housing vs income, scatter, fitted line
plt.scatter(train.Adjusted_Gross_Income, train.Home_Value, color='blue')
plt.plot(train_x, regr.coef_[0][0]*train_x + regr.intercept_[0], '-r')
plt.xlabel("Adjusted Gross Income")
plt.ylabel("Home Value Index")
plt.show()



# preparing to evaluate our model for a good fit
from sklearn.metrics import r2_score

clean_dataset(test)
test = test.reset_index()

test_x = np.asanyarray(test[['Adjusted_Gross_Income']])
test_y = np.asanyarray(test[['Home_Value']])
test_y_hat = regr.predict(test_x)

print("Mean absolute error: %.2f" % np.mean(np.absolute(test_y_hat - test_y)))
print("Residual sum of squares (MSE): %.2f" % np.mean((test_y_hat - test_y) ** 2))
print("R2-score: %.2f" % r2_score(test_y_hat, test_y))
'''

##############################################
# Housing_Income: Multiple Linear Regression #
##############################################

# importing libraries
import matplotlib.pyplot as plt
import pandas as pd
import pylab as pl
import numpy as np

##################
# Importing Data #
##################

# opening text file and reading it into a variable called alice_novel
df = pd.read_csv("housing_inc.csv")

# checking dataset head
df.head()

#####################
# Exploration Phase #
#####################

# drilling down on certain features
cdf = df[['YEAR', 'Home_Value', 'Adjusted_Gross_Income', 'Number_of_Returns',
          'Total_Txbl_Inc_Amt', 'Num_Ret_w_Deductions', 'Num_Ret_w_Txbl_Inc']]
cdf.head(9)

# overall data: housing vs income, scatter

plt.scatter(cdf.Adjusted_Gross_Income, cdf.Home_Value, color='blue')
plt.xlabel("Adjusted_Gross_Income size")
plt.ylabel("Home_Value")
plt.show()


####################
# Test-train split #
####################

# creating a test - train split in data (80 - 20)
msk = np.random.rand(len(df)) < 0.8
train = cdf[msk]
test = cdf[~msk]

# dropping na's, can be a better way later
def clean_dataset(df):
    assert isinstance(df, pd.DataFrame), "df needs to be a pd.DataFrame"
    df.dropna(inplace=True)
    indices_to_keep = ~df.isin([np.nan, np.inf, -np.inf]).any(1)
    return df[indices_to_keep].astype(np.float64)

clean_dataset(train)
train = train.reset_index()

clean_dataset(test)
test = test.reset_index()

# plotting training data distribution
# training data: housing vs income, scatter
plt.scatter(train.Adjusted_Gross_Income, train.Home_Value, color = 'blue')
plt.xlabel("Adjusted_Gross_Income")
plt.ylabel("Home_Value")
plt.show()

#############################
# Multiple Regression Model #
#############################

# modeling using sklearn
from sklearn import linear_model
regr = linear_model.LinearRegression()
x = np.asanyarray(train[['Adjusted_Gross_Income', 'Number_of_Returns',
          'Total_Txbl_Inc_Amt', 'Num_Ret_w_Deductions', 'Num_Ret_w_Txbl_Inc']])
y = np.asanyarray(train[['Home_Value']])
regr.fit (x, y)

# The coefficients
print ('Coefficients: ', regr.coef_)

############################################
# Prediction: OLS (Ordinary Least Squares) #
############################################

y_hat = regr.predict(test[['Adjusted_Gross_Income', 'Number_of_Returns',
          'Total_Txbl_Inc_Amt', 'Num_Ret_w_Deductions', 'Num_Ret_w_Txbl_Inc']])
x = np.asanyarray(test[['Adjusted_Gross_Income', 'Number_of_Returns',
          'Total_Txbl_Inc_Amt', 'Num_Ret_w_Deductions', 'Num_Ret_w_Txbl_Inc']])
y = np.asanyarray(test[['Home_Value']])

print("Residual sum of squares (MSE): %.2f" % np.mean((y_hat - y) ** 2))

# explained variance score: where 1 represents perfect prediction
print('Variance score: %.2f' % regr.score(x, y))








































# in order to display plot within window
# plt.show()
