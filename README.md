# Google_Data_Analyst_Capstone_Project
Case Study: How Does a Bike-Share Navigate Speedy Success?

Case Study Details

Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

About the company

In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.
Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

Reasearch Question

How do annual members and casual riders use Cyclistic bikes differently?

Deliverables

A clear statement of the business task
A description of all data sources used
Documentation of any cleaning or manipulation of data
A summary of your analysis
Supporting visualizations and key findings
Your top three recommendations based on your analysis

Business Task

Analyze Cyclistic’s historical trip data to discover how members abd casual riders use Cyclistic bikes differently and share findings and recommendations with stakeholders.

Data Source

The data archive is available at https://divvy-tripdata.s3.amazonaws.com/index.html.

This project used data from April 2022 to March 2023 (the most recently available 12 months data).

Limitations

Since this is a publicly available dataset, all PII (personal identifiable information) is removed from the datasets. Therefore, it is not possible to perform user based analysis between the two types of customers. Which would have provided critical insigths for understanding behavioral differences.

The datasets are created with a single identifier "ride_id" that represents each unique ride completed by the customers. I first analyzed the structure of each dataset and realized that each has approximately % 10 missing data in "Null or blank" format. Moreover, there are multiple instances of data inconsitencies occurred while preparing the data. All these information have been removed from the data.

In addition to requested recommendations, above limitations have also communicated with the stakeholders to inform that a more effective analysis can be performed with a dataset which contains user data and with lesser if possible no missing throug making technical improvements on data collection process. 

Data Preparation

1) The lastest available 12 months data downloaded from https://divvy-tripdata.s3.amazonaws.com/index.html in CSV file format.
2) Created a back up folder for the raw data.
3) Original files did not follow a file naming convention. Therefore, to maintain consistency all files are renamed in "Year_month" format.
4) In concordance with stakeholder's request following tools are used in this project: Excel, SQL, R Studio and Tableau.
5) Each dataset imported into Excel using import function and saved in xlsx format in a subfolder.
6) Created a new column "ride_length" to calculate the length of each ride by subtracting the column “started_at” from the column “ended_at” and formatted as TIME HH:MM:SS.
7) Created a new colum "day of week" to calculate day of the week that each ride started using the “WEEKDAY” command (for example, =WEEKDAY(C2,1)) in each file. Formated as custom "dddd" to show actual weekday name.
8) However, since Excel has a 1,048,576 row limitation combineing all worksheets into a single one is not possible. Therefore, required Excel tasks completed on file basis.
9) I was not able to complte removing null instances since in some files there are over 70K rows that contain blank cells and every time I tried to select and delete empty rows Excel crushed.
10) Therefore I decided to leave remaining steps of data preparation and analysis to SQL and R Studio.
11) I used PostgresSQL to perform SQL tasks.
12) To combine all 12 CSV files I manually created a table named "combined_data" which allowed me to import thereafter.
13) I created "ride_length", "day_of_week and "month" columns.
14) I removed all "NULL" values and values that account for values shorter than 1 min and longer than 24 hours (1440 minutes).
15) I removed maintainence related data.

Data Analysis - SQL

1) I calculated following descriptive statistics: total number of rows, distinct values, min, max, mean of ride length, mode day of the week.
2) I also calculated average ride length for members and casual riders, average ride length for users by day of week,number of rides for users by day of week, number of rides per hour per day per month by user.
3) Exported "cleaned_combined_data" as CSV

Data Analysis - R Studio

1) Imported CSV dataset
2) 





