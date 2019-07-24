local dir "C:\Users\hanna\git\AHL"
cd `dir'
capture log close 
log using MIDUS-merge.txt, replace text

version 13 
clear all 
set linesize 80
set more off 

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
	use 	MIDUS1\DS0001\MIDUS1A.dta, clear	
	merge 1:1 M2ID using "C:\Users\hanna\git\AHL\MIDUS1\DS0004\MIDUS1B.dta" "C:\Users\hanna\git\AHL\MIDUS1\DS0005\MIDUS1C.dta"
	**7/24 getting an error here, won't run MIDUS1C
	describe, s
	tab 	_merge _merge1 _merge2
	save	MIDUS1\MIDUS1.dta, replace 

//Create error variables to check that merge ran correctly 
	gen		ME1 = 0
			replace ME1 = 1 if 
			
********************************************************************************
//MIDUS 2 (ICPSR 04652) 
********************************************************************************
//Files to be merged: Folder MIDUS 2 includes DS001(DATASET 0001: M2_P1_AGGREGATE DATA) 
//DS002(DATASET 0002: M2_P1_DISPOSITION CODES) DS003(Survey Weights) 
//DS004(DATASET 0004: M2_P1_CODED TEXT DATA) 
//For each (DS001 DS002 DS004) open, do supplemental syntax, save as MIDUS2A
//MIDUS2B MIDUS2D

//DS003 (weights) does not have supplemental syntax. Open and save as MIDUS2C 

//Merge MIDUS2B MIDUS2C MIDUS2D to MIDUS2A, save as MIDUS2

********************************************************************************
//MIDUS 2 Biomarker (ICPSR 29282) 
********************************************************************************
//Files to be merged: Folder MIDUS 2 Biomarker includes DS001(DATASET 0001: AGGREGATED DATA) 
//DS002(DATASET 0002: STACKED MEDICATION DATA) 
//For each (DS001 DS002) open, sort by M2ID, do suppmental syntax, save as MIDUS2BIOA, MIDUS2BIOB


//Merge MIDUS2BIOB to MIDUS2BIOA, save as MIDUS2BIO


//Merge MIDUS2BIO to MIDUS2. Save as MIDUS2

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
