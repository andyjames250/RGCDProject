##############################################################################
# This script performs the following steps:
# 1. Download the Samsung data and unzip into the working directory
# 2. Read the training data
# 3. Read the test data
# 4. Reading supporting data (features and activity labels)
# 5. For activities: append test to training data, convert to factors with level
# names and label the column
# 6. For subjects: append test to training data, convert to factors, and label 
# the column
# 7. For features: extract mean and std measures, combine training and test 
# data, and label the columns
# 8. Merge activity, subject and features together
# 9. Calculate mean by activity, subject and variable groupings and output as
# a tidy data set
##############################################################################

# Required libraries
library(reshape2)
library(plyr)

# 1. Download the Samsung data and unzip into the working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip", method="curl")
unzip("data.zip")

# 2. Read the training data
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
X_train <- read.csv("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")

# 3. Read the test data
y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
X_test <- read.csv("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")

# 4. Reading supporting data (features and activity labels)
features <- read.csv("./UCI HAR Dataset/features.txt", header=FALSE, sep="")
activity_labels <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")

# 5. For activities: append test to training data, convert to factors with level
# names and label the column
y_combined <- rbind(y_train, y_test)
# levels <- levels(activity_labels[,2])
levels <- as.character(activity_labels[,2]) # This is required to preserve order
y_combined[,1] <- factor(y_combined[,1])
levels(y_combined[,1]) <- levels
names(y_combined) <- c("activity")

# 6. For subjects: append test to training data, convert to factors, and label 
# the column
subject_combined <- rbind(subject_train, subject_test)
subject_combined[,1] <- factor(subject_combined[,1])
names(subject_combined) <- c("subject")

# 7. For features: extract mean and std measures, combine training and test 
# data, and label the columns
features_extended <- cbind(features, grepl("mean\\(\\)|std\\(\\)", features[,2]))
names(features_extended) <- c("index", "name", "include")
features_filtered_index <- features_extended[features_extended[,3]==TRUE,1]
X_train_filtered <- X_train[,features_filtered_index]
X_test_filtered <- X_test[,features_filtered_index]
X_combined <- rbind(X_train_filtered, X_test_filtered)
features_filtered_names <- gsub("[^[:alnum:]]", "", features_extended[features_extended[,3]==TRUE,2])
names(X_combined) <- features_filtered_names

# 8. Merge activity, subject and features together
merged <- cbind(y_combined, subject_combined, X_combined)
melted <- melt(merged)

# 9. Calculate mean by activity, subject and variable groupings and output as
# a tidy data set
tidy <- ddply(melted, .(activity, subject, variable), summarise, mean=mean(value, na.rm=TRUE))
write.csv(tidy, "tidy.txt", row.names=FALSE)