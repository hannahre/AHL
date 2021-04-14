////////////////////////////////////////////////////////////////////////////////
**Data Exploration: Distributions, Missing data.  
////////////////////////////////////////////////////////////////////////////////

local dir "C:\Users\hanna\git\AHL\Stata\data-cleaning"
cd `dir'
*capture log close 
*log using MIDUS-recodes.txt, replace text

version 13 
clear all 
set linesize 100
set more off 
set maxvar 32767

* This do-file is meant to be used for exploring patterns and associations in the data. 

////////////////////////////////////////////////////////////////////////////////
**SES and CAM indices 
////////////////////////////////////////////////////////////////////////////////

********************************************************************************
//Income and dummy co-occurrence index 
********************************************************************************

// Wave 1 
	
