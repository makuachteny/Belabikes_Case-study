---
title: 'Bellabeat: Smart Device Optimization'
author: "Teny"
date: "2023-07-21"
output: html_document
---

# About the Company

Urška Sršen and Sando Mur founded Bellabeat, a high-tech company specializing in health-focused smart products. Leveraging her artistic background, Sršen developed beautifully designed technology that aims to inform and inspire women globally. By collecting data on activity, sleep, stress, and reproductive health, Bellabeat empowers women with valuable insights into their own health and habits. Since its establishment in 2013, the company has experienced rapid growth, positioning itself as a tech-driven wellness brand for women.

By 2016, Bellabeat expanded its presence with offices around the world and a diverse range of product offerings. In addition to their e-commerce platform, the company's products became available through numerous online retailers. Bellabeat has invested in various advertising channels, including radio, out-of-home billboards, print, and television, while also heavily focusing on digital marketing. Their online presence encompasses Google Search campaigns, active engagement on Facebook and Instagram, and consistent interactions with consumers on Twitter. Furthermore, Bellabeat runs video ads on YouTube and utilizes display ads on the Google Display Network to support key marketing initiatives.

Recognizing the potential for growth through analysis of consumer data and conducting an in-depth study of smart device usage data for a Bellabeat products could potentially create room for growth.

# Goals

- Understand usage patterns to identify trends
- Identify business opportunities to apply to Bellabeat customers
- Segment customers based on usage behaviors
- Optimize digital marketing channels

# Ask

1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing Strategy?

# Prepare

To analyze this dataset in R, I needed to install and load packages. I elected to use tidyverse, lubridate, dplyr, ggplot2, and tidyr because these packages contain the functions I typically need for the analysis.

# Key Take-Aways

1. Higher activity impacts both calories burned but also sleep.
2. Users are more active with higher intensity later in the day.
3. More sedentary time aligns with less sleep time.
4. Overall, the users in this data set have fewer steps than the amount recommended by health professionals and the CDC.

# Recommendations

1. Conduct similar analysis in the future, with a larger data set to obtain more reliable analysis with a larger sample size.
2. Bellabeat can make strategic use of notifications and reminders about activity, steps, or sleep to potentially promote users.
3. Use the Bellabeat app to collect user-provided information on their fitness goals (e.g. burning calories, better sleep, more activity) and use those goals to send personalized notifications or reminders based on discovered trends.

## Prepare

I loaded tidyverse, lubridate, dplyr, ggplot2, tidyr, rmarkdown packages to help me analyze the data.

```{r loading packages}
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(rmarkdown)
```
## Import Data
Once I finished loading the libraries I imported the data FitBit Fitness Tracker Data.
```{r importing data}
activity <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
calories <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/dailyCalories_merged.csv")
intensities <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/dailyIntensities_merged.csv")
sleep <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
weight <- read_csv("Bellabeat_Case-Study/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv")
```
``` {r View data}
View(activity)
View(calories)
View(intensities)
View(sleep)
View(weight)
```



## Proceesing
I reformatted the data by changing the date columns in each dataset to make them more usable.
```{r processing}
# activity
activity$ActivityDay = as.POSIXct(activity$ActivityDay, format = "%m/%d/%Y %I:%M:%S %p", tz = Sys.timezone())
activity$time <- format(activity$ActivityDay, format = "%H:%M:%S")
activity$date <- format(activity$ActivityDay, format = "%m/%d/%y")

# intensities
intensities$ActivityDay = as.POSIXct(intensities$ActivityDay, format = "%m/%d/%Y %I:%M:%S %p", tz = Sys.timezone())
intensities$time <- format(intensities$ActivityDay, format = "%H:%M:%S")
intensities$date <- format(intensities$ActivityDay, format = "%m/%d/%y")

# Calories
calories$ActivityDay = as.POSIXct(calories$ActivityDay, format = "%m/%d/%Y %I:%M:%S %p", tz = Sys.timezone())
calories$time <- format(calories$ActivityDay, format = "%H:%M:%S")
calories$date <- format(calories$ActivityDay, format = "%m/%d/%y")

# sleep
sleep$ActivityDay = as.POSIXct(sleep$ActivityDay, format = "%m/%d/%Y %I:%M:%S %p", tz = Sys.timezone())
sleep$time <- format(sleep$ActivityDay, format = "%H:%M:%S")
sleep$date <- format(sleep$ActivityDay, format = "%m/%d/%y")

# weight
weight$ActivityDay = as.POSIXct(weight$ActivityDay, format = "%m/%d/%Y %I:%M:%S %p", tz = Sys.timezone())
weight$time <- format(weight$ActivityDay, format = "%H:%M:%S")
weight$date <- format(weight$ActivityDay, format = "%m/%d/%y")
```

## Summary statistics
I conducted summary statistics for some key columns in the activity, calories, sleep, and weight datasets:

```{r summary}
activity %>%
  select(TotalSteps, TotalDistance, SedentaryMinutes, Calories) %>%
  summary()

activity %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes) %>%
  summary()

calories %>%
  select(Calories) %>%
  summary()

intensities %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes) %>%
  summary()

sleep %>
```
