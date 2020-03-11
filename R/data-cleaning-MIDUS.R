# Cleaning Data MIDUS 
# Hannah Andrews
# hannahreandrews@gmail.com 

setwd("C:/Users/hanna/git/AHL")
library(tidyverse)
library(foreign)
library(readstata13)
library(Hmisc)
library(magrittr)

## Commands for exploring data frame 
# head(da02760.0001)
# str(da02760.0001)
# dim(da02760.0001)
# summary(da02760.0001)
# colnames(MIDUS1A)

# Read in all three data sets
MIDUS1 <- read.dta13('C:/Users/hanna/git/AHL/data-cleaning/MIDUS1.dta')
#50 or more warnings... pretty much all about missing factor labels 
MIDUS2 <- read.dta13('C:/Users/hanna/git/AHL/data-cleaning/MIDUS2.dta')
MIDUS3 <- read.dta13('C:/Users/hanna/git/AHL/data-cleaning/MIDUS3.dta')

# Get summary statistics for original CAM vars (yes/no in MIDUS1)
describe(MIDUS1[, c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F", "A1SA39G", "A1SA39H", "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L", "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P")])

# Label Dummy CAM vars acam1-16


# Check out CAM vars 
#Original Vars (ordinal) 
#A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G ///
#  A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O A1SA39P

## Individual Dummies 
describe(MIDUS1[,c("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
                   "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", 
                   "acam14", "acam15","acam16")]) #summary info for all cam dummies
#Convert acam vars to factors
acams <- c("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
          "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", 
          "acam14", "acam15","acam16")
MIDUS1 %<>% mutate_at(acams, factor)
MIDUS1 %>% 
  select("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
         "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", 
         "acam14", "acam15","acam16") %>% 
  plot(describe(x))

plot(describe(MIDUS1[,c("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", 
                        "acam7", "acam8", "acam9", "acam10", "acam11", "acam12", 
                        "acam13", "acam14", "acam15","acam16")]))#plots yes proportio                         n for all cam dummies 



acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16 acamco1 acamme1
describe(MIDUS1$acam16)


############################################################################
# MIDUS 2 Subsetting
############################################################################




















#attributes(MIDUS1[,c("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
#                              "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", 
#                              "acam14", "acam15","acam16")]) #summary info for all cam dummies

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
