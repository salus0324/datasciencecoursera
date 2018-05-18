#Import Necessary libraries
library(zip)
library(dplyr)
library(plyr)

#Download the .zip file with the provide URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile ="./data.zip", method="curl")

#Unzip the file and import all the necesary .txt files
unzip(zipfile ="data.zip")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="ID")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names="Activity Label")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="ID")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="Activity Label")
label <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("Label", "Activity"), stringsAsFactors = F)
feature <- read.table("./UCI HAR Dataset/features.txt", col.names=c("#", "Feature"),stringsAsFactors = F)[2]

# combine all the test related data into one dataframe
test <- data.frame(c(subject_test, y_test, x_test))
# combine all the train related data into one dataframe
train <- data.frame(c(subject_train, y_train, x_train))
# combine the test and train dataframes into one combined dataframe
combined <- rbind(test, train)
# order the combined dataframe by ID and by Activity.Label numbers
combined <- arrange(combined, ID, Activity.Label)

# Assign more desciprtion column names for the measurements
names(combined)[3:ncol(combined)] <- feature[,1]

# Create labeling function to use to replace the Activity.Label numbers to more descriptive strings
labeling <- function(x){
  label$Activity[x]
}
# Use the previously created labeling function to replace the activity.Label numbers to more descriptive strings
combined$Activity.Label <- sapply(combined$Activity.Label, labeling)

# Extract only mean and standard deviation information from the measurement columns
mean_std <-cbind(combined[1:2], combined[,grep("mean\\(|std\\(", names(combined))])

# Group the mean_std dataframe by ID and by Activity.Label
grouped <- group_by(mean_std, ID, Activity.Label)

# Create the final data frame that has the average of each variable for each activity and each subject.
result <- summarize_all(grouped, mean)
# Write out the result data frame as a .txt file
write.table(result, "tidydata.txt",row.names = F)
