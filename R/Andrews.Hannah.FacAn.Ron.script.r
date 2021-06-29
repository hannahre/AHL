# This is Ron's exploration of Hannah's Factor Analysis script.
# Don't assume that Ron is an expert.
# Ron found it very useful to convert the data into a simple matrix (around lines 105-108 below).

# To begin, load the libraries in Hannah's Factor Analysis script:
library(foreign)
library(expss)
library(Hmisc)
library(dplyr)
library(summarytools)
library(magrittr)
library(tidyverse)
library(mosaic)
library(lattice)
library(ggplot2)
library(scales)
library(ggthemes)
library(polycor)
library(psych)
library(REdaS)
library(haven)
library(labelled)
library(mice)
library(GPArotation)
library(foreach)
library(doParallel)
library(questionr)
library(gridExtra)
library(DAKS)
library(fdth)
library(lavaan)

# Then:

# Load my R workspace containing Hannah's stata data:
load("Andrews.Hannah.data.M1.RData")
ls()

dim(M1)
names(atts.M1)

acamsList <- c("acam1", "acam2", "acam3", "acam4", "acam5", "acam6", "acam7", 
               "acam8", "acam9", "acam10", "acam11", "acam12", "acam13", "acam14", "acam15")

acams <- M1[,acamsList] # Subset MIDUS1 - only include CAMs.

# Remove attributes from acams data - created in Stata (labels and data notes). They're (were) producing an error with bart_spher.
acams <- remove_attributes(acams, "label")
acams <- remove_attributes(acams, "notes")

str(acams)

# Work with row-sums:
totalCams <- rowSums(acams[,1:15])
# Note:
length(totalCams)
sum(complete.cases(totalCams))
table(totalCams)
sum(table(totalCams))
## Ron comment: From the above we see, for example:
##  -- There are 7,108 rows in acams, but only 6,157 that have no missing data ("NA") in them.
##  -- Of these 6,157 cases:
##  ---- 1 case  has all 15;
##  ---- 0 cases have 14;
##  ---- 3 cases have 13;
##  ---- 0 cases have 12;
##  ---- 9 cases have 11;  etc.

# acams[sapply(acams, is.numeric)] <- lapply(acams[sapply(acams, is.numeric)], as.factor) # convert all columns to factors

# I will execute the above line (commented out) but I'll call my result "acams.facs," so I can
#  compare it to the "original" acams.

acams.facs <- acams
acams.facs[sapply(acams.facs, is.numeric)] <- lapply(acams.facs[sapply(acams.facs, is.numeric)], as.factor)
# Looks good.
acams <- acams.facs

str(acams) 
head(acams)

acams <- dplyr::rename(acams, 
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
head(acams)
# Keep only complete cases
acams=acams[complete.cases(acams),]
str(acams)

# What type of numbers do we have in the tibble "acams"? Let's see.
### Let's construct a matrix version of acams:
acams.matrix <- as.matrix(acams)
dim(acams.matrix)
head(acams.matrix)
acams.matrix <- as.numeric(acams.matrix)
dim(acams) # is: 6157 rows by 15 columns
6157 * 15 # is: 92,355
length(acams.matrix) # also 92,355
acams.matrix <- matrix(acams.matrix, ncol = 15)
dim(acams.matrix)
colnames(acams.matrix) <- names(acams)
head(acams.matrix)
head(acams) # They look the same.

# Now look at the numbers in acams.matrix:
table(as.vector(acams.matrix))
# All numbers are binary (0, 1)
colSums(acams.matrix)
sort(colSums(acams.matrix))


# CAM Descriptives 
## Frequencies and percentages on each variable 

### Write the program that Hannah used ("freq_dframer")

freq_dframer <- function(data){
  quest_out   <- apply(data, 2, questionr::freq)
  templist <- list()
  for (i in 1:length(names(quest_out))) {
    temp <- data.frame(Item = rep(names(quest_out[i]), nrow(quest_out[[i]])),
                       Category = row.names(quest_out[[i]]),
                       quest_out[[i]])
    templist[[i]] <- temp
  }
  freqs <- dplyr::bind_rows(templist) 
  row.names(freqs) <- NULL
  names(freqs)[3:5] <- c("Frequency", "Percent", "Pcnt_of_nonMissing") 
  freqs$Item <- factor(freqs$Item, levels = unique(freqs$Item))
  freqs
}
freqout <- freq_dframer(acams)

# Check with my matrix version:
freqout$Frequency[seq(2, 30, 2)]
colSums(acams.matrix)
sum(freqout$Frequency[seq(2, 30, 2)] != colSums(acams.matrix)) # They are the same.

# Hannah's visualization:
ggplot(freqout, aes(x = Category, y = Frequency)) +
  geom_col() +
  facet_wrap(. ~ Item, nrow = 5 )

# A different visualization:
freqout.is1 <- freqout[seq(2, 30, 2),]
freqs <- freqout.is1$Frequency
names(freqs) <- c("Ac", "Bi", "Ch", "En", "Ex", "Hb", "Vi", "Ho", "Hy", "Im", "Ma", "Pr", "Re", "Di", "Sp")
o <- order(freqs, decreasing = TRUE)
freqs <- freqs[o]
barplot(freqs, main = "Number of respondents choosing each")

# From Hannah: ## Number of CAM treatments used in the past 12 months

# Convert column to a factor 
totalCams <- as.factor(totalCams)

# Relative frequencies 
prop.table(table(totalCams))

## Ron comment: Interpetation: 48.66% of the 6,157 people (for whom
##  there is no missing data) used 0 Cams; 23.209 % of those people
##  used 1 Cam; etc.

## I get the same result by (using my matrix version of acams):
nrow(acams.matrix) # is: 6,157
how.many.used <- (table(rowSums(acams.matrix))) / 6157
how.many.used
# Visualize it:
barplot(how.many.used, main = "Proportion of 6,157 People who used k Cams (k = 0, 1, ..., 15)")

# From Hannah (fine, but I like the above barplot better):
# Counts and percentages, relative and cumulative 
tb <- fdt_cat(totalCams)
tb

# (From Hannah:) Analayses including all 15 CAMs 
## Correlation matrix 
## Create and plot the tetrachoric correlation matrix for all CAMs. 
het.mat <- hetcor(acams)$cor # I believe this IS correct (Ron).

cor.plot(het.mat, numbers=T, upper=FALSE, main = "Tetrachoric Correlations", show.legend = TRUE, xlas = 2)

# Added by Ron, an alternate visualization of the same thing:
library(corrplot) # If you don't have this library, you may need to install it (Ron).
corrplot(het.mat)
corrplot(het.mat, is.corr=FALSE, method="square", order="hclust")


# From Hannah:
## Test for sampling adequacy 
#I will test for sampling adequacy using the Kaiser-Meyer-Olkin (KMO) 
#  test.MSA refers to the overall measure of sampling adequacy. 
#  MSAi refer to the measure of sampling adequacy for each item. 
#  MSA is a measure of the proportion of variance among variables 
#  that might be common variance. The lower the proportion of 
#  variance that is common the more suited the data are for factor analysis.  

# MSA cutoffs: >.9 marvelous, .8s meritorious, .7s middling, .6s mediocre, 
#  .5s miserable, less than .5 is unacceptable.
## Ron comment: Actually, these colorful descriptors refer to the
##  KMO program, not (just?) to the MSA values produced by the program.
##  (To see this, type the following):
?KMO

## Okay, Hannah ran this as
# KMO(het.mat)
## But we can do it this way:
KMO(het.mat)$MSA
## Interpretation: The overall KMA is .76, which the colorful language
##  (above) characterizes as "meritorious" (Good work!)

## Now for the individual items, sorted from low to high:
sort(KMO(het.mat)$MSAi)

## Ron comment: Basically these look fine to me. Spiritual and Prayer
## are low but still "acceptable" (greater than .5), and the others
## are "middling" (RelaxMeditate) or at least "meritorious" (all
## the others.)

# From Hannah:
nofactors <- fa.parallel(het.mat, n.obs = 6157, fm = "ml", fa = "fa", main = "Parallel Analysis Scree Plots- hetmat")
## Ron comment: 
##  -- This says 6 factors, but the scree plot suggests 2 factors, or maybe 3. (Look for
##      an "elbow" bend in the blue curve).
## -- Hannah writes that the program objected to 0's in the data ("corrected" to
##    0.5). I did not observe this problem.

# Hannah writes:
# From Statistics of DOOM notes: 
# i.	The dark line is set at one, which is part of the Kaiser criterion. 
#     This method is an older rule of thumb that is not well supported anymore.
#     You would look at the number of eigenvalues that are greater than 1 (or 
#     .70 in new literature).  This rule tends to overestimate the number of 
#     factors/components needed.

## Ron comment: Let's look at the eigenvalues, rounded to 4 decimal places:
e <- eigen(het.mat)
round(e$values, digits = 4)

## The first 6 eigenvalues are > .70 (same result as for "fa.parallel"),
##  but the first 4 are > 1.00 (closer to the scree plot analysis).

## Ron comment,
## FINALLY, SOME FACTOR ANALYSIS MODELS!

# Hannah's shell for running factor analysis (NOT USED -- and probably not necessary).
factor_results <- function(data, rotate, fm, n.obs, nfactors, max.iter = 100) {
  factor_model <- fa(r = data, nfactors = nfactors, n.obs=n.obs, rotate = rotate, max.iter = max.iter, fm = fm)
  fit_list <- list(Model = paste0(nfactors, " Factor, ", fm, ", ", rotate), 
                   TLI = factor_model$TLI, 
                   CFI = 1 - ((factor_model$STATISTIC-factor_model$dof)/(factor_model$null.chisq-factor_model$null.dof)),
                   BIC = factor_model$BIC,
                   RMSEA = factor_model$RMSEA[1],
                   RMSR = factor_model$rms)
  return(fit_list)
}

### 1 Factor Models 
#### Maximum Likelihood 
##### Orthogonal rotation: Varimax 

acams15_MLVarimax1 <- fa(r = het.mat, nfactors = 1, n.obs=nrow(acams), rotate = "varimax", max.iter = 100, fm = "ml")
# Print factor loadings 
acams15_MLVarimax1$loadings
# Print diagram showing factor loadings 
fa.diagram(acams15_MLVarimax1, cut = .299, sort = TRUE, main = "All CAMs, Maximum Likelihood, Varimax Rotation")

## Ron comment: Let's see what happens if we use a higher cutoff value, say, .7:
fa.diagram(acams15_MLVarimax1, cut = .7, sort = TRUE, main = "All CAMs, Maximum Likelihood, Varimax Rotation")


## Added by Ron: % of variance accounted for:
acams15_MLVarimax1$Vaccounted

## Added by Ron: BIC (a measure of fit that balances accurate reproduction of the data with
#   parsimony; lower values are better):
acams15_MLVarimax1$BIC

## Added by Ron: an overall summary of this model:
print(acams15_MLVarimax1)
## Interpretation of the above printout:
##  ML1 == factor loadings
##  h2 == communalities
##  u2 == uniquenesses
##  com == complexity of the factor loadings for each variable.


## Ron: What if we repeated the entire factor analysis above, but for THREE factors, that is:

### 3 Factor Model 
#### Maximum Likelihood 
##### Orthogonal rotation: Varimax 

acams15_MLVarimax3 <- fa(r = het.mat, nfactors = 3, n.obs=nrow(acams), rotate = "varimax", max.iter = 100, fm = "ml")

acams15_MLVarimax3$loadings
# Print diagram showing factor loadings USING .6 CUTOFF 
fa.diagram(acams15_MLVarimax3, cut = .6, sort = TRUE, main = "All CAMs, Maximum Likelihood, Varimax Rotation")

###################################################################################
#                                                                                 #
# Ron comment: I think this diagram is pretty cool!                               #
#  Factor ML1: Spiritual Healing and Prayer                                       #
#  Factor ML2: Relax/Meditate and Imagery Tech                                    #
#  Factor ML3: Herbal and Homopathy (these loadings are around .8) and            #
#                 Acupuncture and EnergyHeal (these loadings are around .6)       #
#                                                                                 #
###################################################################################


acams15_MLVarimax3$BIC
# Note: the BIC now is 11,028, down from 22,422 in the 1-factor model (good improvement)


## Ron: Let's try a 4-factor model:

### 4 Factor Model 
#### Maximum Likelihood 
##### Orthogonal rotation: Varimax 

acams15_MLVarimax4 <- fa(r = het.mat, nfactors = 4, n.obs=nrow(acams), rotate = "varimax", max.iter = 100, fm = "ml")

acams15_MLVarimax4$loadings
# Print diagram showing factor loadings USING .6 CUTOFF 
fa.diagram(acams15_MLVarimax4, cut = .6, sort = TRUE, main = "All CAMs, Maximum Likelihood, Varimax Rotation")

acams15_MLVarimax4$BIC


## Ron: Let's try a 6-factor model:

### 6 Factor Model 
#### Maximum Likelihood 
##### Orthogonal rotation: Varimax 

acams15_MLVarimax6 <- fa(r = het.mat, nfactors = 6, n.obs=nrow(acams), rotate = "varimax", max.iter = 100, fm = "ml")

acams15_MLVarimax6$loadings
# Print diagram showing factor loadings USING .6 CUTOFF 
fa.diagram(acams15_MLVarimax6, cut = .6, sort = TRUE, main = "All CAMs, Maximum Likelihood, Varimax Rotation")

acams15_MLVarimax6$BIC

acams15_MLVarimax6$Vaccounted

#################################################################################################
#                                                                                               #
## 6-factor model, with factor loading cutoff at 0.6                                            #
## Looking at the "Vaccounted" (either row "Proportion Var" or row "Proportion Explained"),     #
## the high loadings (in order of which factor exaplains the most) are                          #
##                                                                                              #
## ML4: Relax/Meditate and ImageryTech                                                          #
## ML5: Herbal and Homeopathy and Vitamins                                                      #
## ML2: Exersice/Movement                                                                       #
## ML6: Chiropractic and Massage                                                                #
## ML3: Spiritual                                                                               #
## ML1: Prayer                                                                                  #
#                                                                                               #
#################################################################################################


## FOR THE SAME (6-FACTOR) MODEL, LET'S USE A CUTOFF OF .3 (instead of .6):
fa.diagram(acams15_MLVarimax6, cut = .3, sort = TRUE, main = "All CAMs, Maximum Likelihood, Varimax Rotation")

#################################################################################################
#                                                                                               #
## 6-factor model, with factor loading cutoff at 0.3 [this is the only difference]              #
## Looking at the "Vaccounted" (either row "Proportion Var" or row "Proportion Explained"),     #
## the high loadings (in order of which factor exaplains the most) are                          #
##                                                                                              #
## ML4: Relax/Meditate and ImageryTech and Biofeedback and EnergyHeal and Hypnosis              #
## ML5: Herbal and Homeopathy and Vitamins and Acupuncture and SpecialDiet                      #
## ML2: Exersice/Movement                                                                       #
## ML6: Chiropractic and Massage                                                                #
## ML3: Spiritual                                                                               #
## ML1: Prayer                                                                                  #
#                                                                                               #
#################################################################################################



## Ron comment: There should be some sort of a duality here, between the factors (see above)
##  and THE PEOPLE WHO ENGAGE IN ACTIVITIES. For example, let's look at the people who engage
#   in the set of activities indexed by factor ML4 (as defined just above):
#
people.ML4 <- rowSums(acams.matrix[,c("aRelaxMeditate", "aImageryTech", "aBiofeedback", "aEnergyHeal", "aHypnosis")])
#
# There are five activities loading "high" (above .3) on this factor:
#  RelaxMeditate, ImageryTech, Biofeedbak, EnergyHeal, Hypnosis.
# Question: What is the number of people associated with all 5, with any 4 of these activities,
#  with any 3, etc?
# Answer:
table(people.ML4)
## Comment: 70 people (54 + 14 + 2) engage in at least 3 of the activities included in ML4.

# Let's also look at the number of people associated with the other factors:
people.ML5 <- rowSums(acams.matrix[,c("aHerbal", "aHomeopathy", "aVitamins", "aAcupuncture", "aSpecialDiet")])
table(people.ML5)
## Comment: 98 people (62 + 29 + 7) engaged in at least 3 of the activities in ML5.

people.ML2 <- acams.matrix[,"aExerciseMove"]
table(people.ML2)
## Comment: 1,078 people engage in ML2 ("Exercise / Movement")

people.ML6 <- rowSums(acams.matrix[,c("aChiropractic", "aMassage")])
table(people.ML6)
## Comment: 204 people engage in BOTH chiropractic and massage (factor ML6)

people.ML3 <- acams.matrix[,"aSpiritHeal"]
table(people.ML3)
## Comment: 196 people engage in Spiritual healing (ML3)

people.ML1 <- acams.matrix[,"aPrayer"]
table(people.ML1)
## Comment: 1,842 people engage in Prayer (factor ML1).

