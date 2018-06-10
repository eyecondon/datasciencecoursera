## Load dplyr package
library(dplyr)

## We have already downloaded and unziped the data
# Location of the unziped folder: 'UCI HAR Dataset'
workdata <- "C:/Users/Don/Desktop/R/Coursera/Class - Cleaning Data/Cleaning Data- Final Projec/UCI HAR Dataset"

# Get the initial working directory
past_wd <- getwd()
# Edit the current wd
setwd(workdata)
new_wd <- getwd()

## Build a final tibble for all the data
# We get all the activities here
activities <- read.table("activity_labels.txt", header = FALSE)
# print(activities)

# All features recorded
features <- read.table("features.txt", header = FALSE)

# Fix name of variables: drop special characters
featuresV2 <- as.character(features$V2)
featuresV2 <- gsub(")", "", featuresV2, fixed = TRUE)
featuresV2 <- gsub("(", "", featuresV2, fixed = TRUE)
featuresV2 <- gsub(",", "", featuresV2, fixed = TRUE)
featuresV2 <- gsub("-", "", featuresV2, fixed = TRUE)

# (Step 1) The header of our final data: a vector of labels(subject, activities and measurement labels)
header <- c()
header <- c(header, c("subject", "activity", featuresV2))

# (Step 2) Load subject test & train data
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")

# (Step 3) All subjects: merge
subjects <- c(subject_test[, 1], subject_train[, 1])

# (Step 4) All activities recorded and merge them
Y_test <- read.table("test/Y_test.txt")
Y_train <- read.table("train/Y_train.txt")

Y <- c(Y_test[, 1], Y_train[, 1])

# (Step 5) All row of measurement recorded + merged

X_test <- read.table("test/X_test.txt")
X_train <- read.table("train/X_train.txt")

X <- rbind(X_test, X_train)

# (Step 6) Merge all into one data set
df <- cbind(subjects, Y, X)

# (Step 7) Delete duplicated variable in the data set and headers
# Set the data with descriptive variables names
names(df) <- header
df <- df[, !duplicated(header)]
df <- tbl_df(df)

# (Step 8) Extract only the measurement of the mean and std for each measurement
# As these fields are correctly named, we will grab all field with word mean and std
data_feature <- df %>% select(subject, activity, contains("mean", ignore.case = TRUE), contains("std", ignore.case = TRUE))

# (Step 9) Descriptive activity names
data <- data_feature %>% mutate(activity = activities[activity, "V2"])

# (Step 10) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data <- data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# (Step 11) Write the final tidy data as a txt file
write.csv(data, file = "tidydata.txt", row.names=FALSE)
write.csv(colnames(data), file = "features.txt")

# (Step 12) At the end we reset the wording dir
setwd(past_wd)