# Cleaning Data MIDUS1 
# Hannah Andrews
# hannahreandrews@gmail.com 

setwd("C:/Users/hanna/git/AHL/R")
library(tidyverse)

## Commands for exploring data frame 
# head(da02760.0001)
# str(da02760.0001)
# dim(da02760.0001)
# summary(da02760.0001)
#colnames(MIDUS1A)

load (file = 'MIDUS1/DS0001/02760-0001-Data.rda')
MIDUS1A <- da02760.0001
glimpse(MIDUS1A) 

#Rename Variables
# MIDUS1 = 1 at the end, MIDUS2 = 2, MIDUS3 = 3
MIDUS1A %>% 
  rename(
    M2ID = id,
    M2FAMNUM = famNum,
    SAMPLMAJ = majorSample,
    A1STATUS = completion1,
    A1PAGE_M2 = age1,
    A1PBYEAR_2019 = birthYear, 
    A1PRSEX = female, 
    A1PA4 = selfEvalPhysicalHealth1
    A1PA5 = selfEvalMentalHealth1
    
    
  )

