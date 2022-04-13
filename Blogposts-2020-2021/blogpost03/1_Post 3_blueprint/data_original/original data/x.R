# directory
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/July/wk4_post3/2_Post 3_analysis/data")

# data
x <- read.csv('EdStatsData_orig.csv')

# nulls
x[is.na(x)] <- 0

# empty rows
x$rowtotals <- rowSums(x[,5:69])

# countries of choice
unique(x$Country.Code)

######################
# subset - countries #
######################

x2 <- subset(x, (x$Country.Code == 'CHN')|(x$Country.Code == 'IND')|(x$Country.Code == 'USA'))
x2 <- subset(x, x$rowtotals!=0)

# data for analysis
write.csv(x2, "EdStatsData2.csv")

# subsetting country data frames 
chn <- subset(x2, x2$Country.Code == 'CHN')
ind <- subset(x2, x2$Country.Code == 'IND')
usa <- subset(x2, x2$Country.Code == 'USA')

# dropping earlier datasets
rm(x, x2)

###########
# varlist #
###########
mrg <- merge(chn, ind, by = "Indicator.Name")
mrg2 <- merge(mrg, usa, by = "Indicator.Name")

# saving intersecting variables
varlist <- mrg2[c(1)]

rm(chn, ind, usa, mrg, mrg2)

# common variable list
write.csv(varlist, "varlist.csv")
rm(varlist)

####################
# subset - columns #
####################

relev_vars <- read.csv('varlist_relevant.csv')
data <- read.csv('EdStatsData2_cleaned.csv')


varlist_subset_mrg <- merge(data, relev_vars, by="Indicator.Name")
write.csv(varlist_subset_mrg, 'final_data.csv')

