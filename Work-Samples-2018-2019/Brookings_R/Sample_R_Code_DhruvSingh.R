library(tidyr)
library(stringr)
library(ggplot2)
library(gridExtra)
library(ggpubr)

setwd("C:/Users/dhnsingh/Desktop/Sample_R_Code")

# MCI data: Medical Council of India #containing registered institutions # and their capacity or seats offered by degree.
MCI <- read.csv('MCI_final.csv')

# replacing na values with 0
MCI[is.na(MCI)] <- 0

# Degrees interested in: "DM", "MBBS", "MCH", "MD", "MS", "MSC_Anatomy",  "MSC_Pharmacology", "MSC_Physiology"


# combining DM programmes
grep("DM", colnames(MCI))
colnames(MCI)[10] 

MCI$DM = 0
for (x in 10:55){
  MCI$DM = MCI$DM + MCI[,x]
}

# MBBS
MCI$MBBS = 0
for (x in grep("M.B.B.S", colnames(MCI))){
  MCI$MBBS = MCI$MBBS + MCI[,x]
}


# combining MCH programmes
grep("M.Ch", colnames(MCI))

MCI$MCH = 0
for (x in 113:130){
  MCI$MCH = MCI$MCH + MCI[,x]
}

# combining MD programmes
MCI$MD = 0
for (x in grep("MD..", colnames(MCI))){
  MCI$MD = MCI$MD + MCI[,x]
}

# combining MS programmes
MCI$MS = 0
for (x in grep("MS..", colnames(MCI))){
  MCI$MS = MCI$MS + MCI[,x]
}


# list of all MSc programmes
grep("M.Sc", colnames(MCI)) 

# combining MSC_Anatomy programmes
MCI$MSC_Anatomy = 0
colnames(MCI)[134:135] 
for (x in 134:135){
  MCI$MSC_Anatomy = MCI$MSC_Anatomy + MCI[,x]
}

# MSC_Pharmacology programmes
MCI$MSC_Pharmacology = 0
for (x in grep("Medical.Pharmocology", colnames(MCI))){
  MCI$MSC_Pharmacology = MCI$MSC_Pharmacology + MCI[,x]
}

# MSC_Physiology programmes
MCI$MSC_Physiology = 0
for (x in grep("M.Sc...Physiology", colnames(MCI))){
  MCI$MSC_Physiology = MCI$MSC_Physiology + MCI[,x]
}


# subsetting to relevant columns
MCI_Agg <- MCI[,c(5, 264:271)]

# aggregating to obtain total seat capacity by year and degree
# not showing which colleges drive the capacity
MCI_Agg <- aggregate(. ~ Year, MCI_Agg, sum)


#AISHE Medical Degrees: All India Survey of Higher Education, 2012-18

# # files in directory
# list.files()

# # creating empty matrix with 17 disag columns
# dx <- as.data.frame(matrix(NA, ncol = 17, nrow = 0)) # creates a matrix with 17 columns and variable rows.
# 
# # appending degree wise enrollment from 2012 to 2018
# for (x in 1:7) {
#   df <- read.csv(files[x])
#   df$year = strsplit(files[x], ".csv")[[1]][1]
#   dx <- rbind(dx, df)
# } 

# Reading in appended AISHE enrolment data 2012-2018:
ProgAgg.long <- read.csv('ProgrammeEnrollment_agg.csv')

# subsetting to Total Enrolment by program and year 
ProgAgg.long <- ProgAgg.long[-c(4:10)]

ProgAgg.wide <- spread(ProgAgg.long, Programme, Total)

ProgAgg.wide[is.na(ProgAgg.wide)] <- 0




# "DM", "MBBS", "MCH", "MD", "MS", "MSC_Anatomy", "MSC_Pharmacology", "MSC_Physiology"

# DM
ProgAgg.wide$DM = 0
for (x in grep("D.M", colnames(ProgAgg.wide))){
  ProgAgg.wide$DM = ProgAgg.wide$DM + ProgAgg.wide[,x]
}

# MBBS
ProgAgg.wide$MBBS = 0
for (x in grep("M.B.B.S", colnames(ProgAgg.wide))){
  ProgAgg.wide$MBBS = ProgAgg.wide$MBBS + ProgAgg.wide[,x]
}

# MCH
ProgAgg.wide$MCH = 0
for (x in grep("M.Ch", colnames(ProgAgg.wide))){
  ProgAgg.wide$MCH = ProgAgg.wide$MCH + ProgAgg.wide[,x]
}

# MD
ProgAgg.wide$MD = 0
for (x in grep("M.D.-", colnames(ProgAgg.wide))){
  ProgAgg.wide$MD = ProgAgg.wide$MD + ProgAgg.wide[,x]
}

# MS
ProgAgg.wide$MS = 0
for (x in grep("M.S.-Master of Surgery", colnames(ProgAgg.wide))){
  ProgAgg.wide$MS = ProgAgg.wide$MS + ProgAgg.wide[,x]
}

# combining MSC_Anatomy programmes
ProgAgg.wide$MSC_Anatomy = 0
for (x in grep("Master of Science in Medical Anatomy", colnames(ProgAgg.wide))){
  ProgAgg.wide$MSC_Anatomy = ProgAgg.wide$MSC_Anatomy + ProgAgg.wide[,x]
}

# MSC_Pharmacology programmes
ProgAgg.wide$MSC_Pharmacology = 0
for (x in grep("Master of Science in Medical Pharmacology", colnames(ProgAgg.wide))){
  ProgAgg.wide$MSC_Pharmacology = ProgAgg.wide$MSC_Pharmacology + ProgAgg.wide[,x]
}

# MSC_Physiology programmes
ProgAgg.wide$MSC_Physiology = 0
for (x in grep("Master of Science in Medical Physiology", colnames(ProgAgg.wide))){
  ProgAgg.wide$MSC_Physiology = ProgAgg.wide$MSC_Physiology + ProgAgg.wide[,x]
}


# subsetting to relevant columns
ProgAgg <- ProgAgg.wide[,c(1, 54:61)]

# renaming columns, and reshaping
ProgAgg <- ProgAgg[c("Year", "DM", "MBBS", "MCH", "MD", "MS", "MSC_Anatomy",  "MSC_Pharmacology", "MSC_Physiology")]
Enrolment.long <- gather(ProgAgg, `DM`, `MBBS`, `MCH`, `MD`, `MS`, `MSC_Anatomy`,  `MSC_Pharmacology`, `MSC_Physiology`, key = "Programme", value = "Total")

MCI_Agg <- MCI_Agg[c("Year", "DM", "MBBS", "MCH", "MD", "MS", "MSC_Anatomy",  "MSC_Pharmacology", "MSC_Physiology")]
Capacity.long <- gather(MCI_Agg, `DM`, `MBBS`, `MCH`, `MD`, `MS`, `MSC_Anatomy`,  `MSC_Pharmacology`, `MSC_Physiology`, key = "Programme", value = "Total")


rm(MCI, MCI_Agg, ProgAgg, ProgAgg.long, ProgAgg.wide)

# further aggregating yearly capacities to match enrolment units, reported as total enrolled in a program, not as yearly enrolment.

Capacity.long$GrandTotal <- 0

# DM, 3 year degree
for (x in 23:71){
  for (y in 0:2) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MBBS, 5 year degree
for (x in 94:142){
  for (y in 0:4) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MCH, 3 year degree
for (x in 165:213){
  for (y in 0:2) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MD, 3 year degree
for (x in 236:284){
  for (y in 0:2) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MS, 3 year degree
for (x in 307:355){
  for (y in 0:2) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MSC_Anatomy, 2 year degree
for (x in 378:426){
  for (y in 0:1) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MSC_Pharmacology, 2 year degree
for (x in 449:497){
  for (y in 0:1) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# MSC_Physiology, 2 year degree
for (x in 520:568){
  for (y in 0:1) {
    Capacity.long$GrandTotal[x] = Capacity.long$GrandTotal[x] + Capacity.long$Total[x-y] 
  }
}

# merging MCI and AISHE data:
capacity_enrolment <- merge(Capacity.long, Enrolment.long, by=c("Year", "Programme"))


# limited to 2012-2018 
names(capacity_enrolment) <- c("Year", "Programme", "TotalYearlyCapacity", "GrandTotalCapacity", "TotalEnrolment")
capacity_enrolment$Ratio <- capacity_enrolment$TotalEnrolment/capacity_enrolment$GrandTotalCapacity

## Plotting Enrolment to Capacity Ratios


p1 <- ggplot(aes(x = Year, y = Ratio, color = Programme), data = subset(capacity_enrolment, Programme == "DM"|Programme == "MCH")) +
  geom_line(size = 1) + ggtitle("DM and MCH Enrolment Capacity Ratios") 
p2 <- ggplot(aes(x = Year, y = Ratio, color = Programme), data = subset(capacity_enrolment, Programme == "MBBS")) +
  geom_line(size = 1) + ggtitle("MBBS Enrolment Capacity Ratio") 
p3 <- ggplot(aes(x = Year, y = Ratio, color = Programme), data = subset(capacity_enrolment, Programme == "MD"|Programme == "MS")) +
  geom_line(size = 1) + ggtitle("MD and MS Enrolment Capacity Ratio") 

grid.arrange(p1, p2, p3, ncol = 2)
rm(p1, p2, p3)


## Switching to analysis of graduation rates: appear/enrolled, pass/enrolled
# using cleaned and appended aishe data

YrlyRates <- read.csv('YrlyRates.csv')

# example included: MBBS

# graphing % MBBS students appearing for exams, of those enrolled
# graphing % MBBS students passing their exams, of those enrolled

P4 <- ggplot(aes(x = Year, y = Aprd_Enrld), data = subset(YrlyRates, Programme == "MBBS")) + 
  geom_line(color = "darkcyan", size = 1) + 
  geom_point(color = "darkcyan", size = 2) +
  ggtitle("MBBS: Appeared %") +
  labs(x = "Year", y = "Appeared / Enrolled")

P5 <- ggplot(aes(x = Year, y = Pssd_Enrld), data = subset(YrlyRates, Programme == "MBBS")) + 
  geom_line(color = "darkorange", size = 1) + 
  geom_point(color = "darkorange", size = 2) +
  ggtitle("MBBS: Passed %") +
  labs(x = "Year", y = "Passed / Enrolled")

grid.arrange(P4, P5, ncol = 2)  
rm(P4, P5)


## working with further disaggregated enrolment data, by individual institution.

# for (x in 1:7){
#   raw <- read.csv(files[x])
#   enrolment <- rbind(enrolment, raw)
# }
# 
# enrolment$xtract = str_sub(enrolment$ï..1, -8, -2)
# enrolment$xtract <- gsub('Id: |d: |: | ','', enrolment$xtract)

## ordering data frame by AISHE_CODE column
# enrolment <- enrolment[order(enrolment$AISHE_CODE),]
# rownames(enrolment) <- NULL

InstitutionRatios <- read.csv('InstRatios.csv')

# creating enrolment capacity ratios by undergrad and postgrad
InstitutionRatios$UG_EC <- (InstitutionRatios$UG_T)/(InstitutionRatios$UG_cap)
InstitutionRatios$PG_EC <- (InstitutionRatios$PG_T)/(InstitutionRatios$PG_cap)

# removing inf nan values and replacing with 0
InstitutionRatios$UG_EC[!is.finite(InstitutionRatios$UG_EC)] <- 0
InstitutionRatios$PG_EC[!is.finite(InstitutionRatios$PG_EC)] <- 0



## scatterplot of disaggregated, discrete data.
p1 <- ggplot(aes(x = Year, y = UG_EC), data = InstitutionRatios) + 
  geom_point(color = 'tomato3') + ylim(0,5) + 
  labs(x = "Year", y = "Colleges EC Ratio: Undergraduates")
p2 <- ggplot(aes(x = Year, y = PG_EC), data = InstitutionRatios) + 
  geom_point(color = 'tomato3') + ylim(0,5) +
  labs(x = "Year", y = "Colleges EC Ratio: Postgraduates")

# aggregating all
m3 <- aggregate(. ~ Year, InstitutionRatios, FUN = mean)

# aggregating only ratios under 1
m4 <- aggregate(. ~ Year, subset(InstitutionRatios, InstitutionRatios$UG_EC < 1 & InstitutionRatios$PG_EC < 1), FUN = mean)

# subsetting to check which colleges are skewing the mean, outliers.
m5 <- subset(InstitutionRatios, InstitutionRatios$UG_EC < 1 & InstitutionRatios$PG_EC < 1)
m6 <- subset(InstitutionRatios, InstitutionRatios$UG_EC > 1 & InstitutionRatios$PG_EC > 1)

# scatterplot of percentages less than hundred.
p3 <- ggplot(aes(x = Year, y = UG_EC), data = m5) + 
  geom_point(color = 'darkseagreen') + 
  labs(x = "Year", y = "Colleges Subsetted EC Ratio: Undergraduates")
p4 <- ggplot(aes(x = Year, y = PG_EC), data = m5) + 
  geom_point(color = 'darkseagreen') +
  labs(x = "Year", y = "Colleges Subsetted EC Ratio: Postgraduates")


grid.arrange(p1, p3, ncol = 2)
grid.arrange(p2, p4, ncol = 2)


# length(unique(m5$AISHE_CODE))
# # 302 distinct colleges contribute to this trend
# 
# length(unique(m6$AISHE_CODE))
# # 5 skew it.


# plotting only ratios under 1. shows falling trends for Postgraduate Medical Enrolment
ggplot(aes(x = Year, y = UG_EC), data = m4) +
  geom_line(color = 'steelblue4', size = 1) + geom_point(size = 2) + 
  labs(x = "Year", y = "Colleges EC Ratio: Undergraduates")

ggplot(aes(x = Year, y = PG_EC), data = m4) + 
  geom_line(color = 'steelblue4', size = 1) + geom_point(size = 2) + 
  labs(x = "Year", y = "Colleges EC Ratio: Postgraduates")


# creating ratios for male to total enrolment per college, and female to total enrolment per college
# not subsetted

length(unique(InstitutionRatios$AISHE_CODE))
# 382 institutions here.

InstitutionRatios$ME_T <- (InstitutionRatios$TOTAL_M)/(InstitutionRatios$GRAND_TOTAL)
InstitutionRatios$FE_T <- (InstitutionRatios$TOTAL_F)/(InstitutionRatios$GRAND_TOTAL)

m3 <- aggregate(. ~ Year, InstitutionRatios, FUN = mean)

p5 <- ggplot(aes(x = Year, y = ME_T), data = m3) + 
  geom_line(color = 'darkorchid', size = 1) + geom_point(color = 'darkorchid', size = 2) + 
  labs(x = "Year", y = "Male Enrolment Ratio") + ggtitle("Male Enrolment Rates out of Total")

p6 <- ggplot(aes(x = Year, y = FE_T), data = m3) + 
  geom_line(color = 'orange2', size = 1) + geom_point(color = 'orange2', size = 2) + 
  labs(x = "Year", y = "Female Enrolment Ratio") + ggtitle("Female Enrolment Rates out of Total")

grid.arrange(p5, p6, ncol = 1)


# lastly, decomposing seat capacities by region using stacked area plots.
RegionalSeats <- read.csv('RegionalSeats.csv')

RegionNames <- unique(RegionalSeats$Region)
RegionNames

# creating plots of specializations wise seats for each region. with titles
for (x in 1:6) {
  assign(paste0("R", (x)),
         ggplot(data = subset(RegionalSeats, Region == RegionNames[x]), aes(x = Year, y = seats, fill = specialization)) + 
           geom_area(position = 'stack', linetype = 1, colour="black") + 
           ggtitle(paste0(RegionNames[x], " seat count"))
  )
}

final_regions <- ggarrange(R1, R2, R3, R4, R5, R6,
                           ncol = 1,
                           nrow = 2)


ggexport(final_regions, filename = "Regions_Specialization_Seats.pdf")