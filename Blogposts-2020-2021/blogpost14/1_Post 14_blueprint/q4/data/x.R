getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/4_October/wk3_post14/1_Post 14_blueprint/q4/data")

# install.packages('readxl', repos='http://cran.us.r-project.org')
library("readxl")

# data from 2002 to 2012
df <- data.frame(matrix(ncol = 9, nrow = 0))
for (year in 2002:2012){
  my_data <- read_excel(paste0(as.character(year), "/h06_000.xls"))
  
  names(my_data) <- my_data[6,]
  
  my_data <- my_data[8,(1:9)]
  
  names(my_data)[1] <- "Race"
  
  my_data$Race <- as.character(race)
  
  my_data$Year <- as.character(year)
  
  df3 = rbind(df3, my_data)
}





my_data <- read_excel("2002/h06_000.xls")

names(my_data) <- my_data[5,]

my_data <- my_data[8:58,c(1:3,7)]

names(my_data)[1] <- "State"
names(my_data)[2] <- "Total"

my_data$Year <- 2002
  
  as.character(year)

df3 = rbind(df3, my_data)















df[,(2:9)] <- lapply(df[,(2:9)], as.numeric)

# data from 2013 to 2015
df2 <- data.frame(matrix(ncol = 9, nrow = 0))
for (year in 2013:2015){
  for (race in y){
    my_data <- read_excel(paste0(as.character(year), "/h01_00", as.character(race), ".xls"))
    
    names(my_data) <- my_data[7,]
    
    my_data <- my_data[8,(1:9)]
    
    names(my_data)[1] <- "Race"
    
    my_data$Race <- as.character(race)
    
    my_data$Year <- as.character(year)
    
    df2 = rbind(df2, my_data)
  }
}
df2[,(2:9)] <- lapply(df2[,(2:9)], as.numeric)



# data from 2016 to 2017
df3 <- data.frame(matrix(ncol = 9, nrow = 0))
for (year in 2016:2017){
  for (race in y){
    my_data <- read_excel(paste0(as.character(year), "/h01_00", as.character(race), ".xls"))
    
    names(my_data) <- my_data[6,]
    
    my_data <- my_data[8,(1:9)]
    
    names(my_data)[1] <- "Race"
    
    my_data$Race <- as.character(race)
    
    my_data$Year <- as.character(year)
    
    df3 = rbind(df3, my_data)
  }
}
df3[,(2:9)] <- lapply(df3[,(2:9)], as.numeric)


insurance_data <- rbind(df, df2, df3)

write.csv(insurance_data, "insurance_data.csv")
