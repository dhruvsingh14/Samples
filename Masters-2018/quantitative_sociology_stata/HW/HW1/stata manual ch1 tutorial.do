sysuse auto
browse 
describe
notes

***Part I****

*Q1

sort mpg
list make if mpg>=28 //this lists 11 cars, (only asked for 10) due to eql. vals.
list make mpg in 65/74

*Q2
list make price mpg in 1/3  //again 8, rather than just 3, are listed

summarize
codebook
codebook make

*Q3
mean mpg
summarize price if mpg<21.9
summarize price if mpg>21.9

*Q4
summarize length if foreign==0 //foreign==0 => domestic (US/Canada)
summarize length if foreign==1 //foreign==1 => foreign


browse if missing(rep78)
list make if missing(rep78)

summarize price, detail

tabulate foreign
tabulate rep78

tabulate rep78 foreign, row

*Q5
tabulate price foreign


summarize mpg if foreign==0
summarize mpg if foreign==1
by foreign, sort : summarize mpg

tabulate foreign, summarize(mpg)

ttest mpg, by(foreign) 
 
*Q6
ttest price, by(foreign)

correlate mpg weight 
by foreign, sort : correlate mpg weight
 
 
*Q7 
correlate mpg price

by foreign, sort : correlate mpg price


*multiple correlation matrix is useful when investigating collinearity between
*predictor variables

scatter mpg weight
twoway (scatter mpg weight)


*Q8
twoway (scatter mpg price)


twoway (scatter mpg weight), by(foreign, total)


*Q9 
twoway (scatter mpg price), by(foreign, total)
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


