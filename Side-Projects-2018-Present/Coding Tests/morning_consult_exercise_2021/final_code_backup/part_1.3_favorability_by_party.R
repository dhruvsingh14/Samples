###################################################
# Morning Consult Data Exercise 2020 Data Analyst #
###################################################

# install.packages('gridExtra', repos='http://cran.us.r-project.org')
library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)

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

# creating a subset for democrats
x_dem <- subset(x, x$demPidNoLn == 2 | x$demPidClos == 1)

#########################################
# PART I.3: Individuals Data: Democrats #
#########################################

# creating copy of original dataframe
x_indiv <- x_dem

#colnames(x_indiv)
#grep("indPresApp", colnames(x_indiv))

# restricting analysis to 17 individuals
x_indiv <- x_indiv[grep("indPresApp", colnames(x_indiv))]


#############################################
# Question 3: Individual Ratings: Democrats #
#############################################

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

# Total Favorability: % very favorable + % somewhat favorable
x_indiv_wide$`Total Favorability` <- ((x_indiv_wide$`Very Favorable`)*100/nrow(x_dem)) + ((x_indiv_wide$`Somewhat Favorable`)*100/nrow(x_dem))

############################################
# Question 3: Total Favorability Democrats #
############################################

# using original rating to calculate other categories of total favorability variable
total_fav <- x_indiv_wide

# Don't Approve: % very unfavorable + % somewhat unfavorable
total_fav$`Don't Approve` <- ((total_fav$`Somewhat Unfavorable`)*100/nrow(x_dem)) + ((total_fav$`Very Unfavorable`)*100/nrow(x_dem))

# Other
total_fav$`Other` <- ((total_fav$`Heard Of, No Opinion`)*100/nrow(x_dem)) + ((total_fav$`Never Heard Of`)*100/nrow(x_dem))

# renaming original total favorability column
names(total_fav)[names(total_fav) == "Total Favorability"] <- "Approve"

total_fav <- total_fav[c("Figures", "Approve", "Other", "Don't Approve")]

# gathering into long dataframe for plotting
total_fav <- gather(total_fav, "Position", "Rating", 2:ncol(total_fav))
total_fav <- total_fav[order(total_fav$Figures, total_fav$Position),]

# rounding decimal places for labeling
total_fav$Rating_lab <- format(round(total_fav$Rating, 0), nsmall = 0)

# plot 1: stacked bar, % of total

# converting Position to factor for ordering
total_fav$Position <- factor(total_fav$Position, levels = c("Don't Approve", "Other", "Approve"))

# horizontal
p_dem <- ggplot(total_fav, aes(x = Rating, y = Figures, fill = Position)) +
  geom_col(colour = "black") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_text(aes(x = Rating, label = paste0(Rating_lab, "%")), 
            position = position_stack(vjust = 0.5), 
            colour = "black", size = 2.5) +
  ggtitle("17 Key Political Figures' Favorability Among Democrats")

###############################################################################
###############################################################################

# creating a subset for republicans
x_rep <- subset(x, x$demPidNoLn == 1 | x$demPidClos == 2)

###########################################
# PART I.3: Individuals Data: Republicans #
###########################################

# creating copy of original dataframe
x_indiv <- x_rep

#colnames(x_indiv)
#grep("indPresApp", colnames(x_indiv))

# restricting analysis to 17 individuals
x_indiv <- x_indiv[grep("indPresApp", colnames(x_indiv))]


###############################################
# Question 3: Individual Ratings: Republicans #
###############################################

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

# Total Favorability: % very favorable + % somewhat favorable
x_indiv_wide$`Total Favorability` <- ((x_indiv_wide$`Very Favorable`)*100/nrow(x_rep)) + ((x_indiv_wide$`Somewhat Favorable`)*100/nrow(x_rep))

##############################################
# Question 3: Total Favorability Republicans #
##############################################

# using original rating to calculate other categories of total favorability variable
total_fav <- x_indiv_wide

# Don't Approve: % very unfavorable + % somewhat unfavorable
total_fav$`Don't Approve` <- ((total_fav$`Somewhat Unfavorable`)*100/nrow(x_rep)) + ((total_fav$`Very Unfavorable`)*100/nrow(x_rep))

# Other
total_fav$`Other` <- ((total_fav$`Heard Of, No Opinion`)*100/nrow(x_rep)) + ((total_fav$`Never Heard Of`)*100/nrow(x_rep))

# renaming original total favorability column
names(total_fav)[names(total_fav) == "Total Favorability"] <- "Approve"

total_fav <- total_fav[c("Figures", "Approve", "Other", "Don't Approve")]

# gathering into long dataframe for plotting
total_fav <- gather(total_fav, "Position", "Rating", 2:ncol(total_fav))
total_fav <- total_fav[order(total_fav$Figures, total_fav$Position),]

# rounding decimal places for labeling
total_fav$Rating_lab <- format(round(total_fav$Rating, 0), nsmall = 0)

# plot 1: stacked bar, % of total

# converting Position to factor for ordering
total_fav$Position <- factor(total_fav$Position, levels = c("Don't Approve", "Other", "Approve"))

# horizontal
p_rep <- ggplot(total_fav, aes(x = Rating, y = Figures, fill = Position)) +
  geom_col(colour = "black") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_text(aes(x = Rating, label = paste0(Rating_lab, "%")), 
            position = position_stack(vjust = 0.5), 
            colour = "black", size = 2.5) +
  ggtitle("17 Key Political Figures' Favorability Among Republicans ")


###############################################
# Combining Plots for Side-by-Side Comparison #
###############################################


grid.arrange(p_dem, p_rep, ncol = 1, nrow = 2)


