getwd()

# install.packages('tabulizer', repos='http://cran.us.r-project.org')
# install.packages('pdftools', repos='http://cran.us.r-project.org')
# install.packages('stringr', repos='http://cran.us.r-project.org')

library(tabulizer)
library(pdftools)
library(stringr)

# reading in raw text from pdf
dc_raw <- pdf_text("C:/Users/dhnsingh/Dropbox/Misc/Project/DC.pdf")
dc_raw <- gsub(" ", "", dc_raw)

# splitting raw text into profile data
dc_raw_profiles <-  strsplit(dc_raw, "\r\nVIEWPROFILE")

# example page
dc_raw_profiles[44]

# appending all pages as 1 column, each row containing no more than a profile
d <- as.data.frame(matrix(data = NA, ncol = 1, nrow = 0))

for (i in 1:length(dc_raw_profiles)){
  splsplt <- unlist(dc_raw_profiles[[i]])
  profiles_table <- matrix(unlist(splsplt), ncol=1, byrow=TRUE)
  profiles_table <- as.data.frame(profiles_table)
  d <- rbind(d, profiles_table)
}


d$V1 <- as.character(d$V1)
d$V1 <- gsub("\r\nQ", "Q", d$V1)

# splitting column into elements and cells
d <- str_split_fixed(d$V1, "\r\n", 8)
d <- as.data.frame(d)

# dropping unnecessary columns, renaming
d <- d[-c(1, 7, 8)]
colnames(d) <- c("Name", "JobTitle", "Company", "Major", "Location")

# subsetting rows w/ systems information
grepl("aggie", d$Name)
d_subs <- subset(d, !grepl("aggie", d$Name))
d_subs <- subset(d_subs, !grepl("AGGIE", d_subs$Name))

# reshuffling wrongly placed cells
d_subs$Name <- as.character(d_subs$Name)
d_subs$JobTitle <- as.character(d_subs$JobTitle)
d_subs$Company <- as.character(d_subs$Company)
d_subs$Major <- as.character(d_subs$Major)
d_subs$Location <- as.character(d_subs$Location)

d_subs$Company[477]
str(d_subs)

# length(grep("Washington,DC", d_subs$Company))
# 214 DC entries in company column

# testing
grepl("Washington,DC", d_subs$Company[5])
grepl("Washington,DC", d_subs$Company[477])

rownames(d_subs) <- NULL

# testing
d_subs$Location[17] <- d_subs$Company[17]

loc_vect <- grep("Washington,DC", d_subs$Company)

for (i in loc_vect) {
    d_subs$Location[i] <- d_subs$Company[i]
    d_subs$Company[i] <- ''
}
# length(grep("Washington,DC", d_subs$Company))
# 0
# doing the same for major column -> loc
loc_vect <- grep("Washington,DC", d_subs$Major)
for (i in loc_vect) {
  d_subs$Location[i] <- d_subs$Major[i]
  d_subs$Major[i] <- ''
}
# and for the few in the job title column -> loc
loc_vect <- grep("Washington,DC", d_subs$JobTitle)

for (i in loc_vect) {
  d_subs$Location[i] <- d_subs$JobTitle[i]
  d_subs$JobTitle[i] <- ''
}
## few others such as those at bolling anacostia base

grepl("\\(B", d_subs$JobTitle[27])

# now moving majors to correct column
maj_vect <- grep("\\(B", d_subs$JobTitle)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$JobTitle[i]
  d_subs$JobTitle[i] <- ''
}
# length(grep("\\(B", d_subs$JobTitle))
# 0
maj_vect <- grep("\\(M", d_subs$JobTitle)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$JobTitle[i]
  d_subs$JobTitle[i] <- ''
}
maj_vect <- grep("\\(P", d_subs$JobTitle)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$JobTitle[i]
  d_subs$JobTitle[i] <- ''
}
maj_vect <- grep("\\(N", d_subs$JobTitle)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$JobTitle[i]
  d_subs$JobTitle[i] <- ''
}


## doing the same for the company column -> major
maj_vect <- grep("\\(B", d_subs$Company)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$Company[i]
  d_subs$Company[i] <- ''
}
# length(grep("\\(B", d_subs$Company))
# 0
maj_vect <- grep("\\(M", d_subs$Company)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$Company[i]
  d_subs$Company[i] <- ''
}
maj_vect <- grep("\\(P", d_subs$Company)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$Company[i]
  d_subs$Company[i] <- ''
}
maj_vect <- grep("\\(N", d_subs$Company)
for (i in maj_vect) {
  d_subs$Major[i] <- d_subs$Company[i]
  d_subs$Company[i] <- ''
}


dc_ags <- subset(d_subs, grepl("Washington,DC", d_subs$Location))

write.csv(dc_ags, 'dc_ags.csv')

