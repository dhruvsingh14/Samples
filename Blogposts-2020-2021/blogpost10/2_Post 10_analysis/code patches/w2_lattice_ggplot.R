getwd()

# packageVersion("swirl")

library(swirl)

# install_from_swirl("Exploratory Data Analysis")

swirl()

########################
#   plotting week 2    #
########################


###################################
#   lesson 1: lattice plotting    #
###################################

head(airquality)

# lattice plot
xyplot(Ozone~Wind, airquality)
xyplot(Ozone~Wind, airquality, col = "red", pch = 8, main = "Big Apple Data")

xyplot(Ozone~Wind | as.factor(Month), data = airquality, layout = c(5,1))

xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# lattice plots to a graphing device known as trellis
p <- xyplot(Ozone~Wind, data = airquality)
p

# interesting, trellis stores plot in units or components
names(p)

# shows nonNull elements of trellis
mynames[myfull]

# dispays formula component of trellis
p[["formula"]]

# x limits
p[["x.limits"]]

# lattice panel capabilities make it desirable
table(f)

xyplot(y~x|f, layout = c(2,1))
v1

v2

myedit("plot1.R")

# good example of how base lattice can use a function as input

# p <- xyplot(y ~ x | f, panel = function(x, y, ...) {
#   panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
#   panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
# })
# print(p)
# invisible()

source(pathtofile("plot1.R"), local = TRUE)
2

# p2 <- xyplot(y ~ x | f, panel = function(x, y, ...) {
#   panel.xyplot(x, y, ...)  ## First call default panel function
#   panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
# })
# print(p2)
# invisible()

myedit("plot2.R")
source(pathtofile("plot2.R"), local = TRUE)
3

str(diamonds)
table(diamonds$color)
table(diamonds$color, diamonds$cut)
1

myedit("myLabels.R")

# myxlab <- "Carat"
# myylab <- "Price"
# mymain <- "Diamonds are Sparkly!"

source(pathtofile("myLabels.R"), local = TRUE)

xyplot(price~carat|color*cut, data = diamonds, strip = FALSE, pch = 20, xlab = myxlab, ylab = myylab, main = mymain)
2

# running code w/o strip, which labels plots, and takes up some space in the plot
xyplot(price~carat|color*cut, data = diamonds, pch = 20, xlab = myxlab, ylab = myylab, main = mymain)

#####################################
#   lesson 2: working with colors   #
#####################################
1

# studying the grdevices package for colors
sample(colors(), 10)


# color ramp only takes 0,1 arguments to define its color
pal <- colorRamp(c("red", "blue"))

pal(0)
pal(1)

pal(seq(0, 1, len = 6))


# now using colorRampPalette

p1 <- colorRampPalette(c("red", "blue"))
p1(2)
p1(6)

0xcc

# var p2 returns a vector
p2 <- colorRampPalette(c("red", "yellow"))
p2(2)
p2(10)

# gradient interpolated
showMe(p1(20))
showMe(p2(20))

# crisp divide
showMe(p2(2))


p1

?rgb
4

# alpha represents opacity level
p3 <- colorRampPalette(c("blue", "green"), alpha = 0.5)
p3(5)

plot(x, y, pch = 19, col = rgb(0, 0.5, 0.5))

# adding a transparency measure can show density of a scatterplot
plot(x, y, pch = 19, col = rgb(0, 0.5, 0.5, alpha = 0.3))

# now examing the color brewer package as a base palette
cols <- brewer.pal(3, "BuGn")

showMe(cols)
pal <- colorRampPalette(cols)

# creates gradient of 3 colors
showMe(pal(20))

# interesting density image
image(volcano, col = pal(20))
image(volcano, col = p1(20))


###############################
#  lesson 3: Ggplot2 part 1   #
###############################

str(mpg)

# basic qplot
qplot(displ, hwy, data = mpg)

# colored scatter: qplot
qplot(displ, hwy, data = mpg, color = drv)

# adding smooth trend lines and confidence intervals
qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"))

# adding formula for correlation # produces warning: ignoring method, formula
qplot(displ, hwy, data = mpg, color = drv, 
      geom = c("point", "smooth"), method = "loess", formula = y ~ x)

# calling qplot with just y argument shows ranges in a scatter
qplot(y = hwy, data = mpg, color = drv)

# calling qplot with up to 5 arguments
myhigh
qplot(drv, hwy, data = mpg, geom = "boxplot")

# integrating additional variable using color
qplot(drv, hwy, data = mpg, geom = "boxplot", color = manufacturer)

# hist prac
qplot(hwy, data = mpg, fill = drv)

# now creating facets and panels with qplot
qplot(displ, hwy, data = mpg, facets = . ~ drv) # more detailed info than histogram in this case

# panel hist
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)


###############################
#  lesson 4: Ggplot2 part 2   #
###############################

# 7 elements of grammar of graphics - df, aes, geoms, facets, stats, scales, coordinate system

qplot(displ, hwy, data = mpg, geom = c("point", "smooth"), facets = . ~ drv)

# assigning basic plot contents to var, for buildup, can't print w/o plot type specified
g <- ggplot(mpg, aes(displ, hwy))
summary(g)

# basic scatter plot
g + geom_point()

# basic scatter + smooth
g + geom_point() + geom_smooth() # wide confidence bands point to variation towards the right

# using method linear model to generate regression line
g + geom_point() + geom_smooth(method = "lm")

# producing panel scatterplot
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ drv)

# labelling
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ drv) + ggtitle("Swirl Rules!")

# theme can be used to modify legend and background colors
g + geom_point(color = "pink", size = 4, alpha = 1/2) 

# combing aes color with transparency
g + geom_point(size = 4, alpha = 1/2, aes(color = drv))

# alternate labelling methods
g + geom_point(aes(color = drv)) + labs(title = "Swirl Rules!") + labs(x = "Displacement", y = "Hwy Mileage")

# switching off se (confidence intervals) and introducing a thick dashed reg line
g + geom_point(aes(color = drv), size = 2, alpha = 1/2) + 
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
  
# background color is changed
g + geom_point(aes(color = drv)) + theme_bw(base_family = "Times")

# excluding outliers by explicitly stating the range
plot(myx, myy, type = "l", ylim = c(-3, 3))

# replicating above plot in ggplot
g <- ggplot(data = testdat, aes(x = myx, y = myy))

g + geom_line()
g + geom_line() + ylim(-3, 3) # implementing y bounds in ggplot
g + geom_line() + coord_cartesian(ylim = c(-3, 3))

# layering plots, using margins to create row totals
g <- ggplot(data = mpg, aes(x = displ, y = hwy, color = factor(year)))
g + geom_point()

g + geom_point() + facet_grid(drv~cyl, margins = TRUE)
g + geom_point() + facet_grid(drv~cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black")

g + geom_point() + facet_grid(drv~cyl, margins = TRUE) + 
  geom_smooth(method = "lm", se = FALSE, size = 2, color = "black") +
  labs(x = "Displacement", y = "Highway Mileage", title = "Swirl Rules!")


###############################
#  lesson 5: Ggplot2 extras   #
###############################

str(diamonds)

qplot(price, data = diamonds)
range(diamonds$price)

# dividing our data into 30 bins of width ~ 616
qplot(price, data = diamonds, binwidth  = 18497/30)

# hist plots 
brk
counts

qplot(price, data = diamonds, binwidth  = 18497/30, fill = cut)

# density plot: skewness suggests most diamonds were inexpensive
qplot(price, data = diamonds, geom = "density")

# density plots give us a better sense through their peaks and troughs
qplot(price, data = diamonds, geom = "density", color = cut)

# scatterplot
qplot(carat, price, data = diamonds)

# interesting new way to cut the data: introducing shape for scatter points
qplot(carat, price, data = diamonds, shape = cut)

# cutting scatter using color
qplot(carat, price, data = diamonds, color = cut)

# beautiful colored plot with colored lines fitted
qplot(carat, price, data = diamonds, color = cut) + geom_smooth(method = "lm")
# finding: the better the cut the steeper the slope -> stronger price carat ratio for ideal cut 

# panelled plot of scatters by cut
qplot(carat, price, data = diamonds, color = cut, facets = .~cut) + geom_smooth(method = "lm")

# ggplot review
g <- ggplot(data = diamonds, aes(depth, price)) # exploring depth - price relationship
summary(g)
g + geom_point(alpha = 1/3)

# cutting continuous data to essentially create a new categorical variable
cutpoints <- quantile(diamonds$carat, seq(0, 1, length = 4), na.rm = TRUE)
cutpoints

diamonds$car2 <- cut(diamonds$carat, cutpoints)

g <- ggplot(diamonds, aes(depth, price))

# nicely labeled panel plot of diamonds by cut category and price, with panel columns representing carat category
g + geom_point(alpha = 1/3) + facet_grid(cut~car2)
# extra column displays missing values in quantile cutpoints

# to display missing values unincluded in cutpoint 
diamonds[myd,]

# plot of 4 vars plus reg lines
g + geom_point(alpha = 1/3) + facet_grid(cut~car2) + geom_smooth(method = "lm", size = 3, color = "pink")

# boxplots
ggplot(diamonds, aes(carat, price)) + geom_boxplot() + facet_grid(.~cut)






