acams.drop.bio.matrix <- data.matrix(acams.drop.bio)
acams.tet.mat <- tetrachoric(acams.drop.bio.matrix)
test <- irt.fa(acams.tet.mat, nfactors = 4, n.obs = nrow(acams), rotate = "cluster", fm = "ml")

plot.irt

# Reliability for factor 1 
f1 <- acams.drop.bio[c("aEnergyHeal", "aHypnosis", "aImageryTech", "aRelaxMeditate", "aPraySpirit")]
head(f1)
num.f1 <- remove_attributes(f1, ".rows")
num.f1 <- lapply(f1, as.numeric)
num.f1 <- as.data.frame(num.f1)
kr20(num.f1)

# Change all columns to 0/1 instead of 1/2. 
num.f1.01 <- num.f1 %>% 
  mutate_all(~
    case_when(
      . == 1 ~ 0,
      . == 2 ~ 1
    )
  )

kr20(num.f1.01)
# Same as factors.  

# Below is not working.  
f1.drop.energy<- acams.drop.bio.matrix[c("aHypnosis", "aImageryTech", "aRelaxMeditate", "aPraySpirit")]
f1.drop.energy.mat <- tetrachoric(f1.drop.energy)

# Reliability for factor 2 
f2 <- acams.drop.bio[c("aAcupuncture", "aHerbal", "aHomeopathy")]
head(f2)
kr20(f2)
# Reliability for factor 3 
f3 <- acams.drop.bio[c("aExerciseMove", "aVitamins", "aSpecialDiet")]
head(f3)
kr20(f3)
# Reliability for factor 4 
f4 <- acams.drop.bio[c("aChiropractic", "aMassage")]
head(f4)
kr20(f4)


# Composite reliability 
sl <- standardizedSolution(fit)
sl <- sl$est.std[sl$op == "~"]
names(sl) <- names(acams.drop.bio)
sl


library(semTools)

reliability(fit)

