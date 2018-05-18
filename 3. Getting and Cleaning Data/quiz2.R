library(httr)
library(XML)
library(jsonlite)
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "ceaffde4c8e6300a5dde",
                   secret = "d24d7e4b980db64309481b3c6207fb199bbe95c7")
sig <- sign_oauth1.0(myapp, token ="23931a0cb2447d0c6df8ae97ce3499384a3b7bc7")
GHhandle <- GET("https://api.github.com/users/jtleek/repos", sig)
content1 <- content(GHhandle)
json1 <- jsonlite::fromJSON(toJSON(content1, pretty=T))
head(json1)
json1[json1$name == "datasharing", "created_at"]

library(RMySQL)
acs <- data.frame("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")


result <- dbGetQuery(acs, "show databases;")
result


con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode = readLines(con)
nchar(htmlcode[10])
nchar(htmlcode[20])
nchar(htmlcode[30])
nchar(htmlcode[100])
close(con)
htmlcode

haha <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", width = c(12,7,4,9,4,9,4,9,4),  skip = 4)
sum(haha$V4)

