# read data 
x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt")
s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# merge data
x_merge <- rbind(x_train, x_test)
s_merge <- rbind(s_train, s_test)
y_merge <- rbind(y_train, y_test)

# extracting mean and sd
feats <- read.table("UCI HAR Dataset/features.txt")
f_index <- grep("-mean\\(\\)|-std\\(\\)", feats[, 2])
x_merge <- x_merge[, f_index]
names(x_merge) <- feats[f_index, 2]
names(x_merge) <- gsub("\\(|\\)", "", names(x_merge))
names(x_merge) <- tolower(names(x_merge))  

# labelling of activities 
acts <- read.table("UCI HAR Dataset/activity_labels.txt")
acts[, 2] = gsub("_", "", tolower(as.character(acts[, 2])))
y_merge[,1] = acts[y_merge[,1], 2]
names(y_merge) <- "activity_merge"

# merge labels
names(s_merge) <- "subject"
c_merge <- cbind(s_merge, y_merge, x_merge)

# write tidy data set
write.table(c_merge, "UCI HAR Dataset/tidy_data.txt")

# create independent tidy data set with the average of each variable for each activity and each subject
s_unique = unique(s_merge)[,1]
s_num = length(unique(s_merge)[,1])
n_acts = length(acts[,1])
n_cols = dim(c_merge)[2]
rs = c_merge[1:(s_num*n_acts), ]

row = 1
for (s in 1:s_num) {
	for (a in 1:n_acts) {
		rs[row, 1] = s_unique[s]
		rs[row, 2] = acts[a, 2]
		tmp <- c_merge[c_merge$subject==s & c_merge$activity_merge==acts[a, 2], ]
		rs[row, 3:n_cols] <- colMeans(tmp[, 3:n_cols])
		row = row+1
	}
}
write.table(rs, "UCI HAR Dataset/tidy_data_plus.txt")


