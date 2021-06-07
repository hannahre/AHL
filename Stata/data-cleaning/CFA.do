local dir "C:\Users\hanna\Documents\git\AHL\Stata\data-cleaning"
cd `dir'
*capture log close 
*log using MIDUS-merge.txt, replace text


clear all 
set linesize 100
set more off 


//Project: Dissertation AHL 
//Created by: Hannah Andrews
//Date Created: 05/19/21
//Task: Confirmatory Factor Analysis 


use MIDUS1.dta, clear 

* subset to only cases not missing on any cams 
mark nomiss2
markout nomiss2 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15
tab nomiss2

keep if nomiss2 == 1
save MIDUS1-CFA.dta, replace


rename (acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15) (acupuncture biofeed chiro energy exercise herbal vitamin homeopathy hypno imagery massage prayer meditate diet spiritheal)

tetrachoric acupuncture biofeed chiro exercise herbal vitamin homeopathy hypno imagery massage prayer meditate diet spiritheal

* Create the summary statistics dataset and compute the CFA on the tetrachoric correlations 
* Following: https://stats.idre.ucla.edu/stata/faq/how-can-i-do-cfa-with-binary-variables/
clear
ssd init acupuncture biofeed chiro exercise herbal vitamin homeopathy hypno imagery massage prayer meditate diet spiritheal
ssd set obs 6157
ssd set cor  	1.0000 \ ///
0.3972   1.0000 \ ///
0.3389   0.2550   1.0000 \ ///
0.2432   0.4796   0.2817   1.0000 \ ///
0.6270   0.3731   0.3387   0.4643   1.0000 \ ///
0.3265   0.2740   0.2329   0.4182   0.6368   1.0000 \ ///
0.5989   0.4314   0.3836   0.4690   0.7978   0.6152   1.0000 \ ///
0.4052   0.2071   0.2456   0.1654   0.4116   0.2664   0.3179   1.0000 \ ///
0.4509   0.5522   0.2114   0.5135   0.5745   0.4701   0.5275   0.5256   1.0000 \ ///
0.4332   0.4128   0.5111   0.5925   0.5444   0.3440   0.5438   0.3276   0.4940 1.0000\ ///
0.2279   0.2289   0.1367   0.3111   0.4008   0.3837   0.3799   0.2278   0.5014 0.2656   1.0000\ ///
0.4413   0.6236   0.1932   0.4810   0.5558   0.4391   0.5433   0.5105   0.8336 0.5232   0.5947   1.0000\ ///
0.3067   0.2553   0.1190   0.4633   0.4104   0.4602   0.4608   0.2533   0.4084 0.3151   0.3806   0.4048   1.0000\ ///
0.2803   0.2279   0.1836   0.2393   0.4040   0.2597   0.4099   0.3386   0.4801 0.3198   0.7393   0.3613   0.3419   1.0000

********************************************************************************
//NCCAM domains 
********************************************************************************

* Run CFA on NCCAM domains
sem (AlternativeSystems -> acupuncture homeopathy exercise) ///
	(ManipulativeTreatments -> chiro massage) ///
	(BiologicalBased -> vitamin herbal diet) ///
	(MindBody -> hypno meditate imagery prayer spiritheal biofeed) 
*	(EnergyHealing -> energy)
estat gof, stats(all) 
estat eqgof
			
* 05/20/21 Convergence not achieved with energy included. Rerun tetrachoric correlations without energy and rereun. It worked. 

********************************************************************************
//Ayers and Kronenfeld domains 
********************************************************************************
sem (AlternativeSystems -> acupuncture homeopathy exercise) ///
	(ManipulativeTreatments -> chiro massage) ///
	(BiologicalBased -> vitamin herbal diet) ///
	(MindBody -> hypno meditate imagery prayer spiritheal biofeed) 
*	(EnergyHealing -> energy)
estat gof, stats(all) 
estat eqgof
			
