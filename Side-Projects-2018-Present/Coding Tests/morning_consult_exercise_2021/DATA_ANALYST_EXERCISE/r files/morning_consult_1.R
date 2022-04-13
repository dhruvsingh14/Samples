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
favorability <- read.csv("part 1a) Individual Favorability Data.csv")

str(favorability) # checking data types

# dropping first few empty rows
favorability <- favorability[-c(1:3),]

# converting all columns to numeric
favorability <- sapply(favorability, as.numeric)
favorability <- as.data.frame(favorability)

# replacing na's with 0's
favorability[is.na(favorability)] <- 0

# calculating row totals  
favorability$row_totals <- rowSums(favorability[1:38])

# subsetting to rows containing data
favorability <- subset(favorability, favorability$row_totals != 0)
favorability <- favorability[-c(39)]

# writing out preliminary dataset
write.csv(favorability, "cleaned_data.csv")


############################
# PART I: Individuals Data #
############################

# creating copy of original dataframe
figure_approval <- favorability

#colnames(favorability)
#grep("indPresApp", colnames(favorability))

# restricting analysis to 17 individuals
figure_approval <- figure_approval[grep("indPresApp", colnames(figure_approval))]

rm(favorability) # dropping original dataframe

# creating calculated column for Mitch McConnell (Id 3_2)
column_names <- colnames(figure_approval)

figure_approval$ID3_2_category <- ""
for (i in 1:nrow(figure_approval)){
  if(figure_approval$indPresApp_ID3_2[i] == 1 | figure_approval$indPresApp_ID3_2[i] == 2){
    figure_approval$ID3_2_category[i] <- "favorable"
  } else if(figure_approval$indPresApp_ID3_2[i] == 3 | figure_approval$indPresApp_ID3_2[i] == 4) {
    figure_approval$ID3_2_category[i] <- "unfavorable"
  } else {
    figure_approval$ID3_2_category[i] <- "no opinion"
  }
}
 
x3$count <- 1

x4 <- aggregate(count ~ Mitch_McConnell, x3, FUN = sum)
colnames(x4) <- c("Rating", "Mitch_McConnell")

x5 <- aggregate(count ~ Paul_Ryan, x3, FUN = sum)
colnames(x5) <- c("Rating", "Paul_Ryan")

x6 <- merge(x4, x5, by = "Rating")

x_new <- spread




table(figure_approval$ID3_2_category)
table(figure_approval$ID3_2_category, figure_approval$indPresApp_ID3_2)

#####################################################################

# going rogue here again

#####################################################################
  
x3 <- figure_approval

colnames(x3) <- c("Mitch_McConnell", 
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



x_new <- x6

x_new <- gather(x_new, "Figures", "Frequency", 2:3)


x_new2 <- spread(x_new, Rating, Frequency)



# a.	Net favorability: % favorable (very favorable + somewhat favorable) minus % unfavorable (somewhat unfavorable + very unfavorable)
# b.	Favorability ratio: % favorable (either very favorable or somewhat favorable) divided by % unfavorable (either somewhat unfavorable or very unfavorable)
# c.	Total Favorability: % very favorable + % somewhat favorable


