Code Book for analysis on Samsung sensor data

================

The original data sets may be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Step 1: Combining  the data into one single data frame:
The X_train, y_train and subject_train were firstly read into R via read.table command and then combined into a single data set with cbind() function, such that last two columns in the set represent subject_train (subject ID) and activity (i.e. y_train). The same steps were performed on the test sets. Next step was combining train and test data frames into one dataset with rbind() function. 

# Step 2: Extracting only the measurements on the mean and standard deviation for each measurement.
Since features in this dataset contain various measurments not needed for the analysis, the features were reduced to include only mean and standard deviation of each sensor measurement. Features.txt file contains all the feature names. This file was used to extract only those instances that have a matching pattern in them, in this case the pattern was "mean()" and "std()" which was given to a grep command that does string manipulation. grep command gives a vector containing columns that contain the pattern, based on this vector the tidyData data frame was created. TidyData has 10299 observations of 68 variables.

# Step 3: Replacing numeric activities with the descriptive names.
activity_labels.txt contains the real/descriptive labels for each activity. For the purpose of replacing the numeric values in the last column of the tidyData with the descriptive ones I used sapply function that applies simple function on each element of the last column of tidyData set. This function simply replaces the numeric value with its corresponding descriptive.

# Step 4: Labeling the tidyData with descriptive variable names. 
In order to make the dataset more descriptive and readable certain variable names needed to be replaced with more descriptive versions. Therefore, simple string substitution was performed in order to change the following variable names: 
- each encounter of t was replaced with Time
- each encounter of f was replaced with Frequency
- each encounter of Acc was replaced with Accelerometer
- each encounter of Gyro was replaced with Gyroscope
- each encounter of Mag was replaced with Magnitude
Several other substitution were performed just to make the feature names more readable.

# Step 5: From the data set obtained in step 4, a new tidy data set was created (newTidyData) with the average of each variable for each activity and each subject.
ddply command was used to obtain a new dataset where first column represents the subject ID (participant in the experiment), the second column represents the activity (walking, sitting, etc.) for each of participants and the remaining 66 columns contain the average for the each variable.
Finaly the output of this analysis (newTidyData data frame) was written to a txt file with write.table command and the final txt file is named finalData.txt, this file contains a header with each of the column names. The first two columns specify the id for the subject and the type of activity being performed.