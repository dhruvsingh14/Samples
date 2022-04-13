# libraries
library(tidyr)
library(dplyr)

# directories
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/2_August/wk2_post5/1_Post 4_blueprint/data")

###############
## IRS DATA  ##
###############

setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/2_August/wk2_post5/1_Post 4_blueprint/data/IRS")

# 2011
x1 <- read.csv("2011_IRS_noagi.csv")

# 2012
x2 <- read.csv("2012_IRS_noagi.csv")
x2$YEAR <- 2012
x2 <- x2[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]

# 2013
x3 <- read.csv("2013_IRS_noagi.csv")
x3$YEAR <- 2013
x3 <- x3[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]

# 2014
x4 <- read.csv("2014_IRS_noagi.csv")
x4$YEAR <- 2014
x4 <- x4[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]

# 2014
x4 <- read.csv("2014_IRS_noagi.csv")
x4$YEAR <- 2014
x4 <- x4[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]

# 2015
x5 <- read.csv("2015_IRS_noagi.csv")
x5$YEAR <- 2015
x5 <- x5[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]


# 2016
x6 <- read.csv("2016_IRS_noagi.csv")
x6$YEAR <- 2016
x6 <- x6[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]


# 2017
x7 <- read.csv("2017_IRS_noagi.csv")
x7$YEAR <- 2017
x7 <- x7[c("YEAR", "STATE", "ZIPCODE", "N1", "MARS2",	"A00100", "N04470",	"A04470", "N18425", "A18425",
           "N04800", "A04800", "N07100", "A07100")]


x_comb <- rbind(x1, x2, x3, x4, x5, x6, x7)

rm(x1, x2, x3, x4, x5, x6, x7)

##################
## Zillow DATA  ##
##################
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/2_August/wk2_post5/1_Post 4_blueprint/data/Zillow")
z <- read.csv("Zip_code_Zillow.csv")
z2 <- gather(z, yr_mo, housing_prices,  X1.31.1996:X6.30.2020)

z2$yr_mo <- gsub("X", "", z2$yr_mo)  
z2$yr_mo <- gsub(" ", "", z2$yr_mo)  

# parsing year, using nchar, for string lengths
z2$YEAR <- substr(z2$yr_mo, nchar(z2$yr_mo)-3, nchar(z2$yr_mo))
unique(z2$YEAR)
z2$YEAR <- as.numeric(z2$YEAR)


##########################
## Income Housing DATA  ##
##########################
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/2_August/wk2_post5/1_Post 4_blueprint/data")

housing_inc <- merge(z2, x_comb, by = c("YEAR", "ZIPCODE"))


# combined data

write.csv(housing_inc, "housing_income_data.csv")


