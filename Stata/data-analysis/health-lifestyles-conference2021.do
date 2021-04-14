////////////////////////////////////////////////////////////////////////////////
**Analysis: Health Lifestyles Conference
////////////////////////////////////////////////////////////////////////////////
local dir "C:\Users\hanna\git\AHL\Stata\data-cleaning"
* 02-22 Keeping in analysis folder for now. Change coding.do so that the final data files are save to analysis folder.
cd `dir'
capture log close 
log using health-lifestyles-conference.txt, replace text

version 13 
clear all 
set linesize 100
set more off 
set maxvar 32767

* Testing role of health locus of control, then hopefully insurance. 


**********************************************************************
//Cross-tabs 
**********************************************************************
capture log close
clear all

log using "health-lifestyles-conference-crosstabs-bcams", replace text 


macro drop _all
set linesize 80
set matsize 1000
set more off

use MIDUS2.dta if bCamCo !=. & lnbHhInc !=. & bEduc !=. & bHLOCS !=. & bRace !=. & ///
	bSex !=. & bReligId !=. & bSpirit 
keep bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16 ///
	bCamCo lnbHhInc bEduc bHLOCS bRace bSex bReligId bSpirit
save health-lifestyles-conference.dta, replace 

describe 

	global bcams "bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16"

foreach j in bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16 {
	foreach i in bEduc bHLOCS bRace bSex bReligId bSpirit {
		tab `j' `i',col
	}
}

log close 
log using "health-lifestyles-conference-crosstabs-bCamCo", replace text

foreach i in bEduc bHLOCS bRace bSex bReligId bSpirit {
	tab bCamCo `i', col
}



log close 

**********************************************************************
//Descriptives
**********************************************************************
capture log close
clear all

log using "FINAL-desc", replace text 

version 12
macro drop _all
set linesize 80
set matsize 1000
set more off

use 

***IVs***
svy, subpop (if RIDAGEYR>=20): mean female

svy, subpop (if RIDAGEYR>=20): mean RIDAGEYR
estat sd 

svy, subpop (if RIDAGEYR>=20): tab agecat, cell obs count cellwidth(15) format(%12.2g) 

svy, subpop (if RIDAGEYR>=20): tab race, cell obs count cellwidth(15) format(%12.2g) 

svy, subpop (if RIDAGEYR>=20): tab educ, cell obs count cellwidth(15) format(%12.2g) 

***Outcomes***
svy, subpop (if RIDAGEYR>=20): mean nutlabel

svy, subpop (if RIDAGEYR>=20): mean totfat

svy, subpop (if RIDAGEYR>=20): mean servsiz

svy, subpop (if RIDAGEYR>=20): mean cal

svy, subpop (if RIDAGEYR>=20): mean chol

svy, subpop (if RIDAGEYR>=20): mean sodium

svy, subpop (if RIDAGEYR>=20): mean protein

svy, subpop (if RIDAGEYR>=20): mean dairy

svy, subpop (if RIDAGEYR>=20): mean fruit

svy, subpop (if RIDAGEYR>=20): mean veg

svy, subpop (if RIDAGEYR>=20): mean swt

svy, subpop (if RIDAGEYR>=20): mean dietlife
estat sd
estat sd, var


**********************************************************************
//Binary Logistic Regression on Individual Dietary Behaviors 
**********************************************************************
capture log close
clear all

log using "FINAL-logits", replace text 

version 12
macro drop _all
set linesize 80
set matsize 1000
set more off

use FINAL-educ+diet if swt~=. & veg~=. & fruit~=. & protein~=. & dairy~=. & sodium~=. & chol~=. & totfat~=. & nutlabel~=. & ///
	cal~=. & servsiz~=. & female~=. & agecat~=. & race~=. & pir~=. & educ~=. & RIDAGEYR>=25

capture program drop ohbaby 
program ohbaby
	svy, vce(linearized):logit `1' educ1 educ2 educ3 age2 age3 female mexhisp black raceother, or
	est store m`2'
end 

ohbaby nutlabel 1 
ohbaby servsiz 2
ohbaby cal 3
ohbaby totfat 4
ohbaby chol 5
ohbaby sodium 6

outreg2 [m1 m2 m3 m4 m5 m6] using logits1.doc, word replace eform label dec(2) ///
	symbol(***, **, *) alpha (.001, .01, .05) title (Regression on individual behaviors of educational attainment) ///
	stats(coef ci) stnum(replace coef=exp(coef))
clear 

use FINAL-educ+diet if swt~=. & veg~=. & fruit~=. & protein~=. & dairy~=. & sodium~=. & chol~=. & totfat~=. & nutlabel~=. & ///
	cal~=. & modalc~=. & servsiz~=. & female~=. & agecat~=. & race~=. & pir~=. & educ~=. & RIDAGEYR>=25

ohbaby fruit 1
ohbaby veg 2
ohbaby protein 3
ohbaby dairy 4
ohbaby swt 5

outreg2 [m1 m2 m3 m4 m5] using logits2.doc, word replace eform label dec(2) ///
	symbol(***, **, *) alpha (.001, .01, .05) title (Regression on individual behaviors of educational attainment cont.) ///
	stats(coef ci) stnum(replace coef=exp(coef))

log close 

**********************************************************************
//Negative Binomial Regression on CAMs co-occurrence Index
**********************************************************************
capture log close
clear all

log using "health-lifestyles-conference-nbreg", replace text 
use health-lifestyles-conference.dta, clear

version 12
macro drop _all
set linesize 80
set matsize 1000
set more off

nbreg bCamCo i.bEduc
	est store model1 
nbreg bCamCo lnbHhInc
	est store model2
nbreg bCamCo i.bEduc i.bRace bSex bReligId bSpirit,irr
	est store model3
nbreg bCamCo lnbHhInc i.bRace bSex bReligId bSpirit,irr
	est store model4
nbreg bCamCo i.bEduc lnbHhInc i.bRace bSex bReligId bSpirit,irr
	est store model5
nbreg bCamCo i.bEduc lnbHhInc bHLOCS i.bRace bSex bReligId bSpirit,irr
	est store model6
	
outreg2 [model1 model2 model3] using nbreg123.doc, word replace eform dec(2) label symbol(***, **, *) ///
	alpha (.001, .01, .05) title (Regression on CAM co-occurrence index) ///
	stats(coef ci) stnum(replace coef=exp(coef))
outreg2 [model4 model5 model6] using nbreg456.doc, word replace eform dec(2) label symbol(***, **, *) ///
	alpha (.001, .01, .05) title (Regression on CAM co-occurrence index) ///
	stats(coef ci) stnum(replace coef=exp(coef))

log close 
exit

