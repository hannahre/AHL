# Hannah Andrews 
# Renaming MIDUS variables 
# 2020-03-10

library(magrittr)
library(dplyr)

##### MIDUS 2 ####
# Takes "C:/Users/hanna/git/AHL/R/MIDUS2-1.rda"
# Resulting dataset "C:/Users/hanna/git/AHL/R/MIDUS2-2.rda"
load(file = "C:/Users/hanna/Documents/git/AHL/R/MIDUS2-1.rda")

# Rename cam variables 
MIDUS2_recode <- MIDUS2 %>% 
  mutate(bEverAcupuncture = B1SA56A, 
         bEverBiofeedback = B1SA56B, 
         bEverChiropractor = B1SA56C, 
         bEverEnergy = B1SA56D, 
         bEverMoveTherapy = B1SA56F,   
         bEverHerbTherapy = B1SA56G, 
         bEverMegaVitamins = B1SA56H,  
         bEverHomeopathy = B1SA56I, 
         bEverHypnosis = B1SA56J, 
         bEverImageTech = B1SA56K,  
         bEverMassage = B1SA56L, 
         bEverPray = B1SA56M, 
         bEverMeditate = B1SA56N,  
         bEverSpecialDiet = B1SA56Q, 
         bEverSpiritHeal = B1SA56R, 
         bEverOtherHeal = B1SA56S) %>% 
  # dummy function 

# SES variables 
MIDUS2_recode_new <- MIDUS2_recode %>%
  rename(bTotHHInc = B1STINC1, 
         bBillsDifficulty = B1SG7, 
         bMoneyAfterDebts = B1SG23, 
         bAssetsAfterDebts = B1SG24A, 
         bRespOccupation = B1POCC, 
         bRespOccupMajor = B1POCMAJ, 
         bTotHHInc = B1STINC1, 
         bEducation = B1PB1)

# Health outcomes: Biomarkers and chronic conditions 
MIDUS2 <- MIDUS2 %>% 
  rename(bAnyChronic = B4HSYMX,
         bTotChronic = B4HSYMN,
         bBmi = B4PBMI, 
         bBloodPressureSys = B4P1GS, 
         bBloodPressureDia = B4P1GD,
         bCholLDL = B4BLDL, 
         bCholTot = B4BCHOL, 
         bCholHDL = B4BHDL,
         bTriglycerides = B4BTRIGL, 
         bDHEA = B4BDHEA,
         bDHEAS = B4BDHEAS, 
         bCReactivePro = B4BCRP, 
         bIL6 = B4BIL6, 
         bMsdIL6 = B4BMSDIL6, 
         bIL6Receptor = B4BSIL6R, 
         bHemoglobinA1c = B4BHA1C, 
         bGlucose = B4BGLUC, 
         bInsulin = B4BINSLN, 
         bInsulinGrowthF = B4BIGF1, 
         bCortisol = B4BCORTL, 
         bEpinephrine = B4BEPIN, 
         bNorepinephrine = B4BNOREP, 
         bDopamine = B4BDOPA,
         bBmi = B4PBMI)

# Healthcare/Insurance variables 
MIDUS2 <- MIDUS2 %>% 
  rename(bHasHealthInsurance = B1SC1,
         bPrivateInsurance = B1SC3A, 
         bEmployerInsurance = B1SC3B,
         bSpEmployerInsurance = B1SC3C, 
         bUnionInsurance = B1SC3D, 
         bSpUnionInsurance = B1SC3E, 
         bMedicareInsurance = B1SC3F, 
         bMedicaidInsurance = B1SC3G, 
         bMilitaryInsurance = B1SC3H, 
         bUnmetMedCareNeeds = B1SA52,
         bMDVisitsLastYear = B1SUSEMD)

# Locus of Control 
MIDUS2 <- MIDUS2 %>% 
  rename(bHealthLOCSelf = B1SHLOCS,
         bHealthLOCOther = B1SHLOCO)

# Religious/Spiritual 
MIDUS2 <- MIDUS2 %>% 
  rename(bSpirituality = B1SSPIRI, 
         bReligiousId = B1SRELID, 
         bPrivReligPractice = B1SRELPR, 
         bReligiousSupport = B1SRELSU, 
         bMindfulness = B1SMNDFU,
         bDailySpiritExp = B1SSPRTE)

# Traditional Health Behaviors 
MIDUS2 <- MIDUS2 %>% 
  rename(bMetMinPerWk = B4HMETMW,
         bSleepDuration = B4SSQ_S3,
         bDailyWater	= B4H19, 
         bDailySugBev = B4H20, 
         bDailyFruitVeg = B4H21, 
         bDailyWholeGrains = B4H22, 
         bWkFastfood = B4H24)


# Demographics/Controls 
MIDUS2 <- MIDUS2 %>% 
  rename(bSex = B1PRSEX, 
         bAge = B1PAGE_M2, 
         bRace = B1PF8_A, 
         bEthnicity = B1PF3, 
         bMaritalStatus = B1PB19)
colnames(MIDUS2)

save(MIDUS2, file = "C:/Users/hanna/git/AHL/R/MIDUS2.rda")

# Label MIDUS2 vars 
var.labels <- c(M2ID = "Respondent ID",
                M2FAMNUM = "MIDUS 2 Family number",
                SAMPLMAJ = "Major sample identification",
                B1STATUS = "Completion status of M2 respondents",
                bSex = "Respondent Sex (M/F)",
                B1PANHED = "Anhedonia (continuous)",
                B1PDEPAF = "Depressed Affect (continuous)",
                B1PDEPRE = "Depressed Affect + Anhedon (continuous)",
                B1PANXIE = "Anxiety Disorder (continuous)",
                B1PPANIC = "Panic Attack (continuous)",
                bSpirituality = "Spirituality",
                bReligiousId = "Religious Identification",
                bPrivReligPractice = "Private Religious Practices",
                bReligiousSupport = "Religious Support",
                bMindfulness = "Mindfulness",
                bDailySpiritExp = "Daily Spiritual Experiences",
                bHealthLOCSelf = "Health Locus of control-Self",
                bHealthLOCOther = "Health Locus of control-Others",
                bHasHealthInsurance = "Covered by hlthcare insurance currently",
                bPrivateInsurance = "R: Insurer directly provides hlth insur",
                bEmployerInsurance = "R: Employer provides health insurance",
                bSpEmployerInsurance = "R: SP's employer provides hlth insurance",
                bUnionInsurance = "R: Union provides health insurance",
                bSpUnionInsurance = "R: SP's union provides health insurance",
                bMedicareInsurance = "R: Medicare provides health insurance",
                bMedicaidInsurance = "R: Medicaid/oth provides hlth insurance",
                bMilitaryInsurance = "R: Military provides health insurance",
                bUnmetMedCareNeeds = "Needed med care, couldn't get it (12 mo)",
                bMDVisitsLastYear = "Number Times Seeing Medical Doctor (12 mo)",
                bEverAcupuncture = "Acupuncture frequency (12 mo)",
                bEverBiofeedback = "Biofeedback frequency (12 mo)",
                bEverChiropractor = "Chiropractor frequency (12 mo)",
                bEverEnergy = "Energy healing frequency (12 mo)",
                bEverMoveTherapy = "Exercise/movement therapy freq (12 mo)",
                bEverHerbTherapy = "Herbal therapy frequency (12 mo)",
                bEverMegaVitamins = "High dose mega-vitamins frequency (12mo)",
                bEverHomeopathy = "Homeopathy frequency (12 mo)",
                bEverHypnosis = "Hypnosis frequency (12 mo)",
                bEverImageTech = "Imagery techniques frequency (12 mo)",
                bEverMassage = "Massage therapy frequency (12 ms)",
                bEverPray = "Prayer/other spiritual freq (12 mo)",
                bEverMeditate = "Relaxation/mediation frequency (12 mo)",
                bEverSpecialDiet = "Special diet frequency (12 mo)",
                bEverSpiritHeal = "Spiritual healing by others freq (12 mo)",
                bEverOtherHeal = "Oth non-traditional therapy freq (12 mo)",
                B1SEARN1 = "HH total earning income:original value",
                B1SPNSN1 = "HH total pension income:original value",
                B1SSEC1 = "HH total soc.sec income:original value",
                bBillsDifficulty = "Difficult to pay monthly bills",
                bMoneyAfterDebts = "$ left or owed if cash assets & pd debts",
                bAssetsAfterDebts = "Amt assets/$ owed/left over",
                bRespOccupation = "Occupation code - Respondent",
                bRespOccupMajor = "R's current occupation - major groups",
                bAge = "Age",
                bTotHHInc = "HH total income(wage,pension,ssi,gov asst):original value",
                bEducation = "Highest level of education completed",
                bRace = "Which best describes your race?",
                bEthnicity = "Ethnic group best describes background",
                bMaritalStatus = "Marital status currently",
                B1PWGHT1 = "",
                B1PWGHT2 = "",
                B1PWGHT3 = "",
                B1PWGHT4 = "",
                B1PWGHT5 = "",
                B1PWGHT6 = "",
                B1PWGHT7 = "",
                B1PWGHT8 = "",
                B1PWGHT9 = "",
                bAnyChronic = "Any Symptoms and Chronic Conditions?--Yes/No",
                bTotChronic = "Total number of Symptoms and Chronic Conditions",
                bBmi = "BMI (Body Mass Index)",
                bBloodPressureSys = "Average BP(sitting) systolic",
                bBloodPressureDia = "Average BP(sitting) diastolic",
                bCholLDL = "Blood LDL Cholesterol (mg/dL)",
                bCholTot = "Blood Total Cholesterol (mg/dL)",
                bCholHDL = "Blood HDL Cholesterol (mg/dL)",
                bTriglycerides = "Blood Triglycerides (mg/dL)",
                bDHEA = "Blood DHEA (ng/mL)",
                bDHEAS = "Blood DHEA-S (ug/dL)",
                bCReactivePro = "Blood C-Reactive Protein (ug/mL)",
                bIL6 = "Blood Serum IL6 (pg/mL)	",
                bMsdIL6 = "Blood Serum MSD IL6 (pg/mL)",
                bIL6Receptor = "Blood Serum Soluble IL6 Receptor (pg/mL)",
                bHemoglobinA1c = "Blood Hemoglobin A1c %",
                bGlucose = "Blood Fasting Glucose levels mg/dL",
                bInsulin = "Blood Fasting Insulin levels uIU/mL",
                bInsulinGrowthF = "Blood Fasting IGF1 (Insulin-like Growth Factor 1) ng/mL)",
                bCortisol = "Urine Cortisol (ug/dL)",
                bEpinephrine = "Urine Epinephrine (ug/dL)",
                bNorepinephrine = "Urine Norepinephrine (ug/dL)",
                bDopamine = "Urine Dopamine (ug/dL)",
                bMetMinPerWk = "Total number of Metabolic Equivalent of Task (MET) minutes per week",
                bSleepDuration = "Sleep Duration",
                bDailyWater = "Average day, how many glasses of water do you drink?",
                bDailySugBev = "Average day, how many sugared beverages do you drink?",
                bDailyFruitVeg = "Average day, how many servings of fruit and vegetables do you eat?",
                bDailyWholeGrains = "Average day, how many servings of whole grain do you eat?",
                bWkFastfood = "Average week, how often do you eat at a fast food restaurant or order
                food for takeout or delivery?",
                bMeanCig = "Average: How many cigarettes did you smoke?",
                bMeanAlc  = "Average: HOW MANY DRINKS DID YOU HAVE?")
dplyr::as.tbl(MIDUS2)
MIDUS2 <- Hmisc::upData(MIDUS2, labels = var.labels)
Hmisc::label(MIDUS2)
str(MIDUS2)

save(MIDUS2, file = "C:/Users/hanna/Documents/git/AHL/R/MIDUS2-2.rda")
