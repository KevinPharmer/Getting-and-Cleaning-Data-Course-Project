##The goal of this script is to consolidate multiple datasets into a "Tidy" dataset.
##The script is broken down into 5 sections

##Section 1 - Loads necessary packages, downloads file if needed, and sets working directory
##library(dplyr)##for merge, select

##URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download.file(URL, destfile = "./GCDassignment.zip")
##unzip(zipfile = "./GCDassignment.zip")

##setwd("./UCI HAR Dataset")

##Section 2 - Merges the training and the test sets to create one data set.

##read the data to separate data frames
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

colnames(activity_labels) <- c("Activity_Number", "Activity")

##Combining the data
xy_test <- cbind(subject_test, y_test, x_test)
xy_train <- cbind(subject_train, y_train, x_train)
data_combined <- rbind(xy_test, xy_train)

##Section 3 - labeling data with descriptive names
features_names <- features[,2]
features_names <- as.character(features_names)
colnames(data_combined) <- c("Subject_Number", "Activity_Number", features_names)

##Section 4 - Extracts only the measurements on the mean and standard deviation for each measurement.

column_names <- colnames(data_combined)

##Identifies the columns that have the activity, subject numbers, or mean & std dev using grepl(pattern, x)
desired_columns <- (grepl("Activity_Number" , column_names) | grepl("Subject_Number" , column_names) | 
                   grepl("mean.." , column_names) | grepl("std.." , column_names))

##subsets the data to only include the data with the desired columns
subset_data <- data_combined[,desired_columns == TRUE]

subset_final <- merge(subset_data, activity_labels, by='Activity_Number', all.x=TRUE)
subset_final_ordered <- subset_final %>%
  select(2, Activity, 3:81)##replaces activity number with the actual name

##Section 5 - creates a second, independent tidy data set with the average of each variable for each activity and each subject 

tidy_data <- aggregate(. ~Subject_Number + Activity, subset_final_ordered, mean)
tidy_data <- tidy_data[order(tidy_data$Subject_Number, tidy_data$Activity),]##order first by subject number, then by activity

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
