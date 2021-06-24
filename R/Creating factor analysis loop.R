# test the function
acams13_model <- factor_results(data = het.mat13, rotate = "varimax", fm = "ml", n.obs = nrow(acams), nfactors = 2)
factor_model$loadings
# Check for reliability here - break code chunk here 
# Add reliability values here 
acams13_model[["reliabilityF1"]] <- kr20(acams13[, c("aEnergyHeal", "aExerciseMove", "aImageryTech", "aMassage", "aSpecialDiet", "aBiofeedback", "aHypnosis", "aRelaxMeditate")])

# Test with another data set 
acams13_model2 <- factor_results(data = het.mat13, rotate = "promax", fm = "ml", n.obs = nrow(acams), nfactors = 2)
# add reliability
acams13_model2[["reliabilityF1"]] <- kr20(acams13[, c("aEnergyHeal", "aExerciseMove", "aImageryTech", "aMassage", "aSpecialDiet", "aBiofeedback", "aHypnosis", "aRelaxMeditate")])
model_list <- list(acams13_model, acams13_model2)

# Bind lists 
model_comparison <- dplyr::bind_rows(model_list)

model_list <- list(list_acams15_MLCluster1, 
                   list_acams15_MLOblimin1, 
                   list_acams15_MLPromax1, 
                   list_acams15_MLVarimax1, 
                   list_acams15_PACluster1, 
                   list_acams15_PAOblimin1, 
                   list_acams15_PAPromax1, 
                   list_acams15_PAVarimax1, 
                   list_acams15_MRCluster1, 
                   list_acams15_MROblimin1, 
                   list_acams15_MRPromax1, 
                   list_acams15_MRVarimax1)
model_comparison <- dplyr::bind_rows(model_list)
model_comparison

# Review factors loadings 
acams13_MLVarimax2$loadings
fa.diagram(acams13_MLVarimax2, cut = .299, sort = TRUE)

model_list <- list(acams15_MLCluster1_list, acams15_MLOblimin1_list, acams15_MLPromax1_list, acams15_MLVarimax1_list)
# Bind lists 
acams15_model_comparison <- dplyr::bind_rows(model_list)
acams15_model_comparison

# Function to run factor analysis and create list of fit statistics to be input into table 
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

# Function to run efa, function to compare models. 
```{r, echo=FALSE}
efa <- function(df,   #correlation matrix  
                k, #number of factors
                n.obs,
                rotate,
                fm) {      
  foreach(i=1:k, .packages="psych") %dopar% fa(df, 
                                               nfactors=i,
                                               n.obs=n.obs,
                                               rotate=rotate,
                                               fm=fm
  )
}

rotations <- c("varimax", "promax", "oblimin", "cluster")
factors_methods <- c("ml", "minres", "pa")


acl <- function(df,   #a data.frame with your data 
                k,       #the maximum number of classes to fit
                formula) {  
  foreach(i=1:k, .packages="poLCA") %dopar% poLCA(formula, df, nclass=i, 
                                                  nrep = 100
  )
}











# Appears to work... 
# SERIOUSLY APPEARS TO WORK! :D Produces lists 
test_table_efa <- data.frame(Model=0, CFI=0, TLI=0, BIC=0, RMSR=0, RMSEA=0, Factors=0, FactorMethod=0, Rotation=0)  
counter <- 1
test_efa <- foreach (i=1:6) %:%
  foreach(j=c("ml", "minres", "pa")) %:%
    foreach (k=c("varimax", "promax", "oblimin", "cluster")) %do% {
      model_i_j_k<- fa(r = het.mat, nfactors = i, n.obs=nrow(acams), rotate = k, max.iter = 100, fm = j)
      test_table_efa [counter,"Model"] <- paste0(model_i_j_k$factors, model_i_j_k$fm, model_i_j_k$rotation)
      test_table_efa [counter,"CFI"] <- 1 - ((model_i_j_k$STATISTIC-model_i_j_k$dof)/(model_i_j_k$null.chisq-model_i_j_k$null.dof))
      test_table_efa [counter,"TLI"] <- model_i_j_k$TLI
      test_table_efa [counter,"BIC"] <- model_i_j_k$BIC
      test_table_efa [counter,"RMSR"] <- model_i_j_k$rms
      test_table_efa [counter,"RMSEA"] <- model_i_j_k$RMSEA[1]
      test_table_efa [counter, "Factors"] <- model_i_j_k$factors
      test_table_efa [counter, "FactorMethod"] <- model_i_j_k$fm
      test_table_efa [counter, "Rotation"] <- model_i_j_k$rotation
      return(test_table_efa)
      counter <- counter + 1 
    }

# Convert the nested lists created by the nested loops above to a data frame. 
# 6 columns 72 rows (72 models)
df.test <- unstack(data.frame(d<-unlist(test_efa),names(d)))
df.test

# Turn "Model" column into rownames
df.test.with.rownames <- data.frame(df.test[,-5], row.names=df.test[,5])
df.test.with.rownames

# Reorder columns
col_order <- c("Factors", "FactorMethod", "Rotation", "BIC", "TLI", "CFI", "RMSR", "RMSEA")
df.test.with.rownames2 <- df.test.with.rownames[, col_order]
df.test.with.rownames2

str(df.test.with.rownames2)

# All columns are character vectors.
# Convert appropriate columns to numeric.
cols.num <- c("Factors", "BIC", "TLI", "CFI", "RMSR", "RMSEA")
df.test.with.rownames2[cols.num] <- sapply(df.test.with.rownames2[cols.num],as.numeric)
sapply(df.test.with.rownames2, class)

# Round numeric values to four decimal places
df.test.round <- modify_if(df.test.with.rownames2, ~is.numeric(.), ~round(., 4))



















# Convert data frame to numeric matrix
matrix.test <- data.matrix(df.test, rownames.force = )

# Write another loop for creating fa.diagrams. 

# Appears to work... 
test_efa <- foreach(j=c("ml", "minres", "pa")) %:%
  foreach (k=c("varimax", "promax", "oblimin", "cluster")) %do% {
    fa(r = het.mat, nfactors = 1, n.obs=nrow(acams), rotate = k, max.iter = 100, fm = j)
  }
# Creates a table that compares the models. 
test_compare_models <- function(model) {
  test_table_efa <- data.frame(Model=0, TLI=0, BIC=0, RMSR=0, RMSEA=0, CFI=0)   #empty data.frame to prealocate memory. 
  for(i in 1:length(model)){
    test_table_efa [i,1] <- paste0(model[[i]]$factors, model[[i]]$fm, model[[i]]$rotation)
    test_table_efa [i,2] <- model[[i]]$TLI
    test_table_efa [i,3] <- model[[i]]$BIC
    test_table_efa [i,4] <- model[[i]]$rms
    test_table_efa [i,5] <- model[[i]]$RMSEA[1]
    test_table_efa [i,6] <- 1 - ((model[[i]]$STATISTIC-model[[i]]$dof)/(model[[i]]$null.chisq-model[[i]]$null.dof))
  }
  return(test_table_efa)
}

test_model_fit_all_vars <- test_compare_models(test_efa)







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

test_model_comparison <- compare_models()

test <- efa(het.mat, 6, nrow(acams), )
model_fit_all_vars <- compare_models(test)
rownames(model_fit_all_vars) <- c('1 Factor Mode1', '2 Factor Model', '3 Factor Model', '4 Factor Model', '5 Factor Model', '6 Factor Model')
model_fit_all_vars
```

# Function: factor_results
# Goal: Run factor model and report fit and reliability statistics to model comparison dataframe 
# Inputs 
# data: correlation matrix
# rotate: rotation method 
# fm: factoring method 
# n.obs: number of observations 
# nfactors: number of factors
# max.iter: maximum # of iterations 