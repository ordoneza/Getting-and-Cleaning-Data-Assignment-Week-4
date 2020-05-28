---
title: "CodeBook"
author: "Andrea Ordonez"
date: "5/28/2020"
output:
  html_document: default
  word_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Tidy Data Introduction

The original data presented pertained to human activity recgonition using smartphones. To access the original data and experimental setup refer to <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

The specific files used for this analysis can be found at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. 

The tidy data set represents the averages for each variable of each activity and subject from the original data. 



## Dimensions
The tidy data set is composed by 81 variables and 180 observations. The variables are number of subjects, activity, and the averaged signal measurments (79 variables). 

## Variables
**subjects** 
interger ranging from 1-30

**activity** 
character string of 6 values: "Walking", "Walking_Upstairs", "Walking_ Downstairs", "Sitting", "Standing", "Laying"

**measurement variables** For the definition of each variable reference the orginial data files with the links provided above. 

timeBodyAccelerometerMeanX 
timeBodyAccelerometerMeanY 
timeBodyAccelerometerMeanZ 
timeBodyAccelerometerStandardDeviationX 
timeBodyAccelerometerStandardDeviationY 
timeBodyAccelerometerStandardDeviationZ 
timeGravityAccelerometerMeanX 
timeGravityAccelerometerMeanY 
timeGravityAccelerometerMeanZ 
timeGravityAccelerometerStandardDeviationX 
timeGravityAccelerometerStandardDeviationY 
timeGravityAccelerometerStandardDeviationZ 
timeBodyAccelerometerJerkMeanX 
timeBodyAccelerometerJerkMeanY 
timeBodyAccelerometerJerkMeanZ 
timeBodyAccelerometerJerkStandardDeviationX timeBodyAccelerometerJerkStandardDeviationY timeBodyAccelerometerJerkStandardDeviationZ 
timeBodyGyroscopeMeanX
timeBodyGyroscopeMeanY
timeBodyGyroscopeMeanZ 
timeBodyGyroscopeStandardDeviationX 
timeBodyGyroscopeStandardDeviationY 
timeBodyGyroscopeStandardDeviationZ 
timeBodyGyroscopeJerkMeanX 
timeBodyGyroscopeJerkMeanY 
timeBodyGyroscopeJerkMeanZ 
timeBodyGyroscopeJerkStandardDeviationX 
timeBodyGyroscopeJerkStandardDeviationY 
timeBodyGyroscopeJerkStandardDeviationZ 
timeBodyAccelerometerMagnitudeMean 
timeBodyAccelerometerMagnitudeStandardDeviation 
timeGravityAccelerometerMagnitudeMean timeGravityAccelerometerMagnitudeStandardDeviation                                  timeBodyAccelerometerJerkMagnitudeStandardDeviation 
timeBodyGyroscopeMagnitudeMean 
timeBodyGyroscopeMagnitudeStandardDeviation 
timeBodyGyroscopeJerkMagnitudeMean 
timeBodyGyroscopeJerkMagnitudeStandardDeviation 
frequencyBodyAccelerometerMeanX 
frequencyBodyAccelerometerMeanY 
frequencyBodyAccelerometerMeanZ 
frequencyBodyAccelerometerStandardDeviationX frequencyBodyAccelerometerStandardDeviationY frequencyBodyAccelerometerStandardDeviationZ 
frequencyBodyAccelerometerMeanFreqX 
frequencyBodyAccelerometerMeanFreqY 
frequencyBodyAccelerometerMeanFreqZ 
frequencyBodyAccelerometerJerkMeanX 
frequencyBodyAccelerometerJerkMeanY 
frequencyBodyAccelerometerJerkMeanZ 
frequencyBodyAccelerometerJerkStandardDeviationX frequencyBodyAccelerometerJerkStandardDeviationY frequencyBodyAccelerometerJerkStandardDeviationZ frequencyBodyAccelerometerJerkMeanFreqX 
frequencyBodyAccelerometerJerkMeanFreqY 
frequencyBodyAccelerometerJerkMeanFreqZ 
frequencyBodyGyroscopeMeanX 
frequencyBodyGyroscopeMeanY 
frequencyBodyGyroscopeMeanZ 
frequencyBodyGyroscopeStandardDeviationX 
frequencyBodyGyroscopeStandardDeviationY 
frequencyBodyGyroscopeStandardDeviationZ 
frequencyBodyGyroscopeMeanFreqX 
frequencyBodyGyroscopeMeanFreqY 
frequencyBodyGyroscopeMeanFreqZ 
frequencyBodyAccelerometerMagnitudeMean frequencyBodyAccelerometerMagnitudeStandardDeviation frequencyBodyAccelerometerMagnitudeMeanFreq frequencyBodyAccelerometerJerkMagnitudeMean frequencyBodyAccelerometerJerkMagnitudeStandardDeviation frequencyBodyAccelerometerJerkMagnitudeMeanFreq 
frequencyBodyGyroscopeMagnitudeMean 
frequencyBodyGyroscopeMagnitudeStandardDeviation frequencyBodyGyroscopeMagnitudeMeanFreq 
frequencyBodyGyroscopeJerkMagnitudeMean frequencyBodyGyroscopeJerkMagnitudeStandardDeviation frequencyBodyGyroscopeJerkMagnitudeMeanFreq

## Transformations to tidy data (from original files provided)

*Downloaded files, unzipped them, read the test and training datasets*

```{r}
file="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        filename="week4"
        download.file(file, filename, method="curl")
        data_4<-unzip("week4")
        subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
        x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
        y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
        subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
        x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
        y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
```
*Combined training and test datasets and assigned variable names*

```{r}
activity<-rbind(cbind(subject_train,x_train, y_train), cbind(subject_test, x_test, y_test))
names<-read.table("UCI HAR Dataset/features.txt")
colnames(activity)<-c("subjects", names[,2], "activity")
```
*Selected only the columns for means and standard deviations*
```{r}
data1<-grep("subject|activity|mean|std", colnames(activity))
mean_std<-activity[, data1]
```
*Assigned character names to activity column*
```{r}
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
mean_std$activity<-factor(mean_std$activity, levels=activity_labels[,1], labels=activity_labels[,2])
```
*Editted variable names to make them more readable*
```{r}
colnames(mean_std)<-gsub("^t","time", colnames(mean_std))
colnames(mean_std)<-gsub("Acc","Accelerometer", colnames(mean_std))
colnames(mean_std)<-gsub("^f","frequency", colnames(mean_std))
colnames(mean_std)<-gsub("BodyBody","Body", colnames(mean_std))
colnames(mean_std)<-gsub("Mag","Magnitude", colnames(mean_std))
colnames(mean_std)<-gsub("Gyro","Gyroscope", colnames(mean_std))
colnames(mean_std)<-gsub("mean", "Mean", colnames(mean_std))
colnames(mean_std)<-gsub("std", "StandardDeviation", colnames(mean_std))
colnames(mean_std)<-gsub("-","", colnames(mean_std))
colnames(mean_std)<-gsub("[()]", "", colnames(mean_std))
```
*Created tidy data set with the averages*
```{r}
data<-aggregate(.~subjects + activity, mean_std, mean)
data<-data[order(data$subjects, data$activity), ]
write.table(data,file="tidydata.txt", row.names = FALSE)
```



