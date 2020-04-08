The code download in the working directory the raw data from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The first step is loading the dplyr library, then reading the tables with features and activities.

The table with the train dataset is processed by adding the features as headers, removing duplicated columns, then selecting the columns containing only mean and std values. Finally the columns Subject ID and Activity are added.

The test dataset is processed exactly as above.

Test and training datasets are then joined together, then the activity values are replaced with descriptive names.

The second dataframe containing the means after grouping by Subject Id and Activity is finally calculated and both the datasets are then exported as TXT files (respectively dataset1.txt and dataset2.txt in this folder).