#############
# libraries #
#############
# install.packages('usmap', repos='http://cran.us.r-project.org')
library(ggplot2)
library(usmap)

#####################
# setting directory #
#####################
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk4_post11/2_Post 11_analysis")

########################################
# reading in dataset 1: Fed Auto Sales #
########################################
# source: bea
fed_auto_sales <- read.csv("AUTO_SALES.csv")

fed_auto_sales$DATE <- as.character(fed_auto_sales$DATE)
fed_auto_sales$DATE <- as.Date(fed_auto_sales$DATE, "%m/%d/%Y")

# stick to linear trends here. add color if anything
x_data <- subset(fed_auto_sales, TotalVehicleSales>0)

# total vehicle sales
ggplot(x_data, aes(x=DATE)) + 
  geom_line(aes(y = TotalVehicleSales), color = "darkred") + 
  geom_line(aes(y = LightWeightVehicleSales.AutosandLightTrucks), color="steelblue", linetype="twodash") 

ggplot(data = x_data, aes(x=x_data$DATE, y=x_data$TotalVehicleSales)) + geom_line()

# normalizing Light weight vehicles data
x_data$LightWeightVehicleSales = (x_data$LightWeightVehicleSales - mean(x_data$LightWeightVehicleSales))/(mean(x_data$LightWeightVehicleSales))
x_data$MotorVehicleRetailSales.LightWeightTrucks = (x_data$MotorVehicleRetailSales.LightWeightTrucks - mean(x_data$MotorVehicleRetailSales.LightWeightTrucks))/(mean(x_data$MotorVehicleRetailSales.LightWeightTrucks))

ggplot(x_data, aes(x=DATE)) + 
  geom_line(aes(y = LightWeightVehicleSales), color = "darkred") + 
  geom_line(aes(y = MotorVehicleRetailSales.LightWeightTrucks), color="steelblue", linetype="twodash") 

####################################
# reading in dataset 2: Crash Data #
####################################

fars_data <- read.csv("FARS_data.csv")

for (i in 1: nrow(fars_data)){
  if (fars_data$YEAR[i] < 1998){
    fars_data$YEAR[i] = 1900 + fars_data$YEAR[i] 
  }
}

fars_agg <- aggregate(.~YEAR, fars_data, FUN = mean)

ggplot(data = fars_agg, aes(x=YEAR, y=FATALS)) + geom_line()


######################################
# reading in dataset 3: Commute Data #
######################################
bts_data <- read.csv("BTS_data.csv")

names(bts_data)[12] <- "transit"
names(bts_data)[15] <- "coummute_out_of_county"
names(bts_data)[16] <- "coummute_within_county"

# Basic barplot
p<-ggplot(data=bts_data, aes(x=State.FIPS, y=coummute_out_of_county)) +
  geom_bar(stat="identity", fill = "orange")
p


# Basic barplot
q<-ggplot(data=bts_data, aes(x=State.FIPS, y=coummute_within_county)) +
  geom_bar(stat="identity", , fill = "purple")
q


# Basic barplot
z<-ggplot(data=bts_data, aes(x=State.FIPS, y=transit)) +
  geom_bar(stat="identity", fill = "darkgreen")
z

