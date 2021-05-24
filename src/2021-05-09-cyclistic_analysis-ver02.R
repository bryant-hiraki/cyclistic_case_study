# Package Installation
install.packages("tidyverse")
install.packages("googledrive")

# Loading Libraries
library(tidyverse)
library("googledrive")

# Downloading Data Set
gdrive_id <- read_file("2021-05-09-gdrive_query_results-ver01")
temp <- tempfile(fileext=".csv")
dl <- drive_download(
  as_id(gdrive_id), path=temp, overwrite=TRUE)
raw_data <- read.csv(temp)

################################################################################
# Pie Chart of Rides per Membership
raw_data %>%
  count(member_casual) %>% 
  arrange(desc(member_casual)) %>%
  mutate(prop=n/sum(n) * 100) %>%
  mutate(ypos=cumsum(prop) - 0.5 * prop ) %>%

  ggplot() +
  aes(x="", y=prop, fill=member_casual) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  geom_text(aes(y=ypos, 
                label=scales::percent(round(prop, 0)/100)), 
            color="white", size=6) +
  scale_fill_brewer(palette="Paired") +
  theme_void() 

# Bar Graph of Rides per Day
raw_data %>%
  mutate(start_day=fct_relevel(start_day, 
                               c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                 "Friday", "Saturday", "Sunday"))) %>%
  
  ggplot() +
  aes(x=start_day, fill=member_casual) +
  geom_bar(stat="count", position="dodge") +
  scale_fill_brewer(palette="Paired") +
  theme_minimal()

# Line Graph of Ride Length per Day
raw_data %>%
  mutate(start_day=fct_relevel(start_day, 
                               c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                 "Friday", "Saturday", "Sunday"))) %>%
  group_by(start_day, member_casual) %>%
  summarize(avg_ride_minutes = mean(total_seconds)/60) %>%
  
  
  ggplot() +
  aes(x=start_day, y=avg_ride_minutes, 
      color=member_casual, group=member_casual) +
  geom_point(size=6) +
  geom_line(size=2) +
  ylim(0, 40) +
  scale_color_brewer(palette="Paired") +
  theme_minimal()

