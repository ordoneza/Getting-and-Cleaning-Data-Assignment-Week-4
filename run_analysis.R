##Load necessary R packages
        library(dplyr)
        library(plyr)
        
        
##Download datasets and store them as "week4" file
        file="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        filename="week4"
        download.file(file, filename, method="curl")
        
        
##Unzip files and store as "data_4"
        data_4<-unzip("week4")
        
        
##Read pertinent files 
        subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
        x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
        y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
        subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
        x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
        y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
        
        
##Combine training and test datasets into one table called "activity"
        activity<-rbind(cbind(subject_train,x_train, y_train), cbind(subject_test, x_test, y_test))

        
##Read "features" txt and label columns in "activity"
        names<-read.table("UCI HAR Dataset/features.txt")
        colnames(activity)<-c("subjects", names[,2], "activity")
        
        
##Select data columns that pertain to the mean and std values
        data1<-grep("subject|activity|mean|std", colnames(activity))
        mean_std<-activity[, data1]
        
        
##Assign activity descriptions to each level (1-5) in the "activity" column of the data set
        activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
        mean_std$activity<-factor(mean_std$activity, levels=activity_labels[,1], labels=activity_labels[,2])

        
##Edit variable names
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

##Creating a tidy data set with only the averages for each variable for ach activity and each subject
        data<-aggregate(.~subjects + activity, mean_std, mean)
        data<-data[order(data$subjects, data$activity), ]
        write.table(data,file="tidydata.txt", row.names = FALSE)
        

        
        