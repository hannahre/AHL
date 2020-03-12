# Hannah Andrews 
# Renaming MIDUS variables 
# 2020-03-10

##### MIDUS 2 ####
load(file = "C:/Users/hanna/Documents/git/AHL/R/MIDUS2.rda")
# Rename cam variables 
MIDUS2 <- MIDUS2 %>% 
  rename(bEverAcupuncture = B1SA56A, 
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
         bEverOtherHeal = B1SA56S)

# SES variables 
MIDUS2 <- MIDUS2 %>%
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
