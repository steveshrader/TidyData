# Steve Shrader - November 2014 - Getting and Cleaning Data
# creating tidy data from Samsung Galaxy S smartphone accelerometer data


# 1. Merges the training and the test sets to create one data set.
#     first read in all files
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses="character")  #not as factors which would mess up the cbind below
features        <- read.table("./UCI HAR Dataset/features.txt")
subject_test    <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test          <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test          <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train   <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train         <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train         <- read.table("./UCI HAR Dataset/train/y_train.txt")
#     and then combining the matching files from test and train datasets
#     by row binding them together with the bigger training set first and the smaller test set second
subject_combined <- rbind(subject_train, subject_test)
X_combined       <- rbind(X_train, X_test)
y_combined       <- rbind(y_train, y_test)
#     and removing train and test datasets since combined will be used from this point
rm(subject_train)
rm(subject_test)
rm(X_train)
rm(X_test)
rm(y_train)
rm(y_test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#     features dataset contains the name of the 561 features with mean and std in the name of the features we're interested in
#     add column headers and then filter for mean() or std()
colnames(X_combined) <- features[,2]
X_meanstd_filtered <- X_combined[,c(grep("(mean|std)\\(\\)", colnames(X_combined)))]
#     remove combined dataset since filtered dataset will be used from this point
rm(X_combined)


# 3. Uses descriptive activity names to name the activities in the data set
#     create a descriptive_activity_name vector and convert the numeric in y_combined to the descriptive activity name in activity_labels 2nd column
descriptive_activity_name <- c()
for(i in 1:length(y_combined[,1])){
  descriptive_activity_name <- c(descriptive_activity_name, activity_labels[y_combined[i,1],2])
}
X_meanstd_filtered <- cbind(descriptive_activity_name, X_meanstd_filtered)
#     and we're done with both y_combined and activity_lables
rm(y_combined)
rm(activity_labels)


# 4. Appropriately labels the data set with descriptive variable names. 
#     this was actually done above so we could filter out columns with mean or std on X_meanstd_filtered
#     last one unlabeled is subject_combined
colnames(subject_combined) <- c("subject")


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#     cbind the subject and then aggregate by activity and subject
X_meanstd_filtered <- cbind(subject_combined, X_meanstd_filtered)
tidy_data_set <- aggregate(X_meanstd_filtered, list(Activity=X_meanstd_filtered$descriptive_activity_name, Subject=X_meanstd_filtered$subject), mean)
#     remove columns aggregated on that are duplicate
tidy_data_set <- tidy_data_set[,-c(3,4)]
#     write out the results
write.table(tidy_data_set, "tidy_data_set.txt", row.name=FALSE)