### Project Cleaning Data MOOC  ###

# A single R script named 'run_analysis.R that does the following:
  
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the
#average of each variable for each activity and each subject.

# Assumes that .zip file has been downloaded from below:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## IF NEEDED, Below code can be used to download the .ZIP file and extract the files
#temp <- tempfile()
#download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
#fname = unzip(temp, list=TRUE)
#fname
#dim(fname)
#nrow(fname)
# loop to extract all files in the .zip
#i = 1
#for (i in 1:nrow(fname)) {
#unzip(temp, files=fname[i,1], exdir="~/Cleaning Date MOOC", overwrite=TRUE)
#}
#unlink(temp)

# read .txt files into R
#setwd("~/Cleaning Date MOOC/UCI HAR Dataset/test")

run_analysis <- function(directory = "UCI HAR Dataset") {
  setwd(directory)
  
all_final <- load_munge_files()
tidy_activity_by_subject (all_final)

# write tables to .csv or .txt file
write.csv(all_final, "clean_data_UCI-HAR_all_final.csv")
write.table(tidy, "clean_data_UCI-HAR_tidy.txt", row.name=FALSE)

# return both data frames in a list
list(all_final, tidy)
}

## Start function to 'Load and Munge" the files
load_munge_files <- function() {

## Read in features and add variable names
features <- read.table("features.txt", col.names=c("feat.id", "feature"))

## Read in 'test' files  ##
subject_test <- read.table("test/subject_test.txt", col.names="subject")
X_test <- read.table("test/X_test.txt", col.names=features[,2])
## Add column to id as 'test' data
X_test$test_train <- as.factor(rep("test", dim(X_test)[1]))
y_test <- read.table("test/y_test.txt", col.names="activity")

# Assemble all 'test' files into single date frame
test_all = data.frame(subject_test, y_test, X_test)

### Read in 'train' files
subject_train <- read.table("train/subject_train.txt", col.names="subject")
X_train <- read.table("train/X_train.txt", col.names=features[,2])
## Add column to id as 'train' data
X_train$test_train <- as.factor(rep("train", dim(X_train)[1]))
y_train <- read.table("train/y_train.txt", col.names="activity")

# Assemble all 'train' files
train_all = data.frame(subject_train, y_train, X_train)
head(train_all, 5)

### Combine 'test_all' and train_all' into one data frame
all <- rbind(test_all, train_all)

# 3. Select only cols with mean and std in name
mean_cols <- grep("mean\\.", colnames(all), value=TRUE)
std_cols  <- grep("std\\.",  colnames(all), value=TRUE)
keep = c("subject", "activity", "test_train", mean_cols, std_cols)
all_final <- all[keep]

# Clean up col names by substituting '...' with underscore '_'
names(all_final) <- sub("\\.\\.\\.", "_", names(all_final))
names(all_final) <- sub("\\.\\.", "_", names(all_final))

##  Add 'activity" labels 
activity_in <- read.table("activity_labels.txt", col.names=c("act_id", "act_name"))
labels <- activity_in[,2]
activity <- factor( all_final$activity, levels=c(1:6), labels=labels, ordered=TRUE)
all_final$activity <- activity
}
## END function to 'Load and Munge" the files  ###

## START functions to create a tidy data set with average of each variable for each activity and each subject

tidy_activity_by_subject <- function(all_final){

tidy_tmp <- all_final[colnames(all_final) != "test_train"]
tidy <- aggregate(. ~ tidy_tmp$activity + tidy_tmp$subject, data=tidy_tmp, FUN=mean)
tidy <- tidy[,c(1:2, 5:dim(tidy)[2])]    # drop columns 'subject' and 'activity'
names(tidy) <- sub("^tidy_tmp\\$", "", names(tidy))  # rename columns 1 and 2 
# sort by activity, then subject
tidy[order(tidy$activity, tidy$subject), ]  
print(tidy) 
}
