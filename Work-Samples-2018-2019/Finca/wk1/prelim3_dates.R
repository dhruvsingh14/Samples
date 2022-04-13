getwd()

x <- read.csv('product_primary_data.csv')

#******** Working with Dates ********#

str(x)

subs <- x[c(grep('Application.Date', colnames(x)), grep('Product.Type', colnames(x)), grep('Branch.Name', colnames(x)), grep('Population', colnames(x)))]


D <- subs$Loan.Application.Date
D <- as.Date(D, "%d/%m/%Y")

# converting factor to date 
subs$Loan.Application.Date <- D


d <- as.character.Date(D)

subs$d <- d

spl <- strsplit(subs$d, "-")

# year var: char
year <- 0
for (i in 1:length(spl)) {
  year[i] <- spl[[i]][1]
}
subs$year <- year

# month var: char
month <- 0
for (i in 1:length(spl)) {
  month[i] <- spl[[i]][2]
}
subs$month <- month

# day var: char
day <- 0
for (i in 1:length(spl)) {
  day[i] <- spl[[i]][3]
}
subs$day <- day


subs$count <- 1



prods <- unique(subs$Product.Type)

prods <- as.character(prods)

subs$Product.Type <- as.character(subs$Product.Type)

prods2 <- subs$Product.Type
prods2 <- as.character(prods2)
subs$prods2 <- prods2

subs$prod1 <- 0
subs$prod2 <- NULL
subs$prod3 <- NULL
subs$prod4 <- NULL
subs$prod5 <- NULL
subs$prod6 <- NULL
subs$prod7 <- NULL
subs$prod8 <- NULL



rm(spl, subs, x, D, d, day, i, j, month, prods, prods2, year)


for (i in 1:nrow(agg)) {
  if(agg[i,11] == "Cook Stove"){
    agg$prod1[i] <- 1
  }
}

b <- as.character(agg$Branch.Name)

agg$b <- b

agg2 <- aggregate(count ~ b + year + Population..Branch.Sub.district.District.level., agg, FUN = sum) 

# I find that there aren't 7 years of data for every branch. Some are added after a year or two.

# 

agg2$tot_yr_pop <- 0

for (i in 1:nrow(agg2)) {
  if (agg2$year[i] == "2012"){
    agg2$tot_yr_pop[i] <- agg3[1,2]
  }
}

for (i in 1:nrow(agg2)) {
  if (agg2$year[i] == "2018"){
    agg2$tot_yr_pop[i] <- agg3[7,2]
  }
}



agg3 <- aggregate(Population..Branch.Sub.district.District.level. ~ year, agg2, FUN = sum)

# aggregated total populations for each time period




help(aggregate)

agg <- subs


