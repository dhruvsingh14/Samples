#############
# libraries #
#############
library(ggplot2)

#####################
# setting directory #
#####################
getwd()
setwd("C:/Dhruv/Misc/Personal/writing/Blogging/2_posts/3_September/wk3_post10/2_Post 10_analysis")

###################
# reading in data #
###################
x <- read.csv("final_acs_data.csv")

#################
# plotting data #
#################

# colored boxplot
boxplot(x$FINCP, col = "blue")
boxplot(x$HINCP, col = "blue")
# both have a median income a little over 50,000 (for household and family)

# colored boxplot
boxplot(x$NRC, col = "pink")
boxplot(x$NP, col = "pink")
boxplot(x$NOC, col = "pink")
boxplot(x$NPF, col = "pink")
# in addition, the number of ppl per family is an average of 3, with an average of 1 child

# colored histogram
hist(x$OCPIP, col = "green") # owner costs
hist(x$RNTP, col = "green") # rent
hist(x$GRPIP, col = "green") # rent as a percentage
hist(x$GRNTP, col = "green") # total rent

# multiple 2-dimensional box plots
boxplot(FINCP ~ FES, data = x, col = "red")


# plotting subset for DC only
hist(subset(x, ST == 11)$HINCP, col = "green")
hist(subset(x, ST == 11)$FINCP, col = "green")

hist(subset(x, ST == 25)$HINCP, col = "purple")
hist(subset(x, ST == 25)$FINCP, col = "purple")

hist(subset(x, ST == 51)$HINCP, col = "orange")
hist(subset(x, ST == 51)$FINCP, col = "orange")



# turning to scatter plots
plot(x$FINCP, x$NP, data = x)




# switching to grammar of graphics
qplot(HINCP, NP, data = x, geom = c("point", "smooth"), facets = . ~ FES)



x_reg <- lm(HINCP~CONP+ELEP+FES+FS+FULP+GASP+GRNTP+GRPIP+HINCP+INSP+MHP+MRGP+NOC+NP+NPF+NRC+OCPIP+RNTP+SMOCP+SMP+WATP+ST, data=x)
x_reg

summary(x_reg)


x_reg_ii <- lm(FINCP~CONP+ELEP+FES+FS+FULP+GASP+GRNTP+GRPIP+HINCP+INSP+MHP+MRGP+NOC+NP+NPF+NRC+OCPIP+RNTP+SMOCP+SMP+WATP+ST, data=x)
x_reg_ii

summary(x_reg_ii)


# finally, line graphs of what we want
ggplot(data = x, aes(x = NPF, y = HINCP)) + geom_line() + facet_wrap( ~ FES) + geom_smooth(method = "lm")
ggplot(data = x, aes(x = NRC, y = HINCP)) + geom_line() + facet_wrap( ~ FES) + geom_smooth(method = "lm")






