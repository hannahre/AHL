

local dir "C:\Users\hanna\Documents\git\AHL\Stata\data-cleaning"
cd `dir'
*capture log close 
*log using MIDUS-recodes.txt, replace text

*version 13 
clear all 
set linesize 100
set more off 


*Coding set up: Code for each variable is shown together across waves (e.g. alcohol
	*coding for all waves is displayed together). 
	
*Variable naming conventions: 
	*Waves: each variable starts with a letter denoting the wave it belongs to 
	*	a=wave 1, b=wave2, 3=wave3
	

** Socieconomic Variables  

*** Income 

**** Wave 1

	use MIDUS1.dta, clear 
	* Check coding, skew, and kurtosis
	codebook A1SHHTOT
	sum A1SHHTOT, detail
	hist A1SHHTOT
	* Generate new variable - logged income 
	generate lnAHhInc = ln(A1SHHTOT)
	sum lnAHhInc, detail
	hist lnAHhInc
	notes lnAHhInc: original variable skewness 1.64 kurtosis 5.60
	notes lnAHhInc: logged variable skewness -1.03 kurtosis 5.77
	save, replace 


**** Wave 2

	use MIDUS2.dta, clear 
	* Check coding, skew, kurtosis
	codebook B1STINC1
	sum B1STINC1, detail
	hist B1STINC1 
	* Generate new variable - logged income
	generate lnbHhInc = ln(B1STINC1)
	sum lnbHhInc, detail
	hist lnbHhInc 
	notes lnbHhInc: original variable skewness 1.60 kurtosis 6.07
	notes lnbHhInc: logged variable skewness -1.37 kurtosis 6.81
	save, replace 


**** Wave 3 

	use MIDUS3.dta, clear 
	* Check coding, skewness, and kurtosis
	codebook C1STINC
	sum C1STINC, detail 
	hist C1STINC
	* Generate new variable - logged income 
	generate lnCHhInc = ln(C1STINC)
	sum lnCHhInc, detail
	hist lnCHhInc
	notes lnCHhInc: original variable skewness 1.24 kurtosis 4.08
	note lnCHhInc: logged variable skewness -1.37 kurtosis 5.73
	save, replace 


*** Education 

*Note on coding: "some graduate school" categorized with graduate/professional degree
	
	notes: Education variables "some graduate school" categorized with graduate/professional degree

**** Wave 1

	use MIDUS1.dta, clear
	tab A1PB1
	* Recode Education 
	recode A1PB1 (1/3 = 1) (4/5 = 2) (6/8 = 3) (9 = 4) (10/12 = 5) (97 = .) (. = .), gen(AEduc)
	label define education 1 "Less than High School" 2 "HS Diploma/GED" 3 "Some College/AA Degree" ///
		4 "College Grad" 5 "Graduate or Professional Degree"
	label values AEduc education
	tab A1PB1 AEduc, missing 
	save, replace


**** Wave 2 

	use MIDUS2.dta, clear
	tab B1PB1, missing
	* Recode Education 
	recode B1PB1 (1/3 = 1) (4/5 = 2) (6/8 = 3) (9 = 4) (10/12 = 5) (97 = .) (. = .), gen(bEduc)
	label define education 1 "Less than High School" 2 "HS Diploma/GED" 3 "Some College/AA Degree" ///
		4 "College Grad" 5 "Graduate or Professional Degree" 
	label values bEduc education
	tab B1PB1 bEduc, missing 
	save, replace 


**** Wave 3

	use MIDUS3.dta, clear 
	tab C1PB1,missing
	* Recode Education
	recode C1PB1 (1/3 = 1) (4/5 = 2) (6/8 = 3) (9 = 4) (10/12 = 5) (97/98 = .) (. = .), gen(CEduc)
	label define education 1 "Less than High School" 2 "HS Diploma/GED" 3 "Some College/AA Degree" ///
		4 "College Grad" 5 "Graduate or Professional Degree" 
	label values CEduc education
	tab C1PB1 CEduc, missing 
	save, replace 


** Health Locus of Control 

*** Self

**** Wave 1


**** Wave 2

	use MIDUS2.dta, clear
	tab B1SHLOCS, missing
	sum B1SHLOCS, detail
	* skew -2.02 kurtosis 9.5
	hist B1SHLOCS
	rename B1SHLOCS bHLOCS
	save, replace

**** Wave 3


** Controls  

*** Age

**** Wave 1
 
	use MIDUS1.dta, clear
	sum A1PRAGE_2019, detail
	rename A1PRAGE_2019 AAge
	save, replace

**** Wave 2

	use MIDUS2.dta, clear
	sum B1PAGE_M2, detail
	rename B1PAGE_M2 bAge 
	save, replace 

**** Wave 3

	use MIDUS3.dta, clear 
	sum C1PRAGE, detail
	rename C1PRAGE CAge
	save, replace


*** Race/Ethnicity

**** Wave 1

	use MIDUS1.dta, clear 
	tab A1SS7, missing
	recode A1SS7 (1 = 1) (2 = 2) (3/6 = 3) (. = .), gen(ARace)
	label define race 1 "White" 2 "Black" 3 "Other"
	label values ARace race
	tab A1SS7 ARace, missing 
	save, replace


**** Wave 2
 
	use MIDUS2.dta, clear
	tab B1PF1, missing
	tab B1PF7A, missing
	generate bRace = . 
		replace bRace = 1 if B1PF7A == 1 & B1PF1 == 1
		replace bRace = 2 if B1PF7A == 2 & B1PF1 == 1 
		replace bRace = 3 if B1PF1 != 1
		replace bRace = 4 if (B1PF7A >= 3) & (B1PF7A <= 6) & B1PF1 == 1
		replace bRace = . if B1PF7A == 7 | B1PF7A == 8
		replace bRace = . if B1PF1 == 97 | B1PF1 == 98
		replace bRace = . if missing(B1PF7A, B1PF1)
	label define race2 1 "Non-Hispanic White" 2 "Non-Hispanic Black" 3 ///
		"Mexican American and Other Hispanic" 4 "Other Race"
	label values bRace race2
	tab bRace B1PF7A, missing
	tab bRace B1PF1, missing
	*Checked with browse 
	save, replace 


**** Wave 3
 
	use MIDUS3.dta, clear
	tab C1PF1, missing
	tab C1PF7A, missing
	generate CRace = . 
		replace CRace = 1 if C1PF7A == 1 & C1PF1 == 1
		replace CRace = 2 if C1PF7A == 2 & C1PF1 == 1 
		replace CRace = 3 if C1PF1 != 1
		replace CRace = 4 if (C1PF7A >= 3) & (C1PF7A <= 6) & C1PF1 == 1
		replace CRace = . if C1PF7A == 7 | C1PF7A == 8
		replace CRace = . if C1PF1 == 97 | C1PF1 == 98
		replace CRace = . if missing(C1PF7A, C1PF1)
	label define race3 1 "Non-Hispanic White" 2 "Non-Hispanic Black" 3 ///
		"Mexican American and Other Hispanic" 4 "Other Race"
	label values CRace race3
	tab CRace C1PF7A, missing
	tab CRace C1PF1, missing
	*Checked with browse 
	save, replace

*** Sex

**** Wave 1

	use MIDUS1.dta, clear 
	tab A1PRSEX, missing
	recode A1PRSEX (1 = 0) (2 = 1), gen(ASex)
	label define sex 0 "Male" 1 "Female"
	label values ASex sex
	tab A1PRSEX ASex, missing
	save, replace


**** Wave 2

	use MIDUS2.dta, clear 
	tab B1PRSEX, missing
	recode B1PRSEX (1 = 0) (2 = 1), gen(bSex)
	label define sex2 0 "Male" 1 "Female"
	label values bSex sex2
	tab B1PRSEX bSex, missing
	save, replace


**** Wave 3

	use MIDUS3.dta, clear 
	tab C1PRSEX, missing
	recode C1PRSEX (1 = 0) (2 = 1), gen(CSex)
	label define sex3 0 "Male" 1 "Female"
	label values CSex sex3
	tab C1PRSEX CSex, missing
	save, replace


*** Religiosity

**** Wave 1

	use MIDUS1.dta, clear 
	* Check coding on all religious variables 
	foreach var in A1SR2A A1SR2D A1SR2F A1SR2G A1SR2H A1SR2I {
		codebook `var'
	}

	* Need to be reverse coded so 4 = very and 1 = not at all
	* Create local to act as a counter for generated religious vars. 
	local period = 1	
	* Write for loop - reverse code each religious variable
	* Define value labels to be used religious variable recodes 
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


**** Wave 2

	use MIDUS2.dta, clear
  	sum B1SRELID, detail
  	hist B1SRELID
  	rename B1SRELID bReligId
  	notes bReligId: For an item with a missing value, the mean value of completed items is imputed.
	notes bReligId: The scales are computed for cases that have valid values for at least half of the items on the particular scale. Scale scores are not calculated for cases with fewer than half of the items on the scales, and coded as “98” for “NOT CALCULATED (Due to missing data).”
  	save, replace


**** Wave 3

//Spirituality

**** Wave 1
	
**** Wave 2

	use MIDUS2.dta, clear 
	tab B1SSPIRI, missing
	hist B1SSPIRI
	rename B1SSPIRI bSpirit
	notes bSpirit: Same as bReligId
	save, replace


**** Wave 3

//Marital Status 
	
**** Wave 1

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


**** Wave 2

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


**** Wave 3

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


//Childhood SES 

**** Wave 1
	
**** Wave 2
	
**** Wave 3

//Health insurance 

**** Wave 1
***** Currently covered by health insurance 

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


**** Wave 2
***** Currently covered by health insurance 

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


**** Wave 3
**** Currently covered by health insurance 

	use MIDUS3.dta, clear
	tab C1SC1, missing
	recode C1SC1 (1 = 1) (2 = 0) (. = .), gen(cHlthIns)
	label variable cHlthIns "Currently covered by health insurance"
	label values cHlthIns hlthInVals
	tab cHlthIns C1SC1, missing

	save, replace


//Types of healthcare providers seen 
	
**** Wave 1
	
**** Wave 2
	
**** Wave 3


** CAM Variables 

*CAM associated with each var * across all waves
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
	*cam12	Prayer or other Spiritual practices 
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
		
*** CAM Co-Occurrence Indices  

**** Wave 1

	use MIDUS1.dta, clear 
	* Check coding and distribution of all cam variables 
		foreach var of varlist A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G ///
			A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O A1SA39P {
			fre `var'
		}
			
	* Write loop to dummy all CAM vars 0=never 1= used in the last year 
		*Create new variable that denotes wave and cam var *. 
		*Create local to act as a counter for generated acam vars. 
		local period=1	
		foreach var of varlist A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G ///
			A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O A1SA39P {
			recode `var' (1 = 1) (2 = 0) (. = .), gen(acam`period')
			tab `var' acam`period', missing
			local period=`period'+1
		}

	* Check missing value patterns on CAM dummies
		* Create local list of cams
		global acams "acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16"
		* Investigate missing data patterns on acams
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
		*tab A1SHHTOT aIncCat, missing

		* Create new variable, value = to number of missing values, excluding cases missing on 0 CAMs
		gen OnlyMissACams = MissACams if MissACams != 0
		* Check that above code ran correctly
		tab MissACams OnlyMissACams, missing

		* Missing on at least one CAM by continuous income variable 
		scatter OnlyMissACams A1SHHTOT

		* View distribution of missing values by income categories, increments of 25000, for all observations missing on at least one CAM
		tab OnlyMissACams aIncCat
		tab OnlyMissACams aIncCat, missing

		* Visualize distribution of missing values by 25000 income increments
		histogram OnlyMissACams, discrete by(aIncCat) freq

		notes: There are 260 observations missing at least one CAM with a nonmissing income value. 
		notes: 790 obs missing on all 16 CAMs and missing on the income variable. 
		notes: 192 obs missing on income with no missing CAMs.

	* Relationship between missing values on CAMs and Education 

// CAM16 - other nontraditional therapy. Fill in with coded text data. 
	tab1 A1SA39PA A1SA39PB A1SA39PC A1SA39PD

	foreach var of varlist A1SA39PA A1SA39PB A1SA39PC A1SA39PD {
		tab `var' acam16, missing
	}
		
	* Check missing value patterns on CAMs without CAM16
	* Create local list of cams
	global acams "acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15"
	* Investigate missing data patterns on bcams
	mdesc $acams if A1STATUS == 2
	notes: less than 1% missing on each CAM for respondents who completed both phone and SAQ
	mdesc $acams if A1STATUS == 1
	notes: only included in SAQ; all obs missing on CAMs that only completed the phone interview
	mvpatterns $acams if A1STATUS == 2
	* Create newvar = number of missing values on bcams 
	egen MissACams2=rmiss2($acams) if A1STATUS == 2
	tab MissACams2
	notes: 97.33% of SAQ sample are complete cases.

	* Cross-reference CAM16 reponses with appropriate CAMs
	* First of four coded text variables. 
	tab A1SA39PA

	* Write program to cross-reference cam16 responses and other cams, and reassign values correctly.
	capture program drop othercam
	program define othercam
		list M2ID `1' `2' if `3'
		replace `1' = 1 if `3'
		list M2ID `1' `2' if `3'
	end
	* Run othercam program on reiki responses
	othercam acam4 A1SA39PA "A1SA39PA == 1"
	* Run othercam program on prayer/church
	othercam acam12 A1SA39PA "A1SA39PA == 3"
	* Run othercam program on exercise/movement therapy 
	othercam acam5 A1SA39PA "A1SA39PA == 4"
	* Special diet
	othercam acam14 A1SA39PA "A1SA39PA == 5"
	* Vitamins 
	othercam acam7 A1SA39PA "A1SA39PA == 6"
	notes A1SA39PA: 12 = muscle related therapy. No clear alignment with another CAM. No changes. 
	* Meditation techniques
	othercam acam13 A1SA39PA "A1SA39PA == 14"
	notes A1SA39PA: 17 = other, 18 = artwork, 19 = bone related therapy, 21 = positive mindset. No clear alignment with other CAMs. No changes made. 

	tab A1SA39PB
	* Prayer/church 
	othercam acam12 A1SA39PB "A1SA39PB == 3"
	* Exercise/movement related therapy
	othercam acam5 A1SA39PB "A1SA39PB == 4"
	* Meditation techniques
	othercam acam13 A1SA39PB "A1SA39PB == 14"
	notes A1SA39PB: 17 = other, 18 = artwork, 19 = bone related therapy, 21 = positive mindset. No clear alignment with other CAMs. No changes made. 

	tab1 A1SA39PC 
	notes A1SA39PC: only 1 observation reported other. No changes made. 

	tab A1SA39PD
	* Only one observation. 
	* Meditation techniques
	othercam acam13 A1SA39PD "A1SA39PD == 14"


// CAM21 : Combine prayer and spiritual healing into cam21 
	* acam12 = prayer, acam15 = spiritual healing 
	gen acam21 = .
		replace acam21 = 0 if acam12 == 0 & acam15 == 0
		replace acam21 = 0 if acam12 == 0 & acam15 == .
		replace acam21 = 0 if acam12 == . & acam15 == 0
		replace acam21 = 1 if acam12 == 1 & acam15 == 0
		replace acam21 = 1 if acam12 == 0 & acam15 == 1
		replace acam21 = 1 if acam12 == . & acam15 == 1
		replace acam21 = 1 if acam12 == 1 & acam15 == .
		replace acam21 = 1 if acam12 == 1 & acam15 == 1
	tab acam21, missing
	* Create variable to store all patterns of responses for acam12 and acam15 to be sure acam21 was coded correctly
	* Only cases missing on both should be coded as missing. If respondents are missing on one var but not the other, the 
	* case should be coded as the highest value. 
	egen acam21pattern = concat(acam12 acam15) 
	tab acam21pattern, missing
	* Coded correctly. 

	*Create count variable (sum of CAMs)
	* Removing CAM16 because it is fill in the blank. 
		egen aCamCo1 = rowtotal(acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 ///
			acam11 acam12 acam13 acam14 acam15), missing

		* Examine new count variable 
		tab aCamCo1, missing
		hist aCamCo1

		save, replace

	
**** Wave 2 

	use MIDUS2.dta, clear

	*Display coding and distribution of all cam variables 
		foreach var of varlist B1SA56A B1SA56B B1SA56C B1SA56D B1SA56F B1SA56G B1SA56H B1SA56I ///
			B1SA56J B1SA56K B1SA56L B1SA56M B1SA56N B1SA56Q B1SA56R B1SA56S {
			fre `var' 
		}

	*Write loop to dummy all CAM vars 0=never 1= used in the last year 
		*Create new variable that denotes wave and cam var *. 
		*Create local to act as a counter for generated acam vars. 
		local period=1	
		foreach var of varlist B1SA56A B1SA56B B1SA56C B1SA56D B1SA56F B1SA56G B1SA56H B1SA56I ///
			B1SA56J B1SA56K B1SA56L B1SA56M B1SA56N B1SA56Q B1SA56R B1SA56S B1SA56E B1SA56O B1SA56P {
			recode `var' (1/4= 1) (5 = 0) (. = .), gen(bcam`period')
			tab `var' bcam`period', missing
			local period=`period'+1
		}

	tab1 bcam17 bcam18 bcam19
	
	* Combine physician prescribed diet (cam18) and weight control diet (cam19) with special diet (cam14)
		* Crosstab: Special diet and physician prescribed
		tab bcam14 bcam18, missing
		* 3128 are missing on both. 62 obs report yes on both. 618 report yes on physician prescribed only and 108 report yes on special diet only. 
		* 11 missing on special only, 15 missing on physician prescribed only. 
		* Crosstab: Special diet and weight control 
		tab bcam14 bcam19, missing
		* 3124 missing on both. 15 missing on special diet only. 2 missing on weight control only. 
		* 64 yes on both. 828 yes on weight control only. 108 yes on special diet only. 
		
		* Replace statement for bcam18- physician prescibed diet 
		replace bcam14 = 1 if bcam18 == 1
		tab bcam14 bcam18, missing
		* Replace statemtn for bcam19- weight control diet 
		replace bcam14 = 1 if bcam19 == 1
		tab bcam14 bcam19, missing
		
// CAM21 : Combine prayer and spiritual healing into cam21 
	* bcam12 = prayer, bcam15 = spiritual healing 
	gen bcam21 = .
		replace bcam21 = 0 if bcam12 == 0 & bcam15 == 0
		replace bcam21 = 0 if bcam12 == 0 & bcam15 == .
		replace bcam21 = 0 if bcam12 == . & bcam15 == 0
		replace bcam21 = 1 if bcam12 == 1 & bcam15 == 0
		replace bcam21 = 1 if bcam12 == 0 & bcam15 == 1
		replace bcam21 = 1 if bcam12 == . & bcam15 == 1
		replace bcam21 = 1 if bcam12 == 1 & bcam15 == .
		replace bcam21 = 1 if bcam12 == 1 & bcam15 == 1
	tab bcam21, missing
	* Create variable to store all patterns of responses for bcam12 and bcam15 to be sure bcam21 was coded correctly
	* Only cases missing on both should be coded as missing. If respondents are missing on one var but not the other, the 
	* case should be coded as the highest value. 
	egen bcam21pattern = concat(bcam12 bcam15) 
	tab bcam21pattern, missing
	* Coded correctly. 
		
		* When I realized the mistake. The code above fixes this.: If respondent is missing on only one var, 
		* they should be recorded as their response of the other var
		* whether they report yes or no. For example, if missing on prayer and no on spiritual healing, they 
		* should be no on the combined variable. Below is a statement to address this. 
		* replace bcam12 = 0 if bcam12 == 0 & bcam15 == .

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

		* Scatter - * of missing values by income 
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
		*tab B1STINC1 bIncCat, missing

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

// CAM16 - other nontraditional therapy. Fill in with coded text data. 
	tab1 B1SA56SAO B1SA56SBO

	foreach var of varlist B1SA56SAO B1SA56SBO {
		tab `var' bcam16, missing
	}
		
	* Check missing value patterns on CAMs without CAM16
	* Create local list of cams
	global bcams "bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15"
	* Investigate missing data patterns on bcams
	mdesc $bcams if B1STATUS == 2
	notes: about 1.5-2% of SAQ&phone cases missing on any given CAM
	mdesc $bcams if B1STATUS == 1
	notes: all phone only cases missing on all CAMs
	mvpatterns $bcams if B1STATUS == 2
	* Create newvar = number of missing values on bcams 
	egen Missbcams=rmiss2($bcams) if B1STATUS == 2
	tab Missbcams
	notes: 94.7% of all cases complete. 
	* How many biomarker respondents are complete cases on CAMs. 
	tab MissBCams B4ZSITE, missing
	
	* Many observations gave responses to the "other CAM used" question that matched previously listed CAMs.
	* For example, writing in meditation under "other" even though it was an option. 
	* Whether observations also answered "yes" to the appropriate CAM varies. 
	* Write program to cross-reference cam16 responses and other cams, and assign "yes" responses to one of the 15 main CAMs if appropriate.
	capture program drop othercam
	program define othercam
		list M2ID `1' `2' if `3'
		replace `1' = 1 if `3'
		list M2ID `1' `2' if `3'
	end

	* There are two "other cam" variables that contain written responses. Presumably some observations listed more than one. 
	tab B1SA56SAO
	* Acupressure 
	othercam bcam1 B1SA56SAO "B1SA56SAO == 110"
	* Diet 
	othercam bcam14 B1SA56SAO "B1SA56SAO == 114"
	* Exercise 
	othercam bcam5 B1SA56SAO "B1SA56SAO == 116"
	* Herbal Therapy 
	othercam bcam6 B1SA56SAO "B1SA56SAO == 117"
	* Prayer/spiritual practices
	othercam bcam12 B1SA56SAO "B1SA56SAO == 120"
	* Spiritual healing by others 
	othercam bcam15 B1SA56SAO "B1SA56SAO == 121"
	* Reiki (energy healing)
	othercam bcam4 B1SA56SAO "B1SA56SAO == 122"
	* Relaxation/meditation 
	othercam bcam13 B1SA56SAO "B1SA56SAO == 123"
	* No other suitable CAM to assign 1 to: aromatherapy, cranial therapy, cranialsacral, cardic rehab,
	* magnetics, taking supplements, self made program, others. 

	tab B1SA56SBO
	* Energy healing
	othercam bcam4 B1SA56SBO "B1SA56SBO == 115"
	* Exercise
	othercam bcam5 B1SA56SBO "B1SA56SBO == 116"
	* Did not reassign "taking supplments" observations, though this could potentially fall under taking vitamins. 
	
	
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

		
**** Wave 3 

	use MIDUS3.dta, clear

*Display coding and distribution of all cam variables 
	foreach var of varlist C1SA52A C1SA52B C1SA52C C1SA52D C1SA52F C1SA52G C1SA52H C1SA52I C1SA52J ///
		C1SA52K C1SA52L C1SA52M C1SA52N C1SA52Q C1SA52R C1SA52S C1SA52E C1SA52O C1SA52P {
		fre `var' 
	}

*Write loop to dummy all CAM vars 0=never 1= used in the last year 
	*Create new variable that denotes wave and cam var *. 
	*Create local to act as a counter for generated acam vars. 
	local period=1	
	foreach var of varlist C1SA52A C1SA52B C1SA52C C1SA52D C1SA52F C1SA52G C1SA52H C1SA52I C1SA52J C1SA52K ///
	C1SA52L C1SA52M C1SA52N C1SA52Q C1SA52R C1SA52S C1SA52E C1SA52O C1SA52P {
		recode `var' (1/4= 1) (5 = 0) (. = .), gen(ccam`period')
		tab `var' ccam`period', missing
		local period=`period'+1
	}

	tab1 ccam17 ccam18 ccam19
	
	* Combine physician prescribed diet (cam18) and weight control diet (cam19) with special diet (cam14)
		* Crosstab: Special diet and physician prescribed
		tab ccam14 ccam18, missing
		* 484 respondents report only using a physician prescribed diet. They will be added to the yes column on special diet. 
		* Crosstab: Special diet and weight control 
		tab ccam14 ccam19, missing
		* 354 respondents report only using a weight control diet. They will be added to the yes column on special diet. 
		
		* Replace statement for ccam18- physician prescibed diet 
		replace ccam14 = 1 if ccam18 == 1
		tab ccam14 ccam18, missing
		* Replace statemtn for bccam19- weight control diet 
		replace ccam14 = 1 if ccam19 == 1
		tab ccam14 ccam19, missing
		
// CAM21 : Combine prayer and spiritual healing into cam21 
	* ccam12 = prayer, ccam15 = spiritual healing 
	gen ccam21 = .
		replace ccam21 = 0 if ccam12 == 0 & ccam15 == 0
		replace ccam21 = 0 if ccam12 == 0 & ccam15 == .
		replace ccam21 = 0 if ccam12 == . & ccam15 == 0
		replace ccam21 = 1 if ccam12 == 1 & ccam15 == 0
		replace ccam21 = 1 if ccam12 == 0 & ccam15 == 1
		replace ccam21 = 1 if ccam12 == . & ccam15 == 1
		replace ccam21 = 1 if ccam12 == 1 & ccam15 == .
		replace ccam21 = 1 if ccam12 == 1 & ccam15 == 1
	tab ccam21, missing
	* Create variable to store all patterns of responses for ccam12 and ccam15 to be sure ccam21 was coded correctly
	* Only cases missing on both should be coded as missing. If respondents are missing on one var but not the other, the 
	* case should be coded as the highest value. 
	egen ccam21pattern = concat(ccam12 ccam15) 
	tab ccam21pattern, missing
	* Coded correctly. 

	* Check missing patterns
		* Create local list of cams
		global ccams "ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ccam9 ccam10 ccam11 ccam12 ccam13 ccam14 ccam15 ccam16"
		* Investigate missing data patterns on bcams
		mdesc $ccams
		mvpatterns $ccams
		* Create newvar = number of missing values on bcams 
		egen MissCCams=rmiss2($ccams)
		tab MissCCams, missing

// CAM16 - other nontraditional therapy. Fill in with coded text data. 
	tab1 C1SA52SA C1SA52SB
		
	* Check missing value patterns on CAMs without CAM16
	* Create local list of cams
	global ccams "ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ccam9 ccam10 ccam11 ccam12 ccam13 ccam14 ccam15"
	* Investigate missing data patterns on ccams
	mdesc $ccams if C1STATUS > 2 & C1STATUS != .
	notes: 
	mdesc $ccams if C1STATUS <= 2 & C1STATUS != .
	notes: 
	mvpatterns $ccams if C1STATUS 
	* Create newvar = number of missing values on ccams 
	egen Missccams=rmiss2($ccams) if C1STATUS > 2 & C1STATUS != .
	tab Missccams
	
	* Write program to cross-reference cam16 responses and other cams, and assign "yes" responses to one of the 15 main CAMs if appropriate.
	capture program drop othercam
	program define othercam
		list M2ID `1' `2' if `3'
		replace `1' = 1 if `3'
		list M2ID `1' `2' if `3'
	end

	tab C1SA52SA 
	* Spiriual practice/ reiki - assign yes on energy healing 
	othercam ccam4 C1SA52SA "C1SA52SA == 1"
	* Prayer/church 
	othercam ccam12 C1SA52SA "C1SA52SA == 3"
	* Exercise or movement therapy
	othercam ccam5 C1SA52SA "C1SA52SA == 4"
	* Special diet 
	othercam ccam14 C1SA52SA "C1SA52SA == 5"
	* Vitamins 
	othercam ccam7 C1SA52SA "C1SA52SA == 6"
	* herbal therapy 
	othercam ccam6 C1SA52SA "C1SA52SA == 8"
	* No suitable main CAMs to assign yes to: essential oil, music/television, muscle related therapy,  
	* other, artwork, bone related therapy, positive mindset. 

	tab C1SA52SB
	* Exercise or movement therapy 
	othercam ccam5 C1SA52SB "C1SA52SB == 4"
	* Herbal therapy 
	othercam ccam6 C1SA52SB "C1SA52SB == 8"
	* Acupressure 
	othercam ccam1 C1SA52SB "C1SA52SB == 22" 

*Create co-occurrence index 1 
	egen ccamco1 = rowtotal(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ccam9 ccam10 ccam11 ccam12 ccam13 ///
		ccam14 ccam15 ccam16), missing
		
*Create co-occurrence index 2 
*2019-11-20 cam17-19 not coded yet. Leave out for now
*	egen ccamco2 = rowtotal(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ccam9 ccam10 ccam11 ccam12 ccam13 ///
*		ccam14 ccam15 ccam16 ccam17 ccam18 ccam19), missing

	save, replace


*** CAM Index - with frequency variables 

* Above co-occurrence index uses dummy indicators. 
* Create new index for waves 2 and 3 that use the original ordinal frequency indicators 

**** Wave 2 

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


*** CAM LCA 


* Insert call for LCA do-file. 


***CAM Mean Indices  

**** Wave 1

	use MIDUS1.dta, clear

*Create new var that is the average across all CAMs 
	egen acamme1 = rowmean(acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 ///
		acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16)
*Check that egen ran correctly 
	capture assert acamme1 == (acam1 + acam2 + acam3 + acam4 + acam5 + acam6 + acam7 + ///
		acam8 + acam9 + acam10 + acam11 + acam12 + acam13 + acam14 + acam15 + acam16)/16
	*252 false- missing on one or more cams. 
	
save, replace

	
**** Waves 2

	use MIDUS2.dta, clear 

*Create new var that is the average across CAMs 1-16
	egen bcamme1 = rowmean(bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 ///
		bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16)
		
*Create new var that is the average across CAMs 1-19 (included at Waves 2 and 3)
*2019-11-20 cam17-19 not coded yet. Leave out for now
*	egen bcamme2 = rowmean(bcam1 bcam2 bcam3 bcam4 bcam5 bcam6 bcam7 bcam8 ///
*		bcam9 bcam10 bcam11 bcam12 bcam13 bcam14 bcam15 bcam16 bcam17 bcam18 bcam19)
		
save, replace

		
**** Wave 3

	use MIDUS3.dta, clear 

*Create new var that is the average across CAMs 1-16
	egen ccamme1 = rowmean(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ///
		ccam9 ccam10 ccam11 ccam12 ccam13 ccam14 ccam15 ccam16)
		
*Create new var that is the average across CAMs 1-19 (included at Waves 2 and 3) 
*2019-11-20 cam17-19 not coded yet. Leave out for now
*	egen ccamme2 = rowmean(ccam1 ccam2 ccam3 ccam4 ccam5 ccam6 ccam7 ccam8 ///
*		ccam9 ccam10 ccam11 ccam12 ccam13 ccam14 ccam15 ccam16 ccam17 ccam18 ccam19)
		
save, replace


** THL Variables 

//Alcohol 

**** Wave 1

	use MIDUS1.dta, clear 

**** Wave 2

	use MIDUS2.dta, clear

**** Wave 3

	use MIDUS3.dta, clear 	

//Smoking 

**** Wave 1
	use MIDUS1.dta, clear 
	tab A1PA40 A1PA43, missing
	* Create new variable with 3 categories: nonsmoker, current smoker, and exsmoker. 
	generate aSmoke = .
		replace aSmoke = 1 if A1PA40 == 2
		replace aSmoke = 1 if A1PA43 == 2
		replace aSmoke = 2 if A1PA43 == 1 
		replace aSmoke = 3 if A1PA40 == 1 & A1PA43 == 2
	tab aSmoke, missing
	* Check recode 
	tab aSmoke A1PA40, missing 
	tab aSmoke A1PA43, missing
	
	save, replace 
		
	
// Delimit sample to cases not missing on variables in model. 
	mark nomiss
	markout nomiss aHlthIns aMarried ASex ARace aRelig6 aRelig5 aRelig4 aRelig3 aRelig2 aRelig1 lnAHhInc AEduc A1SBMI A1SCHRON A1SHLOCO A1SHLOCS AAge A1PA4 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15
	tab nomiss
	
	notes: n = 5326 when including health insurance, marital status, religious vars, sex, race, income, educ, bmi, chronic conditions, LOC vars, age, subjective health, and cams.
		
	mark nomiss2
	markout nomiss2 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15
	tab nomiss2
	
	notes: 6157 complete cases on CAMs
	
	mark nomiss3
	markout nomiss3 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 lnAHhInc AEduc ASex
	tab nomiss3
	
	notes: n = 5799 with CAMs, income, education, and gender 

	mark nomiss4
	markout nomiss4 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 lnAHhInc AEduc ASex aMarried ARace AAge
	tab nomiss4

	notes:n = 5712 when adding marital status, race, and age. Only lose 87 cases. 
	
	mark nomiss5
	markout nomiss5 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 lnAHhInc AEduc ASex aMarried ARace AAge aHlthIns A1SHLOCO A1SHLOCS
	tab nomiss5

	notes: n = 5629 when adding health insurance and health locus of control. 
	
	mark nomiss6
	markout nomiss6 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 lnAHhInc AEduc ASex aMarried ARace AAge aHlthIns A1SHLOCO A1SHLOCS A1SBMI A1SCHRON A1PA4
	tab nomiss6
	
	notes: n = 5408 when adding health outcomes. 
	notes: retain 76% of original cases (7108)
	notes: with religous variables retain about 75% of cases. 
	
	keep if nomiss == 1
	save MIDUS1-complete.dta, replace

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	