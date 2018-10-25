#Regression regularization
# regression subset selection in the prostate dataset
library(ElemStatLearn)
data(prostate)
covnames <- names(prostate[-(9:10)])
y <- prostate$lpsa
x <- prostate[, covnames]
form <- as.formula(paste("lpsa~", paste(covnames, collapse="+"), sep=""))

summary(lm(form, data=prostate[prostate$train,]))
#RSS of train is always smaller and decrease as the number of predictors increases.
#However RSS of test data will increase if it overfits
set.seed(1)
train.ind <- sample(nrow(prostate), ceiling(nrow(prostate))/2)
y.test <- prostate$lpsa[-train.ind]
x.test <- x[-train.ind,]
y <- prostate$lpsa[train.ind]
x <- x[train.ind,]
p <- length(covnames)
rss <- list()
for (i in 1:p) {
  cat(i)
  Index <- combn(p,i)
  
  rss[[i]] <- apply(Index, 2, function(is) {
    form <- as.formula(paste("y~", paste(covnames[is], collapse="+"), sep=""))
    isfit <- lm(form, data=x)
    yhat <- predict(isfit)
    train.rss <- sum((y - yhat)^2)
    
    yhat <- predict(isfit, newdata=x.test)
    test.rss <- sum((y.test - yhat)^2)
    c(train.rss, test.rss)
  })
}

plot(1:p, 1:p, type="n", ylim=range(unlist(rss)), xlim=c(0,p), xlab="number of predictors", ylab="residual sum of squares", main="Prostate cancer data")
for (i in 1:p) {
  points(rep(i-0.15, ncol(rss[[i]])), rss[[i]][1, ], col="blue")
  points(rep(i+0.15, ncol(rss[[i]])), rss[[i]][2, ], col="red")
}
minrss <- sapply(rss, function(x) min(x[1,]))
lines((1:p)-0.15, minrss, col="blue", lwd=1.7)
minrss <- sapply(rss, function(x) min(x[2,]))
lines((1:p)+0.15, minrss, col="red", lwd=1.7)
legend("topright", c("Train", "Test"), col=c("blue", "red"), pch=1)

#Problem with high-dimensional data
small <- prostate[1:5,]
lm(lpsa~.,data=small)


########
##Combinding predictors, emsambling method
library(ISLR)
data(Wage)
library(ggplot2)
library(caret)
Wage <- subset(Wage, select=-c(logwage))

inBuild<- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
validation <- Wage[-inBuild,]
buildData <- Wage[inBuild,]
inTrain <- createDataPartition(y=buildData$wage, p=0.7, list=FALSE)
training <- buildData[inTrain,]
testing <- buildData[-inTrain,]
#Build two different models
mod1<- train(wage~., method ='glm', data=training)
mod2 <- train(wage~., method ="rf", data=training, trControl = trainControl(method="cv"), number=3)
pred1 <- predict(mod1, testing)
pred2 <- predict(mod2, testing)
qplot(pred1, pred2, colour = wage, data=testing)
#Fit a model that combines predictors
predDF <- data.frame(pred1, pred2, wage=testing$wage)
combModFit <- train(wage~., method="gam", data=predDF)
combPred <- predict(combModFit, predDF)
sqrt(sum((pred1-testing$wage)^2))
sqrt(sum((pred2-testing$wage)^2))
sqrt(sum((combPred-testing$wage)^2))
# Now use validation set
pred1V <- predict(mod1, validation)
pred2V <- predict(mod2, validation)
predVDF <- data.frame(pred1=pred1V, pred2=pred2V)
combPredV <- predict(combModFit, predVDF)
sqrt(sum((pred1V-validation$wage)^2))
sqrt(sum((pred2V-validation$wage)^2))
sqrt(sum((combPredV-validation$wage)^2))
####forcasting]
library(quantmod)
from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/31/13", format="%m/%d/%y")
getSymbols("GOOG", src="yahoo", from=from.dat, to=to.dat)
head(GOOG)
mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
ts1<-ts(googOpen, frequency=12)
plot(ts1, xlab="Years+1", ylab="GOOG")
plot(decompose(ts1), xlab="years+1")
#Training and test sets
ts1Train <- window(ts1, start=1, end=5)
ts1Test <- window(ts1, start=5, end=(7-0.01))
ts1Train
#Simple moving average
library(forecast)
plot(ts1Train)
lines(ma(ts1Train, order=3), col="red")
#Exponential smoothing
ets1 <- ets(ts1Train, model="MMM")
fcast <- forecast(ets1)
plot(fcast)
lines(ts1Test, col="red")
accuracy(fcast, ts1Test)

#######
#Unsupervised prediction
#Iris example ignoring species labels
data(iris)
library(ggplot2)
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
kMeans1 <- kmeans(subset(training, select=-c(Species)), centers=3)
training$clusters <- as.factor(kMeans1$cluster)
qplot(Petal.Width, Petal.Length, colour=clusters, data=training)
table(kMeans1$cluster, training$Species)
modFit <- train(clusters~., data=subset(training, select=-c(Species)), method="rpart")
table(predict(modFit, training), training$Species)
#Apply on test
testClusterPred <- predict(modFit, testing)
table(testClusterPred, testing$Species)
