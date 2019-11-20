# Cleaning Data MIDUS1 
# Hannah Andrews
# hannahreandrews@gmail.com 

setwd("C:/Users/hanna/git/AHL")
library(tidyverse)
library(foreign)
library(readstata13)

## Commands for exploring data frame 
# head(da02760.0001)
# str(da02760.0001)
# dim(da02760.0001)
# summary(da02760.0001)
# colnames(MIDUS1A)

MIDUS1 <- read.dta13('C:/Users/hanna/git/AHL/data-cleaning/MIDUS1.dta')
#50 warnings... pretty much all about missing factor labels 

#Rename Variables
# MIDUS1 = 1 at the end, MIDUS2 = 2, MIDUS3 = 3
#MIDUS1A %>% 
#  rename(
#    M2ID = id,
#    M2FAMNUM = famNum,
#    SAMPLMAJ = majorSample,
#    A1STATUS = completion1,
#    A1PAGE_M2 = age1,
#    A1PBYEAR_2019 = birthYear, 
#    A1PRSEX = female, 
#    A1PA4 = selfEvalPhysicalHealth1
#    A1PA5 = selfEvalMentalHealth1
#  )

colnames(MIDUS1)
