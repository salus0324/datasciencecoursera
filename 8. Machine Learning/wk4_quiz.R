#Problem 1
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(38833)
modRF <- train(y~., method ='rf', data=vowel.train)
modBOOST<- train(y~., method ='gbm', data=vowel.train)
predRF <- predict(modRF, vowel.test)
predBOOST <- predict(modBOOST, vowel.test)
RF_accuracy <- sum(predRF==vowel.test$y)/length(predRF)
BOOST_accuracy <- sum(predBOOST==vowel.test$y)/length(predBOOST)
agreed_TestData <- vowel.test[predRF==predBOOST,]
agreedpredict <- predict(modRF, agreed_TestData)
agreement_accuracy <- sum(agreedpredict==agreed_TestData$y)/length(agreedpredict)

c(RF_accuracy, BOOST_accuracy, agreement_accuracy)
#######
#Problem2
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
set.seed(62433)
#Build three different models
mod1<- train(diagnosis~., method ='rf', data=training)
mod2 <- train(diagnosis~., method ="gbm", data=training)
mod3 <- train(diagnosis~., method ="lda", data=training)

pred1 <- predict(mod1, testing)
pred2 <- predict(mod2, testing)
pred3 <- predict(mod3, testing)


#Fit a model that combines predictors
predDF <- data.frame(pred1, pred2, pred3, diagnosis=testing$diagnosis)
combModFit <- train(diagnosis~., method="rf", data=predDF)
combPred <- predict(combModFit, predDF)


mod1_accuracy <- sum(pred1==testing$diagnosis)/length(pred1)
mod2_accuracy <- sum(pred2==testing$diagnosis)/length(pred2)
mod3_accuracy <- sum(pred3==testing$diagnosis)/length(pred3)
comb_accuracy <- sum(combPred==testing$diagnosis)/length(combPred)
c(mod1_accuracy, mod2_accuracy, mod3_accuracy, comb_accuracy)
####
#Problem3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
set.seed(233)
names(training)
modlasso <- train(CompressiveStrength~.,method="lasso", data=training)
library(elasticnet)
predictLasso <- predict(modlasso, testing)
onject <- enet(testing$CompressiveStrength,predictLasso)
plot.enet(modlasso$finalModel, xvar="step")
#####
#Problem4
library(lubridate) # For year() function below
library(forecast)
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

ttest <- ts(testing$visitsTumblr)

mod <- bats(tstrain)
pred <-forecast(mod, h=length(ttest), level=0.95)
accuracy(pred, testing$visitsTumblr)
accuracy_percentage <- sum(pred$lower<= testing$visitsTumblr&testing$visitsTumblr<=pred$upper)/length(testing$visitsTumbl)
accuracy_percentage

###problem5
rm(list = ls())
set.seed(3523)
library(AppliedPredictiveModeling)
library(e1071)
library(caret)
library(Metrics)
data(concrete)
inTrain <- createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training <- concrete[ inTrain,]
testing <- concrete[-inTrain,]

set.seed(325)
model <- svm(CompressiveStrength ~ ., data = training)
rmse(testing$CompressiveStrength, predict(model, testing))
