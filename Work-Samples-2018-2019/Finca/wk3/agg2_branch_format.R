library(stringr)
getwd()

## changing case to title format for bracnh

x <- read.csv("monthly_products.csv")

x$branch <- as.character(x$branch)

str(x)

for(i in 1:nrow(x)){
  x$branch[i] <- str_to_title(x$branch[i])
}

x$branch <- gsub(" ", "", x$branch)

write.csv(x, 'monthly_products.csv')


## changing case to title format for districts


x2 <- read.csv("dist1.csv")

x2$branch <- as.character(x2$branch)
x2$district <- as.character(x2$district)

str(x2)


for(i in 1:nrow(x2)){
  x2$branch[i] <- str_to_title(x2$branch[i])
  x2$district[i] <- str_to_title(x2$district[i])
}

x2$branch <- gsub(" ", "", x2$branch)
x2$district <- gsub(" ", "", x2$district)

write.csv(x2, 'dist2_frmtd.csv')


