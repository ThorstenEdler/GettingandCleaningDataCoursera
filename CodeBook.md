data source:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
data description:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script does the following to clean the data:

* 1. merging of training and test sets
* 2. reading features.txt 
* 3. extraction of mean and standard deviation for each measurement
* 4. reading activity_labels.txt and naming activities in the data set by applying descriptive activity names
* 5. labeling the data set with descriptive names
* 6. merging the feature data frame with the activity label/subject ID data frame
* 7. saving the result in merged_clean_data.txt, a 10299x68 data frame
* 8. creating tidy data set with the average of each measurement for each activity and each subject.
* 9. saving the result in data_set_with_the_averages.txt
