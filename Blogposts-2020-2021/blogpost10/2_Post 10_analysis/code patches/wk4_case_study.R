getwd()

# packageVersion("swirl")

library(swirl)

# install_from_swirl("Exploratory Data Analysis")

swirl()

#########################################
#   exploratory data analysis week 4    #
#########################################

#############################
#   lesson 1: case study    #
#############################

#  checking dim for particulate matter 1999 data
dim(pm0)
head(pm0)

# checking column names variable
cnames 

# reassigning col names to remove pipe ('|') delimiter
cnames <- strsplit(cnames, '|', fixed = TRUE)
cnames

# converting subset of columns to 'syntactically valid names'
names(pm0) <- make.names(cnames[[1]][wcol])
head(pm0)

# assigning 1999 particulate measures to its own var
x0 <- pm0$Sample.Value

# checking length and missing values of var
str(x0)
mean(is.na(x0)) # calculates no. of true missing vals out of total boolean returned
# approx 11.3% missing values

# processing 2012 data
names(pm1) <- make.names(cnames[[1]][wcol])
dim(pm1)

# assigning 2012 particulate measures to its own var
x1 <- pm1$Sample.Value
mean(is.na(x1))
# approx 5.6% missing values

# checking summaries
summary(x0)
summary(x1)
# mean and median have declined over time
# so have most other measures, except max

# plotting ranges
boxplot(x0, x1) # appear flatened due to to spread of outliers
boxplot(log10(x0), log10(x1)) # logged values are more readable

# addressing negative values in x1
negative <- x1 < 0 
sum(negative, na.rm = TRUE) # 26474 negative values, after removing missing vals

# checking percentage of negative values
mean(negative, na.rm = TRUE) # roughly 2% of all x1, can be ignored

# checking for patterns in negative vals
dates <- pm1$Date
str(dates)

# reformatting dates var
dates <- as.Date(as.character(dates), "%Y%m%d")
head(dates) # much better formatted!

# plotting histogram of dates by month
hist(dates[negative], "month") # negative measurements may be errors

# switching focus to New York State subset
# checking NY monitor 1999
str(site0) # form : countycode.monitorid

# creating intersection vector to see active monitors across 1999 and 2012
both <- intersect(site0, site1)
both

head(pm0)

# subsetting to acive monitors
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both) 
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both) 

sapply(split(cnt0, cnt0$county.site), nrow) # splitting cnt0 into several data frames
sapply(split(cnt1, cnt1$county.site), nrow) # splitting cnt1 into several data frames

pm0sub <- subset(cnt0, County.Code == 63 & Site.ID == 2008) # examining monitor w/ high freq numbers
pm1sub <- subset(cnt1, County.Code == 63 & Site.ID == 2008) # examining monitor w/ high freq numbers

x0sub <- pm0sub$Sample.Value # focusing on pm25 measurements
x1sub <- pm1sub$Sample.Value # focusing on pm25 measurements

dates0 <- as.Date(as.character(pm0sub$Date), "%Y%m%d") # creating dates for time series plotting
dates1 <- as.Date(as.character(pm1sub$Date), "%Y%m%d") # creating dates for time series plotting

par(mfrow = c(1, 2), mar = c(4, 4, 2, 1)) #setting panel

plot(dates0, x0sub, pch = 20) # plot1 particulate matter over time
abline(h = median(x0sub, na.rm = TRUE), lwd = 2) # median particulate matter recorded

plot(dates1, x1sub, pch = 20) # plot2 particulate matter over time
abline(h = median(x1sub, na.rm = TRUE), lwd = 2) # median particulate matter recorded

rng <- range(x0sub, x1sub, na.rm = TRUE) # aligning range of both our plots
rng

mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = TRUE)) # summarizing state means
str(mn0)

mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE)) # summarizing state means
str(mn1)

summary(mn0)
summary(mn1)

d0 <- data.frame(state = names(mn0), mean = mn0) # creating columns of dataframe
d1 <- data.frame(state = names(mn1), mean = mn1) # creating columns of dataframe

mrg <- merge(d0, d1, by = "state") # merging strings

dim(mrg)
head(mrg)

with(mrg, plot(rep(1, 52), mrg[,2], xlim = c(.5, 2.5))) # base plotting 
with(mrg, points(rep(2, 52), mrg[,3])) # adding to base plot

segments(rep(1, 52), mrg[,2], rep(2, 52), mrg[,3]) # trend plot using two points in time and mapping indiv obs

mrg[mrg$mean.x < mrg$mean.y, ] # checking subset where pollution increased 






