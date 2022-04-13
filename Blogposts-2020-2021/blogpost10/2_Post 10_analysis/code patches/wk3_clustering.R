getwd()

# packageVersion("swirl")

library(swirl)

# install_from_swirl("Exploratory Data Analysis")

swirl()



##########################
#   clustering week 3    #
##########################


##########################################
#   lesson 1: hierarchical clustering    #
##########################################

# euclidean: straight line bw two pts vs manhattan dist: cartesian/grid dist traversed
dist(dataFrame)

# basic dendrogram
hc <- hclust(distxy)
plot(hc)

# closest points together are grouped as 'leaves'

plot(as.dendrogram(hc)) # doesn't include labels
abline(h = 1.5, col = "blue") # 3 clusters cut at this line
abline(h = 0.4, col = "red") # 5 clusters cut at this line
abline(h = 0.05, col = "green") # 12 individual clusters when line is lower than shortest dist

# ways of measuring dist b/w clusters, method 1: complete linkage

# computes dist b/w furthest points in closest clusters, and uses that as linkage dist

dist(dFsm)

# method 2: average linkage, computes avg per cluster closest and links based on that 
hc
2
# hierarchical linkage is quite different from record linkage, no relation there

# heatmaps
heatmap(dataMatrix, col = cm.colors(25))
heatmap(mt)

# dendrogram with labelled points
mt
plot(denmt)

# matrix of distances in dendrogram
# matches hclust
distmt


#####################################
#   lesson 2: k-means clustering    #
#####################################

## some basic theory 
# randomly affix a centroid, and clump nearest points to it
# then calculating average, and readjusting centroid
# this assigns all points to cluster, after picking the number of clusters desired


# stepping through a cluster analysis, fast
# following matrix contains two vectors of centroid coordinates: cx, vy
cmat

# centroids and points
points(cx, cy , col = c("red", "orange", "purple"), pch = 3, cex = 2, lwd = 2)

# order of centroid color determines number

# x, y are point coordinate vectors
# mdist calculates a matrix of distances b/w each point and centroid
mdist(x, y, cx, cy)

# distTmp contains the distances from each point to centroid in a matrix
# points representing columns and centroids representing rows
# for each point, assign the nearest centroid 

# quickly summarizes assignment by distance
apply(distTmp, 2, which.min)

# numbers outputted are according to assignment in points command, cluster 1 = red, 2 = orange and so on.

# new clust contains initial cluster factoring
# initial cluster assignment
points(x, y, pch = 19, cex = 2, col = cols1[newClust])

# calculating new centroid per cluster
tapply(x, newClust, mean)
tapply(y, newClust, mean)

# centroid reassignment -> closer clusters
points(newCx, newCy, col = cols1, pch = 8, cex = 2, lwd = 2)

# recalculates centroid point distances
mdist(x, y, newCx, newCy)

# recalculating centroid assignment per points
apply(distTmp2, 2, which.min)

# recoloring points by new cluster assignment
points(x, y, pch = 19, cex = 2, col = cols1[newClust2])

# finding new cluster means, for x and y coordinates
tapply(x, newClust2, mean)
tapply(y, newClust2, mean)
# notice, that while the original x, y coordinates of the points remain fixed, 
# the centroids change coordinates, and the cluster assignment of points changes

# final cluster assignment
points(finalCx, finalCy, col = cols1, pch = 9, cex = 2, lwd = 2)

# kmeans does all the above work using a function
kmeans(dataFrame, centers = 3)

# checking number of iterations
kmObj$iter

# plotting output of kmeans command
plot(x, y, col = kmObj$cluster, pch = 19, cex = 2)
points(kmObj$centers, col = c("black", "red", "green"), pch = 3, cex = 3, lwd = 3)

# random starts, here 6, determines clustering 
plot(x, y, col = kmeans(dataFrame, 6)$cluster, pch = 19, cex = 2)


######################################
#   lesson 3: dimension reduction    #
######################################

# reading in random normal data
head(dataMatrix)

# visualizing random normal data
heatmap(dataMatrix)


#
myedit("addPatt.R")

# adding pattern to random normal data: example

# set.seed(678910)
# for(i in 1:40){
#   # flip a coin
#   coinFlip <- rbinom(1,size=1,prob=0.5)
#   # if coin is heads add a common pattern to that row
#   if(coinFlip){
#     dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each=5)
#   }
# }

# not all rows will be imposed with a pattern
# coin flip determines assignment
# rep(c(0,3),each=5) command shows first 5 cols will still have mean 0
# while next 5 cols will still have mean 3

source("addPatt.R", local = TRUE)
heatmap(dataMatrix)

# data compression: extracting relevant info from high dimension dataset
# finding the least correlated matrix to explain variability

# methods: 

# PCA - Principal Component Analysis
# SVD - Singular Value Decomposition 

# SVD: expressing original matrix as orthogonal matrices 
# SVD: X=UDV^t

# simple matrix
mat
# decomposed into its elements
svd(mat)
# remultiplying matrices gives original matrix back
matu%*%diag%*%t(matv)


# PCA: must start by scaling original matrix
svd(scale(mat))
prcomp(scale(mat)) # yeilds v matrix from svd, right singular vectors

# first columns of V - first principal component 
svd1$v[,1]

# diagonal entries are like weights
svd1$d

# another example of how SVD explains variance
head(constantMatrix)
svd2$d

# if a majority of variation is explained by one element, the data is one-dimensional
svd2$v[,1:2]

# examing entries of diagonal matrix
svd2$d

# PCA / SVD cannot deal with missing data, have to find a workaround prior
# imputation using k nearest neighbour is one fix, using bioconductor package

# plotting svd can show what amount of variation is explained by the various columns
dim(faceData)

# plotting face image with one dimensions
a1 <- (svd1$u[,1] * svd1$d[1]) %*% t(svd1$v[,1])
myImage(a1)

# plotting face image with two dimensions
a2 <- svd1$u[,1:2] %*% diag(svd1$d[1:2]) %*% t(svd1$v[,1:2])
myImage(a2)

# plotting face image with five dimensions
myImage(svd1$u[,1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[,1:5]))

# plotting face image with ten dimensions
myImage(svd1$u[,1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[,1:10]))

# units or scales of your data matter


#####################################
#   lesson 4: clustering example    #
#####################################

dim(ssd)
names(ssd[562:563])

# breakdown of observations per subject
table(ssd$subject) # indicates that ssd represents training data

# this sum shows total number of rows
sum(table(ssd$subject))

# breakdown of observations per activity
table(ssd$activity)

# subsetting to subject number 1
sub1 <- subset(ssd, subject == 1)
dim(sub1)

# checking columns of subset
names(sub1[1:12])
myedit("showXY.R")

# trying to produce clustering plot by activity
showMe(1:6)

# clustering by subject 1's activities, and type of var: mean
mdist <- dist(sub1[,1:3])
hclustering <- hclust(mdist)
myplclust(hclustering, lab.col = unclass(sub1$activity)) # passive activities mostly fall below walking  

# clustering by subject 1's activities, and type of var: max
mdist <- dist(sub1[,10:12])
hclustering <- hclust(mdist)
myplclust(hclustering, lab.col = unclass(sub1$activity)) # much clearer pattern

# now passive activities are far lower on the distance axis
# clear split between active and passive activities

# removing activity and subject labels, not needed for analysis
svd1 <- svd(scale(sub1[,-c(562, 563)])) 
dim(svd1$u)


# using clustering to detect variation
maxCon <- which.max(svd1$v[,2])
mdist <- dist(sub1[,c(10:12, maxCon)])

# clustering has allowed us to separate 
# different types of walking activities completely
hclustering <- hclust(mdist)
myplclust(hclustering, lab.col = unclass(sub1$activity))

names(sub1[maxCon]) # looking for maximum contributor 


#
kClust <- kmeans(sub1[,-c(562, 563)], centers = 6)
table(kClust$cluster, sub1$activity)




