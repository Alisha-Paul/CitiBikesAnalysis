install.packages(c("readr", "lubridate", "dplyr", "tidyr"))
install.packages("devtools")

library(readr)
library(lubridate)
library(dplyr)
library(tidyr)
library(devtools)

rm(list=ls())

#readr
#read in CSV data using read_csv
trips <- read.csv("C:/Alisha/Trainings/Data Science with R Workshop/201601-citibike-tripdata.csv")
View(trips)
class(trips)

trips

#read in CSV data using read delim
trips <- read.delim("201601-citibike-tripdata.csv", delim = ",")

#read in CSV data with datetime objects
#trips <- read_csv(file.choose(),
#                  col_types = 
#                    cols(starttime = col_datetime(format = "%m/%d/%Y %H:%M:%S"),
#                         stoptime = col_datetime(format = "%m/%d/%Y %H:%M:%S")))


#Substite spaces for underscores in column names
View(trips)
names(trips) <- gsub(" ", "_", names(trips))

View(trips)
head(trips)            

#change 0 to unknown, 1 to male, 2 to female
trips$gender[trips$gender == 0] <- "Unknown"
trips$gender[trips$gender == 1] <- "Male"
trips$gender[trips$gender == 2] <- "Female"

View(trips)

typeof(trips$starttime)
class(trips$starttime)


#lubridate
#change starttime to type time from type char
trips$starttime <- mdy_hms(trips$starttime)
trips$stoptime <- mdy_hms(trips$stoptime)

View(trips)
typeof(trips$starttime)
class(trips$starttime)
