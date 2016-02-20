#Code for Assignment 1
#By Abhilash Kulkarni
#Roll No. 130010006
#Load the dataset, assuming the working directory is the directory containing the data set

bikedatatrain <- read.csv("bikeDataTrainingUpload.csv")
bikedatatest <- read.csv("TestX.csv")
#load all required libraries
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(randomForest)
library(e1071)
#convert the discrete variables into factors in both test and train data

bikedatatrain$season = as.factor(bikedatatrain$season)
bikedatatrain$yr = as.factor(bikedatatrain$yr)
bikedatatrain$weekday = as.factor(bikedatatrain$weekday)
bikedatatrain$workingday = as.factor(bikedatatrain$workingday)
bikedatatrain$weathersit = as.factor(bikedatatrain$weathersit)

#Similarly for test data
bikedatatest$season = as.factor(bikedatatest$season)
bikedatatest$yr = as.factor(bikedatatest$yr)

bikedatatest$weekday = as.factor(bikedatatest$weekday)
bikedatatest$workingday = as.factor(bikedatatest$workingday)
bikedatatest$weathersit = as.factor(bikedatatest$weathersit)

#Now for Random Forest Model, we have to convert the temperature and day type in to factors


a=rpart(cnt~temp,data=bikedatatrain)
fancyRpartPlot(a)

#Using the values got from above, I am creating a new factor variable which will contain the the temperature extent type
# in a column temp_type

bikedatatrain$temp_type[bikedatatrain$temp<0.27]=1
bikedatatrain$temp_type[bikedatatrain$temp>=0.27 & bikedatatrain$temp<0.43 ]=2
bikedatatrain$temp_type[bikedatatrain$temp>=0.43 & bikedatatrain$temp<0.51]=3
bikedatatrain$temp_type[bikedatatrain$temp>=0.51]=4

#Similarly for test data

bikedatatest$temp_type[bikedatatest$temp<0.27]=1
bikedatatest$temp_type[bikedatatest$temp>=0.27 & bikedatatest$temp<0.43 ]=2
bikedatatest$temp_type[bikedatatest$temp>=0.43 & bikedatatest$temp<0.51]=3
bikedatatest$temp_type[bikedatatest$temp>=0.51]=4

bikedatatrain$hum_type[bikedatatrain$hum>=0.77]=1
bikedatatrain$hum_type[bikedatatrain$hum>=0.44]=2
bikedatatrain$hum_type[bikedatatrain$hum<0.44&bikedatatrain$hum<0.45]=3
bikedatatrain$hum_type[bikedatatrain$hum>=0.45]=4

bikedatatest$hum_type[bikedatatest$hum>=0.77]=1
bikedatatest$hum_type[bikedatatest$hum>=0.44]=2
bikedatatest$hum_type[bikedatatest$hum<0.44&bikedatatest$hum<0.45]=3
bikedatatest$hum_type[bikedatatest$hum>=0.45]=4

bikedatatrain$ws_type[bikedatatrain$windspeed>=0.33]=1
bikedatatrain$ws_type[bikedatatrain$windspeed<0.33&bikedatatrain$windspeed>=0.22]=2
bikedatatrain$ws_type[bikedatatrain$windspeed<0.22&bikedatatrain$windspeed>=0.19]=3
bikedatatrain$ws_type[bikedatatrain$windspeed<0.19]=4

bikedatatest$ws_type[bikedatatest$windspeed>=0.33]=1
bikedatatest$ws_type[bikedatatest$windspeed<0.33&bikedatatest$windspeed>=0.22]=2
bikedatatest$ws_type[bikedatatest$windspeed<0.22&bikedatatest$windspeed>=0.19]=3
bikedatatest$ws_type[bikedatatest$windspeed<0.19]=4



#Also creating a day_type variable, depending on whether the day is a weekend holiday
# or weekday holiday

bikedatatrain$day_type=0
bikedatatrain$day_type[bikedatatrain$holiday==0 & bikedatatrain$workingday==0]=1
bikedatatrain$day_type[bikedatatrain$holiday==1]=2
bikedatatrain$day_type[bikedatatrain$holiday==0 & bikedatatrain$workingday==1]= 3

#Similarly for test data
bikedatatest$day_type=0
bikedatatest$day_type[bikedatatest$holiday==0 & bikedatatest$workingday==0]=1
bikedatatest$day_type[bikedatatest$holiday==1]=2
bikedatatest$day_type[bikedatatest$holiday==0 & bikedatatest$workingday==1]= 3

#In order to account for growth/fall in bike rentals from year to year, we need to
# consider both month and year in a single factor variable

bikedatatrain$year_part[bikedatatrain$yr==0]=1
bikedatatrain$year_part[bikedatatrain$yr==0 & bikedatatrain$mnth>3]=2
bikedatatrain$year_part[bikedatatrain$yr==0 & bikedatatrain$mnth>6]=3
bikedatatrain$year_part[bikedatatrain$yr==0 & bikedatatrain$mnth>9]=4
bikedatatrain$year_part[bikedatatrain$yr==1]=5
bikedatatrain$year_part[bikedatatrain$yr==1 & bikedatatrain$mnth>3]=6
bikedatatrain$year_part[bikedatatrain$yr==1 & bikedatatrain$mnth>6]=7
bikedatatrain$year_part[bikedatatrain$yr==1 & bikedatatrain$mnth>9]=8

#similarly for test data
bikedatatest$year_part[bikedatatest$yr==0]=1
bikedatatest$year_part[bikedatatest$yr==0 & bikedatatest$mnth>3]=2
bikedatatest$year_part[bikedatatest$yr==0 & bikedatatest$mnth>6]=3
bikedatatest$year_part[bikedatatest$yr==0 & bikedatatest$mnth>9]=4
bikedatatest$year_part[bikedatatest$yr==1]=5
bikedatatest$year_part[bikedatatest$yr==1 & bikedatatest$mnth>3]=6
bikedatatest$year_part[bikedatatest$yr==1 & bikedatatest$mnth>6]=7
bikedatatest$year_part[bikedatatest$yr==1 & bikedatatest$mnth>9]=8

#Convert all the newly made columns into factor variables
bikedatatrain$temp_type = as.factor(bikedatatrain$temp_type)
bikedatatrain$day_type = as.factor(bikedatatrain$day_type)
bikedatatrain$year_part = as.factor(bikedatatrain$year_part)
bikedatatrain$hum_type = as.factor(bikedatatrain$hum_type)
bikedatatrain$ws_type = as.factor(bikedatatrain$ws_type)
bikedatatrain$mnth = as.factor(bikedatatrain$mnth)

#Similarly for test data
bikedatatest$temp_type = as.factor(bikedatatest$temp_type)
bikedatatest$day_type = as.factor(bikedatatest$day_type)
bikedatatest$year_part = as.factor(bikedatatest$year_part)
bikedatatest$hum_type = as.factor(bikedatatest$hum_type)
bikedatatest$ws_type = as.factor(bikedatatest$ws_type)
bikedatatest$mnth = as.factor(bikedatatest$mnth)

#Initialize the count in the test data
bikedatatest$cnt = 0

#add column to store log of count
#bikedatatrain$logcnt = log(bikedatatrain$cnt + 1)


obj = best.tune(randomForest, cnt ~day_type +temp_type+hum_type+ws_type+year_part+workingday+holiday+hum+windspeed+temp+atemp+weathersit+mnth+yr+season, data = bikedatatrain)
summary(obj)
#Use Random Forest Fit to predict the data using the existing and created features
set.seed(5746)
model_registered <- randomForest(registered ~ day_type +temp_type+hum_type+ws_type+year_part+workingday+holiday+hum+windspeed+temp+atemp+weathersit+mnth+yr+season, data = bikedatatrain,mtry = obj$mtry,
        ntree = 1000, importance = TRUE)
predicted_values=predict(model_registered,bikedatatest)
bikedatatest$cnt=round(predicted_values)

#Convert the predicted values back to count 
#bikedatatest$cnt = round(exp(bikedatatest$logcnt) - 1)

#Store the predicted values in a data frame
solution = cbind(Id = seq(0,nrow(bikedatatest)-1),cnt = bikedatatest$cnt)

#Print the predicted values to a file
write.csv(solution,file = "rollno.csv",row.names = FALSE)
