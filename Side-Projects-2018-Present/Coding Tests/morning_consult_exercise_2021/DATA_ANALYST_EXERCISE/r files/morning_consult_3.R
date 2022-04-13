###################################################
# Morning Consult Data Exercise 2020 Data Analyst #
###################################################

# install.packages('dplyr', repos='http://cran.us.r-project.org')
# install.packages('tidyr', repos='http://cran.us.r-project.org')

library(dplyr)
library(tidyr)
library(ggplot2)

# setting directory
getwd()
setwd("C:/Dhruv/Applying/3_interviewing/2021/4_April/wk1/Morning Consult/Assessment/DATA_ANALYST_EXERCISE")

# reading in data
x <- read.csv("part 1a) Individual Favorability Data.csv")

str(x) # checking data types

# dropping first few empty rows
x <- x[-c(1:3),]

# converting all columns to numeric
x <- sapply(x, as.numeric)
x <- as.data.frame(x)

# replacing na's with 0's
x[is.na(x)] <- 0

# calculating row totals  
x$row_totals <- rowSums(x[1:38])

# subsetting to rows containing data
x <- subset(x, x$row_totals != 0)
x <- x[-c(39)]

# writing out preliminary dataset
# write.csv(x, "cleaned_data.csv")

############################
# PART I: Individuals Data #
############################

# creating copy of original dataframe
x_indiv <- x

#colnames(x_indiv)
#grep("indPresApp", colnames(x_indiv))

# restricting analysis to 17 individuals
x_indiv <- x_indiv[grep("indPresApp", colnames(x_indiv))]


##################################
# Question 1: Individual Ratings #
##################################

# renaming columns to reflect figure names

colnames(x_indiv) <- c("Mitch_McConnell", 
                  "Paul_Ryan", 
                  "Nancy_Pelosi", 
                  "Charles_Schumer", 
                  "Mike_Pence", 
                  "Donald_Trump", 
                  "Republicans_in_Congress", 
                  "Democrats_in_Congress", 
                  "Melania_Trump", 
                  "Ivanka_Trump", 
                  "Jared_Kushner", 
                  "Steve_Bannon", 
                  "Hope_Hicks", 
                  "Gary_Cohn", 
                  "Kellyanne_Conway", 
                  "Jeff_Sessions", 
                  "Robert_Mueller" 
)

# storing column names to iterate over
column_names <- colnames(x_indiv)

# adding column to aggregate frequency by category
x_indiv$Frequency <- 1

# creating empty dataframe
df <- as.data.frame(c(1:6))
colnames(df) <- "Rating"

# creating combined frequency table for all 17 figures
for (i in 1:length(column_names)){
  df_fig <- aggregate(Frequency ~ ., x_indiv[c("Frequency", column_names[i])], FUN = sum)
  colnames(df_fig) <- c("Rating", column_names[i])
  df <- merge(df, df_fig)
}

# formatting data for analysis
x_indiv_long <- gather(df, "Figures", "Frequency", 2:ncol(df))
x_indiv_wide <- spread(x_indiv_long, Rating, Frequency)

# dropping all dataframes, except original and wide
rm(x_indiv, x_indiv_long, df, df_fig)


# renaming columns
colnames(x_indiv_wide) <- c("Figures",
                            "Very Favorable", 
                            "Somewhat Favorable", 
                            "Somewhat Unfavorable", 
                            "Very Unfavorable", 
                            "Heard Of, No Opinion", 
                            "Never Heard Of")

# a.	Net Favorability: % favorable (very favorable + somewhat favorable) minus % unfavorable (somewhat unfavorable + very unfavorable)
x_indiv_wide$`Net Favorability` <- ((x_indiv_wide$`Very Favorable` + x_indiv_wide$`Somewhat Favorable`)/nrow(x)) - ((x_indiv_wide$`Somewhat Unfavorable` + x_indiv_wide$`Very Unfavorable`)/nrow(x))

# b.	Favorability ratio: % favorable (either very favorable or somewhat favorable) divided by % unfavorable (either somewhat unfavorable or very unfavorable)
x_indiv_wide$`Favorability Ratio` <- (x_indiv_wide$`Very Favorable` + x_indiv_wide$`Somewhat Favorable`)/(x_indiv_wide$`Somewhat Unfavorable` + x_indiv_wide$`Very Unfavorable`)

# c.	Total Favorability: % very favorable + % somewhat favorable
x_indiv_wide$`Total Favorability` <- x_indiv_wide$`Very Favorable`/nrow(x) + x_indiv_wide$`Somewhat Favorable`/nrow(x)

fav_ratios <- x_indiv_wide[-c(2:7)]

# exporting csv
write.csv(x_indiv_wide, "Favorability_Ratios.csv")


##################################
# Question 2: Total Favorability #
##################################




