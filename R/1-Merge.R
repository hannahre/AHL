# Subset and Merge MIDUS Data 
# Hannah Andrews
# 2020-02-22



# Data downloaded from ICPSR

########################MIDUS2################################################

# Load MIDUS2 Survey datasets
# Load Questionnaire data 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Survey/MIDUS2-Survey.rda')
myvars <- c("M2ID", "M2FAMNUM", "SAMPLMAJ", "B1STATUS", "B1PRSEX", "B1PANHED", "B1PDEPAF", "B1PDEPRE",
            "B1PANXIE", "B1PPANIC","B1SSPIRI", "B1SRELID", "B1SRELPR", "B1SRELSU", "B1SMNDFU",
            "B1SSPRTE", "B1SHLOCS", "B1SHLOCO", "B1SC1", "B1SC3A", "B1SC3B", "B1SC3C", "B1SC3D",
            "B1SC3E", "B1SC3F", "B1SC3G", "B1SC3H", "B1SA52", "B1SUSEMD", "B1SA56A", "B1SA56B",
            "B1SA56C", "B1SA56D", "B1SA56F", "B1SA56G", "B1SA56H", "B1SA56I", "B1SA56J", "B1SA56K",
            "B1SA56L", "B1SA56M", "B1SA56N", "B1SA56Q", "B1SA56R","B1SA56S", "B1SEARN1", "B1SPNSN1", 
            "B1SSEC1", "B1SG7","B1SG23","B1SG24A", "B1POCC", "B1POCMAJ","B1PAGE_M2", "B1STINC1",
            "B1PB1", "B1PF8_A", "B1PF3", "B1PB19")
survey1 <- da04652.0001[myvars]
str(survey1)

# Load mortality data 
# load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Survey/MIDUS2-Mortality.rda')
# survey2 <- da04652.0002

# Load weights 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Survey/MIDUS2-Weights.rda')
myvars2 <- c("M2ID", "B1PWGHT1", "B1PWGHT2", "B1PWGHT3", "B1PWGHT4", "B1PWGHT5", "B1PWGHT6", 
             "B1PWGHT7", "B1PWGHT8", "B1PWGHT9")
survey2 <- da04652.0003[myvars2]
str(survey2)

# Merge Survey data and weights 
MIDUS2P1 <- merge(survey1, survey2, by = "M2ID", all.x = TRUE, all.y = TRUE)
str(MIDUS2P1)

# Did not load coded text data 

# Load MIDUS2 Biomarker data 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Biomarker/MIDUS2-Biomarkers.rda')
myvars3 <- c("M2ID", "B4HSYMX", "B4HSYMN", "B4PBMI", "B4P1GS", "B4P1GD", "B4BLDL", "B4BCHOL", "B4BHDL", 
             "B4BTRIGL", "B4BDHEA", "B4BDHEAS", "B4BCRP", "B4BIL6", "B4BMSDIL6", "B4BSIL6R", "B4BHA1C",
             "B4BGLUC", "B4BINSLN", "B4BIGF1", "B4BCORTL", "B4BEPIN", "B4BNOREP", "B4BDOPA", "B4HMETMW",
             "B4SSQ_S3", "B4H19", "B4H20", "B4H21", "B4H22", "B4H24")
bio <- da29282.0001[myvars3]
str(bio)

# Merge survey and biomarker data 
MIDUS2 <- merge(MIDUS2P1, bio, by = "M2ID", all = TRUE)

# Load daily diary data 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Daily Diary/MIDUS2-DailyDiary.rda')
myvars4 <- c("M2ID", "B2DB2", "B2DB3")
diary <- da26841.0001[myvars4]

diary_means <- diary %>% 
  group_by(M2ID) %>% 
  summarise(bMeanCig = mean(B2DB2, na.rm = TRUE), 
            bMeanAlc = mean(B2DB3, na.rm = TRUE))
head(diary_means)
str(diary_means)

# Merge diary_means to MIDUS2
MIDUS2 <- merge(MIDUS2, diary_means, by = "M2ID", all = TRUE)
str(MIDUS2)

# Save to both info and ahl git repos 
save(MIDUS2, file = "C:/Users/hanna/Documents/git/INFO523 Coursework/INFO523Coursework/MIDUS2.rda")
save(MIDUS2, file = "C:/Users/hanna/Documents/git/AHL/R/MIDUS2.rda")

# Create table with merge info 
# Added more variables 2020-03-11 did not update 
mydatasets <- c('M2survey', 'M2weights', 'merge survey and weights', 'm2bio', 'merge survey/weights/bio', 'm2diary-means', 'merge survey/weights/bio/diary')
obs <- c(4963, 2257, 4963, 1255, 5164, 2022, 5209)
varnum <- c(100, 10, 109, 37, 145, 3, 147)
M2MergeInfo <- cbind.data.frame(mydatasets, obs, varnum)
print(M2MergeInfo)

