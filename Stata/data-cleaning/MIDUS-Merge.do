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
//Date Created: 07/23/18
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
	keep		M2ID M2FAMNUM SAMPLMAJ A1STATUS A1PRSEX A1PRAGE_2019 A1SS7 A1PB17 A1PA5 A1PANHED ///
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
				A1SA9AA A1SA9BB A1SA9CC A1SCHRON A1SCHROX A1SBMI ///
				A1PC2 A1PC8 A1SR2B A1SR2E A1SR2A A1SR2D A1SR2F ///
				A1SR2G A1SR2H A1SR2I A1PDEPRE	
	save 		MIDUS1\DS0001\MIDUS1A.dta, replace 

	describe, s 

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

	* For now (04/15/21) do not merge daily diary data. 

	save 		MIDUS1\DS0002\MIDUS1D.dta, replace 

*DS004: Twin Screener Data
	use			MIDUS1\DS0004\02760-0004-Data.dta, clear 
	sort		M2ID
	describe, s
	quietly do 	MIDUS1\DS0004\02760-0004-Supplemental_syntax.do
	keep 		M2ID ZYGCAT
	save 		MIDUS1\DS0004\MIDUS1B.dta, replace
	describe, s  

*DS005: Coded text data 
	use 		MIDUS1\DS0005\02760-0005-Data.dta, clear
	sort 		M2ID
	describe, s
	quietly do	MIDUS1\DS0005\02760-0005-Supplemental_syntax.do 
	keep 		M2ID A1SA39PA A1SA39PB A1SA39PC A1SA39PD
	save		MIDUS1\DS0005\MIDUS1C.dta, replace
	describe, s

//Merge MIDUS1B and MIDUS1C to MIDUS1A, save as MIDUS1
//Check Merge - (04/15/21)
	//MIDUS1A - Survey 			obs = 7,108 vars = 135
	//MIDUS1B - Twin Screener 	obs = 1,914 vars = 2 
	//MIDUS1C - Coded Text 		obs = 3,950 vars = 5 
	
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

* 04/15/21 Insert break statement to check merge ran correctly... 


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
	keep 		M2ID M2FAMNUM SAMPLMAJ B1STATUS B1PRSEX B1PAGE_M2 ///
         		B1PF8_A B1PF1 B1PF3 B1PF7A B1PB19 B1PA2 B1PANHED B1PDEPAF ///
				B1PDEPRE B1PANXIE B1PPANIC B1SN1A B1SN1AX B1SN2A ///
				B1SN2B B1SN2C B1SN2D B1SN2E B1SN2F B1SN2G ///
				B1SN2H B1SN2I B1SSPIRI B1SRELID B1SN3D B1SN3A ///
				B1SN3B B1SN3C B1SRELPR B1SN3E B1SN4 B1SN6 ///
				B1SN7 B1SN8A B1SN8B B1SN8C B1SN8D B1SRELSU ///
				B1SN9A B1SN9B B1SN9C B1SN9D B1SN9E B1SN9F ///
				B1SN9G B1SN9H B1SRELCA B1SRELCB B1SN10A B1SN10B ///
				B1SN10C B1SN10D B1SN10E B1SSPRTE B1SN11A B1SN11B ///
				B1SN11C B1SN11D B1SN11E B1SN11F B1SN11G B1SN11H ///
				B1SN11I B1SMNDFU B1SHLOCS B1SHLOCO B1SC1 B1SC3A ///
				B1SC3B B1SC3C B1SC3D B1SC3E B1SC3F B1SC3G ///
				B1SC3H B1SA52 B1SUSEMD B1SA54A B1SA54B B1SA54C ///
				B1SA54D B1SUSEMH B1SA56A B1SA56B B1SA56C B1SA56D B1SA56E ///
				B1SA56F B1SA56G B1SA56H B1SA56I B1SA56J B1SA56K ///
				B1SA56L B1SA56M B1SA56N B1SA56O B1SA56P B1SA56Q B1SA56R B1SA56S ///
				B1SA30A B1SA30B B1SA30C B1SA30D B1SA30E B1SA30F ///
				B1SA31A B1SA31B B1SA31C B1SA31D B1SA31E B1SA31F ///
				B1SA32A B1SA32B B1SA32C B1SA32D B1SA32E B1SA32F ///
				B1SA57A B1SA57B B1SA58A B1SA58B B1SA59A B1SA59B ///
				B1SA60 B1SA61A B1SA61B B1SA61C B1SA61D B1PA37 ///
				B1PA38A B1PA38B B1PA39 B1PA41 B1PA54 B1PA54A ///
				B1PA55 B1PA50 B1PA51 B1PA51A B1PA52 B1PA53 ///
				B1SG8A B1SG8B B1SG8C B1SRINC1 B1SG9A B1SG9B ///
				B1SG9C B1SSINC1 B1STINC1 B1SEARN1 B1SPNSN1 B1SSEC1 ///
				B1SG12 B1SG7 B1SG23 B1SG24A B1SF13 B1SJCDA ///
				B1POCC B1PIND B1POCMAJ B1PINDMJ B1PTSEI B1PB37 ///
				B1POCCS B1PINDS B1PSOCMJ B1PSINMJ B1PTSEIS ///
				B1PB1 B1PB33 B1PA1 B1SA11A B1SA11B B1SA11C  ///
				B1SA11D B1SA11E B1SA11F B1SA11G B1SA11H B1SA11I  ///
				B1SA11J B1SA11K B1SA11L B1SA11M B1SA11N B1SA11O  ///
				B1SA11P B1SA11Q B1SA11R B1SA11S B1SA11T B1SA11U  ///
				B1SA11V B1SA11W B1SA11X B1SA11Y B1SA11Z B1SA11AA  ///
				B1SA11BB B1SA11CC B1SCHRON B1SCHROX B1SBMI ///
				B1SSPIRI B1SRELID B1SA15 B1PDEPRE	
	save 		MIDUS2\DS0001\MIDUS2A.dta, replace 
	describe,	s

*DS002: Disposition Codes 
	use			MIDUS2\DS0002\04652-0002-Data.dta, clear 
	sort		M2ID
	quietly do 	MIDUS2\DS0002\04652-0002-Supplemental_syntax.do
	describe,	s
	save 		MIDUS2\DS0002\MIDUS2B.dta, replace 

*DS003: Survey Weights  
	use 		MIDUS2\DS0003\04652-0003-Data.dta, clear
	sort 		M2ID
	describe,	s
	save		MIDUS2\DS0003\MIDUS2C.dta, replace
	
*DS004: Coded Text Data 
	use			MIDUS2\DS0004\04652-0004-Data.dta, clear 
	sort		M2ID
	describe,	s
	quietly do 	MIDUS2\DS0004\04652-0004-Supplemental_syntax.do
	keep		M2ID B1SA56SAO B1SA56SBO
	describe,	s
	save 		MIDUS2\DS0004\MIDUS2D.dta, replace 

//Merge MIDUS2B MIDUS2C MIDUS2D to MIDUS2A, save as MIDUS2
//Check Merge
	//MIDUS2A obs = 4,963 vars = 210
	//MIDUS2B obs = 7,108 vars = 12
	//MIDUS2C obs = 2,257 vars = 11
	//MIDUS2D obs = 4,963 vars = 3
	
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
	keep		M2ID B4QCESD B4QPS_PS B4H25 B4HMETMW B4SSQ_S3 B4ZSITE ///
				B4H26 B4H26A B4H33 B4H34 B4H35 B4H36 B4H37   ///
				B4H16 B4H17AF B4H17AT B4H17BF B4H17BT B4H17CF  ///
				B4H17CT B4H18AF B4H18AT B4H18BF B4H18BT B4H18CF  ///
				B4H18CT B4H19 B4H20 B4H21 B4H22 B4H23A B4H23B  ///
				B4H23C B4H23D B4H24 B4HSYMX B4HSYMN B4PBMI B4P1GS  ///
				B4P1GD B4BLDL B4BCHOL B4BHDL B4BTRIGL B4BDHEA  ///
				B4BDHEAS B4BCRP B4BIL6 B4BMSDIL6 B4BSIL6R B4BHA1C  ///
				B4BGLUC B4BINSLN B4BIGF1 B4BCORTL B4BNECL B4BCLCRE  ///
				B4BSCL3A B4BSCL42 B4BEPIN B4BEPI12 B4BEPCRE B4BNECL  ///
				B4BNOREP B4BNE12 B4BNOCRE B4BDOPA B4BDOCRE B4BDOP12 B4SSQ_GS
	describe,	s
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
	//MIDUS2BIOA obs = 1,054 vars = 69
	//MIDUS2P1	 obs = 7,108 vars = 133
	
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
	describe,	s
	quietly do 	MIDUS3\DS0001\36346-0001-Supplemental_syntax.do 
	keep		M2ID M2FAMNUM SAMPLMAJ C1STATUS C1PRSEX  C1PRAGE ///
				C1PF8A1 C1PF1 C1PF3 C1PF7A C1PB19 C1PB32A C1PA2 C1PANHED  ///
				C1PDEPAF C1PDEPRE C1PANXIE C1PPANIC C1SN1A C1SN2A  ///
				C1SN2B C1SN2C C1SN2D C1SN2E C1SN2F C1SN2G C1SN2H  ///
				C1SN2I C1SSPIRI C1SRELID C1SN3D C1SN3A C1SN3B  ///
				C1SN3C C1SRELPR C1SN3E C1SN4 C1SN7 C1SN8 C1SN9A  ///
				C1SN9B C1SN9C C1SN9D C1SRELSU C1SN10A C1SN10B C1SN10C  ///
				C1SN10D C1SN10E C1SN10F C1SN10G C1SN10H C1SRELCA  ///
				C1SRELCB C1SN11A C1SN11B C1SN11C C1SN11D C1SN11E  ///
				C1SSPRTE C1SN12A C1SN12B C1SN12C C1SN12D C1SN12E  ///
				C1SN12F C1SN12G C1SN12H C1SN12I C1SMNDFU C1SHLOCS  ///
				C1SHLOCO C1SC1 C1SC3A C1SC3B C1SC3C C1SC3D C1SC3E  ///
				C1SC3F C1SC3G C1SC3H C1SA48 C1SUSEMD C1SA50A C1SA50B  ///
				C1SA50C C1SA50D C1SUSEMH C1SA52A C1SA52B C1SA52C  ///
				C1SA52D C1SA52F C1SA52G C1SA52H C1SA52I C1SA52J  ///
				C1SA52K C1SA52L C1SA52M C1SA52N C1SA52Q C1SA52R  ///
				C1SA52S C1SA52E C1SA52O C1SA52P C1SA26A C1SA26B C1SA26C C1SA26D C1SA26E  ///
				C1SA26F C1SA27A C1SA27B C1SA27C C1SA27D C1SA27E  ///
				C1SA27F C1SA28A C1SA28B C1SA28C C1SA28D C1SA28E  ///
				C1SA28F C1SA53A C1SA53B C1SA54A C1SA54B C1SA55A  ///
				C1SA55B C1SA56 C1SA57A C1SA57B C1SA57C C1SA57D  ///
				C1PA37 C1PA38A C1PA38B C1PA39 C1PA41 C1PA54 C1PA54A  ///
				C1PA55 C1PA50 C1PA51 C1PA51A C1PA52 C1PA53 C1SG11A  ///
				C1SG11B C1SG11C C1SRINC C1SG14A C1SG14B C1SG14C  ///
				C1SSINC C1STINC C1SEARN C1SPNSN C1SSEC C1SG21 C1SG9  ///
				C1SG59 C1SG59B C1SF24 C1SJCDA C1POCC C1PIND C1POCMAJ ///
				C1PINDMJ C1PB37 C1POCCS C1PINDS C1PSOCMJ C1PSINMJ C1PB1  ///
				C1PB33 C1PWGHT1 C1PWGHT2 C1PWGHT3 C1PWGHT4 C1PWGHT5  ///
				C1PWGHT6 C1PWGHT7 C1PWGHT8 C1PWGHT10 C1PWGHT9 C1PA1  ///
				C1SA11A C1SA11B C1SA11C C1SA11D C1SA11E C1SA11F  ///
				C1SA11G C1SA11H C1SA11I C1SA11J C1SA11K C1SA11L  ///
				C1SA11M C1SA11N C1SA11O C1SA11P C1SA11Q C1SA11R  ///
				C1SA11S C1SA11T C1SA11U C1SA11V C1SA11W C1SA11X  ///
				C1SA11Y C1SA11Z C1SA11AA C1SA11BB C1SA11CC C1SCHRON C1SCHROX ///
				C1SBMI C1SSPIRI C1SRELID C1SA15 C1PDEPRE	
	describe,	s
	save 		MIDUS3\DS0001\MIDUS3A.dta, replace 

*DS002: Disposition Codes 
	use			MIDUS3\DS0002\36346-0002-Data.dta, clear 
	sort		M2ID
	describe,	s
	quietly do 	MIDUS3\DS0002\36346-0002-Supplemental_syntax.do
	save 		MIDUS3\DS0002\MIDUS3B.dta, replace 

*DS003: Coded Text Data  
	use 		MIDUS3\DS0003\36346-0003-Data.dta, clear
	sort 		M2ID
	describe,	s
	quietly do 	MIDUS3\DS0003\36346-0003-Supplemental_syntax.do
	keep		M2ID C1SA52SA C1SA52SB
	describe,	s
	save		MIDUS3\DS0003\MIDUS3C.dta, replace

//Merge MIDUS3B and MIDUS3C to MIDUS3A, save as MIDUS 3
//Check Merge
	//MIDUS3A obs = 3,294 vars = 217
	//MIDUS3B obs = 7,108 vars = 6
	//MIDUS3C obs = 3,137 vars = 3 

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
	describe,	s
	quietly do 	MIDUS3-Mortality\DS0001\37237-0001-Supplemental_syntax.do 
	*80 observations from the milwaukee sample 
	drop 		if SAMPLMAJ==13
	describe,	s
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
