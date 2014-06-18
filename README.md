R Getting and Cleaning Data - Course Project
========================================================

Script
--------------------------------------------------------

The script run_analysis.R processes the Samsung data into a tidy data set tidy.txt in the working directory, according to the following steps:

1. Download the Samsung data and unzip into the working directory
2. Read the training data
3. Read the test data
4. Reading supporting data (features and activity labels)
5. For activities: append test to training data, convert to factors with level names and label the column
6. For subjects: append test to training data, convert to factors, and label the column
7. For features: extract mean and std measures, combine training and test data, and label the columns
8. Merge activity, subject and features together
9. Calculate mean by activity, subject and variable groupings and output as a tidy data set

Data Dictionary
--------------------------------------------------------

Refer to codebook.txt in this repository.