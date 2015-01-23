#read files
test_file_path <- 'test/X_test.txt'
test_file_X <- read.table(test_file_path)
train_file_path <- 'train/X_train.txt'
train_file_X <- read.table(train_file_path)
#merge test & train
data <- rbind(test_file_X, train_file_X)
test_y <- read.table('test/y_test.txt')
train_y <- read.table('train/y_train.txt')
#merge test & train
data_y <- rbind(test_y, train_y)
test_subject <- read.table("test/subject_test.txt")
train_subject <- read.table("train/subject_train.txt")
#merge test & train
data_subject <- rbind(test_subject, train_subject)

#assigning names
list_of_X_names <- read.table('features.txt')
names(data) <- list_of_X_names[,2]
names(data_subject) <- c("Subjectname")
names(data_y)<- c("Activityname")



#select columns with "mean" & "std"
cname <- colnames(data)
select_colname <- (cname %in% grep("mean", cname, value=TRUE)) | (cname %in% grep("std",cname, value=TRUE))
data2 <- subset(data, select = select_colname)


#merge dataset
data2 <- cbind(data_subject,data_y, data2)

#Read Activity names
activity_names <- read.table("activity_labels.txt")

#Assign Descriptive activity names in the data2 table
for (i in 1:10299) {
  data2$Activityname[i] <- as.character(activity_names[data2$Activityname[i],2])
}

#Label the data set with proper variables names. 
# Remove () & -
col_names <- colnames(data2)
col_names <- gsub("-mean\\()\\", "mean", col_names)
col_names <- gsub("-std\\()\\", "std", col_names)
names(data2) <- col_names

#Group data by subject & activity
data_group <- group_by(data2, Subjectname, Activityname)

#Calculate mean for each subject & each activity
data_summary <- summarise_each(data_group, funs(mean))
write.table(data_summary,"tidydataset.txt", row.name=FALSE)

