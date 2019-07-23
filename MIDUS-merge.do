cd "C:\Users\hanna\git\AHL"
capture log close 
log using merge-process, replace text

version 13 
clear all 
set linesize 80
set more off 

//Project: Dissertation AHL 
//Created by: Hannah Andrews
//Date: 03-28-19
//Task: Merge files within MIDUS Wave 1- includes SAQ data (v1),  
//		coded text data, twin screener, and 2 weights data files 

********************************************************************************
//MIDUS 1 (ICPSR )
********************************************************************************
//Files to be merged: Folder MIDUS 1 includes DS001 (DATASET 0001: MAIN, SIBLINGS AND TWIN DATA) 
//DS004 (DATASET 0004: TWIN SCREENER DATA) and DS005 (DATASET 0005: CODED TEXT DATA) 
//For each (DS001 DS004 DS005) open, do supplemental syntax, save as MIDUS1A, MIDUS1B, MIDUS1C. 

//Merge MIDUS1B and MIDUS1C to MIDUS1A, save as MIDUS1

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
//For each (DS001 DS002) open, do suppmental syntax, save as MIDUS2BIOA, MIDUS2BIOB

//Merge MIDUS2BIOB to MIDUS2BIOA, save as MIDUS2BIO


//Merge MIDUS2BIO to MIDUS2. Save as MIDUS2

********************************************************************************
//MIDUS 3 
********************************************************************************
//Files to be merged: Folder MIDUS 3 contains DS001(DATASET 0001: AGGREGATE DATA) 
//DS002 (DATASET 0002: DISPOSITION CODES) DS003 (DATASET 0003: CODED TEXT DATA) 

********************************************************************************
//MIDUS 3 Mortality 
********************************************************************************
