getwd()



# install.packages('tabulizer', repos='http://cran.us.r-project.org')
# install.packages('pdftools', repos='http://cran.us.r-project.org')
# install.packages('stringr', repos='http://cran.us.r-project.org')
# install.packages('ggplot2', repos='http://cran.us.r-project.org')


library(tabulizer)
library(pdftools)
library(stringr)
library(ggplot2)

# reading in raw text from pdf
VA <- read.csv("C:/Users/dhnsingh/Dropbox/Misc/Project/agdata_csv/VA_ags.csv")
DC <- read.csv("C:/Users/dhnsingh/Dropbox/Misc/Project/agdata_csv/DC_ags.csv")
DE <- read.csv("C:/Users/dhnsingh/Dropbox/Misc/Project/agdata_csv/DE_ags.csv")
MD <- read.csv("C:/Users/dhnsingh/Dropbox/Misc/Project/agdata_csv/MD_ags.csv")
NJ <- read.csv("C:/Users/dhnsingh/Dropbox/Misc/Project/agdata_csv/NJ_ags.csv")


?ggplot

ggplot(data = VA, aes(Location)) + geom_histogram(stat = "count")