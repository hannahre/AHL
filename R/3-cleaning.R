# MIDUS Data Cleaning and Merging 
# Dissertation 
# Hannah Andrews
# 2020-02-28

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

# Load all MIDUS data into the global environment ####
  load(file = "MIDUS1.rda")
  load(file = "MIDUS2.rda")
  load(file = "MIDUS3.rda")

# Functions ####
# MIDUS1 CAM dummy recode function ####
  # Create list of CAM vars 
  acamsList <- c("A1SA39A", "A1SA39B", "A1SA39C", "A1SA39D", "A1SA39E", "A1SA39F", 
                "A1SA39G", "A1SA39H", "A1SA39I", "A1SA39J", "A1SA39K", "A1SA39L", 
                "A1SA39M", "A1SA39N", "A1SA39O", "A1SA39P")
  acams <- MIDUS1[acamsList]
  summary(acams) # all coded as 1 = yes, 2 = no, NAs = NA
  describe(acams)
  str(acams) # Factors 

# Recode cam vars so that 0 = no and 1 = yes
  acams_dummy <- function(inputVector) {
    inputVector <- as.numeric(inputVector)
    return (ifelse(inputVector == 1, 2,
                   ifelse(inputVector == 2, 1, 
                          ifelse(inputVector == NA, NA))))
  }
  
# MIDUS 2 CAM dummy recode function ####
# Create list of CAM vars 
  bcams_list <- c("B1SA56A", "B1SA56B", "B1SA56C", "B1SA56D", "B1SA56F", 
             "B1SA56G", "B1SA56H", "B1SA56I", "B1SA56J", "B1SA56K", 
             "B1SA56L", "B1SA56M", "B1SA56N", "B1SA56Q", "B1SA56R", 
             "B1SA56S")
  bcams <- MIDUS2[bcams_list]
  summary(bcams) # Freq of CAM use: 1 = A Lot -> 5 = Never, NAs
  describe(bcams)
  str(bcams)
  ordinal_dummy <- function(inputVector){
    inputVector <- as.numeric(inputVector)
    return (ifelse( inputVector%in% c(1, 2, 3, 4), 2,
                    ifelse(inputVector == 5, 1,
                           ifelse(inputVector == NA, NA))))
  }

# MIDUS 3 CAM dummy recode function ####
  ccams_list <- c("C1SA52A", "C1SA52B", "C1SA52C", "C1SA52D", "C1SA52F", 
                  "C1SA52G", "C1SA52H", "C1SA52I", "C1SA52J", "C1SA52K", 
                  "C1SA52L", "C1SA52M", "C1SA52N", "C1SA52Q", "C1SA52R", 
                  "C1SA52S")
  ccams <- MIDUS3[ccams_list]
  summary(ccams) # Freq of CAM use: 1 = A Lot -> 5 = Never, NAs
  describe(ccams)
  str(ccams) # Factors
  # Use ordinal_dummy function

# Recodes (All waves) ####
# MIDUS 1 Recodes #### 
  MIDUS1_recode <- MIDUS1 %>% 
    mutate(aEducation = recode(A1PB1,
                               "(01) No school/some grade school" = "Less than High School",
                               "(02) Eighth grade/junior high school" = "Less than High School",
                               "(03) Some high school" = "Less than High School",
                               "(04) GED" = "High School or GED",
                               "(05) Graduated from high school" = "High School or GED",
                               "(06) 1 to 2 years of college, no degree yet" = "Some college/Associates/2-year college or vocational school",
                               "(07) 3 or more years of college, no degree yet" = "Some college/Associates/2-year college or vocational school",
                               "(08) Graduated from a 2-year college or vocational school, or associate's degree" = "Some college/Associates/2-year college or vocational school",
                               "(09) Graduated from a 4- or 5-year college, or bachelor's degree" = "Bachelors",
                               "(10) Some graduate school" = "Bachelors",
                               "(11) Master's degree" = "Graduate or Professional Degree",
                               "(12) PH.D, ED.D, MD, DDS, LLB, LLD, JD, or other professional degree" = "Graduate or Professional Degree")) %>% 
    rename(aGender = A1PRSEX,
           aHealthLOCSelf = A1SHLOCS,
           aHHIncome = A1SHHTOT) %>% 
    mutate(aRace = recode(A1SS7,
                          "(1) White" = "White", 
                          "(2) Black and/or African American" = "Black", 
                          "(3) Native American or Aleutian Islander/Eskimo" = "Other",
                          "(4) Asian or Pacific Islander" = "Other", 
                          "(5) Other" = "Other", 
                          "(6) Multiracial" = "Other"
    )) %>% 
    mutate_at(acamsList, acams_dummy) %>%  # dummy all M1 CAMS 0 = no and 1 = yes 
    rowwise() %>%
    mutate(ignore = all(is.na(across(starts_with("A1SA39"))))) %>%
    mutate(aCamSum = if_else(ignore, NA_real_, rowSums(across(starts_with("A1SA39")), na.rm = TRUE))) %>% 
    dplyr::select(-ignore) %>% 
    rename(aCamEverAcupuncture = A1SA39A, # rename all vars 
           aCamEverBiofeedback = A1SA39B,
           aCamEverChiropractor = A1SA39C,
           aCamEverEnergy = A1SA39D,
           aCamEverMoveTherapy = A1SA39E,
           aCamEverHerbTherapy = A1SA39F,
           aCamEverMegaVitamins = A1SA39G,
           aCamEverHomeopathy = A1SA39H,
           aCamEverHypnosis = A1SA39I,
           aCamEverImageTech = A1SA39J,
           aCamEverMassage = A1SA39K,
           aCamEverPray = A1SA39L,
           aCamEverMeditate = A1SA39M,
           aCamEverSpecialDiet = A1SA39N,
           aCamEverSpiritHeal = A1SA39O,
           aCamEverOtherHeal = A1SA39P) 
  
# Convert CAMs back into factors. 
  camslist <- c("aCamEverAcupuncture", "aCamEverBiofeedback", "aCamEverChiropractor", 
                "aCamEverEnergy", "aCamEverMoveTherapy", "aCamEverHerbTherapy", 
                "aCamEverMegaVitamins", "aCamEverHomeopathy", "aCamEverHypnosis", 
                "aCamEverImageTech", "aCamEverMassage", "aCamEverPray", 
                "aCamEverMeditate", "aCamEverSpecialDiet", "aCamEverSpiritHeal")
  MIDUS1_recode <- MIDUS1_recode %>% 
    mutate_at(camslist, funs(factor(.))) 
  for(i in camslist) {
    levels(MIDUS1_recode[[i]]) <- c("No", "Yes")  
  }
  
# MIDUS 1 Recode Number of chronic conditions ####
  describe(MIDUS1$A1SCHRON)
  summary(MIDUS1$A1SCHRON)
  MIDUS1 %>% 
    ggplot( aes(x = factor(1), y = A1SCHRON)) +
    geom_boxplot() 
  M1chronSum <- MIDUS1$A1SCHRON
  hist(M1chronSum)
  MIDUS1_recode <- MIDUS1_recode %>% 
    rename (aChronicSum = A1SCHRON)
  
# MIDUS 1 Recode Any chronic conditions ####
  describe(MIDUS1$A1SCHROX)
  MIDUS1_recode <- MIDUS1_recode %>% 
    rename(aChronicAny = A1SCHROX)

# MIDUS 1 Recode BMI ####
  describe(MIDUS1$A1SBMI)
  summary(MIDUS1$A1SBMI)
  MIDUS1 %>% 
    ggplot( aes(x = factor(1), y = A1SBMI)) +
    geom_boxplot() 
  M1bmi <- MIDUS1$A1SBMI
  hist(M1bmi)
  MIDUS1_recode <- MIDUS1_recode %>% 
    rename (aBmi = A1SBMI)
  
# MIDUS 2 Recodes: education, gender, health locus of control, income, cam dummies, summed CAM index #### 
  MIDUS2_recode <- MIDUS2 %>% 
      mutate(bEducation = recode(B1PB1,
                               "(01) NO SCHOOL/SOME GRADE SCHOOL (1-6)" = "Less than High School",
                               "(02) EIGHTH GRADE/JUNIOR HIGH SCHOOL (7-8)" = "Less than High School",
                               "(03) SOME HIGH SCHOOL (9-12 NO DIPLOMA/NO GED)" = "Less than High School",
                               "(04) GED" = "High School or GED",
                               "(05) GRADUATED FROM HIGH SCHOOL" = "High School or GED",
                               "(06) 1 TO 2 YEARS OF COLLEGE, NO DEGREE YET" = "Some college/Associates/2-year college or vocational school",
                               "(07) 3 OR MORE YEARS OF COLLEGE, NO DEGREE YET" = "Some college/Associates/2-year college or vocational school",
                               "(08) GRAD. FROM 2-YEAR COLLEGE, VOCATIONAL SCHOOL, OR ASSOC. DEGR" = "Some college/Associates/2-year college or vocational school",
                               "(09) GRADUATED FROM A 4- OR 5-YEAR COLLEGE, OR BACHELOR'S DEGREE" = "Bachelors",
                               "(10) SOME GRADUATE SCHOOL" = "Bachelors",
                               "(11) MASTER'S DEGREE" = "Graduate or Professional Degree",
                               "(12) PH.D., ED.D., MD, DDS, LLB, LLD, JD, OR OTHER PROFESS'NL DEG" = "Graduate or Professional Degree")) %>% 
      rename(bGender = B1PRSEX,
             bHealthLOCSelf = B1SHLOCS,
             bHHIncome = B1STINC1) %>% 
      mutate_at(bcams_list, ordinal_dummy) %>%  # dummy all bcams, ever used CAM = 1, Never = 0
      rowwise() %>%
      mutate(ignore = all(is.na(across(starts_with("B1SA56"))))) %>%
      mutate(bCamSum = if_else(ignore, NA_real_, rowSums(across(starts_with("B1SA56")), na.rm = TRUE))) %>% 
      dplyr::select(-ignore) %>% 
      rename(bCamEverAcupuncture = B1SA56A,  # rename all variables 
           bCamEverBiofeedback = B1SA56B,
           bCamEverChiropractor = B1SA56C,
           bCamEverEnergy = B1SA56D,
           bCamEverMoveTherapy = B1SA56F,
           bCamEverHerbTherapy = B1SA56G,
           bCamEverMegaVitamins = B1SA56H,
           bCamEverHomeopathy = B1SA56I,
           bCamEverHypnosis = B1SA56J,
           bCamEverImageTech = B1SA56K,
           bCamEverMassage = B1SA56L,
           bCamEverPray = B1SA56M,
           bCamEverMeditate = B1SA56N,
           bCamEverSpecialDiet = B1SA56Q,
           bCamEverSpiritHeal = B1SA56R,
           bCamEverOtherHeal = B1SA56S)
  
# Convert CAMs back into factors
  camslist <- c("bCamEverAcupuncture", "bCamEverBiofeedback", "bCamEverChiropractor", 
                "bCamEverEnergy", "bCamEverMoveTherapy", "bCamEverHerbTherapy", 
                "bCamEverMegaVitamins", "bCamEverHomeopathy", "bCamEverHypnosis", 
                "bCamEverImageTech", "bCamEverMassage", "bCamEverPray", 
                "bCamEverMeditate", "bCamEverSpecialDiet", "bCamEverSpiritHeal")
  MIDUS2_recode <- MIDUS2_recode %>% 
    mutate_at(camslist, funs(factor(.))) 
  for(i in camslist) {
    levels(MIDUS2_recode[[i]]) <- c("No", "Yes")  
  }

# MIDUS2 Race Recode #### 
      as.numeric(MIDUS2$B1PF7A)[100:110]
      MIDUS2$B1PF7A[100:110]
      which(as.numeric(MIDUS2$B1PF7A)==3)
MIDUS2_recode <- MIDUS2_recode %>% 
  mutate(B1PF7Aint=as.numeric(B1PF7A), B1PF1int=as.numeric(B1PF1)) %>% 
      mutate(bRace = case_when(
        is.na(B1PF7Aint) | is.na(B1PF1int) ~ "NA",
        B1PF7Aint == 1 & B1PF1int == 1 ~ "Non-Hispanic White",
        B1PF7Aint == 2 & B1PF1int == 1 ~ "Non-Hispanic Black",
        B1PF1int != 1 ~  "Hispanic", 
        B1PF7Aint %in% c(7,8) ~ "NA",
        TRUE ~ "Other"
      )) 
MIDUS2_recode$bRace[MIDUS2_recode$bRace=="NA"] <- NA
MIDUS2_recode$bRace <- factor(x = MIDUS2_recode$bRace, 
                                 levels = c("Non-Hispanic White",
                                            "Non-Hispanic Black",
                                            "Hispanic",
                                            "Other"))
MIDUS2_recode[15:25,] %>% select(B1PF7A, B1PF1, bRace)
table(MIDUS2_recode$bRace, MIDUS2_recode$B1PF7A)

# MIDUS 2 Sleep Recode: Sleep difficulties ####
  # Check missing patterns
  sleep_vars <- c("B1SA61A", "B1SA61B", "B1SA61C")
  MIDUS2_sleep <- MIDUS2[sleep_vars] # subset that includes the subjective sleep vars 
  gg_miss_upset(MIDUS2_sleep) # visualize missing case patterns
  sleep_complete <- MIDUS2_sleep[complete.cases(MIDUS2_sleep), ] # dataframe with complete cases on sleep vars
  str(sleep_complete)
  # Only 18 cases are missing on some combinations of sleep vars; 3328 missing on all. Do not include cases with any missing values in the average. 
  sapply(MIDUS2_recode[,c("B1SA61A", "B1SA61B", "B1SA61C")], class) # check class of sleep variables
  MIDUS2_recode[sleep_vars] <- sapply(MIDUS2_recode[sleep_vars], as.numeric) # convert sleep vars to numeric 
  MIDUS2_recode$bSleepDifficulty <- rowMeans(MIDUS2_recode[,c("B1SA61A", "B1SA61B", "B1SA61C")])
  describe(MIDUS2_recode$bSleepDifficulty)
  
# MIDUS 2 Sleep Duration ####
  MIDUS2_recode <- MIDUS2_recode %>% 
    rename(bSleepDuration = B4SSQ_S3)

# MIDUS 2 Pittsburgh Sleep Quality Index####
  # 7 components: Sleep latency, sleep duration, sleep efficiency, sleep disturbance,
  # daytime dysfunction, use of sleeping meds, subjective sleep quality 
  describe(MIDUS2$B4SSQ_GS)
  summary(MIDUS2$B4SSQ_GS)
  MIDUS2_recode <- MIDUS2_recode %>% 
    rename(bSleepPittIndex = B4SSQ_GS)

# MIDUS 2 Recode Sum of Chronic Conditions ####
  describe(MIDUS2$B1SCHRON)
  summary(MIDUS2$B1SCHRON)
  MIDUS2 %>% 
    ggplot( aes(x = factor(1), y = B1SCHRON)) +
    geom_boxplot() 
  M2chronSum <- MIDUS2$B1SCHRON
  hist(M2chronSum)
  MIDUS2_recode <- MIDUS2_recode %>% 
    rename (bChronicSum = B1SCHRON)
  
# MIDUS 2 Recode Having any chronic conditions ####
  describe(MIDUS2$B1SCHROX)
  MIDUS2_recode <- MIDUS2_recode %>% 
    rename (bChronicAny = B1SCHROX)
  
# MIDUS 2 Recode BMI - Biomarker Study ####
  describe(MIDUS2$B4PBMI)
  summary(MIDUS2$B4PBMI)
  MIDUS2 %>% 
    ggplot( aes(x = factor(1), y = B4PBMI)) +
    geom_boxplot() 
  M2BioBmi <- MIDUS2$B4PBMI
  hist(M2BioBmi)
  MIDUS2_recode <- MIDUS2_recode %>% 
    rename (bBioBmi = B4PBMI)

# MIDUS 2 Recode BMI - Survey Study ####
  describe(MIDUS2$B1SBMI)
  summary(MIDUS2$B1SBMI)
  MIDUS2 %>% 
    ggplot( aes(x = factor(1), y = B1SBMI)) +
    geom_boxplot() 
  M2Bmi <- MIDUS2$B1SBMI
  hist(M2Bmi)
  MIDUS2_recode <- MIDUS2_recode %>% 
    rename (bBmi = B1SBMI)
  
# MIDUS 3 Recodes education, gender, health locus of control, income, cam dummies, summed CAM index ####
  MIDUS3_recode <- MIDUS3 %>% 
      mutate(cEducation = recode(C1PB1,
                                 "(01) NO SCHOOL/SOME GRADE SCHOOL (1-6)" = "Less than High School",
                                 "(02) EIGHTH GRADE/JUNIOR HIGH SCHOOL (7-8)" = "Less than High School",
                                 "(03) SOME HIGH SCHOOL (9-12 NO DIPLOMA/NO GED)" = "Less than High School",
                                 "(04) GED" = "High School or GED",
                                 "(05) GRADUATED FROM HIGH SCHOOL" = "High School or GED",
                                 "(06) 1 TO 2 YEARS OF COLLEGE, NO DEGREE YET" = "Some college/Associates/2-year college or vocational school",
                                 "(07) 3 OR MORE YEARS OF COLLEGE, NO DEGREE YET" = "Some college/Associates/2-year college or vocational school",
                                 "(08) GRAD. FROM 2-YEAR COLLEGE, VOCATIONAL SCHOOL, OR ASSOC. DEG." = "Some college/Associates/2-year college or vocational school",
                                 "(09) GRADUATED FROM A 4- OR 5-YEAR COLLEGE, OR BACHELOR'S DEG." = "Bachelors",
                                 "(10) SOME GRADUATE SCHOOL" = "Bachelors",
                                 "(11) MASTER'S DEGREE" = "Graduate or Professional Degree",
                                 "(12) PH.D., ED.D., MD, DDS, LLB, LLD, JD, OR OTHER PROFESS'NL DEG." = "Graduate or Professional Degree")) %>% 
      rename(cGender = C1PRSEX,
             cHealthLOCSelf = C1SHLOCS,
             cHHIncome = C1STINC) %>% 
      mutate_at(ccams_list, ordinal_dummy) %>% # dummy ccams, ever used CAM = 1, Never = 0 
      rowwise() %>%
      mutate(ignore = all(is.na(across(starts_with("C1SA52"))))) %>%
      mutate(cCamSum = if_else(ignore, NA_real_, rowSums(across(starts_with("C1SA52")), na.rm = TRUE))) %>% 
      dplyr::select(-ignore) %>% 
      rename(cCamEverAcupuncture = C1SA52A, # rename all variables 
           cCamEverBiofeedback = C1SA52B,
           cCamEverChiropractor = C1SA52C,
           cCamEverEnergy = C1SA52D,
           cCamEverMoveTherapy = C1SA52F,
           cCamEverHerbTherapy = C1SA52G,
           cCamEverMegaVitamins = C1SA52H,
           cCamEverHomeopathy = C1SA52I,
           cCamEverHypnosis = C1SA52J,
           cCamEverImageTech = C1SA52K,
           cCamEverMassage = C1SA52L,
           cCamEverPray = C1SA52M,
           cCamEverMeditate = C1SA52N,
           cCamEverSpecialDiet = C1SA52Q,
           cCamEverSpiritHeal = C1SA52R,
           cCamEverOtherHeal = C1SA52S)
  
# Convert CAMs back into factors
    camslist <- c("cCamEverAcupuncture", "cCamEverBiofeedback", "cCamEverChiropractor", 
                  "cCamEverEnergy", "cCamEverMoveTherapy", "cCamEverHerbTherapy", 
                  "cCamEverMegaVitamins", "cCamEverHomeopathy", "cCamEverHypnosis", 
                  "cCamEverImageTech", "cCamEverMassage", "cCamEverPray", 
                  "cCamEverMeditate", "cCamEverSpecialDiet", "cCamEverSpiritHeal")
    MIDUS3_recode <- MIDUS3_recode %>% 
      mutate_at(camslist, funs(factor(.))) 
    for(i in camslist) {
      levels(MIDUS3_recode[[i]]) <- c("No", "Yes")  
    }

# MIDUS 3 Race Recode #### 
  as.numeric(MIDUS3$C1PF7A)[100:110] # index- view rows 100-110 for specified column
  MIDUS3$C1PF7A[100:110] # view above as factors
  which(as.numeric(MIDUS3$C1PF7A)==3) # find which rows are coded as three
  MIDUS3_recode <- MIDUS3_recode %>% 
    mutate(C1PF7Aint=as.numeric(C1PF7A), C1PF1int=as.numeric(C1PF1)) %>% 
    mutate(cRace = case_when(
      is.na(C1PF7Aint) | is.na(C1PF1int) ~ "NA",
      C1PF7Aint == 1 & C1PF1int == 1 ~ "Non-Hispanic White",
      C1PF7Aint == 2 & C1PF1int == 1 ~ "Non-Hispanic Black",
      C1PF1int != 1 ~  "Hispanic", 
      C1PF7Aint %in% c(7,8) ~ "NA",
      TRUE ~ "Other"
    )) 
  MIDUS3_recode$cRace[MIDUS3_recode$cRace=="NA"] <- NA
  MIDUS3_recode$cRace <- factor(x = MIDUS3_recode$cRace, 
                                levels = c("Non-Hispanic White",
                                           "Non-Hispanic Black",
                                           "Hispanic",
                                           "Other"))
  MIDUS3_recode[15:25,] %>% select(C1PF7A, C1PF1, cRace)
  table(MIDUS3_recode$cRace, MIDUS3_recode$C1PF7A)

# MIDUS 3 Sleep Recode: Sleep difficulties ####
  # Check missing patterns
  sleep_vars <- c("C1SA57A", "C1SA57B", "C1SA57C")
  MIDUS3_sleep <- MIDUS3[sleep_vars] # subset that includes the subjective sleep vars
  gg_miss_upset(MIDUS3_sleep) # visualize missing case patterns
  sleep_complete <- MIDUS3_sleep[complete.cases(MIDUS3_sleep), ] # dataframe with complete cases on sleep vars
  str(sleep_complete)
  # 18 cases are missing on some combinations of sleep vars; 4194 missing on all. Do not include cases with any missing values in the average. 
  sapply(MIDUS3_recode[,c("C1SA57A", "C1SA57B", "C1SA57C")], class) # check class of sleep variables
  MIDUS3_recode[sleep_vars] <- sapply(MIDUS3_recode[sleep_vars], as.numeric) # convert sleep vars to numeric 
  MIDUS3_recode$cSleepDifficulty <- rowMeans(MIDUS3_recode[,c("C1SA57A", "C1SA57B", "C1SA57C")])
  describe(MIDUS3_recode$cSleepDifficulty)
  
# MIDUS 3 Recode Sum of Chronic Conditions ####
  describe(MIDUS3$C1SCHRON)
  summary(MIDUS3$C1SCHRON)
  MIDUS3 %>% 
    ggplot( aes(x = factor(1), y = C1SCHRON)) +
    geom_boxplot() 
  M3chronSum <- MIDUS3$C1SCHRON
  hist(M3chronSum)
  MIDUS3_recode <- MIDUS3_recode %>% 
    rename (cChronicSum = C1SCHRON)


# MIDUS 3 Recode having any chronic conditions ####
  describe(MIDUS3$C1SCHROX)
  MIDUS3_recode <- MIDUS3_recode %>% 
    rename (cChronicAny = C1SCHROX)

# MIDUS 3 Recode BMI ####
  describe(MIDUS3$C1SBMI)
  summary(MIDUS3$C1SBMI)
  MIDUS3 %>% 
    ggplot( aes(x = factor(1), y = C1SBMI)) +
    geom_boxplot() 
  M3bmi <- MIDUS3$C1SBMI
  hist(M3bmi)
  MIDUS3_recode <- MIDUS3_recode %>% 
    rename (cBmi = C1SBMI)
  
# Save files ####
save(MIDUS1_recode, file = "MIDUS1_recode.rda")
save(MIDUS2_recode, file = "MIDUS2_recode.rda")
save(MIDUS3_recode, file = "MIDUS3_recode.rda")

# Export data to Stata ####
require(foreign)
write.dta(MIDUS1_recode, "MIDUS1_Recode.dta")
write.dta(MIDUS2_recode, "MIDUS2_Recode.dta")
write.dta(MIDUS3_recode, "MIDUS3_Recode.dta")










