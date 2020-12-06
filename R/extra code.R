# Old recodes from spring 2020 that I don't understand anymore ####
# Recode Checks (all waves) #

# Apply dummy function on selected columns
MIDUS2 <- MIDUS2 %>% 
  mutate_at(c("bEverAcupuncture", "bEverBiofeedback", "bEverChiropractor", "bEverEnergy", 
              "bEverMoveTherapy", "bEverHerbTherapy", "bEverMegaVitamins", "bEverHomeopathy", 
              "bEverHypnosis", "bEverImageTech", "bEverMassage", "bEverPray", "bEverMeditate"),
            dummy)


# Write function to create cam count var: summed across all cams 
funrowsums <- function(x) {
  if(is.data.frame(x)) x <- as.matrix(x)
  base::rowSums(x, na.rm = TRUE) *NA^!base::rowSums(!is.na(x))
}

aCamCount <- funrowsums(MIDUS1[acamsList])

# Check bCamCount against the dummies 
camsList <- append(camsList, "bCamCount")
head(MIDUS2[camsList])

# Remove bCamCount from camsList
camsList <- camsList[camsList != "bCamCount"]

# Convert dummies to factors
MIDUS2[camsList] <- lapply(MIDUS2[camsList], factor)
sapply(MIDUS2[camsList], class)

# Convert bcams to factors and apply value labels
MIDUS2[camsList] <- lapply(MIDUS2[camsList], factor,
                           levels = c(0, 1),
                           labels = c("No", "Yes"))
str(MIDUS2[camsList])
summary(MIDUS2[camsList])
describe(MIDUS2[camsList])





