#####################
# Setting Directory #
#####################

getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/2_August/wk1_post4/2_Post 4_analysis/data")

###########################
# Reading in All Datasets #
###########################

# Dataset 1: Heritage
heritage <- read.csv("economic_freedom_index2020_heritage.csv")
heritage$Country <- as.character(heritage$Country)

# Dataset 2: Freedom House 1
fh1_democ <- read.csv("fh_democracy_(2019).csv")
fh1_democ$Total.Score.and.Status <- as.character(fh1_democ$Total.Score.and.Status)

# string split
x <- strsplit(fh1_democ$Total.Score.and.Status, "Â")
x2 <- data.frame(matrix(unlist(x), nrow=length(x), byrow=T))

# renaming columns
fh1_democ$Total.Score_democ <- x2$X1
fh1_democ$Status_democ <- x2$X2
names(fh1_democ)[1] <- "Country"

# dropping, change type
fh1_democ <- fh1_democ[-c(2)]
fh1_democ$Country <- as.character(fh1_democ$Country)

# Merged Dataset 1: fh democ, heritage
master <- merge(x=heritage, y=fh1_democ, by = "Country", all = TRUE)

# dropping unnecessary datasets
rm(fh1_democ, heritage, x, x2)

###########################################

# Freedom House Data 2 : Global Freedom
fh2_gf <- read.csv("fh_global_freedom_(2019).csv")
fh2_gf$Total.Score.and.Status <- as.character(fh2_gf$Total.Score.and.Status)

# string split
x <- strsplit(fh2_gf$Total.Score.and.Status, "Â")
x2 <- data.frame(matrix(unlist(x), nrow=length(x), byrow=T))

# renaming columns
fh2_gf$Total.Score_global_freedom <- x2$X1
fh2_gf$Status_global_freedom <- x2$X2
names(fh2_gf)[1] <- "Country"

# dropping, change type
fh2_gf <- fh2_gf[-c(2)]
fh2_gf$Country <- as.character(fh2_gf$Country)

# Merged Dataset 2: master, gf
master2 <- merge(x=master, y=fh2_gf, by = "Country", all = TRUE)

# dropping unnecessary datasets
rm(fh2_gf, master, x, x2)

###########################################

# Freedom House Data 3 : Internet Freedom
fh3_internet <- read.csv("fh_internet_freedom_(2019).csv")
fh3_internet$Total.Score.and.Status <- as.character(fh3_internet$Total.Score.and.Status)

# string split
x <- strsplit(fh3_internet$Total.Score.and.Status, "Â")
x2 <- data.frame(matrix(unlist(x), nrow=length(x), byrow=T))

# renaming columns
fh3_internet$Total.Score_internet <- x2$X1
fh3_internet$Status_internet <- x2$X2
names(fh3_internet)[1] <- "Country"

# dropping, change type
fh3_internet <- fh3_internet[-c(2)]
fh3_internet$Country <- as.character(fh3_internet$Country)

# Merged Dataset 3: master2, internet
master3 <- merge(x=master2, y=fh3_internet, by = "Country", all = TRUE)

# dropping unnecessary datasets
rm(fh3_internet, master2, x, x2)

###########################################

# Cato Data
cato <- read.csv("human-freedom-index-2019_cato.csv")
cato$countries <- as.character(cato$countries)
names(cato)[3] <- "Country"

# Merged Dataset 4: master3, cato
master4 <- merge(x=master3, y=cato, by = "Country", all = TRUE)

# dropping unnecessary datasets
rm(master3, cato)

###########################################

# RSF Data
rsf <- read.csv("index_2020_press_freedom_rsf.csv")

rsf$EN_country <- as.character(rsf$EN_country)
names(rsf)[4] <- "Country"

# Merged Dataset 5: master4, rsf
master5 <- merge(x=master4, y=rsf, by = "Country", all = TRUE)

# dropping unnecessary datasets
rm(master4, rsf)

###########################################

# WPR Data
wpr <- read.csv("world_pop_rev_2020_general_freedom_index.csv")

names(wpr)[1] <- "Country"
wpr$Country <- as.character(wpr$Country)

# Merged Dataset 6: master5, wpr
master6 <- merge(x=master5, y=wpr, by = "Country", all = TRUE)

# dropping unnecessary datasets
rm(master5, wpr)

###########################################

# Write outfile

write.csv(master6, "combined_data.csv")





