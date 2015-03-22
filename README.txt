# Course project 
# run_analysis.R

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

# 3. !! some columns in the dataset are for standard deviations which are supposed to be positive numbers however none of the columns in the test and training dataset consists of positive numers only 
## http://en.wikipedia.org/wiki/Standard_deviation


The output file name "summarized.txt"

The codebook is:

# In tables df_x_test and df x_train - keep only the columns with the means and standard deviations for each activity 


	Label 		Features			Dataset
	
	## V201 	tBodyAccMag-mean()		tBodyAccMag.mean
	## V202 	tBodyAccMag-std()		tBodyAccMag.std
	
	## V214 	tGravityAccMag-mean()		tGravityAccMag.mean
	## V215 	tGravityAccMag-std()		tGravityAccMag.std

	## V227 	tBodyAccJerkMag-mean()		tBodyAccJerkMag.mean
	## V228 	tBodyAccJerkMag-std()		tBodyAccJerkMag.std
	
	## V240 	tBodyGyroMag-mean()		tBodyGyroMag.mean
	## V241 	tBodyGyroMag-std()		tBodyGyroMag.std

	## V253 	tBodyGyroJerkMag-mean()		tBodyGyroJerkMag.mean
	## V254 	tBodyGyroJerkMag-std()		tBodyGyroJerkMag.std
	
	## V503 	fBodyAccMag-mean()		fBodyAccMag.mean
	## V504	 	fBodyAccMag-std()		fBodyAccMag.std

	## V516 	fBodyBodyAccJerkMag-mean()	fBodyBodyAccJerkMag.mean
	## V517 	fBodyBodyAccJerkMag-std()	fBodyBodyAccJerkMag.std
	
	## V529 	fBodyBodyGyroMag-mean()		fBodyBodyGyroMag.mean
	## V530 	fBodyBodyGyroMag-std()		fBodyBodyGyroMag.std
	
	## V542 	fBodyBodyGyroJerkMag-mean()	fBodyBodyGyroJerkMag.mean
	## V543 	fBodyBodyGyroJerkMag-std()	fBodyBodyGyroJerkMag.std


Notation in the summarized file 

	m.tBodyAccMag	= mean(tBodyAccMag.mean), 
	m.tGravityAccMag = mean(tGravityAccMag.mean), 
	m.tBodyAccJerkMag = mean(tBodyAccJerkMag.mean), 
	m.tBodyGyroMag = mean(tBodyGyroMag.mean),
	m.tBodyGyroJerkMag = mean(tBodyGyroJerkMag.mean),
	m.fBodyAccMag = mean(fBodyAccMag.mean),
	m.fBodyBodyAccJerkMag = mean(fBodyBodyAccJerkMag.mean),
	m.fBodyBodyGyroMag = mean(fBodyBodyGyroMag.mean),
	m.fBodyBodyGyroJerkMag = mean(fBodyBodyGyroJerkMag.mean))


Activ.	Activ. label		Activity in dataset (with leading numbers easier to read)

1 	WALKING			1.WALKING			
2 	WALKING_UPSTAIRS	2.WALKING_UPSTAIRS
3 	WALKING_DOWNSTAIRS	3.WALKING_DOWNSTAIRS
4 	SITTING			4.SITTING
5 	STANDING		5.STANDING
6 	LAYING			6.LAYING


