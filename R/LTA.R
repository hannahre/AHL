# Latent Transition Analysis 
# 08/26/2021

# lmest
# install.packages("LMest")
library(LMest)

data("PSIDlong")
dim(PSIDlong)

# lmestData() to check and prepare the data 
dt <- lmestData(data = PSIDlong, id = "id", time = "time")

# Reshape data to long form 
str(acams.drop.bio)
str(bcams.drop.bio)
str(ccams.drop.bio)

# Need to read in with m2id
################################################################################
# Wave 1 
# This chunk reads in the MIDUS1 Stata .dta file, subsets the data to only include CAMs, and restricts the data to complete cases. 

# Read in MIDUS1 data and subset to complete cases on CAMs
# Read in stata file for MIDUS 1
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS1.dta")
M1 <- read_dta(path)
a.lta.var.list <- c("M2ID", "acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
               "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", "acam14", "acam15")

a.cams.lta <- M1[a.lta.var.list] # Subset MIDUS1 - only include CAMs.

# Rename columns 
a.cams.lta <- dplyr::rename(a.cams.lta, 
                       aAcupuncture = acam1, 
                       aBiofeedback = acam2,
                       aChiropractic = acam3,
                       aEnergyHeal = acam4,
                       aExerciseMove = acam5,
                       aHerbal = acam6,
                       aVitamins = acam7,
                       aHomeopathy = acam8,
                       aHypnosis = acam9,
                       aImageryTech = acam10,
                       aMassage = acam11,
                       aPrayer = acam12,
                       aRelaxMeditate = acam13,
                       aSpecialDiet = acam14,
                       aSpiritHeal = acam15)
head(a.cams.lta)


################################################################################
# Wave 2 
# Prayer and spiritual healing combined in stata.

# Read in MIDUS2 data and subset to complete cases on CAMs
# Read in stata file for MIDUS 2
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS2.dta")
M2 <- read_dta(path)
b.cams.list <- c("M2ID", "bcam1", "bcam2", "bcam3", "bcam4", "bcam5", "bcam6", "bcam7", 
               "bcam8", "bcam9", "bcam10", "bcam11", "bcam12", "bcam13", "bcam14")

b.cams.lta <- M2[b.cams.list] # Subset MIDUS2 - only include CAMs.

# Rename columns 
b.cams.lta <- dplyr::rename(b.cams.lta, 
                       bAcupuncture = bcam1, 
                       bBiofeedback = bcam2,
                       bChiropractic = bcam3,
                       bEnergyHeal = bcam4,
                       bExerciseMove = bcam5,
                       bHerbal = bcam6,
                       bVitamins = bcam7,
                       bHomeopathy = bcam8,
                       bHypnosis = bcam9,
                       bImageryTech = bcam10,
                       bMassage = bcam11,
                       bPraySpirit = bcam12,
                       bRelaxMeditate = bcam13,
                       bSpecialDiet = bcam14)
head(b.cams.lta)

################################################################################
# Wave 3 
# This chunk reads in the MIDUS2 Stata .dta file, subsets the data to only include CAMs, and restricts the data to complete cases. 

# Prayer and spiritual healing combined in stata.

# Read in MIDUS2 data and subset to complete cases on CAMs
# Read in stata file for MIDUS 2
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS3.dta")
M3 <- read_dta(path)
c.cams.list <- c("M2ID", "ccam1", "ccam2", "ccam3", "ccam4", "ccam5", "ccam6", "ccam7", 
               "ccam8", "ccam9", "ccam10", "ccam11", "ccam12", "ccam13", "ccam14")

c.cams.lta <- M3[c.cams.list] # Subset MIDUS2 - only include CAMs.

# Rename columns 
c.cams.lta <- dplyr::rename(c.cams.lta, 
                       cAcupuncture = ccam1, 
                       cBiofeedback = ccam2,
                       cChiropractic = ccam3,
                       cEnergyHeal = ccam4,
                       cExerciseMove = ccam5,
                       cHerbal = ccam6,
                       cVitamins = ccam7,
                       cHomeopathy = ccam8,
                       cHypnosis = ccam9,
                       cImageryTech = ccam10,
                       cMassage = ccam11,
                       cPraySpirit = ccam12,
                       cRelaxMeditate = ccam13,
                       cSpecialDiet = ccam14)
head(c.cams.lta)


# Combine prayer and spiritual healing in Wave 1 
# This code chunk combines prayer and spiritual healing and drops aPrayer and aSpiritHeal 
a.cams.lta <- a.cams.lta %>% 
  rowwise() %>% 
  mutate(
    aPraySpirit = case_when(
      aPrayer == 0 & aSpiritHeal == 0 ~ 0,
      aPrayer == 1 & aSpiritHeal == 1 ~ 1, 
      aPrayer == 1 & aSpiritHeal == 0 ~ 1, 
      aPrayer == 0 & aSpiritHeal == 1 ~ 1)
  ) 

check.vars <- c("aPrayer", "aSpiritHeal", "aPraySpirit")
view(a.cams.lta[check.vars])

# If respondents were missing on either prayer or spirit they're coded as missing on the new var. Ugh that needs to be fixed. 


# Drop prayer and spiritual healing columns 
acams <- subset(acams, select = -c(aPrayer, aSpiritHeal))
str(acams)

# Drop biofeedback from each wave 