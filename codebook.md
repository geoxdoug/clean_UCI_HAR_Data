<strong>Background:</strong>

This project cleans the Human+Activity+Recognition+Using+Smartphones  data set 

downloadable link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Prrocessing and manipulation of the raw data is detailed below:

<strong>1) Processing:</strong>

1.A - Merges the measurement data of both the test and train data set.

1.B - Adds the variable 'subject' to both the test and train data sets.

1.C - Addes the variable 'activity' to both the test and train data sets.

1.D - Keeps onnly variables that are mean or standard deviations

1.E - converts variable 'activity' into a factor and labels across levels.

1.F - Saves the resulting data frame into a comma separated file named "clean_data_UCI-HAR_tidy.txt"


<strong>2) CodeBook Vaiables:</strong>

2.A - 'subject' is the id of the subject, as specified in subject_test.txt and subject_train.txt files

2.B - 'activity' a factor describing what the subject was doing at the time of the measurement.

2.B.1 - It has 6 levels: walking, walking.upstairs, walking.downstairs, sitting, standing, laying

2.C - Remaining 66 variables are means and standard deviations as described in the README.txt file of UCI-HAR dataset.
