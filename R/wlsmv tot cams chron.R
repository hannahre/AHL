# divide age by 10 
path.complete <- path.complete %>% 
  mutate(Age_W2.2 = Age_W2/10)
# Divide age by 10 
path.complete <- path.complete %>% 
  mutate(Age_W3.2 = Age_W3/10)
# divide religion by 10 
path.complete <- path.complete %>% 
  mutate(Religion_W2.2 = Religion_W2/10)
path.complete <- path.complete %>% 
  mutate(Religion_W3.2 = Religion_W3/10)

model <- '
# Regressions
# Direct effect - log income 
totalCams_W3 ~ a*LogIncome_W1 
SumChron_W3 ~ b*LogIncome_W1
# Direct Effect - Education
totalCams_W3 ~ c*Education_W1
SumChron_W3 ~ d*Education_W1
# Mediator effects - Income 
SumChron_W2 ~ e*LogIncome_W1 
totalCams_W3 ~ f*SumChron_W2
totalCams_W2 ~ g*LogIncome_W1
SumChron_W3 ~ h*totalCams_W2
# Mediator effects - Education
totalCams_W2 ~ i*Education_W1
SumChron_W2 ~ j*Education_W1 
# Control for previous wave
totalCams_W3 ~ totalCams_W2
SumChron_W3 ~ SumChron_W2
# Indirect effect 
ef := e*f
gh := g*h
jf := j*f
ih := i*h
# total effect
total1 := a + (e*f)
total2 := b + (g*h)
total3 := c + (j*f)
total4 := d + (i*h)
# Controls
totalCams_W2 ~ Sex_W1 + Age_W2.2 + Marital_W2 + HlthInsurance_W2 + HLSelf_W2 + Spiritual_W2 + Religion_W2.2 + MexicanHispanic_W2 + Black_W2 + OtherRace_W2
SumChron_W2 ~ Sex_W1 + Age_W2.2 + Marital_W2 + MexicanHispanic_W2 + Black_W2 + OtherRace_W2
totalCams_W3 ~ Age_W3.2 + Sex_W1 + Marital_W3 + HlthInsurance_W3 + HLSelf_W3 + Spiritual_W3 + Religion_W3.2 + MexicanHispanic_W2 + Black_W2 + OtherRace_W2
SumChron_W3 ~ Age_W3.2 + Sex_W1 + Marital_W3 + MexicanHispanic_W2 + Black_W2 + OtherRace_W2
# Covariances
totalCams_W2 ~~ SumChron_W2
totalCams_W3 ~~ SumChron_W3
'

test.model.summ.2 <- sem(model, data = path.complete, estimator = "WLSMV")