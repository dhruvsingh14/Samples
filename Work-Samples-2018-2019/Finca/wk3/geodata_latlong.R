# it's all mine

getwd()

setwd('C:/Users/dhnsingh/Desktop/Finca/patch-2')

x <- read.csv('latlong.csv')

gsub("° ", " ", "17° 36' N")

x$Latitude <- gsub("° ", " ", x$Latitude)
x$Latitude <- gsub("' N", " ", x$Latitude)

lt <- strsplit(x$Latitude, " ")

x$Longitude <- gsub("° ", " ", x$Longitude)
x$Longitude <- gsub("' E", " ", x$Longitude)

lng <- strsplit(x$Longitude, " ")



## Latitude Sorting for Clients and Stakeholders' clarity
x$lt1 <- 0
# lat
for (i in 1:nrow(x)) {
  x$lt1[i] <- lt[[i]][1]
}

x$lt2 <- 0
# lat.dec
for (i in 1:nrow(x)) {
  x$lt2[i] <- lt[[i]][2]
}

x$lt1 <- as.numeric(x$lt1)
x$lt2 <- as.numeric(x$lt2)
x$lt2 <- x$lt2/60

x$lt <- x$lt1 + x$lt2 # latitude variable


## Longitude Sorting for Clients and Stakeholders' clarity
x$lng1 <- 0
# lng
for (i in 1:nrow(x)) {
  x$lng1[i] <- lng[[i]][1]
}

x$lng2 <- 0
# lat.dec
for (i in 1:nrow(x)) {
  x$lng2[i] <- lng[[i]][2]
}

x$lng1 <- as.numeric(x$lng1)
x$lng2 <- as.numeric(x$lng2)
x$lng2 <- x$lng2/60

x$lng <- x$lng1 + x$lng2 # longitude variable

x <- x[c(1, 4, 9)]

names(x)[1] <- "location"

write.csv(x, 'coordinates.csv')