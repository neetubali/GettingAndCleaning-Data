==================================================================
Tidying data for the  Smartphones Dataset
Version 1.0

This readme file is associated with the script "run_analysis.R" which creates a tidy data set from the raw data set provided. 

Information about the raw data set:
=========================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The raw dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Steps performed by the Script :
==================================================
It is assumed in the steps below that the script file run_analysis.R is present inside the folder "UCI HAR Dataset" which contains the raw data.

1.Merges the training and the test sets to create one data set.
	- Read the X-test and X-train files
	- Merge the two using rbind. This gives data set with 10299 rows (observations) & 561 columns
	- Read the activity data sets(y-test and y-train files)
	- Merge the two using rbind. This gives data set with 10299 rows and 1 coulmn
	- Read the subject data sets (subject_test and subject_train)
	- Merge the two using rbind. This gives data set with 10299 rows and 1 coulmn
	- Assign column names to the 3 new data sets
	
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
	- Select the column names which contain "mean" or "std" using grep and subset commands. 
	- There are 79 columns with "mean" or "std" in the name.
	- There are 3 datasets now : Subjects (10299 *1), Activities(10299 *1), Test& Train data(10299 * 79)
	
3.Uses descriptive activity names to name the activities in the data set
	- Merge the 3 datasets into one using cbind. New data set size : 10299 * 81 
	- Read the activity labels & replace the activity ids in 2nd column with the descriptive activity names.
	
4.Appropriately labels the data set with descriptive variable names. 
	- Read the column names in a vector
	- Remove the undesired () and - using gsub commands
	- Write back the valid column names
	

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	- Load the "dplyr" library
	- Group the data using 'group_by' based on Subject names and Activity names
	- Summarize the data calculating mean for each activity & each subject and assign to a new data_set. This has 180 rows for 30 subjects * 6 activities for each.
	- Write the summarized data to a file using write.table.
