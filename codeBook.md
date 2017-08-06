## Reading and creating tidy datasets from 'Human Activity Recognition' data

### Short notice on the data source

Using the HAR data from UCI databases from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. We are going to use the following txt files to create our handy datasets:

* 'activity_labels.txt' - contains the labels for the physical activities to be measured during the exercise.
* 'features.txt' - contains a vector of the names of the different measurements (561 different features.)
* './test/y_test.txt' - activity ids for the test data.
* './test/X_test.txt' - feature values for the test data.
* './test/subject_test.txt' - subject ids for the test data.
* './train/y_train.txt' - subject ids for the training data.
* './train/X_train.txt' - feature values for the training data.
* './train/subject_train.txt' - activity ids for the training data.

### Reading data

First, we create a function to read the text data described above. The function uses the attribute of "train/test" in order to determine the type of the dataset, reads the corresponding data with the 'scan()' function, and then creates a data frame from each part of the database.Second, we use the 'lapply()' function to read and store the data frames in a "large" list. Finally, we extract and merge the data frames into one data frame.

### Calculating means and standard deviations

We use 'colMeans()' and 'apply(...,sd)' functions in order to calculate the corresponding measures of each feature vector in the merged data frame.

### Creating tidy data for the calculated measures

We read in the feature label vector from 'features.txt', and then put the data together in data frame 'final_data'. This is a 561x3 dataset for the measures of each feature.

### Creating tidy data for detailed measures along subject and activity ids

In the last step, we create a similar table for means as in the previous step, except that we do that for each subject and each activity (i.e. for each subject-activity pairs). In order to do that, we use the 'ddply()' function from 'plyr' package, while we read into our database the labels for the activites from 'activity_labels.txt'.
