# MIDUS Data Cleaning and Merging 
# Dissertation 
# Hannah Andrews
# 2020-02-28

# All data downloaded from ICPSR
# Directory "C:/Users/hanna/Documents/git/AHL/R"

dir <- "C:/Users/hanna/git/AHL/R"
setwd(dir)

# install.packages("expss")
library(expss)
library(Hmisc)
library(dplyr)
# install.packages('summarytools')
library(summarytools)
library(magrittr)
library(tidyverse)

# Load all MIDUS data into the global environment 
load(file = "C:/Users/hanna/Documents/git/AHL/R/MIDUS2-2.rda")

# Coding Survey Variables

## Complementary and alternative medicine variables 
# MIDUS 1 ----
# Check variable types and distributions
# subset cam variables from MIDUS1 survey data 
camsList <- c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F", "A1SA39G", "A1SA39H",
          "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L", "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P")
acams <- MIDUS1SurvOrig[camsList]

# Summary statistics MIDUS 1 CAMs 
summary(acams) # all coded as 1 = yes, 2 = no, NAs = NA
describe(acams) 

# Recode acams so that 0 = no and 1 = yes
dummy <- function(inputVector) {
  inputVector <- as.numeric(inputVector)
  return (ifelse(inputVector == 1, 1,
                  ifelse(inputVector == 2, 0, 
                         ifelse(inputVector == NA, NA))))
}
#apply dummy function on selected columns
MIDUS1SurvOrig <- MIDUS1SurvOrig %>% 
  mutate_at(c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F", 
              "A1SA39G", "A1SA39H", "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L",
              "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P"), dummy)

# Check recode
# summary(MIDUS1SurvOrig[camsList])
# describe(MIDUS1SurvOrig[camsList])
summarytools::freq(MIDUS1SurvOrig$A1SA39A, order = "freq")

MIDUS1Survey <- MIDUS1SurvOrig %>% 
  mutate_at(c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F",
              "A1SA39G", "A1SA39H", "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L",
              "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P"), funs(recode(., `1` = 1, `2` = 0,
                                                                       .default = as.double(NA))))
# Check recode
describe(MIDUS1SurvOrig[camsList])

summarytools::freq(data$Type, order = "freq")


#define "dummy" function
dummy <- function(inputVector){
  inputVector <- as.numeric(inputVector)
  return (ifelse( inputVector%in% c(1, 2, 3, 4), 1,
                  ifelse(inputVector == 5, 0,
                         ifelse(inputVector == NA, NA))))
}

#apply dummy function on selected columns
MIDUS1Survey %>% mutate_at(c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F",
                             "A1SA39G", "A1SA39H", "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L",
                             "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P"), dummy)




cams <- c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F", "A1SA39G", "A1SA39H", "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L", "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P")



# MIDUS 2 CAM dummies and count index ----

# Takes "C:/Users/hanna/Documents/git/AHL/R/MIDUS2-2.rda"

# Dummy all CAM vars so 0=no and yes=1. 

# Summary statistics MIDUS 2 CAMs 
  camsList <- c("bEverAcupuncture", "bEverBiofeedback", "bEverChiropractor", "bEverEnergy", 
                "bEverMoveTherapy", "bEverHerbTherapy", "bEverMegaVitamins", "bEverHomeopathy", 
                "bEverHypnosis", "bEverImageTech", "bEverMassage", "bEverPray", "bEverMeditate" )
  bcams <- MIDUS2[camsList]
  summary(bcams) # 1 = alot, 2 = often, 3 = some, 4 = a little, 5 = never, NA.
  describe(bcams) 

# Recode bcams so that 0 = no and 1 = yes
  dummy <- function(inputVector){
    inputVector <- as.numeric(inputVector)
    return (ifelse( inputVector%in% c(1, 2, 3, 4), 1,
                    ifelse(inputVector == 5, 0,
                           ifelse(inputVector == NA, NA))))
  }

# Apply dummy function on selected columns
  MIDUS2 <- MIDUS2 %>% 
    mutate_at(c("bEverAcupuncture", "bEverBiofeedback", "bEverChiropractor", "bEverEnergy", 
                "bEverMoveTherapy", "bEverHerbTherapy", "bEverMegaVitamins", "bEverHomeopathy", 
                "bEverHypnosis", "bEverImageTech", "bEverMassage", "bEverPray", "bEverMeditate"),
              dummy)

# Write function to create cam count var: summed across all cams 
  funrowsums <- function(x) {
    if(is.data.frame(x)) x <- as.matrix(x)
    base::rowSums(x, na.rm = TRUE) *NA^!base::rowSums(!is.na(x))
  }

  MIDUS2$bCamCount <- funrowsums(MIDUS2[camsList])

# Check bCamCount against the dummies 
  camsList <- append(camsList, "bCamCount")
  head(MIDUS2[camsList])

# Remove bCamCount from camsList
  camsList <- camsList[camsList != "bCamCount"]

# Convert dummies to factors
  MIDUS2[camsList] <- lapply(MIDUS2[camsList], factor)
  sapply(MIDUS2[camsList], class)

# Convert bcams to factors and apply value labels
  MIDUS2[camsList] <- lapply(MIDUS2[camsList], factor,
                             levels = c(0, 1),
                             labels = c("No", "Yes"))
  str(MIDUS2[camsList])
  summary(MIDUS2[camsList])
  describe(MIDUS2[camsList])

# MIDUS 3 CAM dummies and count index ----
  

# MIDUS 2 Investigate SES variables ----
  # Create list of SES variables 
    SesList <- c("bTotHHInc", "bBillsDifficulty", "bMoneyAfterDebts", "bAssetsAfterDebts", 
                 "bRespOccupation", "bRespOccupMajor", "bTotHHInc", "bEducation")
  
  # Descrbe all SES variable
    Hmisc::describe(MIDUS2[SesList])
    summary(MIDUS2[SesList])
  
  
B <- editset(c('bEverAcupuncture %in% c("No", "Yes")', 'bEverBiofeedback %in% c("No", "Yes")'))
violatedEdits(B, MIDUS2)
Be <- violatedEdits(B, MIDUS2)
summary(Be, E)
plot(Be)

(E <- editset(c('age >= 0', 'age <= 150')))
violatedEdits(E, people)



