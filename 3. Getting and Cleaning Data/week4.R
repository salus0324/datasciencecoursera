fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv",method="curl")
cameraData<- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))
splitNames <- strsplit(names(cameraData),"\\.")
  
mylist <- list(letters = c("A", "b", "c"), numbers= 1:3, matrix(1:25, ncol=5))
mylist[1]

class(mylist[[1]][1])

splitNames[[6]][1]
firstElement <- function(x){x[1]}       
sapply(splitNames, firstElement)

reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews, 2)
head(solutions, 2)
sub("_","", names(reviews))
testName <- "this_is_a_test"
gsub("_","",testName)
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
cameraData2

grep("Alameda", cameraData$intersection, value=T)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1,7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff         ")

d1 <-date()
d1
class(d1)
d2 <- Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")

x <- c("1jan1960", "2jan1960", "31mar1960","30jul1960")
x
z <- as.Date(x, "%d%b%Y")
z
z[1]-z[2]
as.numeric(z[1]-z[2])
weekdays(d2)
months(d2)
julian(d2)

install.packages("lubridate")
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2018")

ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz="Pacific/Auckland")
?Sys.timezone

x <- dmy(c("1jan1960", "2jan1960", "31mar1960","30jul1960"))
wday(x[2], label=T)
