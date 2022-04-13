library(ggplot2)

# reading in data
x <- read.csv('product_primary_data.csv')

# renaming columns
names(x)
names(x) <- gsub("\\.", "", names(x))
names(x)[1] <- "PrimaryKey"


# plotting frequencies of sales by area, unit = branch, and unit = product

p1 <- ggplot(data = x, aes(BranchName)) + geom_histogram(stat = "count")
p2 <- ggplot(data = x, aes(ProductType)) + geom_histogram(stat = "count") 

## cook stove is clearly the highest seller, followed by solar light

p3 <- ggplot(data = x, aes(ProductType)) + geom_histogram(stat = "count") + facet_wrap(~ManufacturerName)


# basic stats: 250,000 observation dataset

# manufacturer stats
unique(x$ManufacturerName) # 6 distinct manufacturers, though duplication returns 12

# area stats
unique(x$BranchName) # roughly 190 unique branches
unique(x$CircleName) # roughly 1,700 unique circles
unique(x$Village) # roughly 12,500 unique villages

# populations 
unique(x$PopulationBranchSubdistrictDistrictlevel) # roughly 150 unique populations
# using excel sort: kumble-kasargud is max 1.3 m, and kittur is min: 1,600
summary(x$PopulationBranchSubdistrictDistrictlevel) 
# plotting product demands by most and least populous areas
p4 <- ggplot(data = subset(x, BranchName == "Kittur"), aes(ProductType)) + geom_histogram(stat = "count")
p5 <- ggplot(data = subset(x, BranchName == "Kumble-Kasargud"), aes(ProductType)) + geom_histogram(stat = "count") #subset didn't seem to have any effect
p6 <- ggplot(data = subset(x, BranchName == "Kittur" | BranchName == "Kumble-Kasargud"), aes(ProductType)) + 
  geom_histogram(stat = "count") + facet_wrap(~BranchName, ncol = 1)

# poverty rates 
unique(x$PovertyDistrictlevel) # roughly 25 districts
# using excel sort: virajpet is least poor 1.5%, and challakere is most: 46.7%
summary(x$PovertyDistrictlevel) 
# plotting product demands by most and least populous areas
p7 <- ggplot(data = subset(x, BranchName == "Virajpet" | BranchName == "Challakere"), aes(ProductType)) + 
  geom_histogram(stat = "count") + facet_wrap(~BranchName)


# officer stats
unique(x$FieldOfficerName) # approx 2,300 


# dates/duration
unique(x$LoanApplicationDate) # roughly 2000 


