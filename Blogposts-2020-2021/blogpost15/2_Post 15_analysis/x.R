######################################
# Reading in any necessary libraries #
######################################
library(ggplot2)
library(tidyr)

#######################
# Setting Directories #
#######################
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/4_October/wk4_post15/2_Post 15_analysis")

################
# Reading Data #
################
x <- read.csv("1982_to_2012.csv")
x[is.na(x)] <- 0
x$count <- 1

################
# Binning Data #
################

x$AGE_BIN <-0 

for (i in 1:nrow(x)){
  if (x$AGE[i] >= 18 & x$AGE[i] < 38) {
    x$AGE_BIN[i] = 38
  } else if (x$AGE[i] >= 38 & x$AGE[i] < 58){
    x$AGE_BIN[i] = 58
  } else if (x$AGE[i] >= 58 & x$AGE[i] < 78){
    x$AGE_BIN[i] = 78
  } else if (x$AGE[i] >= 78){
    x$AGE_BIN[i] = 98
  }
}

x$INCOME_BIN <-0 

for (i in 1:nrow(x)){
  if ((x$INCOME[i] >= 1 & x$INCOME[i] <= 6) | (x$INCOME[i] >= 21 & x$INCOME[i] <= 29) | x$INCOME[i] == 40){
    x$INCOME_BIN[i] = 20000
  } else if ((x$INCOME[i] >= 7 & x$INCOME[i] <= 11) | x$INCOME[i] == 30 | x$INCOME[i] == 41){
    x$INCOME_BIN[i] = 50000
  } else if ((x$INCOME[i] >= 12 & x$INCOME[i] <= 14) | x$INCOME[i] == 17){
    x$INCOME_BIN[i] = 75000
  } else if (x$INCOME[i] == 15 | x$INCOME[i] == 16 | x$INCOME[i] == 18 | x$INCOME[i] == 19){
    x$INCOME_BIN[i] = 150000
  }
}

# variables to cut data on: gender, race, ses, region, year

#########
# Music #
#########

################################################################
# i: What sorts of music are the different races listening to? #
################################################################

# MUSIC_WHITE
music_agg <- subset(x, (RACE==1) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)



music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
       key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Race (White), from 1982 to 2012")


# MUSIC_BLACK
music_agg <- subset(x, (RACE==2) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Race (Black), from 1982 to 2012")


# MUSIC_Native American
music_agg <- subset(x, (RACE==3) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Race (Native American), from 1982 to 2012")


# MUSIC_AI
music_agg <- subset(x, (RACE==4) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Race (Asian), from 1982 to 2012")



# music <- aggregate(count ~ YEAR+RACE+JAZZ+SALSA+CLASSICAL+OPERA, x, FUN = sum)

#######################################################
# ii: What music are the different ses' listening to? #
#######################################################

# MUSIC_LOWER_CLASS
music_agg <- subset(x, (INCOME_BIN==20000) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by SES (Lower Classes), from 1982 to 2012")


# MUSIC_MIDDLE_CLASS
music_agg <- subset(x, (INCOME_BIN==50000) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by SES (Middle Classes), from 1982 to 2012")


# MUSIC_UPPER_MIDDLE_CLASS
music_agg <- subset(x, (INCOME_BIN==75000) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by SES (Upper Middle Classes), from 1982 to 2012")


# MUSIC_UPPER_CLASS
music_agg <- subset(x, (INCOME_BIN==150000) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by SES (Upper Classes), from 1982 to 2012")



###########################################################
# iii: What music are the different regions listening to? #
###########################################################

# NORTHEAST
music_agg <- subset(x, (REGION==1) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Region (Northeast), from 1982 to 2012")


# MIDWEST
music_agg <- subset(x, (REGION==2) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Region (Midwest), from 1982 to 2012")

# SOUTH
music_agg <- subset(x, (REGION==3) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Region (South), from 1982 to 2012")


# WEST
music_agg <- subset(x, (REGION==4) & (JAZZ==1 | JAZZ==2 | SALSA==1|SALSA==2 | CLASSICAL==1|CLASSICAL==2 | OPERA==1|OPERA==2))

music_agg <- aggregate(count ~ YEAR+JAZZ+SALSA+CLASSICAL+OPERA, music_agg, FUN = sum)

music_agg$JAZZ <- as.character(music_agg$JAZZ)
music_agg$SALSA <- as.character(music_agg$SALSA)
music_agg$CLASSICAL <- as.character(music_agg$CLASSICAL)
music_agg$OPERA <- as.character(music_agg$OPERA)

music_agg <- gather(music_agg, `JAZZ`, `SALSA`, `CLASSICAL`, `OPERA`, 
                    key = "Music", value = "Category")

music_agg$Music <- as.character(music_agg$Music)
music_agg$YEAR <- as.character(music_agg$YEAR)

music_agg <- subset(music_agg, Category == 1)

music_agg <- aggregate(count ~ YEAR+Music, music_agg, FUN = sum)

ggplot(music_agg, aes(x = YEAR, y = count, fill = Music)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Music), by Region (West), from 1982 to 2012")


#########
# Books #
#########

####################################################
# i: What books are the different genders reading? #
####################################################

# books <- aggregate(count ~ YEAR+GENDER+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, x, FUN = sum)

# READING_MALES
books_agg <- subset(x, (GENDER==1) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by Gender (Males), from 1982 to 2012")


# READING_FEMALES
books_agg <- subset(x, (GENDER==2) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by Gender (Females), from 1982 to 2012")



########################################################
# ii: What books are the different age groups reading? #
########################################################

# READING_YOUNGER
books_agg <- subset(x, (AGE_BIN==38) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by Age (Younger), from 1982 to 2012")



# READING_MIDDLE_AGE
books_agg <- subset(x, (AGE_BIN==58) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by Age (Middle Aged), from 1982 to 2012")



# READING_OLDER
books_agg <- subset(x, (AGE_BIN==78) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by Age (Older Aged), from 1982 to 2012")



# READING_OLD
books_agg <- subset(x, (AGE_BIN==98) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by Age (Elderly), from 1982 to 2012")



########################################################
# iii: What books are the different ses groups reading? #
########################################################

# READING_LOWER_CLASS
books_agg <- subset(x, (INCOME_BIN==20000) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by SES (Lower Classes), from 1982 to 2012")

# READING_MIDDLE_CLASS
books_agg <- subset(x, (INCOME_BIN==50000) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by SES (Middle Classes), from 1982 to 2012")


# READING_UPPER_MIDDLE_CLASS
books_agg <- subset(x, (INCOME_BIN==75000) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by SES (Upper Middle Classes), from 1982 to 2012")

# READING_UPPER_CLASS
books_agg <- subset(x, (INCOME_BIN==150000) & (BOOKS==1 | BOOKS==2 | READ_NOVELS==1|READ_NOVELS==2 | READ_POETRY==1|READ_POETRY==2 | READ_PLAYS==1|READ_PLAYS==2 | LITERATURE==1|LITERATURE==2))

books_agg <- aggregate(count ~ YEAR+BOOKS+READ_NOVELS+READ_POETRY+READ_PLAYS+LITERATURE, books_agg, FUN = sum)

books_agg$BOOKS <- as.character(books_agg$BOOKS)
books_agg$READ_NOVELS <- as.character(books_agg$READ_NOVELS)
books_agg$READ_POETRY <- as.character(books_agg$READ_POETRY)
books_agg$READ_PLAYS <- as.character(books_agg$READ_PLAYS)
books_agg$LITERATURE <- as.character(books_agg$LITERATURE)

books_agg <- gather(books_agg, `BOOKS`, `READ_NOVELS`, `READ_POETRY`, `READ_PLAYS`, `LITERATURE`,
                    key = "Reading", value = "Category")

books_agg$Reading <- as.character(books_agg$Reading)
books_agg$YEAR <- as.character(books_agg$YEAR)

books_agg <- subset(books_agg, Category == 1)

books_agg <- aggregate(count ~ YEAR+Reading, books_agg, FUN = sum)

ggplot(books_agg, aes(x = YEAR, y = count, fill = Reading)) + 
  geom_col(position = "dodge", colour = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  ggtitle("Participation in the Arts (Reading), by SES (Upper Classes), from 1982 to 2012")



