url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile ="./data/p1.csv", method ="curl")
p1 <- read.csv("./data/p1.csv", header=T)
names(p1)
agricultureLogical <- (p1$ACR==3& p1$AGS==6)
head(p1[which(agricultureLogical),],n=3)

library(jpeg)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url2, destfile = "./data/pic.jpeg")
pic <- readJPEG("./data/pic.jpeg", native = T)
class(pic)
dim(pic)
data <- list(pic)
data
str(data)
quantile(pic, probs=c(0.3,0.8))

library("dplyr")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "./data/gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "./data/edu.csv")
gdp <- read.csv("./data/gdp.csv", header = T, skip = 4,na.strings="",stringsAsFactors = FALSE)[,1:2]
names(gdp) <- c("CountryCode", "Ranking")
gdp <- gdp[complete.cases(gdp),]

edu <- read.csv("./data/edu.csv", header =T,na.strings="",stringsAsFactors = FALSE)

mergedData <- merge(gdp, edu, by.x = "CountryCode", by.y="CountryCode", all=F)
mergedData$Ranking <- as.numeric(mergedData$Ranking)
mergedData <- mergedData[order(mergedData$Ranking, decreasing = T),]
length(mergedData[,1])
mergedData[13,]

HighOECD <- mergedData[(mergedData$Income.Group == "High income: OECD"),]
mean(HighOECD$Ranking)

HighnOECD <- mergedData[(mergedData$Income.Group == "High income: nonOECD"),]
mean(HighnOECD$Ranking)

mergedData$RankingGroups <- cut(mergedData$Ranking, breaks=quantile(mergedData$Ranking, probs=seq(0,1,0.1)))
?quantile
table(mergedData$RankingGroups, mergedData$Income.Group)





