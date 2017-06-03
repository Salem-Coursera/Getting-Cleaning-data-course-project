# Getting-Cleaning-data-course-project
## The Week 4 Coursera's Getting & Cleaning Data Course Assignment

# Getting the Data 
### The Data
In this Project we will use the Human Activity Recognition Using Smartphones Data Set 
the data was collected from the accelerometers from the Samsung Galaxy S smartphone with a group of 30 volunteers, Each one performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist as it is explained with details in this link "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
### The file
we downloaded the zipped data set From this link : "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

### understanding and labelling the data
the data contain 70% training data and 30% test data each one in a separate directory (labeled test and train)
beging with the test data 
the "UCI HAR Dataset/test/X_test.txt" file contain the raw data collected from the accelerometer stored in 2947 observation (rows) of 561 variables (columns)
the "UCI HAR Dataset/features.txt" file contain the coloumns label (variables names of the test data)

we nedd also the activity type and volunteer number labeled in each row ! 
the "UCI HAR Dataset/test/subject_test.txt" file contain the volunteers numbers note that data from 30% of volunteers is used to construct the test Data
the "UCI HAR Dataset/features.txt" contains the activity type labeled in numbers from 1 to 6 (walking => laying)

so we have now the test data labeled with variables names in the columns and activity type, and volunteers numbers in each row 
we do the same to the training data (same file names but in the train directory)

## 1) Merges the training and the test sets to create one data set
As described in the previous chapter we now have a labled data for the train and test data set with same number and names of columns
we merge them using the rbind function 

## 2)Extracts the measurements on the mean and standard deviation 
we used the dplyr library and select function to select variables with "mean" and "std" (standard deviation) in their label

## 3)Uses descriptive activity names to name the activities in the data set
## 4)Appropriately labels the data set with descriptive variable names
we had labeled the data as described in the "understanding and labelling the data" chapter

## 5)creates a second, independent tidy data set with the average of each variable for each activity and each subject
we used the group_by fonction from the dplyr package to group the data according the volunteer number and the activity 
we used summarise_all to get the mean of each column summarised according to the grouped data 

### export the result 
write.table is the fuction that i used  

