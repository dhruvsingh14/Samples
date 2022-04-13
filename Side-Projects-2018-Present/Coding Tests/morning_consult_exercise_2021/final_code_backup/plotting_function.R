#####################
# Plotting Function #
#####################

library(dplyr)
library(tidyr)
library(ggplot2)

# takes favorability data, containing voter ratings columns
# creates calculated variables, and returns graph

plotting <- function(fav_ratios, x_denom, title) {
  # Don't Approve: % very unfavorable + % somewhat unfavorable
  fav_ratios$`Don't Approve` <- ((fav_ratios$`Somewhat Unfavorable`)*100/nrow(x_denom)) + ((fav_ratios$`Very Unfavorable`)*100/nrow(x_denom))
  
  # Other
  fav_ratios$`Other` <- ((fav_ratios$`Heard Of, No Opinion`)*100/nrow(x_denom)) + ((fav_ratios$`Never Heard Of`)*100/nrow(x_denom))
  
  # renaming original total favorability column
  names(fav_ratios)[names(fav_ratios) == "Total Favorability"] <- "Approve"
  
  # subsetting to total favorability variable only
  fav_ratios <- fav_ratios[c("Figures", "Approve", "Other", "Don't Approve")]
  
  # gathering into long dataframe for plotting
  fav_ratios <- gather(fav_ratios, "Position", "Rating", 2:ncol(fav_ratios))
  fav_ratios <- fav_ratios[order(fav_ratios$Figures, fav_ratios$Position),]
  
  # rounding decimal places for labeling
  fav_ratios$Rating_lab <- format(round(fav_ratios$Rating, 0), nsmall = 0)
  
  # plot: stacked bar, % of total
  
  # converting Position to factor for ordering
  fav_ratios$Position <- factor(fav_ratios$Position, levels = c("Don't Approve", "Other", "Approve"))
  
  # horizontal
  p <- ggplot(fav_ratios, aes(x = Rating, y = Figures, fill = Position)) +
    geom_col(colour = "black") +
    scale_fill_brewer(palette = "Pastel1") +
    geom_text(aes(x = Rating, label = paste0(Rating_lab, "%")), 
              position = position_stack(vjust = 0.5), 
              colour = "black", size = 2.6) +
    ggtitle(title)
  
  return(p)  
}




