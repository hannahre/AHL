local dir "C:\Users\hanna\Documents\git\AHL\R\Mixed model"
cd `dir'

rename (LogIncome_W1 Education_W1 Sex_W1 SumChron_W2 Age_W2 Marital_W2 HlthInsurance_W2 HLSelf_W2 Spiritual_W2 Religion_W2 MexicanHispanic_W2 Black_W2 OtherRace_W2 SumChron_W3 Age_W3 Marital_W3 HlthInsurance_W3 HLSelf_W3 Spiritual_W3 Religion_W3) (logincome_W1 education_W1 sex_W1 sumchron_W2 age_W2 marital_W2 hlthinsurance_W2 hlself_W2 spiritual_W2 religion_W2 mexicanhispanic_W2 black_W2 otherrace_W2 sumchron_W3 age_W3 marital_W3 hlthinsurance_W3 hlself_W3 spiritual_W3 religion_W3)

rename(totalCams_W2 totalCams_W3)(totalcams_W2 totalcams_W3)

rename(SRH_W2 SRH_W3)(srh_W2 srh_W3)

gsem(totalcams_W2 <- logincome_W1 education_W1 sex_W1 age_W2 marital_W2 hlthinsurance_W2 hlself_W2 spiritual_W2 religion_W2 mexicanhispanic_W2 black_W2 otherrace_W2, poisson) (sumchron_W2 <- logincome_W1 education_W1 sex_W1 age_W2 marital_W2 hlthinsurance_W2 hlself_W2 spiritual_W2 religion_W2 mexicanhispanic_W2 black_W2 otherrace_W2, poisson) (totalcams_W3 <- logincome_W1 education_W1 sumchron_W2 totalcams_W2 age_W3 sex_W1 marital_W3 hlthinsurance_W3 hlself_W3 spiritual_W3 religion_W3 mexicanhispanic_W2 black_W2 otherrace_W2, poisson) (sumchron_W3 <- logincome_W1 education_W1 sumchron_W2 totalcams_W2 age_W3 sex_W1 marital_W3 hlthinsurance_W3 hlself_W3 spiritual_W3 religion_W3 mexicanhispanic_W2 black_W2 otherrace_W2, poisson)

diagram 



* Totcams SRH

use mydata.dta, clear
set seed 1234

* Run gsem
gsem(totalcams_W2 <- logincome_W1 education_W1 sex_W1 age_W2 marital_W2 hlthinsurance_W2 hlself_W2 spiritual_W2 religion_W2 mexicanhispanic_W2 black_W2 otherrace_W2, poisson) (srh_W2 <- logincome_W1 education_W1 sex_W1 age_W2 marital_W2 hlthinsurance_W2 hlself_W2 spiritual_W2 religion_W2 mexicanhispanic_W2 black_W2 otherrace_W2, oprobit) (totalcams_W3 <- logincome_W1 education_W1 srh_W2 totalcams_W2 age_W3 sex_W1 marital_W3 hlthinsurance_W3 hlself_W3 spiritual_W3 religion_W3 mexicanhispanic_W2 black_W2 otherrace_W2, poisson) (srh_W3 <- logincome_W1 education_W1 srh_W2 totalcams_W2 age_W3 sex_W1 marital_W3 hlthinsurance_W3 hlself_W3 spiritual_W3 religion_W3 mexicanhispanic_W2 black_W2 otherrace_W2, oprobit)

regsave using totcamssrh, pval ci

nlcom (_b[srh_W2:logincome_W1]*_b[totalcams_W3:srh_W2]) (_b[totalcams_W3:logincome_W1] + _b[srh_W2:logincome_W1]*_b[totalcams_W3:srh_W2]) (_b[totalcams_W2:logincome_W1]*_b[srh_W3:totalcams_W2]) (_b[srh_W3:logincome_W1] + _b[totalcams_W2:logincome_W1]*_b[srh_W3:totalcams_W2]) (_b[srh_W2:education_W1]*_b[totalcams_W3:srh_W2]) (_b[totalcams_W3:education_W1] + _b[srh_W2:education_W1]*_b[totalcams_W3:srh_W2]) (_b[totalcams_W2:education_W1]*_b[srh_W3:totalcams_W2]) (_b[srh_W3:education_W1] + _b[totalcams_W2:education_W1]*_b[srh_W3:totalcams_W2]), post

esttab using "ietotcamssrh.csv", cells("b se p ci_l ci_u")  replace