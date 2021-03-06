README for JHU’s “Getting and Cleaning Data” course project

Purpose:  To describe how the run_analysis.R script works

Data:  Collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

(See attached project Code Book for details on data and variables.)

Overview:  In general, the R script called run_analysis.R does the following:

* Merges the training and test sets to create one data set

* Extracts only the measurements on the mean and standard deviation for each measurement

* Uses descriptive activity names to name the activites in the data set

* Appropriately labels the data set with descriptive variable names

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Specifics:

* Merges the training and test sets to create one data set:

     - X_train and X_test sets are merged into X_merge data set

     - subject_train and subject_test sets are merged into subj_merge data set

     - y_train and y_test sets are merged into y_merge data set

* Extracts mean and standard deviation for each measurement:

     - Reads measurements from “features.text” data

     - Extracts only measurements for mean and standard deviation

     - Revises measurement names to lower case with symbols removed

* Applies descriptive activity names to the data set:

     - Reads activity labels

     - Revises activity labels to lower case with symbols removed
          - walking
          - walkingupstairs
          - walkingdownstairs
          - sitting
          - standing
          - laying

* Creates a new data set with 10299 rows x 68 columns containing subject ID and activity name, followed by 66 measurements:

     - Merges subject, activity, and measurement data into one data set

     - Creates descriptive variable names to appropriately label the data set

     - Result saved in newData

* Creates a second, independent tidy data set with 180 rows x 68 columns containing the average of each measurement corresponding to each activity for each subject

     - First column contains subject ID’s

     - Second column contains activity names

     - Columns 3 through 68 contain the average for each of the 66 measurements

     - 30 subjects x 6 activities per subject = 180 rows

     - Answer saved in “tidy_data_set.txt” 
