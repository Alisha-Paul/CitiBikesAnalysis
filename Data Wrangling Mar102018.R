
install.packages(c("readr", "lubridate", "dplyr", "tidyr"))
install.packages("devtools")

library(readr)
library(lubridate)
library(dplyr)
library(tidyr)
library(devtools)

rm(list=ls())
# readr
# read in CSV data using read_csv
trips <- read_csv(file.choose())
trips <- read.csv(file.choose())
View(trips)
class(trips)
trips
View(trips)
# read in CSV data using read_delim
trips <- read_delim("201601-citibike-tripdata.csv", delim = ",")

# read in CSV data with datetime objects
trips <- read_csv(file.choose(),
                  col_types = 
                    cols(starttime = col_datetime(format = "%m/%d/%Y %H:%M:%S"),
                         stoptime = col_datetime(format = "%m/%d/%Y %H:%M:%S")))


View(trips)
# substitue spaces for underscores in column names 
names(trips) <- gsub(" ", "_", names(trips))


# change 0 to unknown, 1 to male , 2 to female
trips$gender[trips$gender == 0] <- "Unknown"
trips$gender[trips$gender == 1] <- "Male"
trips$gender[trips$gender == 2] <- "Female"

typeof(trips$starttime)
class(trips$starttime)
# lubridate
# change starttime to type time from type char
# IF you did formatting above then don't do it
trips$starttime <- mdy_hms(trips$starttime)
trips$stoptime <- mdy_hms(trips$stoptime)

# parsing a date
date <- ymd("2016/9/29")
date

# pull the year out of a date
year(date)
month(date)

# mutate to add column for trip day
trips <- mutate(trips, startday = day(trips$starttime))
trips <- mutate(trips, diff_between = difftime(stoptime, starttime, units = "secs"))

# select the time columns
View(select(trips, starttime, stoptime, tripduration, diff_between))

# filter for subscribers only
View(filter(trips, usertype == "Subscriber"))

# filter to see observations in which birth_year is NA
View(filter(trips, is.na(birth_year)))