download.file(url ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "quiz1_1.csv")
db <- read.table("quiz1_1.csv", sep = ",", header = TRUE)
head(db)
Idaho <- subset(db, ST==16 & VAL == 24, select=VAL)
str(Idaho)

library(xlsx)
download.file(url ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile = "quiz1_3.xlsx", method ="curl")
dat <- read.xlsx(file = "quiz1_3.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15, header = TRUE)
sum(dat$Zip*dat$Ext,na.rm=T)

install.packages("XML")
library(XML)
fileUrl = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(file = fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
zipcode = xpathSApply(rootNode, "//zipcode", xmlValue)
zipcode
length(zipcode[zipcode==21231])

library(data.table)
download.file(url ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "quiz1_5.csv")
DT <- fread("quiz1_5.csv")
DT$pwgtp15
