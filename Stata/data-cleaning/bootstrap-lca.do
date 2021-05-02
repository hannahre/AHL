discard
//set trace on
drop _all

cd C:\Users\hanna\Documents\git\AHL\Stata\data-cleaning 
use MIDUS1.dta, clear


qui doLCA A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O, ///
	nstart(10) ///
	nclass(2) ///
	seed(1000) ///
	categories(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) 

//return list	
mat G = r(gamma)
mat R = r(rho)	
local null_logliks = r(loglikelihood)
//dis "null_logliks" `null_logliks'

forvalues i=1/`=rowsof(G)' {
	forvalues j=1/`=colsof(G)' {
		local glist `glist' `=G[`i', `j']'
	}
}
//dis `glist'

forvalues i=1/`=rowsof(R)/2' {
	forvalues j=1/`=colsof(R)' {
		local rholist `rholist' `=R[`i', `j']'
	}
}
//dis `rholist'

qui doLCA A1SA39A A1SA39B A1SA39C A1SA39D A1SA39E A1SA39F A1SA39G A1SA39H A1SA39I A1SA39J A1SA39K A1SA39L A1SA39M A1SA39N A1SA39O, ///
	nstart(10) ///
	nclass(3) ///
	seed(1000) ///
	categories(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) 
local alt_logliks = r(loglikelihood)

//dis "null_logliks" `null_logliks'
//dis "alt_logliks" `alt_logliks'

cap drop _all
/*Example 1: LCA model  */
doLcaBootstrap, ///
      null_gammalist(`glist')    ///
	  null_rholist(`rholist')  ///
	  null_loglikelihood(`null_logliks') ///
	  alt_loglikelihood(`alt_logliks') ///
	  simulate_samplesize(10000)  ///
	  num_bootstrap(99)  ///
	  null_nstarts(10)   ///
	  alt_nstarts(10)    
	  
dis e(p_value)
