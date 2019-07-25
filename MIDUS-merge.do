local dir "C:\Users\hanna\git\AHL"
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
//Task: All merge tasks completed through this do-file. 

********************************************************************************
//MIDUS 1 (ICPSR 02760)
********************************************************************************
//Files to be merged: Folder MIDUS 1 includes DS001 (DATASET 0001: MAIN, SIBLINGS AND TWIN DATA) 
//DS004 (DATASET 0004: TWIN SCREENER DATA) and DS005 (DATASET 0005: CODED TEXT DATA) 
//For each (DS001 DS004 DS005) open, sort M2ID, do supplemental syntax (comes with raw data files
	//from ICPSR; replaces user-defined numeric missing values (e.g., -9) with generic 
	//system missing "."), save as MIDUS1A, MIDUS1B, MIDUS1C. 

*DS001: Main, Siblings, Twin Data 
	use 		MIDUS1\DS0001\02760-0001-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do 	MIDUS1\DS0001\02760-0001-Supplemental_syntax.do 
	save 		MIDUS1\DS0001\MIDUS1A.dta, replace 

*DS004: Twin Screener Data
	use			MIDUS1\DS0004\02760-0004-Data.dta, clear 
	sort		M2ID
	describe, s
	quietly do 	MIDUS1\DS0004\02760-0004-Supplemental_syntax.do
	save 		MIDUS1\DS0004\MIDUS1B.dta, replace 

*DS005: Coded text data 
	use 		MIDUS1\DS0005\02760-0005-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do	MIDUS1\DS0005\02760-0005-Supplemental_syntax.do 
	save		MIDUS1\DS0005\MIDUS1C.dta, replace

//Merge MIDUS1B and MIDUS1C to MIDUS1A, save as MIDUS1
//Check Merge
	//MIDUS1A obs = 7,108 vars = 2,098
	//MIDUS1B obs = 1,914 vars = 90 
	//MIDUS1C obs = 3,950 vars = 82 
	
*Merge MIDUS1B (using) to MIDUS1A (master), save as MIDUS1 	
	use 		MIDUS1\DS0001\MIDUS1A.dta
	merge 		1:1 M2ID using MIDUS1\DS0004\MIDUS1B.dta
	describe, s
	rename 		_merge merge1
	label var 	merge1 "Merge MIDUS1B (using) to MIDUS1A (master)"
	save		MIDUS1\MIDUS1.dta, replace 

*Merge MIDUS1C (using) to MIDUS1 (master), save as MIDUS1 in data cleaning folder
	use 		MIDUS1\MIDUS1.dta, clear	
	merge 		1:1 M2ID using MIDUS1\DS0005\MIDUS1C.dta
	describe, s
	rename 		_merge merge2
	label var 	merge2 "Merge MIDUS1C (using) to product of A+B (master)"
	save		data-cleaning\MIDUS1.dta, replace 

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
	///Instead, merging 
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
//For each (DS001 DS002 DS003) open, do supplemental syntax, save as MIDUS3A MIDUS3B
//MIDUS3C

//Merge MIDUS3B and MIDUS3C to MIDUS3A, save as MIDUS 3

********************************************************************************
//MIDUS 3 Mortality (ICPSR 37237) 
********************************************************************************
//Files to be merged: Folder MIDUS 3 Mortality contains DS001(Mortality data)
//Open DS001, do supplemental syntax, save as MIDUS3MORT

//Merge MIDUS3MORT to MIDUS3  
