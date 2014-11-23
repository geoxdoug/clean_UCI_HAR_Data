Read Me for run_analysis() on UCI_HAR_Dataset
==================
The script run_analysis.R processes the UCI-HAR dataset.
The description of steps and variables is in the file codebook.md.

To run the script:

1 - change to the directory that contains the script (e.g., setwd("my_folder")

2 - load the script: source("run_analysis.R")

3 - call the function "run_analysis"; with the directory name where the UCI-HAR dataset resides
output <- run_analysis()

Function returns 2 datasets:

output[[1]]: a data frame 'all_final' with containing the tidy data set

output[[2]]: a data frame 'tidy' with the means of all measurements for each subject by activity


Function creates a .csv file and a .txt file in the same directory

A) .csv file called "clean_data_UCI-HAR_all_final.csv" containing data frame all_final

B) .txt file called "clean_data_UCI-HAR_tidy.txt" containing data frame tidy
