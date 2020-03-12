# MIDUS Data Cleaning and Merging 
# Dissertation 
# Hannah Andrews
# 2020-02-28

# All data downloaded from ICPSR
# Directory "C:/Users/hanna/Documents/git/AHL/R"

dir <- "C:/Users/hanna/Documents/git/AHL/R"
setwd(dir)

# install.packages("expss")
library(expss)
library(Hmisc)
library(dplyr)
# install.packages('summarytools')
library(summarytools)

# Load all MIDUS data into the global environment 
load(file = "MIDUS2.rda")


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




# MIDUS ----
"bEverAcupuncture", "bEverBiofeedback", "bEverChiropractor", "bEverEnergy", "bEverMoveTherapy", "bEverHerbTherapy"     "bEverMegaVitamins"    "bEverHomeopathy"      "bEverHypnosis"       
"bEverImageTech"       "bEverMassage"         "bEverPray"            "bEverMeditate"       
"bEverSpecialDiet"     "bEverSpiritHeal"      "bEverOtherHeal"