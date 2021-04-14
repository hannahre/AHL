//Wave 1
use MIDUS1.dta, clear
preserve
*Create new var that is the average across all CAMs 
	egen acamme1 = rowmean(acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 ///
		acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16)
*Check that egen ran correctly 
	assert acamme1 == (acam1 + acam2 + acam3 + acam4 + acam5 + acam6 + acam7 + ///
		acam8 + acam9 + acam10 + acam11 + acam12 + acam13 + acam14 + acam15 + acam16)/16
		
generate error = 1 if acamme1 != ((acam1 + acam2 + acam3 + acam4 + acam5 + acam6 + acam7 + acam8 + acam9 + acam10 + ///
	acam11 + acam12 + acam13 + acam14 + acam15 + acam16)/16)
replace error = 0 if acamme1 == (acam1 + acam2 + acam3 + acam4 + acam5 + acam6 + acam7 + acam8 + acam9 + acam10 + ///
	acam11 + acam12 + acam13 + acam14 + acam15 + acam16)/16
	
browse error acamme1 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 ///
	acam11 acam12 acam13 acam14 acam15 acam16 if error ==1
	
browse error acamme1 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 ///
	acam11 acam12 acam13 acam14 acam15 acam16 if error ==0
	
use MIDUS1.dta 
preserve
keep is !missing((acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 ///
		acam9 acam10 acam11 acam12 acam13 acam14 acam15 acam16)
keep var if acam1 ~. & ~. & acam2 ~. & acam3 ~. & acam4 ~. & acam5 ~. & acam6 ~. & acam7 ~. & acam8 ///
		~. & acam9 ~. & acam10 ~. & acam11 ~. & acam12 ~. & acam13 ~. & acam14 ~. & acam15 ~. & acam16 ~.

by error: count if acam1 ==. | acam2 ==. | acam3 ==. | acam4 ==. | acam5 ==. | acam6 ==. | acam7 ==. | acam8 ///
		==. | acam9 ==. | acam10 ==. | acam11 ==. | acam12 ==. | acam13 ==. | acam14 ==. | acam15 ==. | acam16 ==.

egen nmis=rmiss2(acamme1 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 ///
	acam11 acam12 acam13 acam14 acam15 acam16)


mvpatterns acamme1 acam1 acam2 acam3 acam4 acam5 acam6 acam7 acam8 acam9 acam10 ///
	acam11 acam12 acam13 acam14 acam15 acam16
	
	
	
	
	
	
	
	
	
	
	
	
	
	