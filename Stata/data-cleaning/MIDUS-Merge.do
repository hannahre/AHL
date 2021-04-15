local dir "C:\Users\hanna\Documents\git\AHL\Stata"
cd `dir'
capture log close 
log using MIDUS-merge.txt, replace text

version 13 
clear all 
set linesize 100
set more off 
set maxvar 32767

//Project: Dissertation AHL 
//Created by: Hannah Andrews
//Date: 07/23/18
//Task: All data cleaning tasks. 
	//Part 1: Merge data within each wave 
	//Part 2: Coding variables 
	//Part 3: Merge data across waves (note combinations here) 

////////////////////////////////////////////////////////////////////////////////
**PART 1: Merge data within each wave 
////////////////////////////////////////////////////////////////////////////////

********************************************************************************
//MIDUS 1 (ICPSR 02760)
********************************************************************************
//Files to be merged: Folder MIDUS 1 includes DS001 (DATASET 0001: MAIN, SIBLINGS AND TWIN DATA) 
//DS004 (DATASET 0004: TWIN SCREENER DATA) and DS005 (DATASET 0005: CODED TEXT DATA) 
//For each (DS001 DS004 DS005) open, sort M2ID, do supplemental syntax (comes with raw data files
	//from ICPSR; replaces user-defined numeric missing values (e.g., -9) with generic 
	//system missing "."), save as MIDUS1A, MIDUS1B, MIDUS1C. 

*DS001: Main, Siblings, Twin Data 
	use 	 	MIDUS1\DS0001\02760-0001-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS1\DS0001\02760-0001-Supplemental_syntax.do 
	keep		M2ID M2FAMNUM SAMPLMAJ A1STATUS A1PRSEX A1PAGE_M2 A1SS7 A1PB17 A1PA5 A1PANHED ///
				A1PDEPAF A1PDEPRE A1PANXIE A1PPANIC A1SR1 A1SR1A A1SR2A ///
				A1SR2B A1SR2C A1SR2D A1SR2E A1SR2F A1SR2G A1SR2H ///
				A1SR2I A1SR4 A1SR3 A1SR8 A1SR5 A1SR6 A1SHLOCS ///
				A1SHLOCO A1SC1A A1SC1B A1SC1C A1SC1D A1SC1E A1SC1F ///
				A1SC1G A1SC1H A1SUSEMD A1SA37A A1SA37B A1SA37C A1SA37D ///
				A1SUSEMH A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F ///
				A1SA39G A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M ///
				A1SA39N A1SA39O A1SA39P A1SA18 A1SA19 A1SVIGOR A1SA20 ///
				A1SA21 A1SMODER A1PA41 A1PA40 A1PA42 A1PA43 A1PA45 ///
				A1PA53 A1PA53A A1PA54 A1PA54A A1PA55 A1PA56 A1SJ8 ///
				A1SJ9 A1SHHTOT A1SJ11 A1SJ12 A1SJ7 A1SJ14 A1SJ15 ///
				A1SI14 A1SJCDA A1POCC A1PIND A1POCMJ A1PINMJ A1PTSEI ///
				A1PB31 A1POCCS A1PINDS A1POCSMJ A1PINSMJ A1PTSEIS A1PB1 ///
				A1PB27 A1PA4 A1SA9A A1SA9B A1SA9C A1SA9D A1SA9E ///
				A1SA9F A1SA9G A1SA9H A1SA9I A1SA9J A1SA9K A1SA9L ///
				A1SA9M A1SA9N A1SA9O A1SA9P A1SA9Q A1SA9R A1SA9S ///
				A1SA9T A1SA9U A1SA9V A1SA9W A1SA9X A1SA9Y A1SA9Z ///
				A1SA9AA A1SA9BB A1SA9CC A1SCHRON A1SCHROX A1SBMI
	save 		MIDUS1\DS0001\MIDUS1A.dta, replace 

* DS002: Daily diary data 
	use 	 	MIDUS1\DS0002\03725-0001-Data, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS1\DS0002\03725-0001-Supplemental_syntax.do 
	keep 		M2ID A2DB8 A2DB9 A2DDAY

	* Dairy data is long form. Reshape to wide. Create new variables for each interview day representing cig and alc consumption per day (8 days).
	reshape wide A2DB8 A2DB9, i(M2ID) j(A2DDAY)

	* Create new variable that represents average cigarette consumption over 8 days. 
	
	* First, check missing data patterns- will I need to impute values? 
	preserve
	
	* Create global list of religious variables 
	global aCigVars "A2DB81 A2DB82 A2DB83 A2DB84 A2DB85 A2DB86 A2DB87 A2DB88"
	* Investigate missing data patterns on aCigVars
	mdesc $aCigVars
	mvpatterns $aCigVars
	* Create newvar = number of missing values on aCigVars
	egen MissaCigVars=rmiss2($aCigVars)
	tab MissaCigVars, missing
	
	* 62% missing on day 1. 75% to 78% missing on days 2 through 8. 
	* Can't use. 

	* Check missing values on alcohol variables. 

	* Create global list of religious variables 
	global aAlcVars "A2DB91 A2DB92 A2DB93 A2DB94 A2DB95 A2DB96 A2DB97 A2DB98"
	* Investigate missing data patterns on aCigVars
	mdesc $aAlcVars
	mvpatterns $aAlcVars
	* Create newvar = number of missing values on aCigVars
	egen MissaAlcVars=rmiss2($aAlcVars)
	tab MissaAlcVars, missing

	* 21.48% missing on day 1. 36-39% missing on days 2 through 8. 

	restore


*DS004: Twin Screener Data
*	use			MIDUS1\DS0004\02760-0004-Data.dta, clear 
*	sort		M2ID
*	describe, s
*	quietly do 	MIDUS1\DS0004\02760-0004-Supplemental_syntax.do
*	save 		MIDUS1\DS0004\MIDUS1B.dta, replace 

*DS005: Coded text data 
*	use 		MIDUS1\DS0005\02760-0005-Data.dta, clear
*	sort 		M2ID
*	describe, s
*	quietly do	MIDUS1\DS0005\02760-0005-Supplemental_syntax.do 
*	save		MIDUS1\DS0005\MIDUS1C.dta, replace

//Merge MIDUS1B and MIDUS1C to MIDUS1A, save as MIDUS1
//Check Merge
	//MIDUS1A obs = 7,108 vars = 2,098
	//MIDUS1B obs = 1,914 vars = 90 
	//MIDUS1C obs = 3,950 vars = 82 
	
*Merge MIDUS1B (using) to MIDUS1A (master), save as MIDUS1 	
*	use 		MIDUS1\DS0001\MIDUS1A.dta
*	merge 		1:1 M2ID using MIDUS1\DS0004\MIDUS1B.dta
*	describe, s
*	rename 		_merge merge1
*	label var 	merge1 "Merge MIDUS1B (using) to MIDUS1A (master)"
*	save		MIDUS1\MIDUS1.dta, replace 

*Merge MIDUS1C (using) to MIDUS1 (master), save as MIDUS1 in data cleaning folder
*	use 		MIDUS1\MIDUS1.dta, clear	
*	merge 		1:1 M2ID using MIDUS1\DS0005\MIDUS1C.dta
*	describe, s
*	rename 		_merge merge2
*	label var 	merge2 "Merge MIDUS1C (using) to product of A+B (master)"
*	save		data-cleaning\MIDUS1.dta, replace 




	clear 
********************************************************************************
//MIDUS 2 (ICPSR 04652) 
********************************************************************************
//Files to be merged: Folder MIDUS 2 includes DS001(DATASET 0001: M2_P1_AGGREGATE DATA) 
	//DS002(DATASET 0002: M2_P1_DISPOSITION CODES) DS003(Survey Weights) 
	//DS004(DATASET 0004: M2_P1_CODED TEXT DATA) 
//For each (DS001 DS002 DS004)open, sort M2ID, do supplemental syntax (comes with raw data files
	//from ICPSR; replaces user-defined numeric missing values (e.g., -9) with generic 
	//system missing "."), save as MIDUS2A MIDUS2B MIDUS2D
	//DS003 (weights) does not have supplemental syntax. Open, sort by M2ID and save as MIDUS2C 

*DS001: Aggregate Data 
	use 		MIDUS2\DS0001\04652-0001-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS2\DS0001\04652-0001-Supplemental_syntax.do 
	save 		MIDUS2\DS0001\MIDUS2A.dta, replace 

*DS002: Disposition Codes 
	use			MIDUS2\DS0002\04652-0002-Data.dta, clear 
	sort		M2ID
	describe, s
	quietly do 	MIDUS2\DS0002\04652-0002-Supplemental_syntax.do
	save 		MIDUS2\DS0002\MIDUS2B.dta, replace 

*DS003: Survey Weights  
	use 		MIDUS2\DS0003\04652-0003-Data.dta, clear
	sort 		M2ID
	describe, s
	save		MIDUS2\DS0003\MIDUS2C.dta, replace
	
*DS004: Coded Text Data 
	use			MIDUS2\DS0004\04652-0004-Data.dta, clear 
	sort		M2ID
	describe, s
	quietly do 	MIDUS2\DS0004\04652-0004-Supplemental_syntax.do
	save 		MIDUS2\DS0004\MIDUS2D.dta, replace 

//Merge MIDUS2B MIDUS2C MIDUS2D to MIDUS2A, save as MIDUS2
//Check Merge
	//MIDUS2A obs = 4,963 vars = 2,279
	//MIDUS2B obs = 7,108 vars = 12
	//MIDUS2C obs = 2,257 vars = 11
	//MIDUS2D obs = 4,963 vars = 142
	
*Merge MIDUS2B (using) to MIDUS2A (master), save as MIDUS2 	
	use 		MIDUS2\DS0001\MIDUS2A.dta
	merge 		1:1 M2ID using MIDUS2\DS0002\MIDUS2B.dta
	describe, s
	rename 		_merge merge3
	label var 	merge3 "Merge MIDUS2B (using) to MIDUS2A (master)"
	save		MIDUS2\MIDUS2P1.dta, replace 

*Merge MIDUS2C (using) to MIDUS2 (master), save as MIDUS2
	use 		MIDUS2\MIDUS2P1.dta, clear	
	merge 		1:1 M2ID using MIDUS2\DS0003\MIDUS2C.dta
	describe, s
	rename 		_merge merge4
	label var 	merge4 "Merge MIDUS2C (using) to product of A+B (master)"
	save		MIDUS2\MIDUS2P1.dta, replace 

*Merge MIDUS2D (using) to MIDUS2 (master), save as MIDUS2
	use 		MIDUS2\MIDUS2P1.dta, clear	
	merge 		1:1 M2ID using MIDUS2\DS0004\MIDUS2D.dta
	describe, s
	rename 		_merge merge5
	label var 	merge5 "Merge MIDUS2D (using) to product of A+B+C (master)"
	save		MIDUS2\MIDUS2P1.dta, replace

	describe	using MIDUS2\MIDUS2P1.dta, s
	
	clear
********************************************************************************
//MIDUS 2 Biomarker (ICPSR 29282) 
********************************************************************************
//Files to be merged: Folder MIDUS 2 Biomarker includes DS001(DATASET 0001: AGGREGATED DATA) 
	//DS002(DATASET 0002: STACKED MEDICATION DATA) 
//For each (DS001 DS002) open, sort by M2ID, do suppmental syntax (comes with raw data files
	//from ICPSR; replaces user-defined numeric missing values (e.g., -9) with generic 
	//system missing "."), save as MIDUS2BIOA, MIDUS2BIOB

*DS001: Aggregate Data 
	use			MIDUS2-Biomarker\DS0001\29282-0001-Data.dta, clear 
	sort		M2ID
	describe, s
	quietly do 	MIDUS2-Biomarker\DS0001\29282-0001-Supplemental_syntax.do
	*201 observations from the milwaukee sample (not included in the main sample 
		*but were part of the biomarker project. 
	drop 		if SAMPLMAJ==13
	describe, s
	save 		MIDUS2-Biomarker\DS0001\MIDUS2BIOA.dta, replace 

********************************************************************************
	///MIDUS2 Biomarker Stacked Medication data- M2ID does not uniquely identify observations. 
	///Because I am not using the medication data as of today (07/24/19)I just won't merge it. 
	
*DS002: Stacked Medication Data  
*	use			MIDUS2-Biomarker\DS0002\29282-0002-Data.dta, clear 
*	sort		M2ID
*	describe, s
*	quietly do 	MIDUS2-Biomarker\DS0002\29282-0002-Supplemental_syntax.do
*	save 		MIDUS2-Biomarker\DS0002\MIDUS2BIOB.dta, replace 

//Merge MIDUS2BIOB (using) to MIDUS2BIOA (master), save as MIDUS2BIO
//Check Merge
	//MIDUS2BIOA obs = vars = 
	//MIDUS2BIOB obs = vars =
		
*	use 		MIDUS2-Biomarker\DS0001\MIDUS2BIOA.dta
*	merge 		1:1 M2ID using MIDUS2-Biomarker\DS0002\MIDUS2BIOB.dta
*	describe, s
*	rename 		_merge merge?
*	label var 	merge? "Merge MIDUS2BIOB (using) to MIDUS2BIOA (master)"
*	save		MIDUS2-Biomarker\MIDUS2BIO.dta, replace 
********************************************************************************

//Merge MIDUS2BIOA (using) to MIDUS2P1 (master). Save as MIDUS2 in data-cleaning folder. 
//Check Merge	
	//MIDUS2BIOA obs = 1,054 vars = 3,228
	//MIDUS2P1	 obs = 7,108 vars = 2,437
	
	use 		MIDUS2\MIDUS2P1.dta, clear
	merge 		1:1 M2ID using MIDUS2-Biomarker\DS0001\MIDUS2BIOA.dta
	describe, s
	rename 		_merge merge6
	label var 	merge6 "Merge MIDUS2BIOA (using) to MIDUS2P1 (master)"
	save		data-cleaning\MIDUS2.dta, replace 
	
	describe 	using data-cleaning\MIDUS2.dta, s

	clear 
********************************************************************************
//MIDUS 3 (ICPSR 36346) 
********************************************************************************
//Files to be merged: Folder MIDUS 3 contains DS001(DATASET 0001: AGGREGATE DATA) 
	//DS002 (DATASET 0002: DISPOSITION CODES) DS003 (DATASET 0003: CODED TEXT DATA) 
//For each (DS001 DS002 DS003) open, sort M2ID, do supplemental syntax(comes with raw data files
	//from ICPSR; replaces user-defined numeric missing values (e.g., -9) with generic 
	//system missing "."), save as MIDUS3A MIDUS3B MIDUS3C

*DS001: Aggregate Data 
	use 		MIDUS3\DS0001\36346-0001-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS3\DS0001\36346-0001-Supplemental_syntax.do 
	save 		MIDUS3\DS0001\MIDUS3A.dta, replace 

*DS002: Disposition Codes 
	use			MIDUS3\DS0002\36346-0002-Data.dta, clear 
	sort		M2ID
	describe, s
	quietly do 	MIDUS3\DS0002\36346-0002-Supplemental_syntax.do
	save 		MIDUS3\DS0002\MIDUS3B.dta, replace 

*DS003: Coded Text Data  
	use 		MIDUS3\DS0003\36346-0003-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS3\DS0003\36346-0003-Supplemental_syntax.do
	save		MIDUS3\DS0003\MIDUS3C.dta, replace

//Merge MIDUS3B and MIDUS3C to MIDUS3A, save as MIDUS 3
//Check Merge
	//MIDUS3A obs = 3,294 vars = 2,613
	//MIDUS3B obs = 7,108 vars = 6
	//MIDUS3C obs = 3,137 vars = 183 

*Merge MIDUS3B (using) to MIDUS3A (master), save as MIDUS3P1	
	use 		MIDUS3\DS0001\MIDUS3A.dta
	merge 		1:1 M2ID using MIDUS3\DS0002\MIDUS3B.dta
	describe, s
	rename 		_merge merge7
	label var 	merge7 "Merge MIDUS3B (using) to MIDUS3A (master)"
	save		MIDUS3\MIDUS3P1.dta, replace 

*Merge MIDUS3C (using) to MIDUS3P1 (master), save as MIDUS3P1
	use 		MIDUS3\MIDUS3P1.dta, clear	
	merge 		1:1 M2ID using MIDUS3\DS0003\MIDUS3C.dta
	describe, s
	rename 		_merge merge8
	label var 	merge8 "Merge MIDUS3C (using) to product of A+B (master)"
	save		MIDUS3\MIDUS3P1.dta, replace 

	describe	using MIDUS3\MIDUS3P1.dta, s
	
	clear

********************************************************************************
//MIDUS 3 Mortality (ICPSR 37237) 
********************************************************************************
//Files to be merged: Folder MIDUS 3 Mortality contains DS001(Mortality data)
	//Open DS001, do supplemental syntax, save as MIDUS3MORT
	
*DS001: Mortality data  
	use 		MIDUS3-Mortality\DS0001\37237-0001-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS3-Mortality\DS0001\37237-0001-Supplemental_syntax.do 
	*80 observations from the milwaukee sample 
	drop 		if SAMPLMAJ==13
	describe, s
	save 		MIDUS3-Mortality\DS0001\MIDUS3MORT.dta, replace 

//Merge MIDUS3MORT (using) to MIDUS3 (master); save as MIDUS3 in data-cleaning folder 
//Check merge
	//MIDUS3MORT obs = 1,382 vars = 11
	//MIDUS3P1	 obs = 7,108 vars = 2,797 
	use 		MIDUS3\MIDUS3P1.dta, clear	
	merge 		1:1 M2ID using MIDUS3-Mortality\DS0001\MIDUS3MORT.dta
	describe, s
	rename 		_merge merge9
	label var 	merge9 "Merge MIDUS3MORT (using) to MIDUS3P1 (master)"
	save		data-cleaning\MIDUS3.dta, replace 

	describe	using data-cleaning\MIDUS3.dta, s
	
	clear
	
	capture log close 


	
	
	
	


