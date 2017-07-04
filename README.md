## Cleaning and summarisation of mobile phone data
### Purpose
The accompanying R script run-analysis.R merges three training and three test data sets.  It also prepares a summary (means of each numerical variable) by test subject and by the activities the subjects are preforming, which conforms to the principles of "tidy data" (H. Wickham, (2014) Tidy data, J. Stat. Soft. 59, no. 10).

### Prerequisites
The data should be in a sub-directory of the working directory called "UCI HAR Dataset", with training data in a sub-directory "train" of this directory, and test data in a sub-directory "test" at the same level.  The list of features (features.txt) should be in the "UCI HAR Dataset" folder.

### Executing the script
The script contains a separate function to execute each of the five required steps.  They should be executed in turn.  In full they are:

append_data(): Import test and train data; merge sensor data with activity and subject labels; append test data to training data
subset_data(): Retain only the data columns which contain a mean or standard deviation (the "mean frequency" columns are excluded), plus the activity and subject labels
name_activities(): Replace the activity codes (integers from 1-6) with "friendly" activity names, based on, but clarified from, the activity names in the "activity_labels.txt" file provided as part of the raw data sets
rename_columns(): Name each of the sensor data columns following the names in the file "features.txt" supplied as part of the raw data, and name the activity and subject columns
summarise_data(): Prepare the summaries and save it to a space-delimited file titled "tidydata.txt" in the root of the R working directory

We can execute the cleaning with the single command

append_data(); subset_data(); name_activities(); rename_columns(); summarise_data()

### Viewing results
The summary may be loaded by issuing the command:

read.csv(tidydata.txt, sep = " ")

### More information on the data

Further description of the variables included in the tidy data set may be found in the accompanying file CodeBook.md.
