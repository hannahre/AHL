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
               "ccam15", "ccam21", "C1STATUS")

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

################################################################################
# create waves with only complete cases

# wave 3
# Convert C1STATUS to factor 
c.cams.lta$C1STATUS <- as_factor(c.cams.lta$C1STATUS, levels = "values")
# Drop biofeedback and prayer and spirit 
c.cams.lta <- subset(c.cams.lta, select = -c(Prayer_W3, SpiritHeal_W3, Biofeedback_W3))
str(c.cams.lta) 
# Drop incomplete cases
c.cams.complete <- c.cams.lta[complete.cases(c.cams.lta),]

# Create dataframe with only C1STATUS and M2ID to be merged with the other waves so cases that do not have data in wave 3 can be dropped. 
path <- ("C:/Users/hanna/Documents/git/AHL/Stata/data-cleaning/MIDUS3.dta")
M3 <- read_dta(path)
status.list <- c("M2ID", "C1STATUS")

w3.completion <- M3[status.list] # Subset MIDUS2 - only include CAMs.

# Convert c1status to factor variable
w3.completion$C1STATUS <- as_factor(w3.completion$C1STATUS, levels = "values")

# Drop biofeedback and prayspirit
b.cams.lta <- subset(b.cams.lta, select = -c(Prayer_W2, SpiritHeal_W2, Biofeedback_W2))
str(b.cams.lta)
# Merge with Wave 2 
w2.w3.completion <- merge(w3.completion, b.cams.lta, by = "M2ID")
# Drop incomplete cases 
b.cams.complete <- w2.w3.completion[complete.cases(w2.w3.completion),]

# Drop biofeedback and pray spirit
a.cams.lta <- subset(a.cams.lta, select = -c(Prayer_W1, SpiritHeal_W1, Biofeedback_W1))
str(a.cams.lta)
# Merge with Wave 3 
w1.w3.completion <- merge(w3.completion, a.cams.lta, by = "M2ID")
# Drop incomplete cases
a.cams.complete <- w1.w3.completion[complete.cases(w1.w3.completion),]
dim(a.cams.complete)

 
#################################################################################
# Drop biofeedback, prayer, and spirit from each wave

#a.cams.lta <- subset(a.cams.lta, select = -c(Prayer_W1, SpiritHeal_W1, Biofeedback_W1))
#str(a.cams.lta)

#b.cams.lta <- subset(b.cams.lta, select = -c(Prayer_W2, SpiritHeal_W2, Biofeedback_W2))
#str(b.cams.lta)

#c.cams.lta <- subset(c.cams.lta, select = -c(Prayer_W3, SpiritHeal_W3, Biofeedback_W3))
#str(c.cams.lta) 
################################################################################
# Reshaping and merging all three waves 

# These include incomplete cases
# Merge a.cams.lta to b.cams.lta
cams.lta.1 <- merge(a.cams.lta, b.cams.lta, by = "M2ID")
# Merge cams.lta.1 and c.cams.lta
cams.lta.2 <- merge(cams.lta.1, c.cams.lta, by = "M2ID")

library(panelr)

# Reshape wide to long 
cams.long <- long_panel(cams.lta.2, prefix = "_W", begin = 1, end = 3, label_location = "end")

# Merge complete cases 
# Merge waves 1 and 2
cams.complete.1 <- merge(a.cams.complete, b.cams.complete, by = "M2ID", all = TRUE)
# Merge with wave 3
cams.complete.2 <- merge(cams.complete.1, c.cams.complete, by = "M2ID", all = TRUE)

# Drop incomplete cases for cams.complete.  
dim(cams.complete.2)
cams.complete.3 <- cams.complete.2[complete.cases(cams.complete.2),]
dim(cams.complete.3)

# Drop C1STATUS, .x, and .y
cams.complete.3 <- subset(cams.complete.3, select = -c(C1STATUS, C1STATUS.x, C1STATUS.y))
glimpse(cams.complete.3)

# Convert complete cases to long format 
cams.complete.long <- long_panel(cams.complete.3, prefix = "_W", begin = 1, end = 3, id = "M2ID", label_location = "end")

# Rename with response identified at the beginning of the variable name 

################################################################################
# Lmest on complete cases
# Convert cams.long to a dataframe for lmestData function
cams.complete.long <- as.data.frame(cams.complete.long)

# Rename vars so that all all cams start with response identifier(Y)
cams.complete.long <- dplyr::rename(cams.complete.long,
                              YAcupuncture = Acupuncture,
                              YChiropractic = Chiropractic,
                              YEnergyHeal = EnergyHeal,
                              YExerciseMove = ExerciseMove,
                              YHerbal = Herbal,
                              YVitamins = Vitamins,
                              YHomeopathy = Homeopathy,
                              YHypnosis = Hypnosis,
                              YImageryTech = ImageryTech,
                              YMassage = Massage,
                              YRelaxMeditate = RelaxMeditate,
                              YSpecialDiet = SpecialDiet,
                              YPraySpirit = PraySpirit, 
                              time = wave)

# Prepare and explore data 
d <- lmestData(data = cams.complete.long, id = "M2ID", time = "time")
summary(d, dataSummary = "responses", varType = rep("c", ncol(d$Y)))

# Build formula 
basic.complete.fm <- lmestFormula(data = cams.complete.long, response = "Y")

# Model search, time homogenous
complete.out <- lmestSearch(responsesFormula = basic.complete.fm$responsesFormula, 
                            index = c("M2ID", "time"),
                            data = cams.complete.long, 
                            version = "categorical", k = 1:10, 
                            modBasic = 1, seed = 123)
summary(complete.out)

# Marginal probabilities for each number of states
complete.model.4 <- complete.out$out.single[[4]]
complete.model.4$piv
complete.model.5 <- complete.out$out.single[[5]]
complete.model.5$piv
complete.model.6 <- complete.out$out.single[[6]]
complete.model.6$piv
complete.model.7 <- complete.out$out.single[[7]]
complete.model.7$piv
# Very small classes (<5%) begin appearing at 5 classes and beyond
# The majority of gains in model fit are also made between 1 and 4 classes. 

# 4 state solution 
plot(complete.model.4, what = "transitions")
# Matrix of conditional probabilities
mat4 <- as.matrix(complete.model.4$Psi[seq(2, 104,2)])
complete.model.4.condprob <- as.data.frame(split(mat4, 1:13))

# lowest AIC and BIC is 8 classes 
complete.model.8 <- complete.out$out.single[[8]]
summary(complete.model.8)
# Name columns
colnames(complete.model.4.condprob) <- c("Acupuncture",
                                         "Chiropractic",
                                         "EnergyHeal",
                                         "ExerciseMove",
                                         "Herbal",
                                         "Vitamins",
                                         "Homeopathy",
                                         "Hypnosis",
                                         "ImageryTech",
                                         "Massage",
                                         "RelaxMeditate",
                                         "SpecialDiet",
                                         "PraySpirit")
# Export as excel file
write_xlsx(complete.model.4.condprob, "C:/Users/hanna/Documents/git/AHL/R/complete4StatesCondProb.xlsx")

# Create matrix of conditional probabilities of yes on each item. Columns = items, rows = states
mat1 <- as.matrix(complete.model.8$Psi[seq(2, 208,2)])
complete.model.8.condprob <- as.data.frame(split(mat1, 1:13))
# Name columns
colnames(complete.model.8.condprob) <- c("Acupuncture",
                                         "Chiropractic",
                                         "EnergyHeal",
                                         "ExerciseMove",
                                         "Herbal",
                                         "Vitamins",
                                         "Homeopathy",
                                         "Hypnosis",
                                         "ImageryTech",
                                         "Massage",
                                         "RelaxMeditate",
                                         "SpecialDiet",
                                         "PraySpirit")
library(writexl)
write_xlsx(complete.model.8.condprob, "C:/Users/hanna/Documents/git/AHL/R/complete8StatesCondProb.xlsx")

# 6 Classes 
complete.model.6 <- complete.out$out.single[[6]]
summary(complete.model.6)
# Two very small classes, 2% and 3% 
# Create matrix of conditional probabilities of yes on each item. Columns = items, rows = states
mat6 <- as.matrix(complete.model.6$Psi[seq(2, 156,2)])
complete.model.6.condprob <- as.data.frame(split(mat6, 1:13))
colnames(complete.model.6.condprob) <- c("Acupuncture",
                                         "Chiropractic",
                                         "EnergyHeal",
                                         "ExerciseMove",
                                         "Herbal",
                                         "Vitamins",
                                         "Homeopathy",
                                         "Hypnosis",
                                         "ImageryTech",
                                         "Massage",
                                         "RelaxMeditate",
                                         "SpecialDiet",
                                         "PraySpirit")
# Name rows 
row.names(complete.model.6.condprob) <- c("State 1", "State 2", "State 3", "State 4", "State 5", "State 6")
write_xlsx(complete.model.6.condprob, "C:/Users/hanna/Documents/git/AHL/R/complete6StatesCondProb.xlsx")

################################################################################
# LMest - running markov model. 

# Prepare and explore data

# Convert cams.long to a dataframe for lmestData function
cams.long.df <- as.data.frame(cams.long)

# drop id column. I'll use M2ID as the unit identifier 
# cams.long.df <- subset(cams.long.df, select = -c(id))
str(cams.long.df)

# Rename vars so that all all cams start with Cam.
cams.long.df <- dplyr::rename(cams.long.df,
                              YAcupuncture = Acupuncture,
                              YChiropractic = Chiropractic,
                              YEnergyHeal = EnergyHeal,
                              YExerciseMove = ExerciseMove,
                              YHerbal = Herbal,
                              YVitamins = Vitamins,
                              YHomeopathy = Homeopathy,
                              YHypnosis = Hypnosis,
                              YImageryTech = ImageryTech,
                              YMassage = Massage,
                              YRelaxMeditate = RelaxMeditate,
                              YSpecialDiet = SpecialDiet,
                              YPraySpirit = PraySpirit, 
                              time = wave)

# lmestData: create object of class lmestData 
cams.lmest.dt <- lmestData(cams.long.df, id = "id", time = "wave")

summary(cams.lmest.dt, dataSummary = "responses", varType = rep("c", ncol(cams.lmest.dt$Y)))

# Basic Markov Model 
cam.Basic <- lmestFormula(data = cams.long.df, response = "Y")

# Latent markov models for categorical responses 
cam.model <- lmest(responsesFormula = cam.Basic$responsesFormula,
                   index = c("M2ID", "wave"), 
                   data = cams.long.df, k = 1:6)
print(cam.model)
summary(cam.model)
plot(cam.model, what = "CondProb")
plot(cam.model, what = "transitions")
plot(cam.model, what = "marginal")

# time heterogenous - probability of transition can change over time. 
cam.model.out <- lmestSearch(responsesFormula = cam.Basic$responsesFormula,
                             index = c("M2ID", "time"), 
                             data = cams.long.df, version = "categorical", k = 1:8, 
                             modBasic = 0, seed = 123)

summary(cam.model.out)
# 6 classes - same as LCA 
cam.model.6 <- cam.model.out$out.single[[6]]
summary(cam.model.6)
plot(cam.model.6, what = "CondProb")
plot(cam.model.6, what = "transitions")
plot(cam.model.6, what = "marginal")

# 4 classes
cam.model.4 <- cam.model.out$out.single[[4]]
summary(cam.model.4)
plot(cam.model.4, what = "CondProb")
plot(cam.model.4, what = "transitions")
plot(cam.model.4, what = "marginal")

###########################################################
# limit to complete cases across all waves 
# Keep only complete cases. I'd like to see if the results are different - I'm not entirely sure how missing data is being treated. 

# lmestData: create object of class lmestData 
cams.lmest.dt.complete <- lmestData(cams.long.df.complete, id = "id", time = "time")

summary(cams.lmest.dt.complete, dataSummary = "responses", varType = rep("c", ncol(cams.lmest.dt.complete$Y)))





























################################################################################
# Following along data_criminal_sim example from https://cran.r-project.org/web/packages/LMest/vignettes/vignetteLMest.html#latent-markov-models-for-categorical-responses

data(data_criminal_sim)
dim(data_criminal_sim)
str(data_criminal_sim)

# Prepare other datasets from vignettes
data("RLMSlong")
dim(RLMSlong)
data("PSIDlong")
dim(PSIDlong)
data("NLSYlong")
dim(NLSYlong)

# Check and prepare nlsylong data
dt <- lmestData(data = NLSYlong, id = "id", time = "time",
                responsesFormula = anti+self ~NULL)
summary(dt, dataSummary = "responses", varType = rep("c", ncol(dt$Y)))

# Convert to data frame
data_criminal_sim <- data.frame(data_criminal_sim)

# Select only women
crimf <- data_criminal_sim[data_criminal_sim$sex == 2,]

# Create lmData object from crimf
dt1 <- lmestData(data = crimf, id = "id", time = "time")

# Display summary of every response variable for each time occasion 
summary(dt1, varType = rep("d", ncol(dt1$Y)))

## lmestFormula() allows us to specify the model to be estimated. Can also specify all covariates affecting the distribution, or influencing the initial and transition probabilities 
# basic
fmBasic <- lmestFormula(data = RLMSlong, response = "value")
# with all covariates affecting the distribution 
fmLatent <- lmestFormula(data = PSIDlong, response = "Y", 
                         LatentInitial = "X", LatentTransition ="X")
# specify subsets of covariates influencing the initial and transition probabilities of the latent process
fmLatent2 <- lmestFormula(data = PSIDlong, response = "Y", 
                          LatentInitial = c("X1Race","X2Age","X3Age2","X9Income"), 
                          LatentTransition =c("X1Race","X2Age","X3Age2","X9Income"))

#These models rely on a homogenous Markov chain of first order with a finite number of states. Maximum likelihood estimation of model parameters is performed through the EM algorithm. Standard errors for the parameter estimates are obtained by exact computation of the information matrix or through reliable numerical approximations of this matrix, by using option out_se=TRUE or by using the suitable function se().

# Latent Markov models for categorical responses 
# Basic LM model with time heterogenous transition probabilities
# specify number of latent states
mod <- lmest(responsesFormula = fmLatent$responsesFormula,
             index = c("id", "time"),
             data = PSIDlong, k = 2)
# specify range of latent states. Choose model based on AIC and BIC
mod <- lmest(responsesFormula = fmLatent$responsesFormula,
             index = c("id","time"),
             data = PSIDlong, k = 1:3)
# Print method shows the main results
print(mod)
# standard erroes can be obtained with se() function 
se(mod)

# With covariates
# For the data PSIDlong, we can estimate an LM model with covariates affecting the distribution of the latent process by fixing k = 2 latent states as follows:
mod2 <- lmest(responsesFormula = fmLatent$responsesFormula, 
              latentFormula = fmLatent$latentFormula, 
              index = c("id", "time"), 
              data = PSIDlong, k = 2, 
              paramLatent = "multilogit", 
              start = 0, out_se = TRUE)
# Every 10 iterations of the EM algorithm, the function displays, along with the indication of the chosen model specification and number of latent states, the type of starting values used, the number of iterations, the value of the log-likelihood at the end of the current iteration, the difference with respect to the log-likelihood at the end of the previous iteration, and the discrepancy between the corresponding parameter vectors.
# The summary() method returns the estimation results 
summary(mod2)
# Plot of conditional response probabilities referred to the categories of the multivariate response is obtained with plot()
plot(mod2, what = "CondProb")
# A path diagram of the estimated transition probabilities 
plot(mod2, what = "transitions")
# Estimated marginal distribution of the latent states
plot(mod2, what = "marginal")


# Mixed latent markov model 
# Function lmestMixed() allows us to estimate mixed LM models for categorical responses to take into account additional sources of (time-fixed) dependence in the data. 
#For the data data_criminal_sim we are interested to evaluate the patterns of criminal behavior among individuals. At this aim, we estimate a model with k1 = 2 latent classes and k2 = 2 latent states, restricting the analysis to females.
responsesFormula <- lmestFormula(data = crimf, response = "y")$responsesFormula
# k1 = 2 latent classes and k2 = 2 latent states, restricting analysis to females. 
modm <- lmestMixed(responsesFormula = responsesFormula, 
                   index = c("id", "time"), 
                   k1 = 2, k2 = 2, 
                   tol = 10^-3, 
                   data = crimf)
summary(modm)
round(modm$Psi[2, , ], 3)
plot(modm, what = "transitions")
# We can identify the first latent state as that of females with null or very low tendency to commit crimes, whereas the second latent state corresponds to criminals having mainly the following types of activity: theft, burglary, and other offences. According to the estimated transition matrix, females classified in the first cluster present a higher probability (of around 0.5) to move from the second to the first latent state than those assigned to the second cluster (of around 0.4), revealing a more pronounced tendency to commit less crimes over time

# Searching for the global maximum of the log-likelihood 
# AIC and BIc 
# estimating the basic LM model for increasing values of the latent states from 1:4
out <- lmestSearch(responsesFormula = fmBasic$responsesFormula, 
                   index = c("id", "time"),
                   data = RLMSlong, version = "categorical", k = 1:4, 
                   modBasic = 1, seed = 123)
# Display the results of model selection with 
summary(out)
# 4 has lowest BIC and highest number of free parameters
# Estimation results for the selected number of states
mod4 <- out$out.single[[4]]
summary(mod4)
# Plot of the conditional response probabilities referred to the categories of the univariate response obtained with 
plot(mod4, what = "CondProb")
# Local and global decoding
#Function lmestDecoding() allows us to predict the sequence of latent states for the sample units on the basis of the output of the main estimation functions, and so to perform a "dynamic pattern recognition".
# For the basic LM model estimated by using data PSIDlong the local (Ul) and global (Ug) decoding (Viterbi algorithm) are given by:
dec <- lmestDecoding(mod)
head(dec$Ug)


###############################################################################
#lmestData - Preliminary function
dt <- lmestData(data = NLSYlong, id = "id", time = "time",
                responsesFormula = anti+self ~NULL)
summary(dt, dataSummary = "responses", varType = rep("c", ncol(dt$Y)))

data_criminal_sim <- data.frame(data_criminal_sim)
crimf


#################################################################################
# lmestFormula()
# allows us to specify 
# Two components: measurement model and structural model (distribution given covariats)
# specify both components
