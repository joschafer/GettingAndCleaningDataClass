# README.md

This readme will provide the instruction of how to setup for and execute this R script to create a "wide" tidy data set from the original data on human activty recognition with smartphones  (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Setup
* Obtain and expand the data archive in the same directory as the run_analysis.R script.  For example:
  * setwd("~/Documents/Classes/GetCleanData/Project")

## Load common data

* Load original test data sets and combine to one data.frame
* Turn activity and subject into factors
* Name columns
* Load original train data sets and combine to one data.frame
* Turn activity and subject into factors
* Name columns


## 1. Merges the training and the test sets to create one data set.

* Combine the data into a single data.frame 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

* Create subset of data where all of the features inclue mean() or stg()

## 3. Uses descriptive activity names to name the activities in the data set

* Turn activity into descriptor factors

## 4. Appropriately labels the data set with descriptive variable names. 

* Clean up names to accurately reflect what they are 

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* Create data frame that includes subject, activity, feature, mean 

