# install packages
install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("rmarkdown")

# Load libraries
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(rmarkdown)

# Import Data that I want to use
activity <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
calories <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/dailyCalories_merged.csv")
intensities <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/dailyIntensities_merged.csv")
sleep <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
weight <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv")

# Checking columns
head(activity)
head(calories)
head(intensities)
head(sleep)
head(weight)

# review data
View(activity)
View(calories)
View(intensities)
View(sleep)
View(weight)

# reformatting dates
# activity
activity$ActivityDay=as.POSIXct(activity$ActivityDay, format ="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
activity$time <- format(activity$ActivityDay, format = "%H:%M:%S")
activity$date <- format(activity$ActivityDay, format = "%m/%d/%y")

# intensities
intensities$ActivityDay=as.POSIXct(intensities$ActivityDay, format ="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
intensities$time <- format(intensities$ActivityDay, format = "%H:%M:%S")
intensities$date <- format(intensities$ActivityDay, format = "%m/%d/%y")

# Calories
calories$ActivityDay=as.POSIXct(calories$ActivityDay, format ="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
calories$time <- format(calories$ActivityDay, format = "%H:%M:%S")
calories$date <- format(calories$ActivityDay, format = "%m/%d/%y")

# sleep
sleep$ActivityDay=as.POSIXct(sleep$ActivityDay, format ="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
sleep$time <- format(sleep$ActivityDay, format = "%H:%M:%S")
sleep$date <- format(sleep$ActivityDay, format = "%m/%d/%y")

# weight
weight$ActivityDay=as.POSIXct(weight$ActivityDay, format ="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
weight$time <- format(weight$ActivityDay, format = "%H:%M:%S")
weight$date <- format(weight$ActivityDay, format = "%m/%d/%y")

# Summary stats
activity %>%
  select(TotalSteps, TotalDistance, SedentaryMinutes, Calories) %>%
  summary()
# explore num of active minutes per category
activity %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes) %>%
  summary()
# calories
calories %>%
  select(Calories) %>%
  summary()
#intensities
intensities %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes) %>%
  summary()
#sleep
sleep %>%
  select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed) %>%
  summary()
#weight
weight %>%
  select(WeightKg, BMI) %>%
  summary()

activity_sleep_data <- merge(sleep, activity, by = c('Id'))
head(activity_sleep_data)
view(activity_sleep_data)

# Visualization
ggplot(data = activity, mapping = aes(x=TotalSteps, y=Calories)) +
  geom_point() + geom_smooth() + labs(title = "Total Steps vs. Calories")
ggplot(data = sleep, mapping = aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + 
  geom_point()
ggplot(data=activity_sleep_data, aes(x=TotalMinutesAsleep, y=SedentaryMinutes)) + 
  geom_point(color='black') + geom_smooth() +
  labs(title="Minutes Asleep vs. Sedentary Minutes")