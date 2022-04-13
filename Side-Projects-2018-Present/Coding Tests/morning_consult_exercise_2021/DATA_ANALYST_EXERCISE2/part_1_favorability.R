###################################################
# Morning Consult Data Exercise 2020 Data Analyst #
###################################################

library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)

# setting directory
getwd()
setwd("C:/Dhruv/Applying/3_interviewing/2021/4_April/wk1/Morning Consult/Assessment/DATA_ANALYST_EXERCISE2")

# reading in data
df <- read.csv("instructions/part 1a) Individual Favorability Data.csv")
str(df) # checking data types

#################
# Cleaning Data #
#################

# dropping first few empty rows
df <- df[-c(1:3),]

# converting all columns to numeric
df <- sapply(df, as.numeric)
df <- as.data.frame(df)

# replacing na's with 0's
df[is.na(df)] <- 0

# calculating row totals  
df$row_totals <- rowSums(df[1:38])

# subsetting to rows containing data
df <- subset(df, df$row_totals != 0)
df <- df[-c(39)]

############################
# PART I: Individuals Data #
############################

# copying cleaned dataframe
x <- df

##################################
# Question 1: Individual Ratings #
##################################

# calling function aggregate
source('aggregator_function.R')
fav_ratios <- aggregator(x)

# subsetting for export
fav_ratios_w <- fav_ratios[c("Figures", "Net Favorability", "Favorability Ratio", "Total Favorability")]

# rounding to two decimal places for export
fav_ratios_w$`Net Favorability` <- format(round(fav_ratios_w$`Net Favorability`, 3), nsmall = 3)
fav_ratios_w$`Favorability Ratio` <- format(round(fav_ratios_w$`Favorability Ratio`, 3), nsmall = 3)
fav_ratios_w$`Total Favorability` <- format(round(fav_ratios_w$`Total Favorability`, 3), nsmall = 3)

# exporting csv
write.csv(fav_ratios_w, "Favorability_Ratios.csv", row.names = F)
rm(fav_ratios_w)

##################################
# Question 2: Total Favorability #
##################################

# calling plotting function
source('plotting_function.R')

title = "Total Favorability Ratings for 17 Key Political Figures"
p1 <- plotting(fav_ratios, x_denom = x, title)

# saving out plot
p1

rm(x, fav_ratios, title, p1)

#################################################
# Question 3: Total Favorability by Affiliation #
#################################################

#####################
# Republican Voters #
#####################

# creating a subset for republicans
x_rep <- subset(df, df$demPidNoLn == 1 | df$demPidClos == 2)

# creating favorability ratios for republican voters
fav_ratios_rep <- aggregator(x_rep)

# plotting ratings for republican voters
title = "17 Key Political Figures' Favorability Among Republicans"
p_rep <- plotting(fav_ratios_rep, x_denom = x_rep, title)

# saving out combined plot
p_rep
rm(x_rep, fav_ratios_rep, title)

###################
# Democrat Voters #
###################

# creating a subset for democrats
x_dem <- subset(df, df$demPidNoLn == 2 | df$demPidClos == 1)

# creating favorability ratios for democratic voters
fav_ratios_dem <- aggregator(x_dem)

# plotting ratings for democrat voters
title = "17 Key Political Figures' Favorability Among Democrats"
p_dem <- plotting(fav_ratios_dem, x_denom = x_dem, title)

p_dem
rm(x_dem, fav_ratios_dem, title)

# saving out combined plot
grid.arrange(p_rep, p_dem, ncol = 1, nrow = 2)

rm(p_rep, p_dem)