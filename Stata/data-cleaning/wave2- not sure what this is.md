#### Wave 2
```s
	use MIDUS2.dta, clear 
	tab B1PRSEX, missing
	recode B1PRSEX (1 = 0) (2 = 1), gen(bSex)
	label define sex2 0 "Male" 1 "Female"
	label values bSex sex2
	tab B1PRSEX bSex, missing
	save, replace
```

#### Wave 3
```s
	use MIDUS3.dta, clear 
	tab C1PRSEX, missing
	recode C1PRSEX (1 = 0) (2 = 1), gen(CSex)
	label define sex3 0 "Male" 1 "Female"
	label values CSex sex3
	tab C1PRSEX CSex, missing
	save, replace
```

//Religiosity

#### Wave 1
```s
	use MIDUS1.dta, clear 
	* Check coding on all religious variables 
	foreach var in A1SR2A A1SR2D A1SR2F A1SR2G A1SR2H A1SR2I {
		codebook `var'
	}

	* Need to be reverse coded so 4 = very and 1 = not at all
	* Create local to act as a counter for generated religious vars. 
	local period = 1	
	* Write for loop - reverse code each religious variable
	* Define value labels to be ```s
	used religious variable recodes 
	label define relVals 1 "Not at all" 2 "Not very" 3 "Somewhat" 4 "Very"
	foreach var of varlist A1SR2A A1SR2D A1SR2F A1SR2G A1SR2H A1SR2I {
		recode `var' (4 = 1) (3 = 2) (2 = 3) (1 = 4) (. = .), gen(aRelig`period')
		label values aRelig`period' relVals
		tab `var' aRelig`period', missing
		local period=`period'+1
	}

	* Create Religious Index by summing all vars. 

	* To match with indices from other waves: (1) impute mean value of completed items for missing items
	* (2) Code cases missing more than half of the items as missing

	* Check missing patterns
	* Create global list of religious variables 
	global bRelVars "A1SR2A A1SR2D A1SR2F A1SR2G A1SR2H A1SR2I"
	* Investigate missing data patterns on bRelVars
	mdesc $bRelVars
	mvpatterns $bRelVars
	* Create newvar = number of missing values on bRelVars
	egen MissbRelVars=rmiss2($bRelVars)
	tab MissbRelVars, missing

	notes: Religious - Most missing on item 2 (Importance of religion in life). 37 cases.
	notes: Religious - 18 cases missing on item 5 prefer people of the same religion
	notes: Religious - 14 missing on item 6 marriage... all others 12 or fewer cases per pattern.

	save,replace
```

#### Wave 2
```s
	use MIDUS2.dta, clear
  	sum B1SRELID, detail
  	hist B1SRELID
  	rename B1SRELID bReligId
  	notes bReligId: For an item with a missing value, the mean value of completed items is imputed.
	notes bReligId: The scales are computed for cases that have valid values for at least half of the items on the particular scale. Scale scores are not calculated for cases with fewer than half of the items on the scales, and coded as “98” for “NOT CALCULATED (Due to missing data).”
  	save, replace
```

#### Wave 3

//Spirituality

#### Wave 1
	
#### Wave 2
```s
	use MIDUS2.dta, clear 
	tab B1SSPIRI, missing
	hist B1SSPIRI
	rename B1SSPIRI bSpirit
	notes bSpirit: Same as bReligId
	save, replace
```

#### Wave 3

//Marital Status 
	
#### Wave 1
```s
	use MIDUS1.dta, clear
	tab A1PB17, missing
	rename A1PB17 aMarital 

	* Create dummy for married/not married 
	recode aMarital (1 = 1) (2/5 = 0) (. = .), gen(aMarried)
	label variable aMarried "Married/Not married"
	label define married 0 "Not married" 1 "Married"
	label values aMarried married
	tab aMarital aMarried, missing  

	save, replace
```

#### Wave 2
```s
	use MIDUS2.dta, clear 
	tab B1PB19, missing
	rename B1PB19 bMarital

	* Create dummy for married/not married 
	recode bMarital (1 = 1) (2/5 = 0) (. = .), gen(bMarried)
	label variable bMarried "Married/Not married"
	label define married 0 "Not married" 1 "Married"
	label values bMarried married
	tab bMarital bMarried, missing  
	
	save, replace
```

#### Wave 3
```s
	use MIDUS3.dta, clear
	tab C1PB19, missing
	rename C1PB19 cMarital 

	* Create dummy for married/not married	
	recode cMarital (1 = 1) (2/5 = 0) (. = .), gen(cMarried)
	label variable cMarried "Married/Not married"
	label define married 0 "Not married" 1 "Married"
	label values cMarried married
	tab cMarital cMarried, missing  

	save, replace
```

//Childhood SES 

#### Wave 1
	
#### Wave 2
	
#### Wave 3

//Health insurance 

#### Wave 1
##### Currently covered by health insurance 
```s
	use MIDUS1.dta, clear

	* Check response patterns on health insurance variables 
	egen pattern3 = concat(A1SC1*)
		tab pattern3, missing 

	* Generate new variable equal to 1 if yes to any A1SC1*
	generate aHlthIns = 0
		replace aHlthIns = 1 if A1SC1A == 1 | A1SC1B == 1 | A1SC1C == 1 | A1SC1D == 1 | A1SC1E == 1 | A1SC1F == 1 | A1SC1G == 1 | A1SC1H == 1 
		replace aHlthIns = . if A1SC1A == . & A1SC1B == . & A1SC1C == . & A1SC1D == . & A1SC1E == . & A1SC1F == . & A1SC1G == . & A1SC1H == . 
	label define hlthInVals 0 "Uninsured" 1 "Insured"
	label values aHlthIns hlthInVals
	tab aHlthIns, missing

	* Check aHlthIns for errors.

	* Need to know the number of observations with a combination of . and 2 on A1SC1*
	* Define a global called aHlthInsVars with all health insurance variables
	global aHlthInsVars A1SC1A A1SC1B A1SC1C A1SC1D A1SC1E A1SC1F A1SC1G A1SC1H
	display "$aHlthInsVars"
	
	* 649 cases coded as no insurance, 578 cases with 2s across all insurance variables.
	* 71 cases should have some combination of . and 2s across all insurance variables.
	* Generate new variable = 0 if aHlthIns = 0 (no insurance)
	generate chk1 = aHlthIns if aHlthIns == 0
	tab chk1 aHlthIns, missing
	
	* Set chk1 = 2 if some combination of . and 2 across all insurance variables
	* Loop replace statements over all insurance variables. Chk1 equal to 1 if any combination of . and 2 across all insurance vars. 
	foreach i of global aHlthInsVars {
		foreach j of global aHlthInsVars {
				replace chk1 = 2 if `i' == . & `j' == 2 
		} 
	} 
	
	* Set chk1 = 1 if respondent answered "yes" to having any type of insurance 
	replace chk1 = 1 if aHlthIns == 1

	label define chk1Vals 0 "Uninsured" 1 "Insured" 2 "Combination of missing and No on insurance vars"
	label values chk1 chk1Vals
	
	tab chk1 aHlthIns, missing
	* YES!! 71 cases identified with some combination of . and 2 + 578 (all nos) = total uninsured on aHlthIns

	save, replace
```

#### Wave 2
##### Currently covered by health insurance 
```s
	use MIDUS2.dta, clear
	tab B1SC1, missing
	recode B1SC1 (1 = 1) (2 = 0) (. = .), gen(bHlthIns)
	label variable bHlthIns "Currently covered by health insurance"
	label values bHlthIns hlthInVals
	tab bHlthIns B1SC1, missing

	//Type of health insurance coverage 
	generate bHlthIns1 = .
		replace bHlthIns1 = 1 if B1SC1 == 2
		replace bHlthIns1 = 3 if B1SC3F == 1 | B1SC3G == 1 | B1SC3H == 1
		replace bHlthIns1 = 2 if B1SC3A == 1 | B1SC3B == 1 | B1SC3C == 1 | B1SC3D == 1 | B1SC3E == 1
	label define hlthIn 1 "No Insurance" 2 "Private" 3 "Public"
	label values bHlthIns1 hlthIn
	tab bHlthIns1, missing
	notes bHlthIns1: Private trumps public if responded yes to both 

	* Create variable to identify patterns across bHlthIns1 and other insurance variables 
	egen pattern1 = concat(bHlthIns1 B1SC1 B1SC3*) 
		tab pattern1 

	generate bHlthIns2 = .
		replace bHlthIns2 = 1 if B1SC1 == 2
		replace bHlthIns2 = 2 if B1SC3A == 1 | B1SC3B == 1 | B1SC3C == 1 | B1SC3D == 1 | B1SC3E == 1
		replace bHlthIns2 = 3 if B1SC3F == 1 | B1SC3G == 1 | B1SC3H == 1
	*label define hlthIn 1 "No Insurance" 2 "Private" 3 "Public"
	label values bHlthIns2 hlthIn
	tab bHlthIns2, missing
	notes bHlthIns2: Public trumps private if responded yes to both 

	* Create variable to identify patterns across bHlthIns1 and other insurance variables 
	egen pattern2 = concat(bHlthIns2 B1SC1 B1SC3*) 
		tab pattern2

	tab bHlthIns1 bHlthIns2, missing
	notes: Health insurance there are 882 respondents who report having both public and private health insurance 
	notes: Health insurance there are 70 respondents who report not having any insurance currently & having public or private insurance 
	tab bHlthIns1 B1SC1, missing
	tab bHlthIns2 B1SC1, missing

	* Series of variables to check for mistakes 
	generate error1 = . 
		replace error1 = 1 if bHlthIns == 2 & B1SC1 == 2 
		notes error1: 3 errors picked up - coded as having private insurance because of spouse. Okay.
		replace error1 = 2 if bHlthIns == 3 & B1SC1 == 2 
		notes error1: 61 observations stated they had no health insurance but reported having public health insurance. Okay. 
		replace error1 = 3 if bHlthIns == 2 & B1SC3F == 1 
		replace error1 = 4 if bHlthIns == 2 & B1SC3G == 1 
		replace error1 = 5 if bHlthIns == 2 & B1SC3H == 1 
		replace error1 = 6 if bHlthIns == 3 & B1SC3A == 1 	
		replace error1 = 7 if bHlthIns == 3 & B1SC3B == 1
		replace error1 = 8 if bHlthIns == 3 & B1SC3C == 1
		replace error1 = 9 if bHlthIns == 3 & B1SC3D == 1
		replace error1 = 10 if bHlthIns == 3 & B1SC3E == 1
		replace error1 = 11 if bHlthIns == 3 & B1SC3E == 1
	tab error1, missing
	notes error1: 03/03/21 Error var for no/pub/priv health insurance. Don't worry about for now. Going to use B1SC1 unless advised otherwise. 

	save, replace
```

#### Wave 3
#### Currently covered by health insurance 
```s
	use MIDUS3.dta, clear
	tab C1SC1, missing
	recode C1SC1 (1 = 1) (2 = 0) (. = .), gen(cHlthIns)
	label variable cHlthIns "Currently covered by health insurance"
	label values cHlthIns hlthInVals
	tab cHlthIns C1SC1, missing

	save, replace
```

//Types of healthcare providers seen 
	
#### Wave 1
	
#### Wave 2
	
#### Wave 3


## CAM Variables 

*CAM associated with each var # across all waves
	*cam1	Acupuncture
	*cam2	Biofeedback
	*cam3	Chiropractic
	*cam4 	Energy healing
	*cam5	Exercise/movement therapy
	*cam6	Herbal therapy
	*cam7 	High-dose mega-vitaminsused 
	*cam8	Homeopathy 
	*cam9	Hypnosis
	*cam10	Imagery techniques
	*cam11	Massage therapy
	*cam12	Spiritual practices 
	*cam13	Meditation
	*cam14	Special diets
	*cam15	Spiritual healing
	*cam16	Other non-traditional therapy 

*Only at Wave 1
	*cam20	Alt drugs used
	
*Only at Waves 2 and 3
	*cam17	Phys/Occupational therapy
	*cam18	Physician prescribed diet freq
	*cam19 	Weight control diet freq
		
### CAM Co-Occurrence Indices  

#### Wave 1

```s
	use MIDUS1.dta, clear 
	* Check coding and distribution of all cam variables 
		foreach var of varlist A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G ///
			A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O A1SA39P {
			fre `var'
		}
			
	* Write loop to dummy all CAM vars 0=never 1=```s
	used in the last year 
		*Create new variable that denotes wave and cam var #. 
		*Create local to act as a counter for generated acam vars. 
		local period=1	
		foreach var of varlist A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G ///
			A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O A1SA39P {
			recode `var' (1 = 1) (2 = 0) (. = .), gen(acam`period')
			tab `var' acam`period', missing
			local period=`period'+1
		}
		
	* Dummy A1SALTER (only in wave 1)
	notes A1SALTER: only appears at Wave 1. See SAQ question A40 
	notes A1SALTER: used sedatives, tranquilizers, amphetamines, analgesics, 
	notes A1SALTER: prozac, inhalants, marijuana or hashish, cocaine or crack, 
	notes A1SALTER: LSD or other hallucinogens, or heroin on their own or in a 
	notes A1SALTER: other than prescribed by a doctor. 
		recode A1SALTER ///
			(1 = 1) ///
			(2 = 0) ///
			(. = .), ///
			gen(acam20)
		tab A1SALTER acam20, missing

	* Check missing value patterns on CAM dummies
		* Create local list of cams
		global acams "acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16"
		* Investigate missing data patterns on bcams
		mdesc $acams
		mvpatterns $acams
		* Create newvar = number of missing values on bcams 
		egen MissACams=rmiss2($acams)
		tab MissACams, missing

//MISSING VALUES: CAMS AND IVS 
	* Relationship between missing values on CAMs and income 
		scatter MissACams A1SHHTOT
		notes MissACams: scatter with income- slightly more missing values on lower end of income distribution.
		* Check distribution of missing values on CAMs for obs making less than/equal to 100000, and obs making more than 100000
		tab MissACams if A1SHHTOT <= 100000
		tab MissACams if A1SHHTOT > 100000
		notes MissACams: 95.74% of obs reporting inc<=100000 complete cases on CAMs
		notes MissACams: 64.1% of obs reporting inc>100000 complete cases on CAMs
		notes MissACams: 32.92% of obs reporting inc>100000 missing on all 16 CAMs 

		* Create new categorical income variable with 25000 increments to check distribution of missing values on CAMs 
		recode A1SHHTOT (0/25000 		= 1) ///
						(25500/50000	= 2) ///
						(50500/75000 	= 3) ///
						(75500/100000 	= 4) ///
						(100500/125000 	= 5) ///
						(125500/150000 	= 6) ///
						(150500/175000 	= 7) ///
						(175500/200000 	= 8) ///
						(200500/225000 	= 9) ///
						(225500/250000 	= 10) ///
						(250500/275000 	= 11) ///
						(275500/300000 	= 12) ///
						(. = .), ///
						gen(aIncCat)
		label define inccat 1 "0/25000" ///
							2 "25500/50000" ///
							3 "50500/75000" ///
							4 "75500/100000" ///
							5 "100500/125000" ///
							6 "125500/150000" ///
							7 "150500/175000" ///
							8 "175500/200000" ///
							9 "200500/225000" ///
							10 "225500/250000" ///
							11 "250500/275000" ///
							12 "275500/300000"
		label values aIncCat inccat
		tab A1SHHTOT aIncCat, missing

		* Missing on at least one CAM by continuous income variable 
		scatter OnlyMissACams A1SHHTOT

		* Create new variable, value = to number of missing values, excluding cases missing on 0 CAMs
		gen OnlyMissACams = MissACams if MissACams != 0

		* Check that above code ran correctly
		tab MissACams OnlyMissACams, missing

		* View distribution of missing values by income categories, increments of 25000, for all values missing on at least one CAM
		tab OnlyMissACams aIncCat
		tab OnlyMissACams aIncCat, missing

		* Visualize distribution of missing values by 25000 income increments
		histogram OnlyMissACams, discrete by(aIncCat) freq

		notes: There are 260 observations missing at least one CAM with a nonmissing income value. 
		notes: 790 obs missing on all 16 CAMs and missing on the income variable. 
		notes: 192 obs missing on income with no missing CAMs.

	* Relationship between missing values on CAMs and Education 
		
	*Create count variable (sum of CAMs) 
		egen aCamCo1 = rowtotal(acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 ///
			acam11 acam12 acam13 acam14 acam15 acam16), missing

		* Examine new count variable 
		tab aCamCo1, missing
		hist aCamCo1

		save, replace
```
	
#### Wave 2 
```s
	use MIDUS2.dta, clear

	*Display coding and distribution of all cam variables 
		foreach var of varlist B1SA56A B1SA56B B1SA56C B1SA56D B1SA56F B1SA56G B1SA56H B1SA56I ///
			B1SA56J B1SA56K B1SA56L B1SA56M B1SA56N B1SA56Q B1SA56R B1SA56S {
			fre `var' 
		}

	*Write loop to dummy all CAM vars 0=never 1=```s
	used in the last year 
		*Create new variable that denotes wave and cam var #. 
		*Create local to act as a counter for generated acam vars. 
		local period=1	
		foreach var of varlist B1SA56A B1SA56B B1SA56C B1SA56D B1SA56F B1SA56G B1SA56H B1SA56I ///
			B1SA56J B1SA56K B1SA56L B1SA56M B1SA56N B1SA56Q B1SA56R B1SA56S {
			recode `var' (1/4= 1) (5 = 0) (. = .), gen(bcam`period')
			tab `var' bcam`period', missing
			local period=`period'+1
		}

	* Check missing patterns
		* Create local list of cams
		global bcams "bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16"
		* Investigate missing data patterns on bcams
		mdesc $bcams
		mvpatterns $bcams
		* Create newvar = number of missing values on bcams 
		egen MissBCams=rmiss2($bcams)
		tab MissBCams, missing

//MISSING VALUES: CAMS AND IVS	
	* Relationship between income and missing values on CAMs 

		* Create new variable, value = to number of missing values, excluding cases missing on 0 CAMs
		gen OnlyMissBCams = MissBCams if MissBCams != 0

		* Check that above code ran correctly
		tab MissBCams OnlyMissBCams, missing

		* Scatter - # of missing values by income 
		scatter OnlyMissBCams B1STINC1
		notes OnlyMissBCams: scatter with continuous income - more missing values on low end of income distribution.
		hist B1STINC1
		notes OnlyMissBCams: more obs on low end of income distribution anyways... check percentages. 

		* Create new variable - categorical income variable, 25000 increments.
		recode B1STINC1 (0/25000 		= 1) ///
						(25500/50000	= 2) ///
						(50500/75000 	= 3) ///
						(75500/100000 	= 4) ///
						(100500/125000 	= 5) ///
						(125500/150000 	= 6) ///
						(150500/175000 	= 7) ///
						(175500/200000 	= 8) ///
						(200500/225000 	= 9) ///
						(225500/250000 	= 10) ///
						(250500/275000 	= 11) ///
						(275500/300000 	= 12) ///
						(. = .), ///
						gen(bIncCat)
		label define inccat 1 "0/25000" ///
							2 "25500/50000" ///
							3 "50500/75000" ///
							4 "75500/100000" ///
							5 "100500/125000" ///
							6 "125500/150000" ///
							7 "150500/175000" ///
							8 "175500/200000" ///
							9 "200500/225000" ///
							10 "225500/250000" ///
							11 "250500/275000" ///
							12 "275500/300000"
		label values bIncCat inccat
		tab B1STINC1 bIncCat, missing

		* View distribution of missing values by income categories, increments of 25000, for all values missing on at least one CAM
		tab OnlyMissBCams 

		tab OnlyMissBCams bIncCat, missing

		* Visualize distribution of missing values by 25000 income increments
		histogram OnlyMissBCams, discrete by(bIncCat) freq
		
		* Should exclude cases that are missing due to attrition. 
		tab B1STATUS MissBCams, missing
		notes: 2145 obs of the 3096 obs missing on all CAMs (69%) did not complete MIDUS2 phone or questionnaire 
		notes: 922 obs of the 3096 obs missing on all CAMS (29.7%) only completed the phone interview
		notes: 29 obs of the 3096 obs missing on all CAMs completed both the phone interview and questionnaire


	*Create co-occurrence index 1 
		egen bCamCo = rowtotal($bcams) if MissBCams<=8
		notes bCamCo: missing = 0 for obs missing on half or fewer bcams
		notes bCamCo: obs missing on more than half bcams coded as missing
		* Expect 3,130 missing values
		tab bCamCo, missing 
		hist bCamCo
		sum bCamCo, detail

	*Create co-occurrence index 2 
	*2019-11-20 cam17-19 not coded yet. Leave out for now
	*	egen bcamco2 = rowtotal(bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 bcam9 bcam10 bcam11 bcam12 bcam13 ///
	*		bcam14 bcam15 bcam16 bcam17 bcam18 bcam19), missing

		save, replace
```
		
#### Wave 3 
```s
	use MIDUS3.dta, clear

*Display coding and distribution of all cam variables 
	foreach var of varlist C1SA52A C1SA52B C1SA52C C1SA52D C1SA52F C1SA52G C1SA52H C1SA52I C1SA52J ///
		C1SA52K C1SA52L C1SA52M C1SA52N C1SA52Q C1SA52R C1SA52S C1SA52E C1SA52O C1SA52P {
		fre `var' 
	}

*Write loop to dummy all CAM vars 0=never 1=```s
	used in the last year 
	*Create new variable that denotes wave and cam var #. 
	*Create local to act as a counter for generated acam vars. 
	local period=1	
	foreach var of varlist C1SA52A C1SA52B C1SA52C C1SA52D C1SA52F C1SA52G C1SA52H C1SA52I C1SA52J ///
		C1SA52L C1SA52M C1SA52N C1SA52Q C1SA52R C1SA52S C1SA52E C1SA52O C1SA52P {
		recode `var' (1/4= 1) (5 = 0) (. = .), gen(ccam`period')
		tab `var' ccam`period', missing
		local period=`period'+1
	}

*Create co-occurrence index 1 
	egen ccamco1 = rowtotal(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ccam9 ccam10 ccam11 ccam12 ccam13 ///
		ccam14 ccam15 ccam16), missing
		
*Create co-occurrence index 2 
*2019-11-20 cam17-19 not coded yet. Leave out for now
*	egen ccamco2 = rowtotal(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ccam9 ccam10 ccam11 ccam12 ccam13 ///
*		ccam14 ccam15 ccam16 ccam17 ccam18 ccam19), missing

	save, replace
```

### CAM Index - with frequency variables 

* Above co-occurrence index uses dummy indicators. 
* Create new index for waves 2 and 3 that use the original ordinal frequency indicators 

#### Wave 2 
```s
	use MIDUS2.dta, clear 
	* Check frequency for each CAM
	foreach var of varlist B1SA56A B1SA56B B1SA56C B1SA56D B1SA56F B1SA56G B1SA56H B1SA56I ///
		B1SA56J B1SA56K B1SA56L B1SA56M B1SA56N B1SA56Q B1SA56R B1SA56S {
		fre `var' 
	}

	* Reverse code all CAMs so that 0 = Never and 4 = A lot
	local period=1	 
	foreach var of varlist B1SA56A B1SA56B B1SA56C B1SA56D B1SA56F B1SA56G B1SA56H B1SA56I ///
		B1SA56J B1SA56K B1SA56L B1SA56M B1SA56N B1SA56Q B1SA56R B1SA56S {
		recode `var' (1 = 4) (2 = 3) (3 = 2) (4 = 1) (5 = 0) (. = .), gen(bCamFreq`period')
		tab `var' bCamFreq`period', missing
		local period=`period'+1
	}

	* Sum values 
	egen bCamFreqInd = rowtotal(bCamFreq1 bCamFreq2 bCamFreq3 bCamFreq4 bCamFreq5 bCamFreq6 bCamFreq7 bCamFreq8 bCamFreq9 bCamFreq10 bCamFreq11 bCamFreq12 bCamFreq13 ///
		bCamFreq14 bCamFreq15 bCamFreq16), missing
	hist bCamFreqInd
	sum bCamFreqInd, detail
	graph box bCamFreqInd
	tab bCamFreqInd, missing

	* Check that bCamFreqInd coded correctly
	save, replace
```

### CAM LCA 


* Insert call for LCA do-file. 


###CAM Mean Indices  

#### Wave 1
```s
	use MIDUS1.dta, clear

*Create new var that is the average across all CAMs 
	egen acamme1 = rowmean(acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 ///
		acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16)
*Check that egen ran correctly 
	capture assert acamme1 == (acam1 + acam2 + acam3 + acam4 + acam5 + acam6 + acam7 + ///
		acam8 + acam9 + acam10 + acam11 + acam12 + acam13 + acam14 + acam15 + acam16)/16
	*252 false- missing on one or more cams. 
	
save, replace
```
	
#### Waves 2
```s
	use MIDUS2.dta, clear 

*Create new var that is the average across CAMs 1-16
	egen bcamme1 = rowmean(bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 ///
		bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16)
		
*Create new var that is the average across CAMs 1-19 (included at Waves 2 and 3)
*2019-11-20 cam17-19 not coded yet. Leave out for now
*	egen bcamme2 = rowmean(bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 ///
*		bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16 bcam17 bcam18 bcam19)
		
save, replace
```
		
#### Wave 3
```s
	use MIDUS3.dta, clear 

*Create new var that is the average across CAMs 1-16
	egen ccamme1 = rowmean(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ///
		ccam9 ccam10 ccam11 ccam12 ccam13 ccam14 ccam15 ccam16)
		
*Create new var that is the average across CAMs 1-19 (included at Waves 2 and 3) 
*2019-11-20 cam17-19 not coded yet. Leave out for now
*	egen ccamme2 = rowmean(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ///
*		ccam9 ccam10 ccam11 ccam12 ccam13 ccam14 ccam15 ccam16 ccam17 ccam18 ccam19)
		
save, replace
```

## THL Variables 

//Alcohol 

#### Wave 1

	use MIDUS1.dta, clear 

#### Wave 2

	use MIDUS2.dta, clear

#### Wave 3

	use MIDUS3.dta, clear 	

