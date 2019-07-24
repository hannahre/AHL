local dir "C:\Users\hanna\git\AHL"
cd `dir'
capture log close 
log using , replace text

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
//For each (DS001 DS004 DS005) open, sort M2ID, do supplemental syntax, save as MIDUS1A, MIDUS1B, MIDUS1C. 

*DS001: Main, Siblings, Twin Data 
	use 	MIDUS1\DS0001\02760-0001-Data.dta, clear
	sort 	M2ID
	//Describe: Check that it's sorted & for reference checking merge process 
	describe, s
	do 		MIDUS1\DS0001\02760-0001-Supplemental_syntax.do 
	save 	MIDUS1\DS0001\MIDUS1A.dta, replace 

*DS004: Twin Screener Data
	use		MIDUS1\DS0004\02760-0004-Data.dta, clear 
	sort	M2ID
	describe, s
	do 		MIDUS1\DS0004\02760-0004-Supplemental_syntax.do 
	save 	MIDUS1\DS0004\MIDUS1B.dta, replace 

*DS005: Coded text data 
	use 	MIDUS1\DS0005\02760-0005-Data.dta, clear
	sort 	M2ID
	describe, s
	do		MIDUS1\DS0005\02760-0005-Supplemental_syntax.do 
	save	MIDUS1\DS0005\MIDUS1C.dta, replace

//Merge MIDUS1B and MIDUS1C to MIDUS1A, save as MIDUS1
	use 	MIDUS1\DS0001\MIDUS1A.dta

*Merge twin screener data to main/sib/twin data 	
	merge 1:1 M2ID using MIDUS1\DS0004\MIDUS1B.dta
	describe, s
	tab 	_merge
	***07-23 do tomorrow! Review how _merge works, create variable that goes to 
	*** 1 if there is an error in the merge. Create different variables for each merge 
	*** Be sure to label with the using and in use datasets. 
	gen 
	drop 	_merge
	save	MIDUS1\MIDUS1.dta, replace 

*Merge coded text data to twin screener+main/sib/twin data 	
	use 	MIDUS1\MIDUS1.dta, clear 

	merge 1:1 M2ID using MIDUS1\DS0005\MIDUS1C.dta
	describe, s
	tab 	_merge 
	drop	_merge 
	save	MIDUS1\MIDUS1.dta, replace 
	
	use MIDUS1\MIDUS1.dta
	describe, s

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
