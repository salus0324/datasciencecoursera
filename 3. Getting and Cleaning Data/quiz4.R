fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/idaho.csv",method="curl")
idaho <- read.csv("./data/idaho.csv", stringsAsFactors = F)
names(idaho)
splitNames <- strsplit(names(idaho),"wgtp")
splitNames[[123]]

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2, destfile="./data/gdp.csv",method="curl")
gdp <- read.csv("./data/gdp.csv", skip=4,header=T, stringsAsFactors = F, na.strings="")
names(gdp)
head(gdp)
gdp <- gdp[c("X", "X.1", "X.3", "X.4")]
names(gdp) <- c("CountryCode", "Ranking","Country","Economy")
gdp <- gdp[complete.cases(gdp),]
tail(gdp)
gdp$Economy<-as.numeric(gsub(",","",gdp$Economy))
tail(gdp)
mean(as.numeric(gdp$Economy), na.rm=T)

grep("^United",gdp$Country)

edu <- read.csv("./data/edu.csv", header =T,na.strings="",stringsAsFactors = FALSE)

mergedData <- merge(gdp, edu, by.x = "CountryCode", by.y="CountryCode", all=F)
names(mergedData)

mergedData <- mergedData[!is.na(mergedData$Special.Notes),]
fiscal <- mergedData[grepl("[Ff]iscal",mergedData$Special.Notes),]

june <- fiscal[grep("end: June",fiscal$Special.Notes),]

length(june[,1])

library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)
sampleTimes <- data.frame(sampleTimes)
names(sampleTimes)
head(sampleTimes$sampleTimes)
library(lubridate)
year <- data.frame(ymd(sampleTimes$sampleTimes))
names(year) <- "dates"
head(year)
as.character(year(year$dates))

two12 <- year[(year(year$dates)=="2012"),]
alsomon <- year[(year(year$dates)==2012 & wday(year$dates)==2),]
length(alsomon)
