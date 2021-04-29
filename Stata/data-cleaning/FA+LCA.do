local dir "C:\Users\hanna\Documents\git\AHL\Stata\data-cleaning"
cd `dir'
*capture log close 
*log using MIDUS-merge.txt, replace text

version 13 
clear all 
set linesize 100
set more off 
set maxvar 32767

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

* Create polychoric correlation matrix with cams1-15 
polychoric acam1-acam15

* Display number of cases included with listwise deletion 
display r(sum_w)

global N = r(sum_w) 
matrix r = r(R) 
factormat r, n($N) factors(3)
rotate, varimax horst
rotate, varimax horst blanks(.3)
rotate, promax horst blanks(.3)
estat common
factormat r, n($N) factors(5)
rotate, varimax horst
rotate, varimax horst blanks(.3)
rotate, promax horst blanks(.3)
estat common

* LCA
gsem (acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 acam11 acam12 acam13 acam14 acam15 <- ), logit lclass(C 3)

