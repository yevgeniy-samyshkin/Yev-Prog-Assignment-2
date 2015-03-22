# Course project 
# run_analysis.R

# ====== Readme.txt ===========================================

# Student - Yevgeniy SAMYSHKIN 
# 22 March 2015 

# This script contains the following: 

# A brief description of the issues with the datasets and why in needs to be rearranged 

# 1. Merging the training and the test data sets to create one data set.
# 2. Extracting only the measurements on the mean and standard deviation for each measurement (#1 and #2 possibly can be done in reverse order)
 
# 3. Assigns descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Notes: 
# 1. the script is run from a given working directory
# 2. the scipu uses library {dplyr}

# ====== Readme.txt ===========================================

setwd("C:/Users/ys906826/Documents/04. Training/05. Coursera-R-II/course_project")
library(dplyr)


# Read files
# str(df_features)

	cat("===== STEP I: LOADING DATA TABLES", "\n")
	df_features <-read.table("features.txt")
	cat("Loading ... features.txt --> df_features", "\n")


## DATA SET : TRAIN 

# Data directory: /train -------------------------------------------

	cat("\n")
	cat("Loading ... train/X_train.txt --> df_x_train", "\n")
	df_x_train <-read.table("train/X_train.txt")

	cat("Loading ... train/Y_train.txt --> df_y_train", "\n")
	df_y_train <-read.table("train/Y_train.txt")

	cat("Loading ... train/subject_train.txt --> df_subject_train", "\n", "\n")
	df_subject_train <-read.table("train/subject_train.txt")



# DATA SET : TEST

# Data directory: /test -------------------------------------------

	cat("Loading ... train/X_test.txt --> df_x_test", "\n")
	df_x_test <-read.table("test/X_test.txt")
	
	cat("Loading ... test/Y_test.txt --> df_y_test", "\n")
	df_y_test <-read.table("test/Y_test.txt")
	
	cat("Loading ... test/subject_test.txt --> df_subject_test", "\n", "\n")
	df_subject_test <-read.table("test/subject_test.txt")
	

cat("===== STEP II: COMBINING DATA TABLES", "\n")

## Add paricipants' column to each data set 

	# -- Rename columns in participats dataset 
	
	df_subject_test<-rename(df_subject_test, subject=V1)
	df_subject_train<-rename(df_subject_train, subject=V1)
	
	df_y_test<-rename(df_y_test, activity_no=V1)
	df_y_train<-rename(df_y_train, activity_no=V1)
 

# In tables df_x_test and df x_train - keep only the columns with the means and standard deviations for each activity 

	## V201 tBodyAccMag-mean()
	## V202 tBodyAccMag-std()
	
	## V214 tGravityAccMag-mean()503 fBodyAccMag-mean()
	## V215 tGravityAccMag-std()

	## V227 tBodyAccJerkMag-mean()
	## V228 tBodyAccJerkMag-std()
	
	## V240 tBodyGyroMag-mean()
	## V241 tBodyGyroMag-std()

	## V253 tBodyGyroJerkMag-mean()
	## V254 tBodyGyroJerkMag-std()
	
	## V503 fBodyAccMag-mean()
	## V504 fBodyAccMag-std()

	## V516 fBodyBodyAccJerkMag-mean()
	## V517 fBodyBodyAccJerkMag-std()
	
	## V529 fBodyBodyGyroMag-mean()
	## V530 fBodyBodyGyroMag-std()
	
	## V542 fBodyBodyGyroJerkMag-mean()
	## V543 fBodyBodyGyroJerkMag-std()
	
# =================================================================

## Bind the activities variable to each dataset
	df_x_test<-cbind(df_y_test,df_x_test)
	df_x_train<-cbind(df_y_train,df_x_train)

## Bind the subject variable to each dataset 
	df_x_test<-cbind(df_subject_test, df_x_test) 
	df_x_train<-cbind(df_subject_train, df_x_train) 

## Combine datasets, further transformations to follow (creating a variable for Features)
	df_x<-rbind(df_x_test, df_x_train)

# Prepare a table that will contain columns for subject, activity_no, feature, mean() and std()
# create columns  

	df_x<-mutate(df_x, activity="", feature="", mean=0, std=0)

# dataset will contain only columns of interest (mean and sd for each feature):
	df_x<-select(df_x, subject, activity_no, activity, feature, mean, std, V201:V202, V214:V215, V227:V228, V240:V241, V253:V254, V503:V504, V516:V517, V529:V530, V542:V543)

# Rename columns to assign features (mean and std still in columns):
 
	df_x<-rename(df_x, tBodyAccMag_mean=V201, tBodyAccMag_std=V202) 
	df_x<-rename(df_x, tGravityAccMag_mean=V214, tGravityAccMag_std=V215) 
	df_x<-rename(df_x, tBodyAccJerkMag_mean=V227, tBodyAccJerkMag_std=V228) 
	df_x<-rename(df_x, tBodyGyroMag_mean=V240 , tBodyGyroMag_std=V241) 
	df_x<-rename(df_x, tBodyGyroJerkMag_mean=V253, tBodyGyroJerkMag_std=V254)
	df_x<-rename(df_x, fBodyAccMag_mean=V503, fBodyAccMag_std=V504)
	df_x<-rename(df_x, fBodyBodyAccJerkMag_mean=V516, fBodyBodyAccJerkMag_std=V517)
	df_x<-rename(df_x, fBodyBodyGyroMag_mean=V529, fBodyBodyGyroMag_std=V530)
	df_x<-rename(df_x, fBodyBodyGyroJerkMag_mean=V542, fBodyBodyGyroJerkMag_std=V543)


# Move values from features columns into the mean and std columns:

	df_x_1<-mutate(df_x, feature= "tBodyAccMag", 		mean=tBodyAccMag_mean, 			std=tBodyAccMag_std)
	df_x_2<-mutate(df_x, feature= "tGravityAccMag", 	mean=tGravityAccMag_mean, 		std=tGravityAccMag_std)
	df_x_3<-mutate(df_x, feature= "tBodyAccJerkMag", 	mean=tBodyAccJerkMag_mean, 		std=tBodyAccJerkMag_std)
	df_x_4<-mutate(df_x, feature= "tBodyGyroMag", 		mean=tBodyGyroMag_mean, 		std=tBodyGyroMag_std)
	df_x_5<-mutate(df_x, feature= "tBodyGyroJerkMag", 	mean=tBodyGyroJerkMag_mean, 		std=tBodyGyroJerkMag_std)
	df_x_6<-mutate(df_x, feature= "fBodyAccMag", 		mean=tBodyGyroJerkMag_mean, 		std=tBodyGyroJerkMag_std)
	df_x_7<-mutate(df_x, feature= "fBodyBodyAccJerkMag", 	mean=fBodyBodyAccJerkMag_mean, 	std=fBodyBodyAccJerkMag_std)
	df_x_8<-mutate(df_x, feature= "fBodyBodyGyroMag", 	mean=fBodyBodyGyroMag_mean, 		std=fBodyBodyGyroMag_std)
	df_x_9<-mutate(df_x, feature= "fBodyBodyGyroJerkMag", mean=fBodyBodyGyroJerkMag_mean, 	std=fBodyBodyGyroJerkMag_std)


	df_x<-rbind(df_x_1, df_x_2, df_x_3, df_x_4, df_x_5, df_x_6, df_x_7, df_x_8, df_x_9)
	
	# The dataset with variables organised, activity still to be labelled 

	df_x<-select(df_x, subject, activity_no, activity, feature, mean, std)

	df_x_walking <- filter(df_x, activity_no== 1)		
	df_x_walking_upstairs  <- filter(df_x, activity_no== 2)
	df_x_walking_downstairs  <- filter(df_x, activity_no== 3)
	df_x_sitting <- filter(df_x, activity_no== 4)
	df_x_standing <- filter(df_x, activity_no== 5)
	df_x_laying  <- filter(df_x, activity_no== 6)

	df_x_walking<-mutate(df_x_walking, activity="WALKING")
	df_x_walking_upstairs<-mutate(df_x_walking_upstairs,  activity="WALKING UPSTAIRS")
	df_x_walking_downstairs<-mutate(df_x_walking_downstairs,  activity="WALKING DOWNSTAIRS")
	df_x_sitting<-mutate(df_x_sitting,  activity="SITTING")
	df_x_standing<-mutate(df_x_standing, activity="STANDING")
	df_x_laying<-mutate(df_x_laying, activity="LAYING")


	df_x <- rbind(df_x_walking, df_x_walking_upstairs, df_x_walking_downstairs, df_x_sitting, df_x_standing, df_x_laying)
	df_x_final <-select(df_x, subject, activity, feature, mean, std)
	




### =======================================================================




