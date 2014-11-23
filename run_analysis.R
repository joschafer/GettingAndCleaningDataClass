## REMINDER.  Set your working directory where the UCI HAR Dataset archive was expanded.

## You should create one R script called run_analysis.R that does the following. 
library(sqldf)

## Load common data
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

## Load original test data sets and combine to one data.frame
sampleTestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
sampleTestYData <- read.table("UCI HAR Dataset/test/y_test.txt")
sampleTestXData <- read.table("UCI HAR Dataset/test/X_test.txt")
## Turn activity and subject into factors
combinedTestData <- cbind(as.factor(sampleTestSubjects$V1), as.factor(sampleTestYData$V1), sampleTestXData)

## Name columns
colnames(combinedTestData) <- c("subject","activity", levels(features$V2))

## Load original train data sets and combine to one data.frame
sampleTrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
sampleTrainYData <- read.table("UCI HAR Dataset/train/y_train.txt")
sampleTrainXData <- read.table("UCI HAR Dataset/train/X_train.txt")
## Turn activity and subject into factors
combinedTrainData <- cbind(as.factor(sampleTrainSubjects$V1), as.factor(sampleTrainYData$V1), sampleTrainXData)

## Name columns
colnames(combinedTrainData) <- c("subject","activity", levels(features$V2))

###################################################################
## 1. Merges the training and the test sets to create one data set.
###################################################################

## Combine the data into a single data.frame 
combinedData <- rbind(combinedTrainData, combinedTestData)


###################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
###################################################################

## Create subset of data where all of the features inclue mean() or stg()
selectedVariables <- c(1,2,sort(c( grep("mean\\(\\)", colnames(combinedData)), grep("std\\(\\)", colnames(combinedData)))))
meanStandardDeviationData <- combinedData[selectedVariables]


###################################################################
## 3. Uses descriptive activity names to name the activities in the data set
###################################################################

## Turn activity into descriptor factors
levels(meanStandardDeviationData$activity) <- c("walking","walkingUpstairs","walkingDownstairs","sitting","standing","laying")            


###################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
###################################################################

## Clean up names to accurately reflect what they are 
##make.names(names, unique = FALSE, allow_ = TRUE)
savedColumnNames <- colnames(meanStandardDeviationData)
colnames(meanStandardDeviationData) <- gsub("\\-","",gsub("\\-mean\\(\\)","Mean", gsub("\\-std\\(\\)","Std", savedColumnNames)))


###################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###################################################################

## Create data frame that includes subject, activity, feature, mean 
sqlQuery <- paste("select subject, activity, ", paste(paste("avg(", colnames(meanStandardDeviationData[c(-1,-2)]), ")"), " ", collapse=","), " from meanStandardDeviationData group by subject, activity")

meansByAccountActivity <- sqldf(sqlQuery)
savedColumnNames2 <- colnames(meansByAccountActivity)
colnames(meansByAccountActivity) <- gsub("avg\\( ","",gsub(" \\)","", savedColumnNames2))

write.table(meansByAccountActivity, "tidyDataSet.txt", row.name=FALSE )


