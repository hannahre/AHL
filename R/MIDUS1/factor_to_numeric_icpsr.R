#---------------------------------------------------------------------------
# factor_to_numeric_icpsr.R
# 2012/12/06
#
# Convert R factor variable back to numeric in an ICPSR-produced R data
# frame. This works because the original numeric codes were prepended by
# ICSPR to the factor levels in the process of converting the original
# numeric categorical variable to factor during R data frame generation.
#
# REQUIRES add.value.labels function from prettyR package
#    http://cran.r-project.org/web/packages/prettyR/index.html
#
#
# Substitute the actual variable and data frame names for da99999.0001$MYVAR
# placeholders in syntax below.
#
#    data frame = da99999.0001
#    variable   = MYVAR
#
#
# Line-by-line comments:
#
# (1) Load prettyR package
#
# (2) Create object (lbls) containing the factor levels for the specified
#     variable.  Sort will be numeric as original codes (zero-padded, if
#     necessary) were preserved in the factor levels.
#
# (3) Strip original codes from lbls, leaving only the value labels, e.g.,
#       "(01) STRONGLY DISAGREE" becomes "STRONGLY DISAGREE"
#
# (4) Strip labels from data, leaving only the original codes, e.g.,
#       "(01) STRONGLY DISAGREE" becomes "1"
#
#     Then, coerce variable to numeric
#
# (5) Add value labels, making this a named numeric vector
#---------------------------------------------------------------------------
load (file = 'MIDUS1/DS0001/02760-0001-Data.rda')

library(prettyR)
lbls <- sort(levels(da02760.0001$MYVAR))
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
da02760.0001$MYVAR <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", da02760.0001$MYVAR))
da02760.0001$MYVAR <- add.value.labels(da02760.0001$MYVAR, lbls)

## 2019-11-14
#Errors: 
#da02760.0001$MYVAR <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", da02760.0001$MYVAR))
#Error in `$<-.data.frame`(`*tmp*`, MYVAR, value = numeric(0)) : 
#  replacement has 0 rows, data has 7108
#da02760.0001$MYVAR <- add.value.labels(da02760.0001$MYVAR, lbls)
#Error in names(attr(x, "value.labels")) <- value.labels : 
#  attempt to set an attribute on NULL

save(file = 'MIDUS1/DS0001/02760-0001-Data.rda')
