# Required libraries
library(reshape2)
library(plyr)

# Download data         
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip", method="curl")
unzip("data.zip")

# Read training data        
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
X_train <- read.csv("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")

# Read test data        
y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
X_test <- read.csv("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")

# Read supporting files
features <- read.csv("./UCI HAR Dataset/features.txt", header=FALSE, sep="")
activity_labels <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")

# For activities: combine training and test data, convert into factors using appropriate level names, 
# and label the column
y_combined <- rbind(y_train, y_test)
levels <- levels(activity_labels[,2])
y_combined[,1] <- factor(y_combined[,1])
levels(y_combined[,1]) <- levels
names(y_combined) <- c("activity")

# For subjects: combine training and test data, convert into factors, and label the column
subject_combined <- rbind(subject_train, subject_test)
subject_combined[,1] <- factor(subject_combined[,1])
names(subject_combined) <- c("subject")

# For features: extract mean and std measures, combine training and test data, and label the columns
features_extended <- cbind(features, grepl("mean\\(\\)|std\\(\\)", features[,2]))
names(features_extended) <- c("index", "name", "include")
features_filtered_index <- features_extended[features_extended[,3]==TRUE,1]
X_train_filtered <- X_train[,features_filtered_index]
X_test_filtered <- X_test[,features_filtered_index]
X_combined <- rbind(X_train_filtered, X_test_filtered)
features_filtered_names <- gsub("[^[:alnum:]]", "", features_extended[features_extended[,3]==TRUE,2])
names(X_combined) <- features_filtered_names

# Merge activity, subject and features together into one tidy dataset
merged <- cbind(y_combined, subject_combined, X_combined)
melted <- melt(merged)
tidy <- ddply(melted, .(activity, subject, variable), summarise, mean=mean(value, na.rm=TRUE))
write.csv(tidy, "tidy.txt")