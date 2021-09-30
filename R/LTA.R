# Latent Transition Analysis 
# 08/26/2021

# lmest
# install.packages("LMest")
library(LMest)
library(tidyr)
library(dplyr)

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
               "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", "acam14", "acam15",
               "acam21")

a.cams.lta <- M1[a.lta.var.list] # Subset MIDUS1 - only include CAMs.

# Rename columns 
a.cams.lta <- dplyr::rename(a.cams.lta, 
                            Acupuncture_W1 = acam1, 
                            Biofeedback_W1 = acam2,
                            Chiropractic_W1 = acam3,
                            EnergyHeal_W1 = acam4,
                            ExerciseMove_W1 = acam5,
                            Herbal_W1 = acam6,
                            Vitamins_W1 = acam7,
                            Homeopathy_W1 = acam8,
                            Hypnosis_W1 = acam9,
                            ImageryTech_W1 = acam10,
                            Massage_W1 = acam11,
                            Prayer_W1 = acam12,
                            RelaxMeditate_W1 = acam13,
                            SpecialDiet_W1 = acam14, 
                            SpiritHeal_W1 = acam15, 
                            PraySpirit_W1 = acam21)
head(a.cams.lta)

# Add time variables. Wave 1 = 1
# a.cams.lta$Wave1 <- "1"

################################################################################
# Wave 2 
# Prayer and spiritual healing combined in stata.

# Read in MIDUS2 data and subset to complete cases on CAMs
# Read in stata file for MIDUS 2
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS2.dta")
M2 <- read_dta(path)
b.cams.list <- c("M2ID", "bcam1", "bcam2", "bcam3", "bcam4", "bcam5", "bcam6", "bcam7", 
               "bcam8", "bcam9", "bcam10", "bcam11", "bcam12", "bcam13", "bcam14", "bcam15", "bcam21")

b.cams.lta <- M2[b.cams.list] # Subset MIDUS2 - only include CAMs.

# Rename columns 
b.cams.lta <- dplyr::rename(b.cams.lta, 
                            Acupuncture_W2 = bcam1, 
                            Biofeedback_W2 = bcam2,
                            Chiropractic_W2 = bcam3,
                            EnergyHeal_W2 = bcam4,
                            ExerciseMove_W2 = bcam5,
                            Herbal_W2 = bcam6,
                            Vitamins_W2 = bcam7,
                            Homeopathy_W2 = bcam8,
                            Hypnosis_W2 = bcam9,
                            ImageryTech_W2 = bcam10,
                            Massage_W2 = bcam11,
                            Prayer_W2 = bcam12,
                            RelaxMeditate_W2 = bcam13,
                            SpecialDiet_W2 = bcam14, 
                            SpiritHeal_W2 = bcam15, 
                            PraySpirit_W2 = bcam21)
head(b.cams.lta)

# Add time variable: Wave 2=2 
#b.cams.lta$Wave2 <- "2"

################################################################################
# Wave 3 
# This chunk reads in the MIDUS2 Stata .dta file, subsets the data to only include CAMs, and restricts the data to complete cases. 

# Prayer and spiritual healing combined in stata.

# Read in MIDUS2 data and subset to complete cases on CAMs
# Read in stata file for MIDUS 2
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS3.dta")
M3 <- read_dta(path)
c.cams.list <- c("M2ID", "ccam1", "ccam2", "ccam3", "ccam4", "ccam5", "ccam6", "ccam7", 
               "ccam8", "ccam9", "ccam10", "ccam11", "ccam12", "ccam13", "ccam14", 
               "ccam15", "ccam21")

c.cams.lta <- M3[c.cams.list] # Subset MIDUS2 - only include CAMs.

# Rename columns 
c.cams.lta <- dplyr::rename(c.cams.lta, 
                            Acupuncture_W3 = ccam1, 
                            Biofeedback_W3 = ccam2,
                            Chiropractic_W3 = ccam3,
                            EnergyHeal_W3 = ccam4,
                            ExerciseMove_W3 = ccam5,
                            Herbal_W3 = ccam6,
                            Vitamins_W3 = ccam7,
                            Homeopathy_W3 = ccam8,
                            Hypnosis_W3 = ccam9,
                            ImageryTech_W3 = ccam10,
                            Massage_W3 = ccam11,
                            Prayer_W3 = ccam12,
                            RelaxMeditate_W3 = ccam13,
                            SpecialDiet_W3 = ccam14, 
                            SpiritHeal_W3 = ccam15, 
                            PraySpirit_W3 = ccam21)
head(c.cams.lta)

# Add time variable: Wave 3 = 3
#c.cams.lta$Wave3 <- "3"

#################################################################################
# Drop biofeedback, prayer, and spirit from each wave

a.cams.lta <- subset(a.cams.lta, select = -c(Prayer_W1, SpiritHeal_W1, Biofeedback_W1))
str(a.cams.lta)

b.cams.lta <- subset(b.cams.lta, select = -c(Prayer_W2, SpiritHeal_W2, Biofeedback_W2))
str(b.cams.lta)

c.cams.lta <- subset(c.cams.lta, select = -c(Prayer_W3, SpiritHeal_W3, Biofeedback_W3))
str(c.cams.lta)

################################################################################
# Reshaping and merging all three waves 

# Merge a.cams.lta to b.cams.lta
cams.lta.1 <- merge(a.cams.lta, b.cams.lta, by = "M2ID")
# Merge cams.lta.1 and c.cams.lta
cams.lta.2 <- merge(cams.lta.1, c.cams.lta, by = "M2ID")

library(panelr)

# Reshape wide to long 
cams.long <- long_panel(cams.lta.2, prefix = "_W", begin = 1, end = 3, label_location = "end")

################################################################################
