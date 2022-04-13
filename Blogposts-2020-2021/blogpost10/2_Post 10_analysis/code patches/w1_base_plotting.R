head(pollution)
dim(pollution)

summary(pollution$pm25) # summary stats
4
quantile(ppm)
4

# colored boxplot
boxplot(ppm, col = "blue")
1

# drawing a horizontal line
abline(h = 12)
1

# colored histogram
hist(ppm, col = "green")
1

# 1-d density plot through tick marks
rug(ppm)

low
high

hist(ppm, col = "green", breaks = 100)
1
rug(ppm)

hist(ppm, col = "green")
abline(v = 12, lwd = 2) # drawing vertical line as benchmark
# distribution above or below standard tells us about the overall population
abline(v = median(ppm), col = "magenta", lwd = 4)

# var names
names(pollution)

reg <- table(pollution$region)
reg

barplot(reg, col = "wheat", main = "Number of Counties in Each Region")
3

# multiple 2-dimensional box plots
boxplot(pm25 ~ region, data = pollution, col = "red")

# used to set pane for multiple plots
par(mfrow=c(2,1), mar=c(4,4,2,1)) # mfrow: rows and columns of pane, mar: margins

east <- subset(pollution, region == "east")
head(east)
hist(east$pm25, col = "green")

hist(subset(pollution, region == "west")$pm25, col = "green")

# turning to scatter plots
plot(latitude, pm25, data = pollution)

with(pollution, plot(latitude, pm25))

abline(h = 12, lwd = 2, lty = 2) # lty can be used to create a dashed line

plot(pollution$latitude, ppm, col = pollution$region) # using color to encode information
2

abline(h = 12, lwd = 2, lty = 2)

# setting up pane for mutiple scatterplots
par(mfrow = c(1,2), mar = c(5,4,2,1))

# left pane
west <- subset(pollution, region == "west")
plot(west$latitude, west$pm25, main = "West")
plot(east$latitude, east$pm25, main = "East")
1


# swirl3: Graphics devices
?Devices

with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")

dev.cur()

# writing graph to a pdf
pdf(file="myplot.pdf")

with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")

dev.cur()
dev.off()

# copying screenplot to png in directory
dev.cur()
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png, file = "geyserplot.png")
dev.off()

2

#####################################
#   plotting 4: plotting systems    #
#####################################
head(cars)
with(cars, plot(speed, dist))

# base plotting system allows us to add to a plot that's already been rendered
text(mean(cars$speed), max(cars$dist), "SWIRL rules!")

# lattice plots, do not allow us to add to plots, single call
head(state)

table(state$region)

# scatter life exp vs inc, over reg (nice formatting!)
xyplot(Life.Exp~Income|region, data = state, layout = c(4,1))
xyplot(Life.Exp~Income|region, data = state, layout = c(2,2)) # layout sets the grid

# ggplot combines base plotting / layering with lattice one-off commands
head(mpg)
dim(mpg)
table(mpg$model) # 38 car models

# starting out with qplot scatter
qplot(displ, hwy, data = mpg)


#################################
#   plotting 5: base plotting   #
#################################

head(airquality)

# nice command to show range for one var, instead of full summary
range(airquality$Ozone, na.rm = TRUE)

# plotting dist
hist(airquality$Ozone)

# preparing a boxplot
table(airquality$Month)
boxplot(Ozone~Month, airquality)
boxplot(Ozone~Month, airquality, xlab = "Month", ylab = "Ozone (ppb)", col.axis = "blue", col.lab = "red")

# example of layering with ggplot
title(main = "Ozone and Wind in New York City")

# automatic labels for axes generated in ggplot
with(airquality, plot(Wind, Ozone))

# layering
title(main = "Ozone and Wind in New York City")

# 72 parameters for plotting
length(par())
names(par())

# plot dimensions in inches
par()$pin

# foreground color
par("fg")

# plot characteristics: line type etc
par("pch")

# line type
par("lty")

# empty plot, axes etc, w/o data
plot(airquality$Wind, airquality$Ozone, type = "n")

# layering 
title(main = "Wind and Ozone in NYC")

may <- subset(airquality, Month == 5)
points(may$Wind, may$Ozone, col = "blue", pch = 17)

notmay <- subset(airquality, Month != 5)
points(notmay$Wind, notmay$Ozone, col = "red", pch = 8)

# beutiful lesson on layering a legend onto your plot
legend("topright", pch = c(17, 8), col = c("blue", "red"), legend = c("May", "Other Months"))
# adding dashed line at median
abline(v = median(airquality$Wind), lty = 2, lwd = 2)

# window for two plots
par(mfrow = c(1, 2))
# plot1
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
# plot2
plot(airquality$Ozone, airquality$Solar.R, main = "Ozone and Solar Radiation")

# 
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")

mtext("Ozone and Weather in New York City", outer = TRUE)




