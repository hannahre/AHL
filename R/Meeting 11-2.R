# Addressing questions from meeting on 11/2 


# Will need to create panel dataset with CAMs and chronic conditions. 
# MIDUS 1
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS1.dta")
M1 <- read_dta(path)
acamsList <- c("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
               "acam8", "acam9", "acam10", "acam11", "acam13", "acam14", 
               "acam21", "A1SCHROX")

wave1.cams.chron <- M1[acamsList]

# Keep only complete cases
wave1.cams.chron=wave1.cams.chron[complete.cases(wave1.cams.chron),]
str(wave1.cams.chron)

# Rename columns 
wave1.cams.chron <- dplyr::rename(wave1.cams.chron, 
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
                            RelaxMeditate_W1 = acam13,
                            SpecialDiet_W1 = acam14, 
                            PraySpirit_W1 = acam21)

# Create column that is the sum of CAMs used 
totalCams_W1 <- rowSums(wave1.cams.chron[,1:14])

# How many people have a change in health status between waves? 

# How many people change # of CAMs? 

# For each CAM, how many change in the percentage of people using them? 