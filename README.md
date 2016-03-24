# Coursera-Getting an Cleaning Data #
## Course Project ##

###R Scripts###
####run_analysis.R####
The run_analysis.R script performs all functions required in this assignment.  The code flows as follows.  
1. Load dplyr  
2. Read the variable names from features.txt  
3. Make as data set containing the columns we want.  
4. Create the data set for the test subjects.  
5. Create the data set for the train subjects.  
6. Combine the test and train data sets.  
7. Create the result data set by summarizing the data by Subject and Activity and calculate the mean of those grouped variables.  
8. Clean up the variable names.  
9. Write the output to a text file.  
10. Clean up the environment

The data sets are created using a pipeline which works as follows.
Reading the subjects, reading activities and binding that column to the set,
read the activities and joining them on the activity id, read the sample data and select the columns we want.
