# Mark's SQL Portfolio

Hello, this Portfolio showcase a case study I've done while I was taking the Google Data Analytics Certificate program

##### Data source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html)

##### Queried using: BigQuery Sandbox

##### Data visualization: [Tableau](https://public.tableau.com/app/profile/da.wei1820/viz/Googledataanalyticscasestudy1/Dashboard1#3)

##### SQL Queries: [Cyclistics data](https://github.com/markwei93/markwei93.github.io/blob/main/Cyclistics%20data.sql)

### Background:
Cyclistic is a bike-share program that features more than 5,800 bicycles and 600
docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand
tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities
and riders who can’t use a standard two-wheeled bike. The majority of riders opt for
traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more
likely to ride for leisure, but about 30% use the bikes to commute to work each day

### Scenario
AS I am a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share
company in Chicago. The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, your team wants to
understand how casual riders and annual members use Cyclistic bikes differently. From these
insights, your team will design a new marketing strategy to convert casual riders into annual
members. But first, Cyclistic executives must approve your recommendations, so they must be
backed up with compelling data insights and professional data visualizations.

### Ask
Three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

The director of marketing has assigned you the first question to answer: How do annual members and casual
riders use Cyclistic bikes differently?


### Prepare
I will be using Cylistic's trip data [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) ([license](https://www.divvybikes.com/data-license-agreement))from Jan,2023 to Dec,2023 to identify and analyze the differences between casusual users and member users

### Process
We will be using BigQuery to process the data, since it contains more than 5.6 million rows.
First we combined 12 csv file for all 12 months through 2023 into 1 table named 'trip_2023_combined'
Then we checking if there are any missing or wrong data. After running the query


![Sheet 1](https://github.com/markwei93/markwei93.github.io/assets/157609668/3cd79f2d-105c-4518-b1b9-d0848b408f8f)
![Sheet 2](https://github.com/markwei93/markwei93.github.io/assets/157609668/4a78be51-d411-4bda-93cd-8f918513c87a)
![Sheet 3](https://github.com/markwei93/markwei93.github.io/assets/157609668/bca49119-9171-408d-a97c-ce062a7ca565)
![Sheet 4](https://github.com/markwei93/markwei93.github.io/assets/157609668/0db47e5e-1409-47b7-aba3-f7c1c2987858)
![Sheet 5](https://github.com/markwei93/markwei93.github.io/assets/157609668/5aa704e7-ae68-4fbf-8c48-8c29aebaab48)
![Sheet 6](https://github.com/markwei93/markwei93.github.io/assets/157609668/cb1d745f-3429-4350-a15e-17d337d9561b)
