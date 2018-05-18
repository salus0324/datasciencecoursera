#Getting and Cleaning Data Course Project Codebook



##subject_test
  This dataframe contains data imported from subject_test.txt file. It includes a column of subject ID who were involved in test measurements. The script assigns "ID" as the column name. The value ranges from 1 to 30



##x_test
  This dataframe contains data imported from x_test.txt file. It includes multiple columns for each feature of measurements. Each row is a set of measurement for each activity from each subject.



##y_test
  This dataframe contains data imported from y_test.txt file. It includes a column of activity label numbers for each measurements. The script assigns "Activity Label" as the column name. The value ranges from 1 to 6.



##subject_train
  This dataframe contains data imported from subject_train.txt file. It includes a column of subject ID who were involved in train measurements. The script assigns "ID" as the column name. The value ranges from 1 to 30



##x_train
  This dataframe contains data imported from x_train.txt file. It includes multiple columns for each feature of measurements. Each row is a set of measurement for each activity from each subject.



##y_train
  This dataframe contains data imported from y_train.txt file. It includes a column of activity label numbers for each measurements. The script assigns "Activity Label" as the column name. The value ranges from 1 to 6.



##label
  This dataframe contains data imported from activity_labels.txt file. It includes two columns: label number and activity description. The script assigns column name as "Label" and "Activity."



##feature
  This dataframe contains data imported from features.txt file. It includes a column with descriptions on features of measurements. The script assign column name as "Feature"



##test
  This dataframe is a combination of all the test related data frames (subject_test, y_test, and x_test). It has columns of ID, Activity Label and all the measurement features.



##train
  This dataframe is a combination of all the train related data frames (subject_train, y_train, and x_train). It has columns of ID, Activity Label and all the measurement features.



##combined
  This dataframe is the combination of test and train dataframe. It has columns of ID, Activity Label and all the measurement features. Then the script order the dataframe by ID and by the activity label both in ascending orders.

-column names of combined dataframe
--The script uses feature dataframe to assign more descriptive column names for the measurement columns.

-activity label of combined dataframe
--The script creates "labeling" function and uses it to replace the activity.Label numbers to more descriptive strings.



##mean_std
  The script extracts only mean and standard deviation information from the measurement columns and assign to mean_std dataframe.
  Then the script groups group the mean_std dataframe by ID and by Activity.Label




##result
  The script creates the final data frame, result, that has the average of each variable for each activity and each subject. Then finally it writes out the result data frame as a tidydata.txt file
          