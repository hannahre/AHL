library(lavaan)
library(foreign)

dat <- read.spss("https://stats.idre.ucla.edu/wp-content/uploads/2018/05/SAQ.sav",
                 to.data.frame=TRUE, use.value.labels = FALSE)

# Correlation matrix rounded to 2 decimals
round(cor(dat[,1:8]), 2)

# Sample covariance matrix
round(cov(dat[,3:5]),2)

# Degrees of freedom 
## free parameters = number of unique parameters - number of fixed parameters
## df = number of known values - number of free parameters 
## number of known values = p(p+1)/2 
## Ex: 3 item CFA. So there are three known parameters(values on the items) 
## 3(3+1)/2=3(4)/2 = 12/2 = 6

## df negative, known < free (under-identified, cannot run the model)
## df = 0, known = free (just identified or saturated, no model fit)
## df positive, known > free (over-identified, model fit can be assessed)

# Address under-identification
## marker method: fixes the first loading of each factor to 1 
## variance standardization method: fixes the variance of each factor to 1 but freely estimates all loadings 

# Lavaan syntax
## ~ predict regression 
## =~ indicator factor analysis
## ~~ covariance. Eg: f1~~f1 is the covariance of f1 with itself 
## ~1 intercept 
## 1* fixes parameter 
## NA* frees parameter (useful to override defaul marker method)
## a* labels the parameter 'a', model constraints

# one factor three items, variance std
m1b <- 'f =~ NA*q03 + q04 + q05 
        f ~~ 1*f' 
# line 38: overrides the default marker method
# line 39: fixes the variance of the factor to 1
# Covariance of something with itself is just variance
onefac3items_b <- cfa(m1b, data = dat)
summary(onefac3items_b)


