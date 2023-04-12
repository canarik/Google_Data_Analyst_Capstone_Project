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

# Adding hour column

cleaned_combined_data$hour <- format(cleaned_combined_data$started_at, format= "%H")

# Adding season column 

cleaned_combined_data <-cleaned_combined_data %>% 
  mutate(season = 
  case_when(month == "MARCH" ~ "Spring",
  month == "APRIL" ~ "Spring",
  month == "MAY" ~ "Spring",
  month == "JUNE"  ~ "Summer",
  month == "JULY"  ~ "Summer",
  month == "AUGUST"  ~ "Summer",
  month == "SEPTEMBER" ~ "Fall",
  month == "OCTOBER" ~ "Fall",
  month == "NOVEMBER" ~ "Fall",
  month == "DECEMBER" ~ "Winter",
  month == "JANUARY" ~ "Winter",
  month == "FEBRUARY" ~ "Winter"))


# Descriptive statistics: min, max, mean of ride length, mode day of the week.

summary(cleaned_combined_data$ride_length)


cleaned_combined_data %>% 
  group_by(day_of_week) %>% 
  summarise(ride_id = n())

# Number of rides by user type and rideable type

cleaned_combined_data %>%
  group_by(member_casual, rideable_type) %>% 
  count(rideable_type)
  
# Average ride length by user type and hour

cleaned_combined_data %>%
  group_by(member_casual, hour) %>% 
  summarise(number_of_rides = n() 
            ,average_ride_length = mean(ride_length)) %>% 
  arrange(member_casual, hour)

# Average ride length by user type and day of week

cleaned_combined_data %>%
  group_by(member_casual, day_of_week) %>% 
  summarise(number_of_rides = n() 
            ,average_ride_length = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week)

# Average ride length by user type and month

cleaned_combined_data %>%
  group_by(member_casual, month) %>% 
  summarise(number_of_rides = n() 
            ,average_ride_length = mean(ride_length)) %>% 
  arrange(member_casual, month)

# Average ride length by user type and season 

cleaned_combined_data %>%
  group_by(member_casual, season) %>% 
  summarise(number_of_rides = n() 
            ,average_ride_length = mean(ride_length)) %>% 
  arrange(member_casual, season)


# Plotting number of rides by user and rideable type

ggplot(cleaned_combined_data, aes(x = day_of_week, fill = member_casual)) +
  geom_bar(position = "dodge") +
  ggtitle('Daily Ridership by User Type', subtitle = "April 2022 - March 2023") + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) +	
  xlab('Day of Week') + ylab('Number of rides') + 
  labs(fill='User Type') +
  scale_y_continuous(labels = scales::comma) +
  scale_fill_manual(values = c("orange", "purple4"),
                    labels = c("casual","member"))


# Plotting average ride length by user type and hour

cleaned_combined_data %>%
  group_by(member_casual, hour) %>%
  summarise(number_of_rides = n()
            ,avg_ride_length = mean(ride_length)) %>%
  arrange(member_casual, hour) %>%
  ggplot(aes(x = hour, y = avg_ride_length, fill = member_casual)) +
  geom_col(position = "dodge") +
  ggtitle('Average Ride Length by User Type and Hour', subtitle = "April 2022 - March 2023") + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5), plot.caption = element_text(hjust = 0.5)) +	
  xlab('Hour') + ylab('Ride Length') +
  labs(fill='User Type') +
  scale_y_continuous(labels = scales::comma) +
  scale_fill_manual(values = c("orange", "purple4"),
                    labels = c("casual","member"))

# Plotting average ride length by user type and day of week

cleaned_combined_data %>%
  group_by(member_casual, day_of_week) %>%
  summarise(number_of_rides = n()
            ,avg_ride_length = mean(ride_length)) %>%
  arrange(member_casual, day_of_week) %>%
  ggplot(aes(x = day_of_week, y = avg_ride_length, fill = member_casual)) +
  geom_col(position = "dodge") +
  ggtitle('Average Ride Length by User Type and Day of Week', subtitle = "April 2022 - March 2023") + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5), plot.caption = element_text(hjust = 0.5)) +	
  xlab('Day of Week') + ylab('Ride Length') +
  labs(fill='User Type') +
  scale_y_continuous(labels = scales::comma) +
  scale_fill_manual(values = c("orange", "purple4"),
                    labels = c("casual","member"))

# Plotting average ride length by user type and month

cleaned_combined_data %>%
  group_by(member_casual, month) %>%
  summarise(number_of_rides = n()
            ,avg_ride_length = mean(ride_length)) %>%
  arrange(member_casual, month) %>%
  ggplot(aes(x = month, y = avg_ride_length, fill = member_casual)) +
  geom_col(position = "dodge") +
  ggtitle('Average Ride Length by User Type and Month', subtitle = "April 2022 - March 2023") + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5), plot.caption = element_text(hjust = 0.5)) +	
  xlab('Month') + ylab('Ride Length') +
  labs(fill='User Type') +
  scale_y_continuous(labels = scales::comma) +
  scale_fill_manual(values = c("orange", "purple4"),
                    labels = c("casual","member"))

# Plotting average ride length by user type and season

cleaned_combined_data %>%
  group_by(member_casual, season) %>%
  summarise(number_of_rides = n()
            ,avg_ride_length = mean(ride_length)) %>%
  arrange(member_casual, season) %>%
  ggplot(aes(x = season, y = avg_ride_length, fill = member_casual)) +
  geom_col(position = "dodge") +
  ggtitle('Average Ride Length by User Type and Season', subtitle = "April 2022 - March 2023") + 
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5), plot.caption = element_text(hjust = 0.5)) +	
  xlab('Season') + ylab('Ride Length') +
  labs(fill='User Type') +
  scale_y_continuous(labels = scales::comma) +
  scale_fill_manual(values = c("orange", "purple4"),
                    labels = c("casual","member"))

##########################################################


