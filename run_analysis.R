##Load dplyr and tidyr
library(dplyr)
library(tidyr)

##Read in the variable names
col_names <- read.delim("./UCI_HAR_Dataset/features.txt", header = F, sep= " ",stringsAsFactors = F)

##Make a data set of the columns we want
desired_columns <- col_names[grep("(?:std)|(?:mean)",col_names$V2),]

##Build the data set of test subjects
###Chain consists of readinging the subjects, reading acitvities and binding that column to the set,
###reading the actvitities and joining them on the activity id, read the sample data and select the columns we want.
data_set <- read.delim("./UCI_HAR_Dataset/test/subject_test.txt", header = F, col.names = c("Subject")) %>%
  cbind(read.delim("./UCI_HAR_Dataset/test/y_test.txt", header = F, col.names = c("ActivityIndex"))) %>% tbl_df() %>%
  inner_join(read.delim("./UCI_HAR_Dataset/Activity_labels.txt", header = F, sep= " " ,col.names =c("ActivityIndex", "Activity"))) %>%
  cbind(read.delim("./UCI_HAR_Dataset/test/X_test.txt", header = F, sep= "", col.names=as.vector(col_names$V2))) %>% tbl_df() %>% select(c(1,3,desired_columns$V1 +3))

##Build the data set of train sujects
###The chain is as documnented above
data_set2 <- read.delim("./UCI_HAR_Dataset/train/subject_train.txt", header = F, col.names = c("Subject")) %>%
  cbind(read.delim("./UCI_HAR_Dataset/train/y_train.txt", header = F, col.names = c("ActivityIndex"))) %>% tbl_df() %>%
  inner_join(read.delim("./UCI_HAR_Dataset/Activity_labels.txt", header = F, sep= " " ,col.names =c("ActivityIndex", "Activity"))) %>%
  cbind(read.delim("./UCI_HAR_Dataset/train/X_train.txt", header = F, sep= "", col.names=as.vector(col_names$V2))) %>% tbl_df() %>% select(c(1,3,desired_columns$V1 +3)) 

##Combine the train and test data sets into one set using rbind()
combined_set <- rbind(data_set, data_set2)

##Create tidy summary data using the combined_set grouped by Subject and Activity.  The means are run ove the groups.
summarized_output <- summarize_each(group_by(combined_set,Subject,Activity), funs(mean))

##Clean up variable names
colnames(summarized_output) <- gsub("mean","Mean",colnames(summarized_output))
colnames(summarized_output) <- gsub("std","Std",colnames(summarized_output))
colnames(summarized_output) <- gsub("\\.","",colnames(summarized_output))

#Clean up our temporary work
rm(list=c("col_names","desired_columns","data_set","data_set2","combined_set"))