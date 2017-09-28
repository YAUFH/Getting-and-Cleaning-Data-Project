# Week4 Assignment - run_analysis.R


#load package, unzip file
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "wearable.zip", method ="curl")
unzip(zipfile = "wearable.zip")


# Read data to R, label columns
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("classLabels","activityName"))
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE,col.names = c("index", "featureNames"))
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE,col.names = "subjectID")
xTrain <-read.table("UCI HAR Dataset/train/x_train.txt", header = FALSE,col.names = features[,2])
yTrain <-read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE,col.names = "classLabels")
subjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE,col.names = "subjectID")
xTest <-read.table("UCI HAR Dataset/test/x_test.txt", header = FALSE,col.names = features[,2])
yTest <-read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE,col.names = "classLabels")


# 1)Merges the training and the test sets to create one data set
traindataset <- cbind(yTrain, subjectTrain, xTrain)
testdataset <- cbind(yTest, subjectTest, xTest)
onedataset <- rbind(traindataset,testdataset)


# 2)Extracts only the measurements on the mean and standard deviation for each measurement.
colNames <- colnames(onedataset)
Vector <- (grepl("classLabels..",colNames) | grepl("subject..",colNames) | grepl("..mean..",colNames) & !grepl("..meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("..std..",colNames) & !grepl("..std()..-",colNames))
onedataset <- onedataset[Vector==TRUE]



# 3)Uses descriptive activity names to name the activities in the data set
# 4)Appropriately labels the data set with descriptive variable names.
onedataset <- merge(onedataset,activityName,by='classLabels',all.x=TRUE)
colNames <- colnames(onedataset)

for(i in 1:length(colNames))
{
  colNames[i] <-gsub(".std","StdDev", colNames[i])
  colNames[i] <-gsub(".Acc","Accelerometer", colNames[i])
  colNames[i] <-gsub(".Mag","Magnitude", colNames[i])
  
}

colnames(onedataset) <- colNames
View(onedataset)

# 5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata <- aggregate(onedataset, by = list (subjectID = onedataset$subjectID), mean)

View(tidydata)

write.table(tidydata, "./tidydata.txt", row.names = FALSE, sep = "\t")
