SmartData <- function () {
    
    # library loading
    library(dplyr)
    
    # download the smart phone data
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "./smartdata.zip", method = "curl")
    
    #Extract files in the zip file
    Smartfiles <- unzip("./smartdata.zip")
    
    #Assembling train data set
    
    #Extract "./UCI HAR Dataset/train/X_train.txt" 
    TrainData <- read.table(Smartfiles[27])
    #Extract "./UCI HAR Dataset/train/y_train.txt"
    TrainAct <-  read.table(Smartfiles[28])
    #Extract "./UCI HAR Dataset/train/subject_train.txt" 
    TrainSubject <- read.table(Smartfiles[26])
    
    Train <- data.frame(TrainSubject,TrainAct,TrainData)
    
    #Assmebling test data set
    
    #Extract "./UCI HAR Dataset/test/X_test.txt"
    TestData <- read.table(Smartfiles[15])
    #Extract "./UCI HAR Dataset/test/y_test.txt" 
    TestAct <-  read.table(Smartfiles[16])
    #Extract "./UCI HAR Dataset/test/subject_test.txt"
    TestSubject <- read.table(Smartfiles[14])
    
    Test <- data.frame(TestSubject,TestAct,TestData)
    
    #Merging Train and Test data
    MergeData <- bind_rows(Train, Test)
    
    #setting column names
    MergeData <- rename(MergeData, subjectID = V1, activity = V1.1)
        #Extract "./UCI HAR Dataset/features.txt" 
        features <- read.table(Smartfiles[2])
    #561 features will be set column names
    names(MergeData)[3:563] <- as.character(features$V2)
    
    #Filter out measurements other than mean and standard deviation
    #filtering indices for mean()
    Meanindex <- grep(pattern = "mean\\()", x = names(MergeData))
    #filtering indices for std()
    stdindex <- grep(pattern = "std()", x = names(MergeData))
    #indices combined
    MeanStdindx <- c(Meanindex,stdindex)
    MeanStdindx <- sort(MeanStdindx)
    # Mean and Std columns filtered, including subjectID and activity
    MergeMeanStd <- MergeData[, c(1,2,MeanStdindx)]
    
    #Getting descriptive activity names "./UCI HAR Dataset/activity_labels.txt"                         
    Actnames <- read.table(Smartfiles[1])
    for(i in 1:nrow(MergeMeanStd)) {MergeMeanStd$activity[i] = as.character(Actnames[,2][which(MergeMeanStd$activity[i] == Actnames[,1])])}
    
    # new data set group by subject and activity
    MeanSubAct <- group_by(MergeMeanStd, subjectID, activity) 
    AvgSubAct <- summarise_each(MeanSubAct, funs(mean))
    
    #writing tidy data to tables
    write.table(MeanSubAct, "./MeanSubAct.txt", row.names = FALSE)
    write.table(AvgSubAct, "./AvgSubAct.txt", row.names = FALSE)
    
}