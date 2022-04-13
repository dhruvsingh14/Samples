library(ggplot2)
library(dplyr)

getwd()


#******** Missing Values ********#

x <- read.csv('product_primary_data.csv')

# missing values
summary(is.na(x))
table(is.na(x)) #4,000 missing values out of 6.7 million cells

dx <- NULL
for (i in 1:ncol(x)) {
  dx[i] <- table(is.na(x[i]))
}
print(dx < 237738)
table(is.na(x$Address.Location)) # roughyly 4,000 missing adresses 


#******** Loan Application Date ********#

# x <- read.csv('product_primary_data.csv')

# working with Dates
str(x)
D <- x$Loan.Application.Date
D <- as.Date(D, "%d/%m/%Y")

# converting factor to date 
x$loan.app.date <- D

p1 <- ggplot(x, aes(loan.app.date, Product.Type)) + geom_line()

summary(x$loan.app.date) # duration/span: August, 2012 -- September, 2018.

# this gives total sales
qplot(x = loan.app.date, data = x, binwidth = 10) # here's a plot of all observations, by app date
                                                  # given 1 obs -> 1 inst, this is total install trend
# sales by product type
qplot(x = loan.app.date, data = x, binwidth = 10, color = Product.Type)

# here's differential trends in product sales over time
qplot(x = loan.app.date, data = x, binwidth = 10, 
      geom = "freqpoly", color = Product.Type)



#******** Population Variation ********#

x <- read.csv('product_primary_data.csv')

str(x)

branchpopulation <- as.character(x$Population..Branch.Sub.district.District.level.)
x$branchpopulation <- branchpopulation

pop_groups <- group_by(x, branchpopulation)


x.salesbyage <- summarise(pop_groups,
                          sales_mean = mean(count(Product.Type)),
                          n = n())

pf.fc_by_age <- arrange(pf.fc_by_age, age)

head(pf.fc_by_age)

x$count <- 1


agg <- x[c(26,29,30)]
agg <- aggregate(. ~ branchpopulation + Population..Branch.Sub.district.District.level., agg, FUN = sum)


