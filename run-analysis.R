# 1. Append the training and the test sets to create one data set.
#
append_data <- function(){
        # Read data and make columns numeric
        x_train <- read.table("UCI HAR Dataset/train/X_train.txt", skipNul = TRUE, colClasses = c("character", "numeric"))
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
                train <- cbind(x_train, y_train, subject_train)
        x_test <- read.table("UCI HAR Dataset/test/X_test.txt", skipNul = TRUE, colClasses = c("character", "numeric"))
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
        test <- cbind(x_test, y_test, subject_test)
        combined <<- rbind(train, test)
        i <- 1
        # Initially I get some columns of X_train/test imported as character instead of numeric
        # Manually make sure all X columns are numeric
        while (i < 562){
                combined[,i] <<- as.numeric(combined[,i])
                i <- i + 1
        }
}
#
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
#
subset_data <- function(){
        # Select only the columns whose names contain the strings "mean" or "std" but not "meanF"
        # (I chose to exclude the "meanFreq" columns)
        namelist <<- read.table("UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors = FALSE)
        # Use grepl to find ("mean" AND NOT "meanF") OR "std"
        extracted <<- combined[,c((grepl("mean",namelist$V2) & !grepl("meanF",namelist$V2)) | grepl("std",namelist$V2), TRUE, TRUE)]
}
#
# 3. Use descriptive activity names to name the activities in the data set
#
name_activities <- function(){
        # Add "friendly" activity names and put them into the activity (penultimate) column
        activities <<- data.frame(Y = 1:6, Activity = c("Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Lying down"))
        extracted[,ncol(extracted) - 1] <<- activities[extracted[,ncol(extracted) - 1],2]
}
#
# 4. Appropriately label the data set with descriptive variable names.
#
rename_columns <- function(){
        # I have directly used the names from features.txt instead of trying to clarify them
        # They are explained in the codebook
        # Use the same grepl expression as used to subset by columns in part 3
        names(extracted) <<- c(namelist[(grepl("mean",namelist$V2) & !grepl("meanF",namelist$V2)) | grepl("std",namelist$V2), 2], "Activity", "Subject")
}
#
# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
#
summarise_data <- function(){
        # Prepare summary (means of each numeric column, by activity and subject)
        require(dplyr)
        grouped <- group_by(extracted,Subject,Activity)
        data_summary <- summarise_if(grouped, is.numeric, .funs = mean)
        # Write tidy data set
        write.table(data_summary, file = "tidydata.txt", row.names = FALSE)
}
