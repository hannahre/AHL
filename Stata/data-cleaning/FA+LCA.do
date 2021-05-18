local dir "C:\Users\hanna\Documents\git\AHL\Stata\data-cleaning"
cd `dir'
*capture log close 
*log using MIDUS-merge.txt, replace text


clear all 
set linesize 100
set more off 


//Project: Dissertation AHL 
//Created by: Hannah Andrews
//Date Created: 04/28/21
//Task: LCA and Factor Analysis 

********************************************************************************
//MIDUS 1: Factor analysis with listwise deletion 
********************************************************************************
* Following instructions from UCLA for running a FA with dummy variables 
* https://stats.idre.ucla.edu/stata/faq/how-can-i-perform-a-factor-analysis-with-categorical-or-categorical-and-continuous-variables/
	use MIDUS1.dta, clear 

rename (acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15) (acupuncture biofeed chiro energy exercise herbal vitamin homeopathy hypno imagery massage prayer meditate diet spiritheal)
	
* Create polychoric correlation matrix with cams1-15 
	polychoric acupuncture biofeed chiro energy exercise herbal vitamin homeopathy hypno imagery massage prayer meditate diet spiritheal
	tetrachoric acupuncture biofeed chiro energy exercise herbal vitamin homeopathy hypno imagery massage prayer meditate diet spiritheal
* Display number of cases included with listwise deletion 
	display r(sum_w)
* Create global that sets N equal to the number of cases with listwise deletion 
	global N = r(sum_w) 
* Use matrix command to store the polychoric correlation matrix as r 
	matrix r = r(R)
* Run factor analysis on matrix 
* Principal factor is the default 
	factormat r, n($N)  
* Rotated factor loadings: The factor loadings for the varimax orthogonal rotation represent both how the variables are weighted for each factor but also the correlation between the variables and the factor. A varimax rotation attempts to maximize the squared loadings of the columns.
	rotate, varimax horst
* Only retain factor loadings greater than .3
	rotate, varimax horst blanks(.3)
* Promax: The factor loadings for the promax oblique rotation represent how the each of the variables are weighted for each factor. Note: these are not correlations between variables and factors. The promax rotation allows the factors to be correlated in an attempt to better approximate simple structure.
	rotate, promax horst blanks(.3)
* Display the correlation among the factors of an oblique rotation.
	estat common
* Obtain AIC and BIC 
	estat factors 


factormat r, n($N) factors(5)
rotate, varimax horst
rotate, varimax horst blanks(.3)
rotate, promax horst blanks(.3)
estat common



* LCA
discard
*set trace on
drop _all


cd C:\Users\hanna\Documents\git\AHL\Stata\data-cleaning 
use MIDUS1.dta, clear
keep A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O

doLCA A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O, ///
      nclass(5) ///
	  seed(100000) ///
	  seeddraws(100000) ///
	  categories(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)  ///
	  criterion(0.000001)  ///
	  rhoprior(1.0)
	  
return list
matrix list r(gamma)
matrix list r(gammaSTD)
matrix list r(rho)
matrix list r(rhoSTD)

