#####################
# setting directory #
#####################

getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/1_Post 11_blueprint/data/County Transportation Profiles")

###############################
# creating Aggregated dataset #
###############################

# reading in
bts_data <- read.csv("County_Transportation_Profiles.csv", header = TRUE, fill = FALSE)
  
# replacing na with 0s
bts_data[is.na(bts_data)] = 0
  
# aggregating
agg_data <- aggregate(.~State.Name, bts_data, FUN = mean)

#######################
# writing out dataset #
#######################

write.csv(agg_data, "BTS_data.csv")
