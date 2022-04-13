getwd()

# install.packages('tabulizer', repos='http://cran.us.r-project.org')
# install.packages('pdftools', repos='http://cran.us.r-project.org')
# install.packages('stringr', repos='http://cran.us.r-project.org')

library(tabulizer)
library(pdftools)
library(stringr)


agdata <- "C:/Users/dhnsingh/Dropbox/Misc/Project/agdata"
data <- list.files(agdata)

d_comb <- data.frame(matrix(ncol = 5, nrow = 0))


for (i in 1:length(data)){
  


# reading in raw text from pdf
d_raw <- pdf_text(paste(agdata, "/",data[i], sep = ''))
d_raw <- gsub(" ", "", d_raw)

# splitting raw text into profile data
d_raw_profiles <-  strsplit(d_raw, "\r\nVIEWPROFILE")

# appending all pages as 1 column, each row containing no more than a profile

d <- data.frame(matrix(ncol = 1, nrow = 0))

for (i in 1:length(d_raw_profiles)){
  splsplt <- unlist(d_raw_profiles[[i]])
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

# relabeling rows after subset
rownames(d_subs) <- NULL

d_comb <- rbind(d_comb, d_subs)

}



loc_vect <- grep("DC", d_comb$Company)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}
# doing the same for major column -> loc
loc_vect <- grep("DC", d_comb$Major)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Major[i]
  d_comb$Major[i] <- ''
}
# and for the few in the job title column -> loc
loc_vect <- grep("DC", d_comb$JobTitle)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}
## few others such as those at bolling anacostia base
  


loc_vect <- grep("DE", d_comb$Company)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}
# doing the same for major column -> loc
loc_vect <- grep("DE", d_comb$Major)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Major[i]
  d_comb$Major[i] <- ''
}
# and for the few in the job title column -> loc
loc_vect <- grep("DE", d_comb$JobTitle)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}




loc_vect <- grep("MD", d_comb$Company)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}
# doing the same for major column -> loc
loc_vect <- grep("MD", d_comb$Major)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Major[i]
  d_comb$Major[i] <- ''
}
# and for the few in the job title column -> loc
loc_vect <- grep("MD", d_comb$JobTitle)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}



loc_vect <- grep("VA", d_comb$Company)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}
# doing the same for major column -> loc
loc_vect <- grep("VA", d_comb$Major)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$Major[i]
  d_comb$Major[i] <- ''
}
# and for the few in the job title column -> loc
loc_vect <- grep("VA", d_comb$JobTitle)
for (i in loc_vect) {
  d_comb$Location[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}





# now moving majors to correct column
maj_vect <- grep("\\(B", d_comb$JobTitle)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}
# length(grep("\\(B", d_comb$JobTitle))
# 0
maj_vect <- grep("\\(M", d_comb$JobTitle)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}
maj_vect <- grep("\\(P", d_comb$JobTitle)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}
maj_vect <- grep("\\(N", d_comb$JobTitle)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$JobTitle[i]
  d_comb$JobTitle[i] <- ''
}


## doing the same for the company column -> major
maj_vect <- grep("\\(B", d_comb$Company)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}

maj_vect <- grep("\\(M", d_comb$Company)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}
maj_vect <- grep("\\(P", d_comb$Company)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}
maj_vect <- grep("\\(N", d_comb$Company)
for (i in maj_vect) {
  d_comb$Major[i] <- d_comb$Company[i]
  d_comb$Company[i] <- ''
}














md_ags <- subset(d_subs, grepl(",MD", d_subs$Location))

write.csv(md_ags, 'md_ags.csv')

