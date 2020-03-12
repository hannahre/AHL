# Merging MIDUS2 Data and Subsetting 
# Hannah Andrews
# 2020-02-22

# Originally brought in the merged stata file; too many problems. 

# Data downloaded from ICPSR

# Load MIDUS2 Survey datasets
# Load Questionnaire data 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Survey/DS0001/04652-0001-Data.rda')
myvars <- c("M2ID", "M2FAMNUM", "SAMPLMAJ", "B1STATUS", "B1PRSEX", "B1PA1", "B1PA2", "B1PA38A",
            "B1PA37", "B1PANHED", "B1PDEPAF", "B1PDEPRE", "B1PANXIE", "B1PPANIC", "B1PF7A", "B1PF7B",
            "B1PF7C", "B1PF7D", "B1PF8B", "B1PF3", "B1PF2A", "B1PF2B", "B1PF2C", "B1SSPIRI", 
            "B1SRELID", "B1SRELPR", "B1SRELSU", "B1SRELCA", "B1SRELCB", "B1SMNDFU", "B1SSPRTE",
            "B1SHLOCS", "B1SHLOCO", "B1SC1", "B1SC3A", "B1SC3B", "B1SC3C", "B1SC3D", "B1SC3E", 
            "B1SC3F", "B1SC3G", "B1SC3H", "B1SA52", "B1SUSEMD", "B1SA54A", "B1SA54B", 
            "B1SA54C", "B1SA56A", "B1SA56B", "B1SA56C", "B1SA56D", "B1SA56F", "B1SA56G", "B1SA56H",
            "B1SA56I", "B1SA56J", "B1SA56K", "B1SA56L", "B1SA56M", "B1SA56N", "B1SA56Q", "B1SA56R",
            "B1SA56S", "B1SA30A", "B1SA30B", "B1SA30C", "B1SA30D", "B1SA30E", "B1SA30F", "B1SA31A",
            "B1SA31B", "B1SA31C", "B1SA31D", "B1SA31E", "B1SA31F", "B1SA32A", "B1SA32B", "B1SA32C",
            "B1SA32D", "B1SA32E", "B1SA32F", "B1SA57A", "B1SA57B", "B1SA58A", "B1SA58B", "B1SA61A",
            "B1SA61B", "B1SA61C", "B1SA61D", "B1SEARN1", "B1SPNSN1",  "B1SSEC1", "B1SG7","B1SG23",
            "B1SG24A", "B1POCC", "B1POCMAJ","B1PAGE_M2", "B1STINC1", "B1PB1")
survey1 <- da04652.0001[myvars]

# Daily diary data "B2DB2", "B2DB3", 

# Load mortality data 
# load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Survey/DS0002/04652-0002-Data.rda')
# survey2 <- da04652.0002
# Load weights 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Survey/DS0003/04652-0003-Data.rda')
myvars2 <- c("M2ID", "B1PWGHT1", "B1PWGHT2", "B1PWGHT3", "B1PWGHT4", "B1PWGHT5", "B1PWGHT6", 
             "B1PWGHT7", "B1PWGHT8", "B1PWGHT9")
survey2 <- da04652.0003[myvars2]

# Merge Survey data and weights 
MIDUS2P1 <- merge(survey1, survey2, by = "M2ID", all.x = TRUE, all.y = TRUE)

# Did not load coded text data 

# Load MIDUS2 Biomarker data 
load(file = 'C:/Users/hanna/Documents/git/AHL/R/MIDUS 2/MIDUS 2 Biomarker/DS0001/29282-0001-Data.rda')
myvars3 <- c("M2ID", "B4HSYMX", "B4HSYMN", "B4PBMI", "B4P1GS", "B4P1GD", "B4BLDL", "B4BCHOL", "B4BHDL", 
             "B4BTRIGL", "B4BDHEA", "B4BDHEAS", "B4BCRP", "B4BIL6", "B4BMSDIL6", "B4BSIL6R", "B4BHA1C",
             "B4BGLUC", "B4BINSLN", "B4BIGF1", "B4BCORTL", "B4BNECL", "B4BCLCRE", "B4BSCL3A", "B4BSCL42",
             "B4BEPIN", "B4BEPI12", "B4BEPCRE", "B4BNECL", "B4BNOREP", "B4BNE12", "B4BNOCRE", "B4BDOPA",
             "B4BDOCRE", "B4BDOP12", "B4QCESD", "B4QPS_PS")
bio <- da29282.0001[myvars3]

# Merge survey and biomarker data 
MIDUS2 <- merge(MIDUS2P1, bio, by = "M2ID", all.x = TRUE)

save(MIDUS2, file = "C:/Users/hanna/Documents/git/INFO523 Coursework/INFO523Coursework/MIDUS2.rda")


