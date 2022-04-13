library(tidyr)

getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/4_October/wk3_post14/1_Post 14_blueprint/q2")

x <- read.csv("insurance_data.csv")


x2 <- gather(x, `Total`, `Not.covered`, `Covered`, `Private.insurance`, `Employment.based`, `Own.Employment.based`,
       `Direct.purchase.insurance`, `Government.health.plan`, key = "variable", value = "counts")


x3 <- spread(x2, Year, counts)

	
	
write.csv(x3, "insurance_data_wide.csv")
	
	
	
	
	



