getwd()

x <- read.csv('monthly_products2_dist.csv')

str(x$district)

x$district <- as.character(x$district)


# aggregating by district x product, using summation

agg <- aggregate(count ~ district + product, x, FUN = sum)

quantile(subset(agg$count, agg$product == "CookStove"), c(.33, .50, .67))
quantile(subset(agg$count, agg$product == "GobarGasPlant"), c(.33, .50, .67))
quantile(subset(agg$count, agg$product == "GreenwayJumboStoveGJS1"), c(.33, .50, .67))
quantile(subset(agg$count, agg$product == "SolarLight"), c(.33, .50, .67))


# using quantile cutoffs to categorize districts, separately for each product

agg$hml_cookstove <- 0
agg$hml_gobargas <- 0
agg$hml_jumbostove <- 0
agg$hml_solarlight <- 0


# Cutoffs for CookStove

for (i in 1:nrow(agg)) {
  if (agg$count[i] < quantile(subset(agg$count, agg$product == "CookStove"), c(.33)) & agg$product[i] == "CookStove"){
    agg$hml_cookstove[i] = 1
  } else if (agg$count[i] > quantile(subset(agg$count, agg$product == "CookStove"), c(.67)) & agg$product[i] == "CookStove") {
    agg$hml_cookstove[i] = 3
  } else if (agg$product[i] == "CookStove") {
    agg$hml_cookstove[i] = 2
  }
}

# Cutoffs for GobarGasPlant

for (i in 1:nrow(agg)) {
  if (agg$count[i] < quantile(subset(agg$count, agg$product == "GobarGasPlant"), c(.33)) & agg$product[i] == "GobarGasPlant"){
    agg$hml_gobargas[i] = 1
  } else if (agg$count[i] > quantile(subset(agg$count, agg$product == "GobarGasPlant"), c(.67)) & agg$product[i] == "GobarGasPlant") {
    agg$hml_gobargas[i] = 3
  } else if (agg$product[i] == "GobarGasPlant") {
    agg$hml_gobargas[i] = 2
  }
}

# Cutoffs for GreenwayJumboStoveGJS1

for (i in 1:nrow(agg)) {
  if (agg$count[i] < quantile(subset(agg$count, agg$product == "GreenwayJumboStoveGJS1"), c(.33)) & agg$product[i] == "GreenwayJumboStoveGJS1"){
    agg$hml_jumbostove[i] = 1
  } else if (agg$count[i] > quantile(subset(agg$count, agg$product == "GreenwayJumboStoveGJS1"), c(.67)) & agg$product[i] == "GreenwayJumboStoveGJS1") {
    agg$hml_jumbostove[i] = 3
  } else if (agg$product[i] == "GreenwayJumboStoveGJS1") {
    agg$hml_jumbostove[i] = 2
  }
}

# Cutoffs for SolarLight

for (i in 1:nrow(agg)) {
  if (agg$count[i] < quantile(subset(agg$count, agg$product == "SolarLight"), c(.33)) & agg$product[i] == "SolarLight"){
    agg$hml_solarlight[i] = 1
  } else if (agg$count[i] > quantile(subset(agg$count, agg$product == "SolarLight"), c(.67)) & agg$product[i] == "SolarLight") {
    agg$hml_solarlight[i] = 3
  } else if (agg$product[i] == "SolarLight") {
    agg$hml_solarlight[i] = 2
  }
}


agg2 <- agg[-c(2, 3)]

agg2 <- aggregate(.~district, agg2, FUN = sum)

## here 1 = Low, 2 = Medium, 3 = High


for (i in 1:nrow(agg2)) {
  if (agg2$hml_cookstove[i] == 1){
    agg2$hml_cookstove[i] = "Low"
  } else if (agg2$hml_cookstove[i] == 2) {
    agg2$hml_cookstove[i] = "Medium"
  } else if (agg2$hml_cookstove[i] == 3) {
    agg2$hml_cookstove[i] = "High"
  } else if (agg2$hml_cookstove[i] == 0) {
    agg2$hml_cookstove[i] = "NA"
  }
}


for (i in 1:nrow(agg2)) {
  if (agg2$hml_gobargas[i] == 1){
    agg2$hml_gobargas[i] = "Low"
  } else if (agg2$hml_gobargas[i] == 2) {
    agg2$hml_gobargas[i] = "Medium"
  } else if (agg2$hml_gobargas[i] == 3) {
    agg2$hml_gobargas[i] = "High"
  } else if (agg2$hml_gobargas[i] == 0) {
    agg2$hml_gobargas[i] = "NA"
  }
}


for (i in 1:nrow(agg2)) {
  if (agg2$hml_jumbostove[i] == 1){
    agg2$hml_jumbostove[i] = "Low"
  } else if (agg2$hml_jumbostove[i] == 2) {
    agg2$hml_jumbostove[i] = "Medium"
  } else if (agg2$hml_jumbostove[i] == 3) {
    agg2$hml_jumbostove[i] = "High"
  } else if (agg2$hml_jumbostove[i] == 0) {
    agg2$hml_jumbostove[i] = "NA"
  }
}


for (i in 1:nrow(agg2)) {
  if (agg2$hml_solarlight[i] == 1){
    agg2$hml_solarlight[i] = "Low"
  } else if (agg2$hml_solarlight[i] == 2) {
    agg2$hml_solarlight[i] = "Medium"
  } else if (agg2$hml_solarlight[i] == 3) {
    agg2$hml_solarlight[i] = "High"
  } else if (agg2$hml_solarlight[i] == 0) {
    agg2$hml_solarlight[i] = "NA"
  }
}



agg3 <- merge(x, agg2, by = "district")

write.csv(agg3, 'hml.csv')
