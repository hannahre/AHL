# MIDUS Data Exploration
# Dissertation 
# Hannah Andrews
# 2020-09-29

# All data downloaded from ICPSR
# Directory "C:/Users/hanna/Documents/git/AHL/R"

# Set Working Directory ####
dir <- "C:/Users/hanna/Documents/git/AHL/R"
setwd(dir)

# Load Libraries ####
library(expss)
library(Hmisc)
library(dplyr)
library(summarytools)
library(magrittr)
library(tidyverse)
library(mosaic)
library(lattice)
library(ggplot2)

# Load all MIDUS data into the global environment ####
load(file = "MIDUS1.rda")
load(file = "MIDUS2.rda")
load(file = "MIDUS3.rda")

# MIDUS 1 Missing Data ####
rowSums(is.na(MIDUS1)) # Number of missing per row
colSums(is.na(MIDUS1)) # Number of missing per column 


# MIDUS 1 CAMS ####
MIDUS1_Cams <- MIDUS1 %>% 
  select(starts_with("A1SA39"))

describe(MIDUS1_Cams)

# MIDUS 1 Income ####
MIDUS1$A1SHHTOT
summary(MIDUS1$A1SHHTOT) # summary statistics: min, max, quartiles, mean
fivenum(MIDUS1$A1SHHTOT) # same info as summary
str(MIDUS1$A1SHHTOT)
table(MIDUS1$A1SHHTOT)
MIDUS1 %>% summarise(m1IncDistinct = n_distinct(A1SHHTOT), # COunt distinct values
                     m1IncNA = sum(is.na(A1SHHTOT)), # sum of NAs
                     m1IncMed = median(A1SHHTOT, na.rm = TRUE)) # median, remove NAs
hist(MIDUS1$A1SHHTOT,
     main = "MIDUS1 Total HH Income",
     xlab = "Total HH Income", 
     breaks = 500)
m1incplot <- ggplot(data = MIDUS1, aes(x = A1SHHTOT)) + 
                      geom_density() # Create density plot
m1incplot
MIDUS1 %>% 
  ggplot( aes(x = factor(1), y = A1SHHTOT)) +
  geom_boxplot() + # Create boxplots
  geom_jitter(width = 0.15, size = .5, na.rm = TRUE) # Add a point for each observation

# MIDUS 2 Income ####
MIDUS2$B1STINC1
summary(MIDUS2$B1STINC1)
str(MIDUS2$B1STINC1)
table(MIDUS2$B1STINC1)
MIDUS2 %>% summarise(m2IncDistinct =n_distinct(B1STINC1), 
                     m2IncNA = sum(is.na(B1STINC1)), 
                     m2IncMed = median(B1STINC1, na.rm = TRUE))
m2IncPlot <- ggplot(data = MIDUS2, aes(x = B1STINC1)) + 
  geom_density() # Create density plot
m2IncPlot
MIDUS2 %>% 
  ggplot( aes(x = factor(1), y = B1STINC1)) +
  geom_boxplot() + # Create boxplots
  geom_jitter(width = 0.15, size = .5, na.rm = TRUE) # Add a point for each observation

# MIDUS 3 Income ####
MIDUS3$C1STINC
summary(MIDUS3$C1STINC)

