library(ggplot2)
getwd()

x <- read.csv('product_primary_data.csv')

#******** Population Weighted Averages ********#

str(x)

# subsetting main data to include: branch/area, time frame variables, products, pricing, population, poverty rates


subs <- x[c(grep('Branch.Name', colnames(x)), grep('Application.Date', colnames(x)), grep('Installed.Date', colnames(x)), grep('Product.Type', colnames(x)), 
            grep('Loan.Amount', colnames(x)), grep('Population', colnames(x)), grep('Poverty', colnames(x)))]

# renaming columns
colnames(subs) <- c("Branch", "Applied", "Installed", "Product", "Price", "Population", "Poverty")

D1 <- subs$Applied
D1 <- as.Date(D1, "%d/%m/%Y")
# converting factor to date 
subs$Applied <- D1

D2 <- subs$Installed
D2 <- as.Date(D2, "%d/%m/%Y")
# converting factor to date 
subs$Installed <- D2

# splitting string dates
d1 <- as.character.Date(D1)
d2 <- as.character.Date(D2)

# split date is list of lists
spl1 <- strsplit(d1, "-")
  
  #spl2 <- strsplit(d2, "-")

rm(D1, D2, d1, d2)

# year var: char
year1 <- 0
for (i in 1:length(spl1)) {
  year1[i] <- spl1[[i]][1]
}
subs$yr_applied <- year1


# creating a count for each purchase
subs$count <- 1


yrly_panel <- aggregate(count ~ Branch + yr_applied + Product + Price + Population + Poverty,  subs, FUN = sum)

# fit <- lm(count ~ Branch + yr_applied + Product + Price + Population + Poverty, yrly_panel)
# summary(fit)
# plot(fit)
# 
# 
# fit3 <- lm(count ~ Product + Poverty, yrly_panel)
# summary(fit3)
# plot(fit3)
# 
# 
# write.csv(yrly_panel, file = "yearly_panel.csv", row.names = FALSE)



#******   Creating Some more Plots to grain clearer picture   ******#


p1 <- ggplot(x = yr_applied, data = yrly_panel, binwidth = 10) + geom_bar() + facet_wrap(~Product)

p1 <- ggplot(data=yrly_panel, aes(x=yr_applied, y= count), binwidth = 10) +
  geom_bar(stat="identity")  + facet_wrap(~Product)

p2 <- ggplot(data=yrly_panel, aes(x=yr_applied, y= Poverty), binwidth = 10) +
  geom_bar(stat="identity")  + facet_wrap(~Product)

p3 <- ggplot(data=yrly_panel, aes(x=yr_applied, y= count), binwidth = 10) +
  geom_bar(stat="identity")  + facet_wrap(~yr_applied)

