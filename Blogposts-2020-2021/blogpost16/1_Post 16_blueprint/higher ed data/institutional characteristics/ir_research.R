# libs
library(tabulizer)
library(pdftools)
library(stringr)
library(ggplot2)

#dir
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/5_November/wk1_post16/1_Post 16_blueprint/higher ed data/institutional characteristics")

# eda

# 04 data
#data04 <- read.csv("ic2004.csv")
#col04 <- names(data04)
#col04 <- as.data.frame(col04)
#names(col04)[1] <- "variable_names"

# 05 data
#data19 <- read.csv("ic2019.csv")
#col19 <- names(data19)
#col19 <- as.data.frame(col19)
#names(col19)[1] <- "variable_names"

# common columms
#col_comb <- merge(col04, col19, by = "variable_names")
#col_comb$variable_names <- as.character(col_comb$variable_names)

# string of all common columns
#x=''
#for (i in (1:81)){
#    x = paste0(x, ",'", col_comb$variable_names[i], "'")
#}

# vector of variable lists:
#full_varlist <- c('ALLONCAM','APPLFEEG','APPLFEEU','ASSOC1','ASSOC2','ASSOC3','ASSOC4','ASSOC5','ASSOC6','ATHASSOC','BOARD','BOARDAMT','CALSYS','CNTLAFFI','CONFNO1','CONFNO2','CONFNO3','CONFNO4','CREDITS1','CREDITS2','CREDITS3','CREDITS4','FT_FTUG','FT_UG','LEVEL1','LEVEL12','LEVEL2','LEVEL3','LEVEL4','LEVEL5','LEVEL6','LEVEL7','LEVEL8','MEALSWK','OPENADMP','PEO1ISTR','PEO2ISTR','PEO3ISTR','PEO4ISTR','PEO5ISTR','PEO6ISTR','PT_FTUG','PT_UG','PUBPRIME','PUBSECON','RELAFFIL','RMBRDAMT','ROOM','ROOMAMT','ROOMCAP','SLO5','SLO51','SLO52','SLO53','SLO6','SLO7','SLO8','SLO81','SLO82','SLO83','SLO9','SPORT1','SPORT2','SPORT3','SPORT4','STUSRV1','STUSRV2','STUSRV3','STUSRV4','STUSRV8','STUSRV9','TUITVARY','UNITID','XAPPFEEG','XAPPFEEU','XBORDAMT','XMEALSWK','XRMBDAMT','XROOMAMT','XROOMCAP','YRSCOLL')
trimmed_varlist <- c('UNITID', 'ALLONCAM', 'ASSOC1', 'BOARD', 'BOARDAMT', 'CNTLAFFI', 'RELAFFIL')

# IR dataset build
df <- data.frame(matrix(nrow = 0, ncol= 8))

for (year in 2004:2019){
  ir_data <- read.csv(paste0("ic", as.character(year), ".csv"))
  ir_data <- ir_data[trimmed_varlist]
  ir_data$Year <- as.character(year)
  df = rbind(df, ir_data)
}

# parsing ipeds ids
raw <- pdf_text("ipedsinst.pdf")
raw <- gsub(" ", ",", raw)

# splitting raw text into questions data
raw_inst <-  strsplit(raw, "\r\n")

# appending all pages as 1 column, each row containing no more than a profile
d <- as.data.frame(matrix(data = NA, ncol = 1, nrow = 0))

for (i in 1:length(raw_inst)){
  splsplt <- unlist(raw_inst[[i]])
  inst_table <- matrix(unlist(splsplt), ncol=1, byrow=TRUE)
  inst_table <- as.data.frame(inst_table)
  d <- rbind(d, inst_table)
}

# cleaning strings
d$V1 <- as.character(d$V1)

d$inst_code <- substr(d$V1, 1, 6)
d$state <- substr(d$V1, nchar(d$V1)-1, nchar(d$V1))

d$inst_name_city <- substr(d$V1, 7, nchar(d$V1)-2)

d$city <- substring(d$inst_name_city, regexpr(",,,", d$inst_name_city) + 1)

d$inst_name <- sub(",,,,.*", "", d$inst_name_city)             


# dropping redundant datasets
rm(inst_table, ir_data, raw_inst)

# subsetting inst code data
d <- d[c(2,3,5,6)]

d$city <- gsub(",", "", d$city)

d$inst_name <- gsub(",", " ", d$inst_name)

d <- d[grep("([0-9]+).*$", d$inst_code), ]

names(d)[1] <- "UNITID"
names(d)[2] <- "STATE"
names(d)[3] <- "CITY"
names(d)[4] <- "INSTITUTION_NAME"

d$UNITID <- as.numeric(d$UNITID)

combined_dataset <- merge(d, df, by = "UNITID")


combined_dataset$ALLONCAM <- as.character(combined_dataset$ALLONCAM)
combined_dataset$BOARDAMT <- as.character(combined_dataset$BOARDAMT)


combined_dataset$ALLONCAM <- as.numeric(combined_dataset$ALLONCAM)
combined_dataset$BOARDAMT <- as.numeric(combined_dataset$BOARDAMT)


combined_dataset[is.na(combined_dataset)] <- 0

combined_dataset$COUNT = 1

names(combined_dataset)[11] <- "YEAR"


### Graphing characteristics: chart 1: ownership vs. cost of attending
inst_agg <- aggregate(BOARDAMT ~ YEAR+CNTLAFFI, combined_dataset, FUN = mean)

inst_agg <- subset(inst_agg, CNTLAFFI != -1)

inst_agg$CNTLAFFI <- as.character(inst_agg$CNTLAFFI)
inst_agg$YEAR <- as.numeric(inst_agg$YEAR)

ggplot(inst_agg, aes(x = YEAR, y = BOARDAMT, fill = CNTLAFFI)) +
  geom_line() +
  geom_point(size = 4, shape = 21)  # Also use a point with a color fill


### Graphing characteristics: chart 2: counts by 2-3 select religions
inst_agg <- aggregate(COUNT ~ YEAR+RELAFFIL, combined_dataset, FUN = sum)

inst_agg <- subset(inst_agg, RELAFFIL == 71 | RELAFFIL == 54 | RELAFFIL == 66)

inst_agg$RELAFFIL <- as.character(inst_agg$RELAFFIL)
inst_agg$YEAR <- as.numeric(inst_agg$YEAR)

ggplot(inst_agg, aes(x = YEAR, y = COUNT, fill = RELAFFIL)) +
  geom_line() +
  geom_point(size = 4, shape = 21)  # Also use a point with a color fill


# chart 3
inst_agg <- aggregate(COUNT ~ YEAR+STATE+CNTAFFIL, combined_dataset, FUN = sum)

inst_agg <- subset(inst_agg, RELAFFIL == 71 | RELAFFIL == 54 | RELAFFIL == 66)

inst_agg$RELAFFIL <- as.character(inst_agg$RELAFFIL)
inst_agg$YEAR <- as.numeric(inst_agg$YEAR)

ggplot(inst_agg, aes(x = YEAR, y = COUNT, fill = RELAFFIL)) +
  geom_line() +
  geom_point(size = 4, shape = 21)  # Also use a point with a color fill



library(usmap)


plot_usmap(data = statepop, values = "pop_2015", color = "red") + 
  scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
  theme(legend.position = "right")



