## Course project for JHU's "Getting and Cleaning Data"

## Data for project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Assignment is to create one R script called run_analysis.R that does the following:
## 1. Merges the training and test sets to create one data set
## 2. Extracts only the measurements on the mean and standard deviation for each measurement
## 3. Uses descriptive activity names to name the activites in the data set
## 4. Appropriately labels the data set with descriptive variable names
## 5. From the data set in step 4, creates a second, independent tidy data set with the
##    average of each variable for each activity and each subject


## 1. Merges the training and test sets to create one data set:

X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
X_merge <- rbind(X_train, X_test)

subj_train <- read.table("train/subject_train.txt")
subj_test <- read.table("test/subject_test.txt")
subj_merge <- rbind(subj_train, subj_test)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
y_merge <- rbind(y_train, y_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement:

measurements <- read.table("features.txt")
measurements_mean_sd <- grep("-mean\\(\\)|-std\\(\\)", measurements[, 2])
X_merge <- X_merge[, measurements_mean_sd]
names(X_merge) <- measurements[measurements_mean_sd, 2]
names(X_merge) <- gsub("\\(|\\)", "", names(X_merge))
names(X_merge) <- tolower(names(X_merge))

## 3. Uses descriptive activity names to name the activites in the data set:

activity_labels <- read.table("activity_labels.txt")
activity_labels[, 2] <- gsub("_", "", tolower(as.character(activity_labels[, 2])))
y_merge[,1] <- activity_labels[y_merge[,1], 2]
names(y_merge) <- "activity"

## 4. Appropriately labels the data set with descriptive variable names:

names(subj_merge) <- "subject"
newData <- cbind(subj_merge, y_merge, X_merge)
write.table(newData, "merged_newData.txt")

## 5. From the data set in step 4, creates a second, independent tidy data set with the
##    average of each variable for each activity and each subject:

unique_subjects <- unique(subj_merge)[,1]
number_of_subjects <- length(unique(subj_merge)[,1])
number_of_activities <- length(activity_labels[,1])
number_of_columns <- dim(newData)[2]
answer <- newData[1:(number_of_subjects * number_of_activities), ]
row <- 1
for (i in 1:number_of_subjects) {
        for (z in 1:number_of_activities) {
                answer[row, 1] <- unique_subjects[i]
                answer[row, 2] <- activity_labels[z, 2]
                vault <- newData[newData$subject==i & newData$activity==activity_labels[z, 2], ]
                answer[row, 3:number_of_columns] <- colMeans(vault[, 3:number_of_columns])
                row <- row + 1
        }
}
write.table(answer, "tidy_data_set.txt", row.name = FALSE)
