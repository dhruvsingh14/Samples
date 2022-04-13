#####################
# setting directory #
#####################

getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/1_Post 11_blueprint/data/FARS")


########################################
# Finding Relevant Columns to Merge On #
########################################

# checking for commonalities between 2018 and 1975 data
# 2018
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/1_Post 11_blueprint/data/FARS/2018")
data_2018 <- read.csv("ACCIDENT.csv")
colnames_2018 <- as.data.frame(colnames(data_2018))
names(colnames_2018)[1] <- "column_names"

# 1975
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/1_Post 11_blueprint/data/FARS/1975")
data_1975 <- read.csv("ACCIDENT.csv")
colnames_1975 <- as.data.frame(colnames(data_1975))
names(colnames_1975)[1] <- "column_names"

# merge
colnames_common <- merge(colnames_1975, colnames_2018, by = "column_names")

rm(data_1975, data_2018, colnames_1975, colnames_2018)





####################
# creating dataset #
####################

# Null Dataset
df <- data.frame(matrix(ncol = 29, nrow = 0))

# Macro looping through 1975 to 2018 datasets
for (year in 1975:2018){
  
  # directory
  setwd(paste0("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/1_Post 11_blueprint/data/FARS/", as.character(year)))

  # dataset_a, reading in
  fars_data <- read.csv("ACCIDENT.csv", header = TRUE, fill = FALSE)
  
  # subsetting to relevant columns
  fars_data <- fars_data[c("ARR_HOUR", "ARR_MIN", "CF1", "CF2", "CF3", "CITY", "COUNTY", "DAY", "DAY_WEEK", "DRUNK_DR", 
                           "FATALS", "HARM_EV", "HOUR", "LGT_COND", "MAN_COLL", "MINUTE", "MONTH", "NOT_HOUR", "NOT_MIN", 
                           "PERSONS", "RAIL", "REL_ROAD", "SCH_BUS", "SP_JUR", "ST_CASE", "STATE", "VE_FORMS", "WEATHER", 
                           "YEAR")]
  
  # replacing na with 0s
  fars_data[is.na(fars_data)] = 0
  
  # aggregating
  agg_data <- aggregate(.~YEAR+STATE, fars_data, FUN = mean)
  
  # appending
  df = rbind(df, agg_data)
    
  # printing progress
  print(as.character(year))
}

#######################
# writing out dataset #
#######################

write.csv(df, "C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/1_Post 11_blueprint/data/FARS/FARS_data.csv")
