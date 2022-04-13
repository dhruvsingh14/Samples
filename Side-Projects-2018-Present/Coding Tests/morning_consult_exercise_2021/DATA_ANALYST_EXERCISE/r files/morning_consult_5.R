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
x_indiv_wide$`Net Favorability` <- ((x_indiv_wide$`Very Favorable` + x_indiv_wide$`Somewhat Favorable`)*100/nrow(x)) - ((x_indiv_wide$`Somewhat Unfavorable` + x_indiv_wide$`Very Unfavorable`)*100/nrow(x))

# b.	Favorability ratio: % favorable (either very favorable or somewhat favorable) divided by % unfavorable (either somewhat unfavorable or very unfavorable)
x_indiv_wide$`Favorability Ratio` <- (x_indiv_wide$`Very Favorable` + x_indiv_wide$`Somewhat Favorable`)/(x_indiv_wide$`Somewhat Unfavorable` + x_indiv_wide$`Very Unfavorable`)

# c.	Total Favorability: % very favorable + % somewhat favorable
x_indiv_wide$`Total Favorability` <- ((x_indiv_wide$`Very Favorable`)*100/nrow(x)) + ((x_indiv_wide$`Somewhat Favorable`)*100/nrow(x))

# subsetting for export
fav_ratios <- x_indiv_wide[c("Figures", "Net Favorability", "Favorability Ratio", "Total Favorability")]

# rounding to two decimal places for export
fav_ratios$`Net Favorability` <- format(round(fav_ratios$`Net Favorability`, 3), nsmall = 3)
fav_ratios$`Favorability Ratio` <- format(round(fav_ratios$`Favorability Ratio`, 3), nsmall = 3)
fav_ratios$`Total Favorability` <- format(round(fav_ratios$`Total Favorability`, 3), nsmall = 3)

# exporting csv
write.csv(fav_ratios, "Favorability_Ratios.csv", row.names = F)
rm(fav_ratios)

##################################
# Question 2: Total Favorability #
##################################

# using original rating to calculate other categories of total favorability variable
total_fav <- x_indiv_wide

# Don't Approve: % very unfavorable + % somewhat unfavorable
total_fav$`Don't Approve` <- ((total_fav$`Somewhat Unfavorable`)*100/nrow(x)) + ((total_fav$`Very Unfavorable`)*100/nrow(x))

# Other
total_fav$`Other` <- ((total_fav$`Heard Of, No Opinion`)*100/nrow(x)) + ((total_fav$`Never Heard Of`)*100/nrow(x))

# renaming original total favorability column
names(total_fav)[names(total_fav) == "Total Favorability"] <- "Approve"

total_fav <- total_fav[c("Figures", "Approve", "Other", "Don't Approve")]

# gathering into long dataframe for plotting
total_fav <- gather(total_fav, "Position", "Rating", 2:ncol(total_fav))
total_fav <- total_fav[order(total_fav$Figures, total_fav$Position),]

# rounding decimal places for labeling
total_fav$Rating_lab <- format(round(total_fav$Rating, 0), nsmall = 0)

# plot 1: stacked bar, % of total
total_fav$Position <- factor(total_fav$Position, levels = c("Don't Approve", "Other", "Approve"))

ggplot(total_fav, aes(x = Figures, y = Rating, fill = Position)) +
  geom_col()

# Plot 2: horizontal bar plot
ggplot(total_fav, aes(x = Rating, y = Figures, fill = Position)) +
  geom_col(colour = "black") +
  scale_fill_brewer(palette = "Pastel1")

# Plot 3: horizontal bar plot with labels
ggplot(total_fav, aes(x = Rating, y = Figures, fill = Position)) +
  geom_col(colour = "black") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_text(aes(x = Rating, label = paste0(Rating_lab, "%")), position = position_stack(vjust = 0.5), colour = "black") +
  ggtitle("Total Favorability Ratings for 17 Key Political Figures")


