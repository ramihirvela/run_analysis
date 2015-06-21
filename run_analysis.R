## test read

y_test <-  read.table("test/Y_test.txt")
subject_test <-  read.table("test/subject_test.txt")
x_test <-  read.table("test/X_test.txt")


## train read

y_train <-  read.table("train/Y_train.txt")
subject_train <- read.table("train/subject_train.txt")
x_train <-  read.table("train/X_train.txt")


## rename columns

features <-read.table("features.txt")
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]
colnames(subject_train) <- "Subject"
colnames(subject_test) <- "Subject"
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"

## extract mean & standard deviation
x_test_ext <- x_test[grep("mean()", names(x_test), fixed=TRUE)]
x_test_ext <- cbind(x_test_ext, x_test[grep("std()", names(x_test), fixed=TRUE)])
x_train_ext <- x_train[grep("mean()", names(x_train), fixed=TRUE)]
x_train_ext <- cbind(x_train_ext, x_train[grep("std()", names(x_train), fixed=TRUE)])

## merge data
train <- cbind(y_train, subject_train, x_train_ext)
test <- cbind(y_test, subject_test, x_test_ext)
dataset <- rbind(test, train)

#rename activity labels

dataset[1][dataset[1]==1] <- "WALKING"
dataset[1][dataset[1]==2] <- "WALKING UP"
dataset[1][dataset[1]==3] <- "WALKING DOWN"
dataset[1][dataset[1]==4] <- "SITTING"
dataset[1][dataset[1]==5] <- "STANDING"
dataset[1][dataset[1]==6] <- "LAYING"

## create tidy dataset

tidyData <- aggregate(.~ Activity + Subject, dataset, mean, na.rm=TRUE)