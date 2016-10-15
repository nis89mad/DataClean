Files contained

run_analysis.R - R script used generate the required tidy data sets
CodeBook.md - contains details on the variables included in data sets generated using the R script run_analysis.R

Transformations done on the data available from Smartphones Dataset

1. Text files contained in train folder loaded in to R using read.table() function
2. DataFrame ("Train") is set up to contain the subject ID, activty done and the associated variables from the files loaded from train folder
3. Text files contained in test folder loaded in to R using read.table() function
4. DataFrame ("Test"") is set up to contain the subject ID, activty done and the associated variables from the files loaded from test folder
5. Train data and test data are combined ("MergeData") using bind_rows function
6. 1st and 2nd Column names in MergeData dataframe renamed to "subjectID" and "activity", respectively
7. Rest of the columns (3 to 563) renamed using the variable names provided in features.txt file
8. Columns associated with mean (indicated by "mean()" in the variable name) and standard deviation (indicated by "std()" in the variable name) taken out. Other columns were removed
9. Numbers in the activty column were mapped with their respective activity name as per activity_labels.txt
10. Resulting dataset is gruped first by subjectID column and then activity column
11. This provides the first tidy dataset MeanSubAct
12. MeanSubAct dataset is summerized with mean function to generate AvgSubAct dataset