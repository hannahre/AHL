// 07/27/19 Created when working on recoding - was going to include in the recode section but 
	//realized it doesnt really mean anything because these are not based on the actual a
	//sample I'll be using. 


use MIDUS1.dta
hist A1SHHTOT, freq discrete normal xtitle("MIDUS 1 Total HH Income") xtick(0(10000)300000) ///
	wi(10000) saving(graphs\ainc, replace)
use MIDUS2.dta 
hist B1STINC1, freq discrete normal xtitle("MIDUS 2 Total HH Income") xtick(0(10000)300000) ///
	wi(10000) 
	saving(graphs\binc, replace)
graph combine graphs\ainc.gph graphs\binc.gph, col(1) saving("annual HH income",replace)
graph use "annual HH income"
graph export graphs\annualHHinc.pdf
