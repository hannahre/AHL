# Recreating the poLCA example from http://finzi.psych.upenn.edu/library/poLCA/doc/poLCA-manual-1-4.pdf
# https://github.com/dlinzer/poLCA/blob/master/inst/doc/poLCA-manual-example.R

library(poLCA)
data("gss82")

# Predcell ####
# poLCA output includes element predcell that enables quick comparisons of the observed cell counts
# tot eh cell counts predicted by the latent class model- but only for cells that were observed
# to contain at least one observation. 
# Can use poLCA.table to generate predicted cell counts for any combination of the manifest variables. 

f <- cbind(PURPOSE, ACCURACY, UNDERSTA, COOPERAT) ~ 1
gss.lc2 <- poLCA(f, gss82, nclass = 2)

gss.lc2$predcell # shows that of the 36 possible four-response sequences of responses (3X2X2X3) only 33 are actually observed.

poLCA.table(formula = COOPERAT~1, 
            condition = list(PURPOSE=3, ACCURACY = 1, UNDERSTA = 2),
            lc = gss.lc2) # produces predicted frequency table for COOPERAT conditional on the specified values of the other 3 vars.

poLCA.table(formula = COOPERAT~UNDERSTA,
            condition = list(PURPOSE = 3, ACCURACY = 1),
            lc = gss.lc2) # produces a two-way table of cell counts based on conditions

poLCA.predcell(lc = gss.lc2, y = c(1,1,1,1)) # percentage of people in the underlying population replying 1 to all four questions based on the estimated probability mass function 

# Reordering the latent classes ####
lc <- poLCA(f, gss82, nclass = 3) # estimate a 3 class model
probs.start <- lc$probs.start # extract the outputted list of probs.start

# poLCA.reorder takes as its first argument the list of starting values probs.start
# Second argument is a vector describing the desired ordering of the latent classes

new.probs.start <- poLCA.reorder(probs.start, c(1, 3, 2)) # vector c(1, 3, 2) instructs poLCA.reorder to keep the first class in its current position, move the third class to the second, and the second class to the third position. 

lc <- poLCA(f, gss82, nclass = 3, probs.start = new.probs.start) # outputted classes will now match the desired ordering. 

# Recognizing and avoiding local maxima ####
data("gss82")
f <- cbind(PURPOSE, ACCURACY, UNDERSTA, COOPERAT) ~1

# Estimate the model 500 times
# after each function call, record the max log likelihood and the estimated population sizes of the three types of survey respondent.
mlmat <- matrix(NA, nrow = 500, ncol = 4) # create matrix of NAs with 500 rows (1 for each iteration) and 4 columns
for (i in 1:500) {
  gss.lc2 <- poLCA(f, gss82, nclass = 3, maxiter = 3000, tol = 1e-7, verbose = FALSE)
  mlmat[i, 1] <- gss.lc2$llik # record maximum log likelihood for each model in the matrix
  o <- order(gss.lc2$probs$UNDERSTA[,1], decreasing = TRUE) 
  mlmat[i, -1] <- gss.lc2$P[o]
}
mlmat # in the paper, they summarize the number of times each maxll occurs, and the class proportions for each 

# automate the above with nrep
gss.lc <- poLCA(f, gss82, nclass = 3, maxiter = 3000, nrep = 10)

# Latent class model example with the carcinoma data
data("carcinoma")
f <- cbind(A, B, C, D, E, F, G) ~1
lc2 <- poLCA(f, carcinoma, nclass = 2)
lc3 <- poLCA(f, carcinoma, nclass = 3)
lc4 <- poLCA(f, carcinoma, nclass = 4, maxiter = 5000) # four class model will typically need a larger number of iterations



