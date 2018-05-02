library(datasets)
data(iris)
s <- split(iris, iris$Species)
lapply(s, function(x) colMeans(x))
