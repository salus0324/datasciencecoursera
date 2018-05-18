#Coursera Getting and Cleaning data Course Project
The script "run_analysis.R" uses data files from UCI HAR Dataset to create a tidy data file, "tidydata.txt. Below is the list of functionality of the script "run_analysis.R"

1. It merges the training and the test sets to create one data set.  
*It extracts data from subject_test, x_test, y_test, subject_train, x_train and y_train text files. It cbind among test files and train files, then and rbind the test and train data. The resulting dataframe from this activity is combined  

2. It assigns descriptive activity names to name the activities in the data set  
*It uses data extracted from activity_label.txt to replace the number label to descriptive string labels such as "Walking" or "Sitting." It creates a function "labeling" that finds the correct label string and uses sapply function to use the label function for each number label numbers of observation.  

3. It assigns labels the data set with descriptive variable names.  
*It uses data extracted from features.txt to replace the column names of the measurements to descriptive string labels.  

4. It extracts only the measurements on the mean and standard deviation for each measurement.  
*It uses grep function to extract columns with names that include mean( or std( strings from combined dataframe and assign to mean_std dataframe.  

5. From the data set in step 4, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
*It groups the mean_std dataframe by it's id and activity label. Then it uses "summarise_all" function to take average of each measurement variables for each activity and each subject ID.  

For the details on the background or the data itself, please refer to README.txt file in UCI HAR Dataset.