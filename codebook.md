Getting and Cleaning Data Course Project – Code Book

This document describes the code inside run_analysis.R

The variables being used in the code includes 
1. Read dataset files from UCI HAR to dataset repository in R 
a. activitylabels 
b. features 
c. subjectTrain 
d. xTrain 
e. yTrain 
f. subjectTest 
g. xTest 
h. yTest

2. new dataset after merging text.txt and train.txt 
a. onedataset

3. logical vector created for more descriptive activity names
a. colNames

4. Final data set after aggregating the average of data of same variables 
a. tidydata


The code is divided in to 4 sections

1. Download and unzip source data file
2. Download and read individual text files into R
3. Manipulate data
4. Writing tidy data to .txt


Download and unzip source data file
1. Downloads UCI HAR zip file 
2. Unzips UCI HAR zip file

Download and read individual text files into R
1. Reads the activity labels to activitylabels
2. Reads the column names of data to features
3. Reads the test data set to xTest and yTest
4. Reads the train data set to xTrain and yTrain

Manipulate data
1. Combines activitylabes, features, xTest, yTest, xTrain and yTrain to onedataset
2. Selects only mean and standard deviation columns to onedataset
3. Updates variable names to be more descriptive
4. Aggregates the average of each column for each activity/subject pair to new data set called tidydata 

Writing tidy data to .txt
1. Outputs tidydata to .txt file


