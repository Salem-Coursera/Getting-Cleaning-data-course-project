#run analysis script 

# importing dplyr library
library(dplyr)

# 1st step assembling the test data set 

# reading the data (test data section)
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
Fvariables <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
Training_labels <- read.table("UCI HAR Dataset/test/y_test.txt")

#transforming the data with tbl_df
Xtest <- tbl_df(Xtest)
subjects <- tbl_df(subjects)
Fvariables <- tbl_df(Fvariables)
training_labels  <- tbl_df(Training_labels)

# naming the columns
names(Xtest) <- Fvariables$V2

# adding the subject number in each row
names(subjects) <- "subject_nb"
data1 <- cbind(subjects,Xtest)

#adding the name of activity insteade of it's code number  
#for this we need to create a new funtion "activity_name"
activity_name <- function(n) {
        i <- 1
        data <- c(NULL)
        for (i in 1:length(n)) {
        if (n[i] == "1" ) { data[i] <- "WALKING"}
        if (n[i] == "2" ) { data[i] <- "WALKING_UPSTAIRS"}
        if (n[i] == "3" ) { data[i] <- "WALKING_DOWNSTAIRS"}
        if (n[i] == "4" ) { data[i] <- "SITTING"}
        if (n[i] == "5" ) { data[i] <- "STANDING"}
        if (n[i] == "6" ) { data[i] <- "LAYING"} 
                }
        return (data)
}

# we use the new function activity name to make the data more understandable 
actname <- activity_name(Training_labels$V1)
data2 <- cbind(actname, data1)
#now the test data is ready to use 

#we do the same to the training data (same file names but in the train directory)

Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
Fvariables <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_Training_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
Xtrain <- tbl_df(Xtrain)
train_subjects <- tbl_df(train_subjects)
Fvariables <- tbl_df(Fvariables)
train_Training_labels  <- tbl_df(train_Training_labels)
names(Xtrain) <- Fvariables$V2
names(train_subjects) <- "subject_nb"
train_data1 <- cbind(train_subjects,Xtrain)
actname <- activity_name(train_Training_labels$V1)
train_data2 <- cbind(actname, train_data1)
#now the training data is ready to use 

#merging the train and test data 
project_data <- rbind(train_data2,data2)

# treating names
valid_column_names <- make.names(names=names(project_data), unique=TRUE, allow_ = TRUE)
names(project_data) <- valid_column_names

#selecting measurements on the mean and standard deviation 
clean_data <- select(project_data,actname,subject_nb,contains("mean"),contains("std"))

# average of each variable for each activity and each subject
clean_data <- group_by(clean_data,actname,subject_nb)
summarised_data <- summarise_all(clean_data,mean)

# exporting the data
write.table(summarised_dat,file = "galaxy_watch_data.txt")
