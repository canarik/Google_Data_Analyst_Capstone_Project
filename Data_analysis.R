# Installing and loading packages

install.packages("tidyverse")
install.packages("dplyr")
install.packages("skimr")
install.packages("janitor")
install.packages("lubridate")
install.packages("data.table")
install.packages("DescTools")

library(tidyverse)
library(dplyr)
library(skimr)
library(janitor)
library(lubridate)
library(data.table)
library(DescTools)

# Loading SQL prepared clean CSV file

cleaned_combined_data <- read_csv('/Users/canarik/Desktop/Cyclist_data/cleaned_combined_data.csv')

# Confirming loaded data and total number of rows

str(cleaned_combined_data)

# Total number of rows is matching as 4396207

# Adding season column 

cleaned_combined_data <-cleaned_combined_data %>% mutate(season = 
                case_when(month == "03" ~ "Spring",
                          month == "04" ~ "Spring",
                          month == "05" ~ "Spring",
                          month == "06"  ~ "Summer",
                          month == "07"  ~ "Summer",
                          month == "08"  ~ "Summer",
                          month == "09" ~ "Fall",
                          month == "10" ~ "Fall",
                          month == "11" ~ "Fall",
                          month == "12" ~ "Winter",
                          month == "01" ~ "Winter",
                          month == "02" ~ "Winter"))


# Descriptive statistics: min, max, mean of ride length, mode day of the week.

summary(cleaned_combined_data$ride_length)


cleaned_combined_data %>% 
  group_by(day_of_week) %>% 
  summarise(ride_id = n())

# Number of rides by user type and rideable type

cleaned_combined_data %>%
  group_by(member_casual, rideable_type) %>% 
  count(rideable_type)
  
# Average ride length by user type and day of week

cleaned_combined_data %>%
  group_by(member_casual, day_of_week) %>% 
  summarise(number_of_rides = n() 
            ,average_ride_length = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week)
  




