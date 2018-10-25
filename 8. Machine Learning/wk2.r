library(caret)
library(kernlab)
data(spam)
#=================================================
#=================================================
# Data Slicing
#=================================================
# Partition
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
set.seed(32343)
modelFit <- train(type~., data=training, method="glm")
modelFit
modelFit$finalModel
prediction <- predict(modelFit, newdata=testing)
prediction

confusionMatrix(prediction, testing$type)
#=================================================
# K fold
set.seed(32323)
folds <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain=TRUE)
sapply(folds, length)
folds[[1]][1:10]
#==================================================
# Resampling, boostrap
set.seed(32323)
folds <- createResample(y=spam$type, times=10, list=TRUE)
sapply(folds,length)
#==================================================
# Time slices
set.seed(32323)
tme <- 1:1000
folds <- createTimeSlices(y=tme, initialWindow=20, horizon=10)
names(folds)
#=================================================
#=================================================
# Data Slicing
# Training options
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
set.seed(32343)
modelFit <- train(type~., data=training, method="glm")

args(train.default)
#=================================================
#=================================================
# Plotting predictors
library(ISLR)
library(ggplot2)
library(caret)
data(Wage)
summary(Wage)
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training)
dim(testing)
#=================================================
featurePlot(x=training[,c("age", "education", "jobclass")], y=training$wage, plot="pairs")
qq <- qplot(age, wage, colour=education, data=training)
qq+ geom_smooth(method="lm", formula=y~x)
#=================================================
library(Hmisc)
cutWage <- cut2(training$wage, g=3)
table(cutWage)
p1 <- qplot(cutWage, age, data=training,fill=cutWage, geom=c("boxplot"))
p1
p2 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot", "jitter"))
p2
#=================================================
t1<- table(cutWage, training$jobclass)
t1
prop.table(t1,1)           
#=================================================
qplot(wage, colour=education, data=training, geom="density")
#=================================================
#=================================================
# Preprocessing
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
hist(training$capitalAve, main="", xlab="ave. capital run length")
trainCapAve <- training$capitalAve
trainCapAveS<- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(trainCapAveS)
sd(trainCapAveS)

preObj <- preProcess(training[,-58], method = c("center", "scale"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
mean(trainCapAveS)
#=================================================
#=================================================
# Covariate creation
#=================================================
library(ISLR)
library(caret)
data(Wage)
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
# Common covariates to add, dummy variables. Convert factor variabes to indicator variables
table(training$jobclass)
dummies <- dummyVars(wage~jobclass, data=training)
head(predict(dummies, newdata=training))
# Removing zero covariates
nsv <- nearZeroVar(training, saveMetrics = TRUE)
nsv
#Spline basis
library(splines)
bsBasis <- bs(training$age, df=3)
lm1 <- lm(wage~bsBasis, data=training)
plot(training$age, training$wage, pch=19, cex=0.5)
points(training$age, predict(lm1, newdata=training), col="red", pch=19, cex=0.5)
predict(bsBasis, age=testing$age)
#=================================================
#=================================================
# Preprocessing with PCA
#=================================================
# Correlated predictors
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

M <- abs(cor(training[,-58]))
diag(M) <- 0
which(M > 0.8,arr.ind=T)
names(spam)[c(34,32)]
plot(spam[,34], spam[,32])
#We could rotate the plot
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 0.71*training$num415 - 0.71*training$num857
plot(X,Y)
# Principal components in R- prcomp
smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
plot(prComp$x[,1],prComp$x[,2])
prComp
# PCA on SPAM data
typeColor <- ((spam$type=="spam")*1 + 1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2],col=typeColor,xlab="PC1",ylab="PC2")
# PCA with caret
preProc <- preProcess(log10(spam[,-58]+1),method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)
# Preprocessing with PCA - building model
preProc <- preProcess(log10(training[,-58]+1),method="pca",pcaComp=2)
trainPC <- predict(preProc,log10(training[,-58]+1))
modelFit <- train(y=training$type,method="glm",x=trainPC)
# Preprocessing with PCB - testing model
testPC <- predict(preProc,log10(testing[,-58]+1))
confusionMatrix(testing$type,predict(modelFit,testPC))
# Alternative (set # of PCs)
modelFit1 <- train(training$type ~ .,method="glm",preProcess="pca",data=training)
confusionMatrix(testing$type,predict(modelFit1,testing))

#=================================================
#=================================================
# Predicting with regression
library(caret)
data("faithful")
set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list = FALSE)
trainFaith <- faithful[inTrain,]
testFaith <- faithful[-inTrain,]
head(trainFaith)
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="Waiting", ylab="Duration")
#Fit a linear model
lm1 <- lm (eruptions~waiting, data=trainFaith)
summary(lm1)
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="Waiting", ylab="Duration")
lines(trainFaith$waiting, lm1$fitted, lwd=3)
coef(lm1)[1] + coef(lm1)[2]*80
newdata <- data.frame(waiting=80)
predict(lm1, newdata)
# Compare train vs test
par(mfrow=c(1,2))
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="waiting", ylab="Duration")
lines(trainFaith$waiting, predict(lm1), lwd=3)
plot(testFaith$waiting, testFaith$eruptions, pch =19, col="blue", xlab="Waiting", ylab="Duration")
lines(testFaith$waiting, predict(lm1, newdata=testFaith,lwd=3))
# Get training set/test set errors
#Calculate RMSE on training
sqrt(sum((lm1$fitted-trainFaith$eruptions)^2))
# Calculate RMSE on test
sqrt(sum((predict(lm1, newdata=testFaith)-testFaith$eruptions)^2))
# Prediction intervals
pred1 <- predict(lm1, newdata=testFaith, interval="prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting, testFaith$eruptions, pch=19, col="blue")
matlines(testFaith$waiting[ord], pred1[ord,], type="l",col=c(1,2,2), lty=c(1,1,1), lwd=3)
# Using caret function
modFit <- train(eruptions ~ waiting, data= trainFaith, method="lm")
summary(modFit$finalModel)
#=================================================
#=================================================
# Predicting with regression multiple covariates
library(ISLR)
library(ggplot2)
library(caret)
data(Wage)
Wage <- subset(Wage, select = -c(logwage))
summary(Wage)
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list = FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
featurePlot(x=training[,c("age", "education", "jobclass")], y=training$wage, plot="pairs")
qplot(age, wage, colour=jobclass, data=training)
qplot(age, wage, colour=education, data=training)
par(mfrow=c(1,1))
modFit <- train(wage~age+jobclass+education, method="lm", data=training)
finMod <- modFit$finalModel
print(modFit)
print(finMod)
plot(finMod, 1, pch=19, cex=0.5, col='#00000010')
qplot(finMod$fitted, finMod$residuals, colour=race, data=training)
#Plot by index
plot(finMod$residuals, pch=19)
#Predicted vs truth in test set
pred <- predict(modFit, testing)
qplot(wage, pred,colour=year, data=testing)
#If you want to use all covariates
modFitAll <- train(wage~., data=training, method="lm")
pred <- predict(modFitAll, testing)
qplot(wage, pred, data=testing)
#quiz wk2
#Problem 2,3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
library(Hmisc)
training$FlyAsh <- cut2(training$FlyAsh, g=4 )
testing = mixtures[-inTrain,]
qq <- qplot(age, wage, colour=education, data=training)
qplot(1:nrow(training), training$CompressiveStrength,colour=training$FlyAsh, data=training)
qplot(1:nrow(training), training$CompressiveStrength,colour=training$Age, data=training)
cor(training$CompressiveStrength, training$FlyAsh)
dim(training)
hist(training$Superplasticizer)
min(training$Superplasticizer)
# Problem 4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
ILtraining <- cbind(training[, grepl("^IL",colnames(training))])
ILtesting <- cbind(testing[, grepl("^IL",colnames(testing))])

preProc <- preProcess(ILtraining,method="pca", thresh=0.90)
preProc

#problem 5
ILtraining <- cbind(ILtraining, training$diagnosis)
ILtesting <- cbind(ILtesting, testing$diagnosis)
head(ILtraining)
modelnopca <- train(`training$diagnosis` ~ .,method="glm",data=ILtraining)
confusionMatrix(predict(modelnopca,ILtesting), testing$diagnosis)

modelwpca <- train(`training$diagnosis` ~ ., preProc='pca',method="glm",data=ILtraining)
confusionMatrix(predict(modelwpca,ILtesting), testing$diagnosis)
