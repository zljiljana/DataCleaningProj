# Step 1: Merges the training and the test sets to create one data set.
X_train <- read.table("./UCI HAR Dataset//train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset//train/y_train.txt")
subj_train <- read.table("./UCI HAR Dataset//train/subject_train.txt")

X_test <- read.table("./UCI HAR Dataset//test//X_test.txt")
y_test <- read.table("./UCI HAR Dataset//test//y_test.txt")
subj_test <- read.table("./UCI HAR Dataset//test//subject_test.txt")

train_data <- cbind(X_train, subj_train, y_train)
test_data <- cbind(X_test, subj_test, y_test)

data <- rbind(train_data, test_data)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt")
colsContainingMeanStd <- c(grep( "mean()", features[,2], fixed = TRUE), grep( "std()", features[,2], fixed = TRUE))
tidyData <- data[, c(colsContainingMeanStd, ncol(data)-1, ncol(data))]

# Step 3: Uses descriptive activity names to name the activities in the data set
activityLbls <- read.table("./UCI HAR Dataset//activity_labels.txt")
tidyData[,ncol(tidyData)] <- sapply(tidyData[,ncol(tidyData)], function(replace) replace = as.character(activityLbls[replace,2]))

# Step 4: Appropriately labels the data set with descriptive variable names.
featuresToRelabel <- features[colsContainingMeanStd, 2]
featuresToRelabel <- sub("tBody","TimeBody",  featuresToRelabel)
featuresToRelabel <- sub("fBody","FrequencyBody",  featuresToRelabel)
featuresToRelabel <- sub("Acc","Accelerometer",  featuresToRelabel)
featuresToRelabel <- sub("Gyro","Gyroscope", featuresToRelabel)
featuresToRelabel <- sub("tGravity","TimeGravity", featuresToRelabel)
featuresToRelabel <- sub("BodyBody","Body",  featuresToRelabel)
featuresToRelabel <- sub("Mag","Magnitude",  featuresToRelabel)
featuresToRelabel <- c(featuresToRelabel, "Subject", "Activity")
colnames(tidyData) <- featuresToRelabel

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of
#           each variable for each activity and each subject.
newTidyData <- ddply(tidyData, .(Subject, Activity), numcolwise(mean))
