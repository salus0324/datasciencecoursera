library(AppliedPredictiveModeling)
library(caret)
library(ElemStatLearn)
library(pgmm)
library(rpart)

#Problem1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
inTrain <- createDataPartition(y=segmentationOriginal$Class, p=0.7, list=FALSE)
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]
set.seed(125)
fit <- train(Class~., method ="rpart", data=training)
print(fit$finalModel)
plot(fit$finalModel, uniform=TRUE, main="Classification Tree")
text(fit$finalModel, use.n=TRUE, all=T, cex=.8)


#Problem3
library(pgmm)
data(olive)
olive = olive[,-1]
names(olive)
modFit <- train(Area~., method ="treebag", data=olive)
modFit$finalModel
newdata = as.data.frame(t(colMeans(olive)))
newdata
predict(modFit, newdata)

#Problem4
library(ElemStatLearn)
library(caret)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)
names(trainSA)
modFit <- train(chd~tobacco+typea+ldl+age+alcohol+obesity, method ="glm", family="binomial", data=trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
prediction <- predict(modFit, trainSA)
predictiontest <- predict(modFit,testSA)
missClass(trainSA$chd, prediction)
missClass(testSA$chd, predictiontest)

#problem5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
modFit <- train(y~., data=vowel.train, method="rf", prox=TRUE)
varImp(modFit)
