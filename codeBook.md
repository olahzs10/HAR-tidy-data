## Code book for the R script

### Data source

* 'activity_labels.txt' - contains the labels for the physical activities to be measured during the exercise.
* 'features.txt' - contains a vector of the names of the different measurements (561 different features.)
* './test/y_test.txt' - activity ids for the test data.
* './test/X_test.txt' - feature values for the test data.
* './test/subject_test.txt' - subject ids for the test data.
* './train/y_train.txt' - subject ids for the training data.
* './train/X_train.txt' - feature values for the training data.
* './train/subject_train.txt' - activity ids for the training data.

### Functions and transformations
* 'load_data()' - special reading function doing the following steps:
1) read ids from text data using 'scan()' function;
2) read in data set for feature values, andtransform it into a matrix;
3) putting ids and data matrix together into a data.frame.

* Using lapply() to read in different types of data (train/test).
* Extract and merge data from the "large" list created in the previous step.
* Calculating target measures with colMeans() and apply(...,sd).
* Calculating target measures along each subject and activity id with ddply() from plyr package.

### Variables in the resulting data frame(s)

A) Data frame: 'final_data' -  contains the result from of the calculated means and standard deviations for the features.

B) Data frame: 'df2' - contains the mean of all features along subjects and activities (i.e. for all subject-activity pairs).

1. 'subject_id' - factor variable for train and test subjects in the exercise (1-30).
2. 'activity_id' - factor variables for physical activities ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING");
3. measurement - factor variable with 561 levels for the original features in the dataset
4. mean - calculated mean on the given basis. 
5. st_dev - calculated standard deviation on the given basis. 
