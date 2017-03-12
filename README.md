# Module-3---Project

Course project for Module 3: Getting and Cleaning Data course. 

There is an R script attached, entitled "run_analysis.R", that does the following:

1. Clear the work space
2. Sets the working directory
3. Read the data from a pre-downloaded folder
4. Loads both the training and test datasets, labelling them in turn
5. Merges the two datasets
6. Creates a vector that selects only the mean and standard deviation
7. Merges the vector in (6) with the dataset in (5)
8. Creates a tidy dataet that consists of the average value of each variable for each subject and activity
9. Writes the final result in a text file, entitled "tidyset.txt"
