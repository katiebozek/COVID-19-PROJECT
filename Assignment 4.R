# Clear Console and Environment
rm(list=ls(all=TRUE))
cat("\014")

# Import packages
library(tidyverse)
library(here)
library(gapminder)
library(socviz)
library(dplyr)
library(ggrepel)

# Read in files
setwd("~/BIS 244/COVID-19-PROJECT/covid-19-data")
us.counties <- read.csv("~/BIS 244/COVID-19-PROJECT/covid-19-data/us-counties.csv")

# Filter to only PA counties
pacounties <- us.counties %>% filter(state=="Pennsylvania")

pacounties$new_dates <- as.Date(as.character.Date(pacounties$date))
parecent <- pacounties[pacounties$new_dates == max(pacounties$new_dates),]


# Create graph 
p_title <- paste("COVID-19 Deaths vs Cases for PA as of",as.character(max(pacounties$new_dates)),"")
x_label <- "Cases"
y_label <- "Deaths"

p <- ggplot(parecent, aes(x = cases, y = deaths,
                          label = county))
p + geom_point() +
  geom_text_repel()+
  geom_smooth(se=FALSE,method = "lm") +
  labs(x = x_label, y = y_label, title = p_title)