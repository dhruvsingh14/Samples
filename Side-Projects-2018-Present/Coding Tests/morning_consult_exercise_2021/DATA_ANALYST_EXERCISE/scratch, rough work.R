###################################################
# Morning Consult Data Exercise 2020 Data Analyst #
###################################################

# install.packages('dplyr', repos='http://cran.us.r-project.org')
# install.packages('tidyr', repos='http://cran.us.r-project.org')

library(dplyr)
library(tidyr)
library(ggplot2)

# setting directory
getwd()
setwd("C:/Dhruv/Applying/3_interviewing/2021/4_April/wk1/Morning Consult/Assessment/DATA_ANALYST_EXERCISE")

data("mtcars")
head(mtcars)

# converting row names to column
mtcars$make_model <- row.names(mtcars)   

# extracting car make from make_model
mtcars$make <- gsub("([A-Za-z]+).*", "\\1", mtcars$make_model)

# tabulating average mean using tapply
tapply(mtcars$mpg, mtcars$make, mean)