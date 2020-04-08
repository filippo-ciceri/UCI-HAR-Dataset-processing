#this code is written to be executed within the folder at the same level of the folder
#containing the raw data files (named "UCI HAR Dataset"), otherwise the relative paths
#to the raw data files won't work.

#load the dplyr library
library(dplyr)

#load features and activities
features_factor <- read.table("../UCI HAR Dataset/features.txt", header = FALSE, sep = "", dec = ".")[,2]
features_vector <- as.character(features_factor)
activity_label <- read.table("../UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", dec = ".")

#process the train table by using the features as headers, removes duplicated columns, then select columns
#containing only mean and std values. Finally the columns Subject ID and Activity are added
subject_train <- read.table("../UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".")
X_train <- read.table("../UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", dec = ".")
names(X_train) <- features_vector
X_train <- subset(X_train, select=which(!duplicated(colnames(X_train)))) 
X_train <- select(X_train, matches("mean")|matches("std"))
train <- cbind(subject_train,y_train,X_train)

#Process the test dataset exactly as described above
subject_test <- read.table("../UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".")
X_test <- read.table("../UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")
y_test <- read.table("../UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", dec = ".")
names(X_test) <- features_vector
X_test <- subset(X_test, select=which(!duplicated(colnames(X_test)))) 
X_test <- select(X_test, matches("mean")|matches("std"))
test <- cbind(subject_test,y_test,X_test)

#Join the test and train datasets, then replace the activity values with descriptive names
final <- rbind(train,test)
names(final)[1:2] <- c("Subject ID","Activity")
final$Activity <- factor(final$Activity,
                         levels=activity_label$V1,
                         labels=activity_label$V2)

#Calculate the second dataframe containing the means after grouping by Subject Id and Activity
final2 <- final %>% 
          group_by(`Subject ID`,Activity) %>% 
          summarise_all(mean)

#Finally export the two tables as TXT files
write.table(final, 'dataset1.txt', row.name=FALSE)
write.table(final2, 'dataset2.txt', row.name=FALSE)