local dir "C:\Users\hanna\git\AHL\"
cd `dir'
capture log close 
log using data-cleaning\SSSP.txt, replace text

version 13 
clear all 
set linesize 100
set more off 

use data-cleaning\MIDUS1.dta, clear 

keep M2ID SAMPLMAJ A1PRSEX A1PRAGE_2019 acam1 acam2 acam3 acam4 acam5 acam6 acam7 ///
		 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16 aeduc ahhinc A1PINMJ 

save data-cleaning\MIDUS1-SSSP.dta, replace 

log close 

version 16

gsem (acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 ///
		acam12 acam13 acam14 acam15<- _cons), logit lclass(C 5) nonrtolerance
 
estat lcprob 



		
gsem (x1 x2 x3 x4 x5 <- _cons), logit lclass(7) nonrtolerance
matrix b = e(b) 