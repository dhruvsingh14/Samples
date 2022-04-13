# directory
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/July/wk4_post3/2_Post 3_analysis/data")

####################
# subset - columns #
####################

edu_data <- read.csv('1_EdStatsData.csv')
relev_vars <- read.csv('2_varlist_relevant_selected.csv')


final_subset <- merge(edu_data, relev_vars, by="Indicator.Name")

write.csv(final_subset, '3_final_subset.csv')

