Getting and Cleanind Data final Project

================

R script called run_analysis.R contained in this repository does the following:

1. Merges the training and the test sets to create one data set from a study which uses smartphone sensors to track motion during particular activities. It read the corresponding train/test datasets from the folder named "UCI HAR Dataset"
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set. The activities are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set called 'newTidyData' with the average of each variable for each activity (the action being performed: walking, sitting, standing, etc.) and each subject (participant in the experiment).