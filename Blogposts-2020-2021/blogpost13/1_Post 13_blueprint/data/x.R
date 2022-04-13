# Libraries
library(tidyr)

# Directory
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/4_October/wk2_post13/1_Post 13_blueprint/data")

# Datasets
healthcare_use <- read.csv("healthcare_use.csv")
healthcare_use <- healthcare_use[c("Variable", "Measure", "Country", "Year", "Value")]
healthcare_use$Variable <- as.character(healthcare_use$Variable)
healthcare_use$Country <- as.character(healthcare_use$Country)
healthcare_use$Measure <- as.character(healthcare_use$Measure)
healthcare_use <- spread(healthcare_use, Variable, Value)
healthcare_use[is.na(healthcare_use)] <- 0


health_resources <- read.csv("health_resources.csv")
health_resources <- health_resources[c("Variable", "Measure", "Country", "Year", "Value")]
health_resources$Variable <- as.character(health_resources$Variable)
health_resources$Country <- as.character(health_resources$Country)
health_resources$Measure <- as.character(health_resources$Measure)
health_resources <- spread(health_resources, Variable, Value)
health_resources[is.na(health_resources)] <- 0


merged_df <- merge(health_resources, healthcare_use, by = c("Country", "Year"), all = FALSE)

write.csv(merged_df, "merged_dataset.csv")




