######################
set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] <- NA
X

X[,1]
X[,"var1"]
X[1:2, "var2"]
X[(X$var1 <= 3 | X$var3 > 15),]
X[which(X$var2>8),]
sort(X$var1)
sort(X$var1, decreasing =T)
sort(X$var2, na.last = T)
X[order(X$var1),]
library(plyr)
arrange(X, desc(var1))
X$var4 <- rnorm(5)
Y <- cbind(X, rnorm(5))
Y
#########################################
if(!file.exists(",/data")){
  dir.create("./data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile ="./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")
quantile(restData$councilDistrict, na.rm =T)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))

table(restData$zipCode, useNA ="ifany")
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt
warpbreaks
warpbreaks$replicatd <- rep(1:9, len=54)
warpbreaks
xt <- xtabs(breaks ~., data = warpbreaks)
ftable(xt)
fakeData <- rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units ="Mb")

############################## 
if(!file.exists(",/data")){
  dir.create("./data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile ="./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")

s1 <- seq(1, 10, by=2)
s2 <- seq(1,10,length=3)
x <- c(1,3,8,25,100)
seq(along =x)

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
restData$zipWrong <- ifelse(restData$zipCode <0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode<0)

restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
quantile(restData$zipCode)
X[order(X$var1),]
head(restData[,c(2,9)][order(restData$zipCode),])
table(restData$zipGroups, restData$zipCode)

install.packages("Hmisc")
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
table(restData$zipGroups)

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes", "no"), size=10, replace=T)
yesnofac <- factor(yesno, levels =c("yes", "no"))
yesno
yesnofac
relevel(yesnofac, ref="yes")
as.numeric(yesnofac)

restData2 <- mutate(restData, zipGroups = cut2(zipCode, g =4))
table(restData2$zipGroups)
#############################################
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n=3)
cyldata <- dcast(carMelt, cyl ~ variable, mean)
cyldata

head(InsectSprays)
summary(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount <- lapply(spIns, sum)
sprCount
unlist(sprCount)
sapply(spIns, sum)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))

install.packages("dplyr")
library("dplyr")
options(width =105)
chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)
names(chicago)
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
i <- match("city", names(chicago))
i
j <- match("dptp", names(chicago))
j
head(chicago[, -(i:j)])
chic.f <- filter(chicago, pm25tmean2 >30)
head(chic.f, 10)
chic.f <- filter(chicago, pm25tmean2 >30 & tmpd >80)
head(chic.f)
chicago <- arrange(chicago, date)
head(chicago)
chicago <- arrange(chicago, desc(date))
tail(chicago)
chicago <- rename(chicago, pm25=pm25tmean2, dewpoint = dptp)
head(chicago)
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm=T))
head(select(chicago, pm25, pm25detrend))
chicago <- mutate(chicago, tempcat = factor(1*(tmpd >80), labels = c("cold", "hot")))
hotcold <- group_by(chicago,tempcat )
summarize(hotcold, pm25=mean(pm25, na.rm =TRUE), o3 = max(o3tmean2), no2=median(no2tmean2))
chicago <- mutate(chicago, year = as.POSIXlt(date)$year+1900)
year <- group_by(chicago, year)
summarize(year, pm25=mean(pm25, na.rm =TRUE), o3 = max(o3tmean2), no2=median(no2tmean2))

chicago %>% mutate(month = as.POSIXlt(date)$mon +1) %>% group_by(month) %>% summarize(pm25=mean(pm25, na.rm =TRUE), o3 = max(o3tmean2), no2=median(no2tmean2))
########################################################
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews)
head(solutions)
names(reviews)
mergedData <- merge(reviews, solutions, by.x = "solution_id", by.y="id", all=T)
head(mergedData)
intersect(names(solutions), names(reviews))
mergedData2 <- merge(reviews,solutions, all=TRUE)
mergedData2

df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
df3 <- data.frame(id=sample(1:10), z=rnorm(10))
dfList <- list(df1, df2, df3)
join_all(dfList)
arrange(join(df1,df2),id)
