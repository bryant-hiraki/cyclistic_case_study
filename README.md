# __Cyclistic__
### Google Data Analytics Certification: Case Study 1. Analysis of the difference between bike share usage across subscription tiers.

## Table of Contents
1. [Summary](README.md#summary)
2. [Links](README.md#links)
3. [Data](README.md#data)
4. [Analysis](README.md#analysis)

## Summary
### Introduction
The sample bike share service offers two tiers of subscriptions: individual passes which characterize "casual" riders and annual memberships constituting "member" riders. This project was intended to elucidate the difference in usage characteristics observed between "casual" and "member" riders.

This project was developed to satisfy the Case Study 1 scenario outlined in the Google Data Analytics Certification course capstone. The scenario involves analysis of the "Cyclistic" fictional bike share company and utilizes a public data set provided by Motivate International Inc. under [this](https://www.divvybikes.com/data-license-agreement) license.

### Process
1. Files downloaded as .csv files from Divvy source (link below)
2. Data imported into Google BigQuery and consolidated into view
3. View exported to RStudio via Google Drive 
4. Statistical analysis and visualization conducted in RStudio with Tidyverse

## Links
- [Presentation](https://docs.google.com/presentation/d/1XsbyddNDFZZVY6o9eAD8GiteXuGbETGUUwJ9eTp8jyY/edit?usp=sharing)
- [Dataset](https://divvy-tripdata.s3.amazonaws.com/index.html)
- [Google Data Analytics Certification](https://grow.google/dataanalytics/#?modal_active=none)

## Data
- __Date Range:__ April 2020 - April 2021
- __Source Files:__ 12 files logging trip data per month
- __Processed:__ 1.3 GB of data via Google BigQuery
- __Analyzed:__ 3,804,245 rows via RStudio

## Analysis
### Pie Chart
![piechart](https://github.com/bryant-hiraki/cyclistic_case_study/blob/main/images/2021-05-17-pie_chart-ver01.png "Pie Chart")  
Pie chart summarizing the distribution of rides from April 2020 to April 2021 between subscription types

### Bar Graph
![bargraph](https://github.com/bryant-hiraki/cyclistic_case_study/blob/main/images/2021-05-17-bar_graph_count-ver01.png "Bar Graph")  
Bar Graph showing the number of rides between subscription type for each day of the week

### Line Graph
![linegraph](https://github.com/bryant-hiraki/cyclistic_case_study/blob/main/images/2021-05-17-line_graph_len_ver01.png "Line Graph")  
Line Graph tracking the average ride length in minutes across each day of the week
