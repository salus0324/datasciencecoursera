setwd("C:/Users/kshim/Documents/Coursera/datasciencecoursera/10. Capstone/final")

#Question #1
enblogsize <- file.info("en_US.blogs.txt")$size
print(paste("There are", round(as.numeric(enblogsize)/1e6,0), "mb in the file: en_US.blogs.txt"))

#Question #2
con <- file("en_US.twitter.txt", "r") 
numline <- length(readLines(con))   
print(paste("There are about", round(as.numeric(numline)/1000000,0), "million lines in the file: en_US.twitter.txt"))
close(con)

#Question #3
con1 <- file("en_US.blogs.txt", "r") 
con2 <- file("en_US.twitter.txt", "r")
con3 <- file("en_US.news.txt", "r")
con1maxline <- max(nchar(readLines(con1)))
con2maxline <- max(nchar(readLines(con2)))
con3maxline <- max(nchar(readLines(con3)))
 
print(paste("The longest line in en_US.blogs.txt has ", con1maxline, " characters"))
print(paste("The longest line in en_US.twitter.txt has ", con2maxline, " characters"))
print(paste("The longest line in en_US.news.txt has ", con3maxline, " characters"))
print(paste("Therefore en_US.blogs.txt has the longest line:", con1maxline," characters"))

close(con1, con2, con3)

#Question #4
con <- file("en_US.twitter.txt", "r") 
lines <- readLines(con)
ratio <- sum(grepl("love",lines))/sum(grepl("hate", lines))   
print(paste("There ration between lines with love to those of hate is ", round(ratio,2), "in the file: en_US.twitter.txt"))
close(con)

#Question #5
con <- file("en_US.twitter.txt", "r") 
lines <- readLines(con)
lines[grep("biostats", lines)]
close(con)

#Question #6
con <- file("en_US.twitter.txt", "r") 
lines <- readLines(con)
nummatch <- sum(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", lines))
print(paste("There are ", nummatch, " exact matches in the file: en_US.twitter.txt"))
close(con)
