# Cleaning Data MIDUS1 
# Hannah Andrews
# hannahreandrews@gmail.com 

setwd("C:/Users/hanna/git/AHL/R")

## Commands for exploring data frame 
# head(da02760.0001)
# str(da02760.0001)
# dim(da02760.0001)
# summary(da02760.0001)

load (file = 'MIDUS1/DS0001/02760-0001-Data.rda')

#Run ICPSR supplemental file factor_to_numeric_ICPSR
source('MIDUS1/factor_to_numeric_icpsr.R')
