########################
# Aggregating Function #
########################

library(dplyr)
library(tidyr)
library(ggplot2)

aggregator <- function(x) {
  
  # restricting analysis to 17 individuals
  x <- x[grep("indPresApp", colnames(x))]
  
  # renaming columns to reflect figure names
  
  colnames(x) <- c("Mitch McConnell",
                   "Paul Ryan", 
                   "Nancy Pelosi", 
                   "Charles Schumer", 
                   "Mike Pence", 
                   "Donald Trump", 
                   "Republicans in Congress", 
                   "Democrats in Congress", 
                   "Melania Trump", 
                   "Ivanka Trump", 
                   "Jared Kushner", 
                   "Steve Bannon", 
                   "Hope Hicks", 
                   "Gary Cohn", 
                   "Kellyanne Conway", 
                   "Jeff Sessions", 
                   "Robert Mueller" 
  )
  
  # storing column names to iterate over
  column_names <- colnames(x)
  
  # adding column to aggregate frequency by category
  x$Frequency <- 1
  
  # creating empty dataframe
  df <- as.data.frame(c(1:6))
  colnames(df) <- "Rating"
  
  # creating combined frequency table for all 17 figures
  for (i in 1:length(column_names)){
    df_fig <- aggregate(Frequency ~ ., x[c("Frequency", column_names[i])], FUN = sum)
    colnames(df_fig) <- c("Rating", column_names[i])
    df <- merge(df, df_fig)
  }
  
  # formatting data for analysis
  x_long <- gather(df, "Figures", "Frequency", 2:ncol(df))
  x_wide <- spread(x_long, Rating, Frequency)
  
  # renaming columns
  colnames(x_wide) <- c("Figures",
                        "Very Favorable", 
                        "Somewhat Favorable", 
                        "Somewhat Unfavorable", 
                        "Very Unfavorable", 
                        "Heard Of, No Opinion", 
                        "Never Heard Of")
  
  # a.	Net Favorability: % favorable (very favorable + somewhat favorable) minus % unfavorable (somewhat unfavorable + very unfavorable)
  x_wide$`Net Favorability` <- ((x_wide$`Very Favorable` + x_wide$`Somewhat Favorable`)*100/nrow(x)) - ((x_wide$`Somewhat Unfavorable` + x_wide$`Very Unfavorable`)*100/nrow(x))
  
  # b.	Favorability ratio: % favorable (either very favorable or somewhat favorable) divided by % unfavorable (either somewhat unfavorable or very unfavorable)
  x_wide$`Favorability Ratio` <- (x_wide$`Very Favorable` + x_wide$`Somewhat Favorable`)/(x_wide$`Somewhat Unfavorable` + x_wide$`Very Unfavorable`)
  
  # c.	Total Favorability: % very favorable + % somewhat favorable
  x_wide$`Total Favorability` <- ((x_wide$`Very Favorable`)*100/nrow(x)) + ((x_wide$`Somewhat Favorable`)*100/nrow(x))

  return(x_wide)  
}




