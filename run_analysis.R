#Module 3: Project

#Clear workspace
rm(list=ls())

#Set working directory
setwd("C:/Users/Toshiba/Dropbox/Coursera/Data Science/Module 3 - Getting Data/Project/UCI HAR Dataset")

# Read in the data from files
features = read.table("./features.txt", header=FALSE) #imports features.txt
activity_labels = read.table("./activity_labels.txt", header=FALSE) #imports activity_labels.txt

# Assign column names to the imported data
colnames(activity_labels)  = c('ref','activityId');

#Load train dataset
xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt - training set
yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt - training label
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt - person who performed

#Label columns
colnames(xTrain)        = features[,2]; 
colnames (yTrain)        = "activityId";
colnames(subjectTrain)  = "subjectId";


#Combine all 3 items
train <- cbind(subjectTrain,yTrain,xTrain)

#Load test dataset
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt


#Label columns
colnames(xTest)  = features[,2]; 
colnames(yTest) = "activityId";
colnames(subjectTest)  = "subjectId";


#Combine all 3 items
test <- cbind(subjectTest, yTest, xTest)


#Merge train and test dataset together
consol <- rbind(train,test)

#Create a vector of column names for consol
colNames <- colnames(consol)

#Select only mean and std dev
features_select <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

#Create a vector with the selected features
consol_select <- consol[,features_select ==TRUE]

#Merge the selected features with the original consolidated dataset
consol_select_label <- merge(consol_select, activity_labels,by ='activityId', all.x=TRUE)
consol_final <- subset(consol_select_label, select = -c(ref) )



#############################################################3


##Create a second, independent tidy data set with the average of each variable
##for each activity and each subject

tidyset <- aggregate(. ~ activityId+ subjectId, consol_final, mean)
tidyset <- tidyset[order(tidyset$subjectId, tidyset$activityId),]

#Write tidyset to text file
write.table(tidyset, "tidyset.txt", row.name=FALSE)