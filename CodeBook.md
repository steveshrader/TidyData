CodeBook
--------

Variables
---------
The output of the project is **tidy_data_set.txt** with the following factors

**Activity** - What activity of the subject was being monitored.  
Options are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  
  
**Subject** - The person being monitored.  Numbered sequentially 1 through 30 for the participants of the study  
  
**Measurements** - the remaining columns of data are the mean and std dev for each measurement type aggregated by Subject and Activity.  More detail can be found in the README file of the source data.  There are readings for accelerometer (Acc) and gyroscope (Gyro).  The factors are:  
tBodyAcc-mean()-X  
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X  
tBodyAccJerk-std()-Y  
tBodyAccJerk-std()-Z  
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X  
tBodyGyro-std()-Y  
tBodyGyro-std()-Z  
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X  
tBodyGyroJerk-std()-Y  
tBodyGyroJerk-std()-Z  
tBodyAccMag-mean()  
tBodyAccMag-std()  
tGravityAccMag-mean()  
tGravityAccMag-std()  
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()  
tBodyGyroMag-mean()  
tBodyGyroMag-std()  
tBodyGyroJerkMag-mean()  
tBodyGyroJerkMag-std()  
fBodyAcc-mean()-X  
fBodyAcc-mean()-Y  
fBodyAcc-mean()-Z  
fBodyAcc-std()-X  
fBodyAcc-std()-Y  
fBodyAcc-std()-Z  
fBodyAccJerk-mean()-X  
fBodyAccJerk-mean()-Y  
fBodyAccJerk-mean()-Z  
fBodyAccJerk-std()-X  
fBodyAccJerk-std()-Y  
fBodyAccJerk-std()-Z  
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X  
fBodyGyro-std()-Y  
fBodyGyro-std()-Z  
fBodyAccMag-mean()  
fBodyAccMag-std()  
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()  
fBodyBodyGyroMag-mean()  
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean()  
fBodyBodyGyroJerkMag-std()  
  
Data
----
The data is from a study on Samsung Galaxy S smartphones and can be found and downloaded at the following locations  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   
  
The Dataset also includes a README.txt with detailed descriptions of the source data.


Transformations
---------------

 1. Merges the training and the test sets to create one data set.
     first read in all files
     and then combining the matching files from test and train datasets
     by row binding them together with the bigger training set first and the smaller test set second
     and removing train and test datasets since combined will be used from this point


 2. Extracts only the measurements on the mean and standard deviation for each measurement.
     features dataset contains the name of the 561 features with mean and std in the name of the features we're interested in
     add column headers and then filter for mean() or std()
     remove combined dataset since filtered dataset will be used from this point


 3. Uses descriptive activity names to name the activities in the data set
     create a descriptive_activity_name vector and convert the numeric in y_combined to the descriptive activity name in activity_labels 2nd column
     and we're done with both y_combined and activity_lables


 4. Appropriately labels the data set with descriptive variable names. 
     this was actually done above so we could filter out columns with mean or std on X_meanstd_filtered
     last one unlabeled is subject_combined


 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
     cbind the subject and then aggregate by activity and subject
     remove columns aggregated on that are duplicate
     write out the results
