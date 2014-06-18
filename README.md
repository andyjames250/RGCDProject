R Getting and Cleaning Data - Course Project
========================================================

Introduction
--------------------------------------------------------

The script run_analysis.R processes the Samsung data into a tidy data set, according to the following steps:

1. Download the Samsung data and unzip into the working directory
2. Read the training data
3. Read the test data
4. Reading supporting data (features and activity labels)
5. For activities: append test to training data, convert to factors with level names and label the column
6. For subjects: append test to training data, convert to factors, and label the column
7. For features: extract mean and std measures, combine training and test data, and label the columns
8. Merge activity, subject and features together
9. Calculate mean by activity, subject and variable groupings and output as a tidy data set

DATA DICTIONARY - tidy.txt output from run_analysis.R
--------------------------------------------------------

activity
        Activity as specified in Samsung data
        Factor w/ 6 levels
                LAYING
                SITTING
                STANDING
                WALKING
                WALKING_DOWNSTAIRS
                WALKING_UPSTAIRS

subject
        Subject as specified in Samsung data
        Class: Factor w/ 30 levels
                1
                2
                3
                4
                5
                6
                7
                8
                9
                10
                11
                12
                13
                14
                15
                16
                17
                18
                19
                20
                21
                22
                23
                24
                25
                26
                27
                28
                29
                30

variable
        Feature name as specified in Samsung data. Any non-alphanumeric characters
        are removed. Only mean and std measures were extracted from Samsung data
        Class: Factor w/ 66 levels
                tBodyAccmeanX
                tBodyAccmeanY
                tBodyAccmeanZ
                tBodyAccstdX
                tBodyAccstdY
                tBodyAccstdZ
                tGravityAccmeanX
                tGravityAccmeanY
                tGravityAccmeanZ
                tGravityAccstdX
                tGravityAccstdY
                tGravityAccstdZ
                tBodyAccJerkmeanX
                tBodyAccJerkmeanY
                tBodyAccJerkmeanZ
                tBodyAccJerkstdX
                tBodyAccJerkstdY
                tBodyAccJerkstdZ
                tBodyGyromeanX
                tBodyGyromeanY
                tBodyGyromeanZ
                tBodyGyrostdX
                tBodyGyrostdY
                tBodyGyrostdZ
                tBodyGyroJerkmeanX
                tBodyGyroJerkmeanY
                tBodyGyroJerkmeanZ
                tBodyGyroJerkstdX
                tBodyGyroJerkstdY
                tBodyGyroJerkstdZ
                tBodyAccMagmean
                tBodyAccMagstd
                tGravityAccMagmean
                tGravityAccMagstd
                tBodyAccJerkMagmean
                tBodyAccJerkMagstd
                tBodyGyroMagmean
                tBodyGyroMagstd
                tBodyGyroJerkMagmean
                tBodyGyroJerkMagstd
                fBodyAccmeanX
                fBodyAccmeanY
                fBodyAccmeanZ
                fBodyAccstdX
                fBodyAccstdY
                fBodyAccstdZ
                fBodyAccJerkmeanX
                fBodyAccJerkmeanY
                fBodyAccJerkmeanZ
                fBodyAccJerkstdX
                fBodyAccJerkstdY
                fBodyAccJerkstdZ
                fBodyGyromeanX
                fBodyGyromeanY
                fBodyGyromeanZ
                fBodyGyrostdX
                fBodyGyrostdY
                fBodyGyrostdZ
                fBodyAccMagmean
                fBodyAccMagstd
                fBodyBodyAccJerkMagmean
                fBodyBodyAccJerkMagstd
                fBodyBodyGyroMagmean
                fBodyBodyGyroMagstd
                fBodyBodyGyroJerkMagmean
                fBodyBodyGyroJerkMagstd

mean
        The simple average of the measurements on the grouping of activity,
        subject, and variable
        Class: numeric