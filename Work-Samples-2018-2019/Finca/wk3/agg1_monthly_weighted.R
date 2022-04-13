getwd()

x <- read.csv('product_primary_data.csv')

# working with primary data to obtain regional aggregates (by branch) in given time frame (monthly)

str(x)

# subsetting main data to include: branch/area, time frame variables, products, pricing, population, poverty rates


subs <- x[c(grep('Branch.Name', colnames(x)), grep('Application.Date', colnames(x)), grep('Installed.Date', colnames(x)), grep('Product.Type', colnames(x)), 
            grep('Loan.Amount', colnames(x)), grep('Population', colnames(x)), grep('Poverty', colnames(x)))]

# renaming columns
colnames(subs) <- c("branch", "Applied", "Installed", "Product", "Price", "Population", "Poverty")

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


rm(D1, D2, d1, d2)

# year var: char
year <- 0
for (i in 1:length(spl1)) {
  year[i] <- spl1[[i]][1]
}
subs$yr_applied <- year

# month var: char
month <- 0
for (i in 1:length(spl1)) {
  month[i] <- spl1[[i]][2]
}
subs$mo_applied <- month


# creating a count for each purchase
subs$count <- 1


#converting product to char, for operators
subs$Product <- as.character(subs$Product)

unique(subs$Product)


# dropping 3 low count products
subs <- subset(subs, subs$Product != "Cook Stove GSSV3" & subs$Product != "Pyro Stoves" & subs$Product != "Solar Water Heater")


# substituting spaces in string
subs$Product <- gsub(" ", "", subs$Product)


# combining two solar light types

for (i in 1:nrow(subs)){
  if (subs$Product[i] == "SolarLightSelco"){
    subs$Product[i] <- "SolarLight"
  }
}

# now down to 4 product types
unique(subs$Product)


# aggregating by month
monthly_panel <- aggregate(count ~ branch + yr_applied + mo_applied + Product + Price + Population + Poverty,  subs, FUN = sum)

m_p <- aggregate(. ~ branch + yr_applied + mo_applied + Product + Population + Poverty,  monthly_panel, FUN = mean)

m_p$loan_per_branch <- m_p$Price * m_p$count
m_p$agg_date <- paste0(m_p$yr_applied, '-', m_p$mo_applied, '-', '01')


summary(subs$Population)

m_p$pop_wt <- 0

total.pop <- sum(unique(m_p$Population))

m_p$pop_wt <- m_p$Population/total.pop
m_p$pop_wt <- m_p$pop_wt*100

m_p$weighted_loans_byBranchProd <- m_p$loan_per_branch*m_p$pop_wt
m_p$weighted_count_byBranchProd <- m_p$count*m_p$pop_wt

rm(spl1, x, subs)

write.csv(m_p, 'monthly_products.csv')