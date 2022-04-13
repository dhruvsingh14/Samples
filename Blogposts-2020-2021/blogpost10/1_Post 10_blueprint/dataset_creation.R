#####################
# setting directory #
#####################

getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk3_post10/1_Post 10_blueprint/acs_1year_data")

####################
# creating dataset #
####################


# Null Dataset
df <- data.frame(matrix(ncol = 23, nrow = 0))

# reading in and appending 2005 data as well
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk3_post10/1_Post 10_blueprint/acs_1year_data/2005")

# dataset_05, reading in
dataset_05 <- read.csv("psam_husa_2005.csv", header = TRUE, fill = FALSE)

# subsetting to relevant columns
dataset_05 <- dataset_05[c("CONP", "ELEP", "FES",	"FINCP", "FS", "FULP", "GASP", "GRNTP", "GRPIP", "HINCP",	"INSP",
                           "MHP", "MRGP", "NOC", "NP", "NPF", "NRC", "OCPIP", "RNTP", "SMOCP", "SMP", "WATP", "ST")]

# replacing na with 0s
dataset_05[is.na(dataset_05)] = 0

# adding year variable
dataset_05$YEAR <- "2005"

# aggregating
agg_data_05 <- aggregate(.~YEAR+ST+FES, dataset_05, FUN = mean)

# appending
df = rbind(df, agg_data_05)



# Macro looping through 2006 to 2018 datasets
for (year in 2006:2018){
  
  # directory
  setwd(paste0("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk3_post10/1_Post 10_blueprint/acs_1year_data/", as.character(year)))

  # dataset_a, reading in
  dataset_a <- read.csv(paste0("psam_husa_", as.character(year), ".csv"), header = TRUE, fill = FALSE)
  
  # subsetting to relevant columns
  dataset_a <- dataset_a[c("CONP", "ELEP", "FES",	"FINCP", "FS", "FULP", "GASP", "GRNTP", "GRPIP", "HINCP",	"INSP",
                           "MHP", "MRGP", "NOC", "NP", "NPF", "NRC", "OCPIP", "RNTP", "SMOCP", "SMP", "WATP", "ST")]
  # replacing na with 0s
  dataset_a[is.na(dataset_a)] = 0
  
  
    
  # dataset_b, reading in
  dataset_b <- read.csv(paste0("psam_husb_", as.character(year), ".csv"), header = TRUE, fill = FALSE)

    # subsetting to relevant columns
  dataset_b <- dataset_b[c("CONP", "ELEP", "FES",	"FINCP", "FS", "FULP", "GASP", "GRNTP", "GRPIP", "HINCP",	"INSP",
                          "MHP", "MRGP", "NOC", "NP", "NPF", "NRC", "OCPIP", "RNTP", "SMOCP", "SMP", "WATP", "ST")]
  # replacing na with 0s
  dataset_b[is.na(dataset_b)] = 0

    
  # combining a and b
  psam_hus <- rbind(dataset_a, dataset_b)
  
  # adding year variable
  psam_hus$YEAR <- as.character(year)
  
  # aggregating
  agg_data <- aggregate(.~YEAR+ST+FES, psam_hus, FUN = mean)
  
  # appending
  df = rbind(df, agg_data)
    
  # printing progress
  print(as.character(year))
}

#######################
# writing out dataset #
#######################

write.csv(df, "C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk3_post10/1_Post 10_blueprint/acs_1year_data/final_acs_data.csv")
