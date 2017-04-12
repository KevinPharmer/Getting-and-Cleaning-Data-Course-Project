# Getting-and-Cleaning-Data-Course-Project

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script was written to read and and merge the datasets and add descriptive labels.  The combined data set is then transcribed to a "Tidy" data set that contains the averages of each measurement per subject and activity.  

The script has 5 sections, the first being optional.  

Section 1 (Optional) - Loads the required package, downloads the data and sets the working directory

Section 2 - Merges the training and the test sets to create one data set
This section first reads the data into data.frames and then combines them using cbind and rbind.

Section 3 - Appropriately labels the data set with descriptive variable names.
The labels are added to the dataset from the features text document.  Subject and Activity numbers are also noted.

Section 4 - Extracts only the measurements on the mean and standard deviation for each measurement.
This step uses the 'dplyr' package and needs to be loaded.
The desired columns are first identified using grep1 by looking for columns that contain "mean" or "std dev", in addition
to the Activity and Subject identifiers.
After the desired columns are identified, they are subsetted and adjusted to display the activity name versus number

Section 5 - creates a second, independent tidy data set with the average of each variable for each activity and each subject 
A new tidy data set is created using the merged and labeled dataset through the aggregate function.
This is then written to a .txt file.
