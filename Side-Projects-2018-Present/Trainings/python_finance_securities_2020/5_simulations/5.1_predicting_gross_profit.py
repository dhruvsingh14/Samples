################################
# 5.1: Predicting Gross Profit #
################################

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
rev
                       
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

COGS.mean()
COGS.std()

########################################
# 5.1: Predicting Gross Profit, pt. II #
########################################

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











































































# in order to display plot within window
# plt.show()
