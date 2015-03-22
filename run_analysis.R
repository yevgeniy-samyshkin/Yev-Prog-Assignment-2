# Course project 
# run_analysis.R

# ====== Readme.txt ===========================================

# Yevgeniy SAMYSHKIN 
# 22 March 2015 

# This script does the following: 

# 1. Merges the training and the test data sets to create one data set
# 2. Extracts only the measurements on the mean() and standard deviation() for each measurement 
 
# 3. Assigns descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names 

# 5. From the data set in Step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Notes: 
# 1. the script is run from a given working directory
# 2. the scipt uses {dplyr}
# 3. the script generate intermediate text lines showing the action being performed (using cat()) 

# ====== Readme.txt ===========================================

library(dplyr)

cat("===== STEP I: LOADING DATA TABLES", "\n")

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
	

cat("===== STEP II: COMBINING DATA TABLES AND LABELLING DATA", "\n")

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

# Prepare a table that will contain columns for subject, activity, feature, mean() and std()
# create columns  

	df_x<-mutate(df_x, activity="")

# dataset will contain only columns of interest (mean and sTd for each feature):
	df_x<-select(df_x, subject, activity_no, activity, V201:V202, V214:V215, V227:V228, V240:V241, V253:V254, V503:V504, V516:V517, V529:V530, V542:V543)


# Rename columns to assign features (mean and std still in columns):
 
df_x<-rename(df_x, tBodyAccMag.mean=V201, tBodyAccMag.std=V202) 
df_x<-rename(df_x, tGravityAccMag.mean=V214, tGravityAccMag.std=V215) 

df_x<-rename(df_x, tBodyAccJerkMag.mean=V227, tBodyAccJerkMag.std=V228) 
df_x<-rename(df_x, tBodyGyroMag.mean=V240 , tBodyGyroMag.std=V241) 

df_x<-rename(df_x, tBodyGyroJerkMag.mean=V253, tBodyGyroJerkMag.std=V254)
df_x<-rename(df_x, fBodyAccMag.mean=V503, fBodyAccMag.std=V504)

df_x<-rename(df_x, fBodyBodyAccJerkMag.mean=V516, fBodyBodyAccJerkMag.std=V517)

df_x<-rename(df_x, fBodyBodyGyroMag.mean=V529, fBodyBodyGyroMag.std=V530)
df_x<-rename(df_x, fBodyBodyGyroJerkMag.mean=V542, fBodyBodyGyroJerkMag.std=V543)

	
# The dataset with variables organised, activity still to be labelled 

#####	df_x<-select(df_x, subject, activity_no, activity, )

	df_x_walking <- filter(df_x, activity_no== 1)		
	df_x_walking_upstairs  <- filter(df_x, activity_no== 2)
	df_x_walking_downstairs  <- filter(df_x, activity_no== 3)
	df_x_sitting <- filter(df_x, activity_no== 4)
	df_x_standing <- filter(df_x, activity_no== 5)
	df_x_laying  <- filter(df_x, activity_no== 6)

	df_x_walking<-mutate(df_x_walking, activity="1.WALKING")
	df_x_walking_upstairs<-mutate(df_x_walking_upstairs,  activity="2.WALKING UPSTAIRS")
	df_x_walking_downstairs<-mutate(df_x_walking_downstairs,  activity="3.WALKING DOWNSTAIRS")
	df_x_sitting<-mutate(df_x_sitting,  activity="4.SITTING")
	df_x_standing<-mutate(df_x_standing, activity="5.STANDING")
	df_x_laying<-mutate(df_x_laying, activity="6.LAYING")


	df_x <- rbind(df_x_walking, df_x_walking_upstairs, df_x_walking_downstairs, df_x_sitting, df_x_standing, df_x_laying)


# Summary: df_x_final is a tidy dataset in which eack line is a measurement for one subject with means and standard deviations presented
# each measurement for subjects is characterised by activity

# * note that columns labelled in dataset as standard deciations have negative values (whereas STD is supposed to be positive in statistics)- I do not have explanation and the numbers are presented as they are
# I have checked the row datasets - no single column is repretented by positivie numbers only 


# In the summary I have included only the averages of the mean values, as the averages of standard deviations does mu make obvious sense, but the principle remains the same   

grouped <-group_by(df_x, subject, activity)

summarized <-summarize(grouped, 
	m.tBodyAccMag= mean(tBodyAccMag.mean), 
	m.tGravityAccMag=mean(tGravityAccMag.mean), 
	m.tBodyAccJerkMag=mean(tBodyAccJerkMag.mean), 
	m.tBodyGyroMag=mean(tBodyGyroMag.mean),
	m.tBodyGyroJerkMag=mean(tBodyGyroJerkMag.mean),
	m.fBodyAccMag=mean(fBodyAccMag.mean),
	m.fBodyBodyAccJerkMag=mean(fBodyBodyAccJerkMag.mean),
	m.fBodyBodyGyroMag=mean(fBodyBodyGyroMag.mean),
	m.fBodyBodyGyroJerkMag=mean(fBodyBodyGyroJerkMag.mean))

# >head(summarized)
	
#  subject             activity m.tBodyAccMag m.tGravityAccMag m.tBodyAccJerkMag m.tBodyGyroMag m.tBodyGyroJerkMag m.fBodyAccMag m.fBodyBodyAccJerkMag
# 1       1            1.WALKING   -0.13697118      -0.13697118       -0.14142881    -0.16097955         -0.2987037   -0.12862345           -0.05711940
# 2       1   2.WALKING UPSTAIRS   -0.12992763      -0.12992763       -0.46650345    -0.12673559         -0.5948829   -0.35239594           -0.44265216
# 3       1 3.WALKING DOWNSTAIRS    0.02718829       0.02718829       -0.08944748    -0.07574125         -0.2954638    0.09658453            0.02621849
# 4       1            4.SITTING   -0.94853679      -0.94853679       -0.98736420    -0.93089249         -0.9919763   -0.94778292           -0.98526213
# 5       1           5.STANDING   -0.98427821      -0.98427821       -0.99236779    -0.97649379         -0.9949668   -0.98535636           -0.99254248
# 6       1             6.LAYING   -0.84192915      -0.84192915       -0.95439626    -0.87475955         -0.9634610   -0.86176765           -0.93330036
# Variables not shown: m.fBodyBodyGyroMag, m.fBodyBodyGyroJerkMag

cat("Script completed", "\n")


