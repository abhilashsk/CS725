#CS 705 Assignment 1
##Abhilash Kulkarni
##Roll No. 13001006

The given code uses Random Forest Model to predict the bike sharing count

The train data is loaded in the dataset "bikedatatrain", and the test data is loaded in "bikedatatest"

All the discrete variables in the dataset like yr, mnth, season etc are converted in to factor variables in both test and train data

I have also created new factor feature variables which divides the data points into categories based on following features:

* Normalized Temperature (temp)
* Year and Month (Both converted into a single year_part factor variable)
* Day_type is a factor variable which tells whether the day was a working day, holiday or a weekend holiday

Then I have used the randomForest function from the randomForest library to predict the count values.

The predicted data value is then written into the output.csv file 

library used :

* rpart
* library(rattle)
* library(rpart.plot)
* library(RColorBrewer)
* library(randomForest)
* library(e1071)

To run, type source("130010006.R") in R console.

Both the train and test datasets should be in the same folder as the R file