library(lattice)
library(datasets)

xyplot(Ozone~Wind, data=airquality)

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone~Wind|Month, data=airquality, layout =c(5,1))

set.seed(10)
x<-rnorm(100)
f <- rep(0:1, each =50)
y <- x+f-f*x+rnorm(100, sd=0.5)
f <- factor(f, label=c("Group 1", "Group 2"))
xyplot(y~x | f, layout =c(2,1))

xyplot(y~x | f, panel = function(x,y, ...){
  panel.xyplot(x,y, ...)
  panel.abline(h=median(y), lty=2)
})

xyplot(y~x | f, panel = function(x,y, ...){
  panel.xyplot(x,y, ...)
  panel.lmline(x,y, col=2)
})

library(ggplot2)
str(mpg)
mpg$manufacturer <- factor(mpg$manufacturer)
mpg$model <- factor(mpg$model)
mpg$trans <- factor(mpg$trans)
mpg$drv <- factor(mpg$drv)
qplot(displ, hwy, data=mpg, color =drv)
qplot(displ, hwy, data=mpg, geom = c("point", "smooth"))
qplot(hwy, data=mpg, fill=drv)
qplot(displ, hwy, data=mpg, facets=.~drv)
qplot(hwy, data=mpg, facets=drv~., binwidth=2)


install_from_swirl("Exploratory Data Analysis")



