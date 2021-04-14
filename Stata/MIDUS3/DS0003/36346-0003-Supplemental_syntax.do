/*-------------------------------------------------------------------------*
 |                                                                         
 |            STATA SUPPLEMENTAL SYNTAX FILE FOR ICPSR 36346
 |           MIDLIFE IN THE UNITED STATES (MIDUS 3), 2013-2014
 |                    (DATASET 0003: CODED TEXT DATA)
 |
 |
 | This Stata missing value recode program is provided for optional use with
 | the Stata system version of this data file as distributed by ICPSR.
 | The program replaces user-defined numeric missing values (e.g., -9)
 | with generic system missing "."  Note that Stata allows you to specify
 | up to 27 unique missing value codes.  Only variables with user-defined
 | missing values are included in this program.
 |
 | To apply the missing value recodes, users need to first open the
 | Stata data file on their system, apply the missing value recodes if
 | desired, then save a new copy of the data file with the missing values
 | applied.  Users are strongly advised to use a different filename when
 | saving the new file.
 |
 *------------------------------------------------------------------------*/

replace C1PAA1A = . if (C1PAA1A == 97 | C1PAA1A == 98 | C1PAA1A == 99)
replace C1PAA1B = . if (C1PAA1B == 97 | C1PAA1B == 98 | C1PAA1B == 99)
replace C1PAA1C = . if (C1PAA1C == 97 | C1PAA1C == 98 | C1PAA1C == 99)
replace C1PAA1D = . if (C1PAA1D == 97 | C1PAA1D == 98 | C1PAA1D == 99)
replace C1PAA1E = . if (C1PAA1E == 97 | C1PAA1E == 98 | C1PAA1E == 99)
replace C1PAA2LBBA = . if (C1PAA2LBBA == 97 | C1PAA2LBBA == 98 | C1PAA2LBBA == 99)
replace C1PAA2LBBB = . if (C1PAA2LBBB == 97 | C1PAA2LBBB == 98 | C1PAA2LBBB == 99)
replace C1PA7BJA = . if (C1PA7BJA == 97 | C1PA7BJA == 98 | C1PA7BJA == 99)
replace C1PA7BJB = . if (C1PA7BJB == 97 | C1PA7BJB == 98 | C1PA7BJB == 99)
replace C1PA22A = . if (C1PA22A == 97 | C1PA22A == 98 | C1PA22A == 99)
replace C1PA22B = . if (C1PA22B == 97 | C1PA22B == 98 | C1PA22B == 99)
replace C1PA22C = . if (C1PA22C == 97 | C1PA22C == 98 | C1PA22C == 99)
replace C1PA22D = . if (C1PA22D == 97 | C1PA22D == 98 | C1PA22D == 99)
replace C1PA23CJA = . if (C1PA23CJA == 97 | C1PA23CJA == 98 | C1PA23CJA == 99)
replace C1PA23CJB = . if (C1PA23CJB == 97 | C1PA23CJB == 98 | C1PA23CJB == 99)
replace C1PA24EFA = . if (C1PA24EFA == 97 | C1PA24EFA == 98 | C1PA24EFA == 99)
replace C1PA24EFB = . if (C1PA24EFB == 97 | C1PA24EFB == 98 | C1PA24EFB == 99)
replace C1PA24EFC = . if (C1PA24EFC == 97 | C1PA24EFC == 98 | C1PA24EFC == 99)
replace C1PA28JA = . if (C1PA28JA == 997 | C1PA28JA == 998 | C1PA28JA == 999)
replace C1PA28JB = . if (C1PA28JB == 997 | C1PA28JB == 998 | C1PA28JB == 999)
replace C1PA29AIA = . if (C1PA29AIA == 97 | C1PA29AIA == 98 | C1PA29AIA == 99)
replace C1PA29AIB = . if (C1PA29AIB == 97 | C1PA29AIB == 98 | C1PA29AIB == 99)
replace C1PA31JA = . if (C1PA31JA == 997 | C1PA31JA == 998 | C1PA31JA == 999)
replace C1PA31JB = . if (C1PA31JB == 997 | C1PA31JB == 998 | C1PA31JB == 999)
replace C1PA31JC = . if (C1PA31JC == 997 | C1PA31JC == 998 | C1PA31JC == 999)
replace C1PA32JA = . if (C1PA32JA == 997 | C1PA32JA == 998 | C1PA32JA == 999)
replace C1PA32JB = . if (C1PA32JB == 997 | C1PA32JB == 998 | C1PA32JB == 999)
replace C1PA32JC = . if (C1PA32JC == 997 | C1PA32JC == 998 | C1PA32JC == 999)
replace C1PA33JA = . if (C1PA33JA == 997 | C1PA33JA == 998 | C1PA33JA == 999)
replace C1PA33JB = . if (C1PA33JB == 997 | C1PA33JB == 998 | C1PA33JB == 999)
replace C1PA33JC = . if (C1PA33JC == 997 | C1PA33JC == 998 | C1PA33JC == 999)
replace C1PA34JA = . if (C1PA34JA == 997 | C1PA34JA == 998 | C1PA34JA == 999)
replace C1PA34JB = . if (C1PA34JB == 997 | C1PA34JB == 998 | C1PA34JB == 999)
replace C1PA34JC = . if (C1PA34JC == 997 | C1PA34JC == 998 | C1PA34JC == 999)
replace C1PA35JA = . if (C1PA35JA == 997 | C1PA35JA == 998 | C1PA35JA == 999)
replace C1PA35JB = . if (C1PA35JB == 997 | C1PA35JB == 998 | C1PA35JB == 999)
replace C1PA35JC = . if (C1PA35JC == 997 | C1PA35JC == 998 | C1PA35JC == 999)
replace C1PB2A11A = . if (C1PB2A11A == 97 | C1PB2A11A == 98 | C1PB2A11A == 99)
replace C1PB2BBGA = . if (C1PB2BBGA == 97 | C1PB2BBGA == 98 | C1PB2BBGA == 99)
replace C1PB2BBGB = . if (C1PB2BBGB == 97 | C1PB2BBGB == 98 | C1PB2BBGB == 99)
replace C1PB3KA = . if (C1PB3KA == 97 | C1PB3KA == 98 | C1PB3KA == 99)
replace C1PB3KB = . if (C1PB3KB == 97 | C1PB3KB == 98 | C1PB3KB == 99)
replace C1PB5GA = . if (C1PB5GA == 97 | C1PB5GA == 98 | C1PB5GA == 99)
replace C1PB5GB = . if (C1PB5GB == 97 | C1PB5GB == 98 | C1PB5GB == 99)
replace C1PB5AB1A = . if (C1PB5AB1A == 97 | C1PB5AB1A == 98 | C1PB5AB1A == 99)
replace C1PB5AB1B = . if (C1PB5AB1B == 97 | C1PB5AB1B == 98 | C1PB5AB1B == 99)
replace C1PB5AB1C = . if (C1PB5AB1C == 97 | C1PB5AB1C == 98 | C1PB5AB1C == 99)
replace C1PB33AKA = . if (C1PB33AKA == 97 | C1PB33AKA == 98 | C1PB33AKA == 99)
replace C1PB33BBGA = . if (C1PB33BBGA == 97 | C1PB33BBGA == 98 | C1PB33BBGA == 99)
replace C1PB33BBGB = . if (C1PB33BBGB == 97 | C1PB33BBGB == 98 | C1PB33BBGB == 99)
replace C1PB34KA = . if (C1PB34KA == 97 | C1PB34KA == 98 | C1PB34KA == 99)
replace C1PB34KB = . if (C1PB34KB == 97 | C1PB34KB == 98 | C1PB34KB == 99)
replace C1PB36GA = . if (C1PB36GA == 97 | C1PB36GA == 98 | C1PB36GA == 99)
replace C1PB36GB = . if (C1PB36GB == 97 | C1PB36GB == 98 | C1PB36GB == 99)
replace C1PB36A1A = . if (C1PB36A1A == 97 | C1PB36A1A == 98 | C1PB36A1A == 99)
replace C1PB36A1B = . if (C1PB36A1B == 97 | C1PB36A1B == 98 | C1PB36A1B == 99)
replace C1PB36A1C = . if (C1PB36A1C == 97 | C1PB36A1C == 98 | C1PB36A1C == 99)
replace C1PC6A = . if (C1PC6A == 97 | C1PC6A == 98 | C1PC6A == 99)
replace C1PC6B = . if (C1PC6B == 97 | C1PC6B == 98 | C1PC6B == 99)
replace C1PC6C = . if (C1PC6C == 97 | C1PC6C == 98 | C1PC6C == 99)
replace C1PCDTA1 = . if (C1PCDTA1 == 997 | C1PCDTA1 == 998 | C1PCDTA1 == 999)
replace C1PCDTA2 = . if (C1PCDTA2 == 997 | C1PCDTA2 == 998 | C1PCDTA2 == 999)
replace C1PCDTA3 = . if (C1PCDTA3 == 997 | C1PCDTA3 == 998 | C1PCDTA3 == 999)
replace C1PCDTA4 = . if (C1PCDTA4 == 997 | C1PCDTA4 == 998 | C1PCDTA4 == 999)
replace C1PCDTA5 = . if (C1PCDTA5 == 997 | C1PCDTA5 == 998 | C1PCDTA5 == 999)
replace C1PCDTA6 = . if (C1PCDTA6 == 997 | C1PCDTA6 == 998 | C1PCDTA6 == 999)
replace C1PCDTA7 = . if (C1PCDTA7 == 997 | C1PCDTA7 == 998 | C1PCDTA7 == 999)
replace C1PCDTA8 = . if (C1PCDTA8 == 997 | C1PCDTA8 == 998 | C1PCDTA8 == 999)
replace C1PCDTA9 = . if (C1PCDTA9 == 997 | C1PCDTA9 == 998 | C1PCDTA9 == 999)
replace C1PCDTA11 = . if (C1PCDTA11 == 997 | C1PCDTA11 == 998 | C1PCDTA11 == 999)
replace C1PCDTB1 = . if (C1PCDTB1 == 997 | C1PCDTB1 == 998 | C1PCDTB1 == 999)
replace C1PCDTB2 = . if (C1PCDTB2 == 997 | C1PCDTB2 == 998 | C1PCDTB2 == 999)
replace C1PCDTB3 = . if (C1PCDTB3 == 997 | C1PCDTB3 == 998 | C1PCDTB3 == 999)
replace C1PCDTB4 = . if (C1PCDTB4 == 997 | C1PCDTB4 == 998 | C1PCDTB4 == 999)
replace C1PCDTC2 = . if (C1PCDTC2 == 997 | C1PCDTC2 == 998 | C1PCDTC2 == 999)
replace C1PCDOA1 = . if (C1PCDOA1 == 997 | C1PCDOA1 == 998 | C1PCDOA1 == 999)
replace C1PCDOA2 = . if (C1PCDOA2 == 997 | C1PCDOA2 == 998 | C1PCDOA2 == 999)
replace C1PCDOA3 = . if (C1PCDOA3 == 997 | C1PCDOA3 == 998 | C1PCDOA3 == 999)
replace C1PCDOA4 = . if (C1PCDOA4 == 997 | C1PCDOA4 == 998 | C1PCDOA4 == 999)
replace C1PCDOA5 = . if (C1PCDOA5 == 997 | C1PCDOA5 == 998 | C1PCDOA5 == 999)
replace C1PCDOA6 = . if (C1PCDOA6 == 997 | C1PCDOA6 == 998 | C1PCDOA6 == 999)
replace C1PCDOA7 = . if (C1PCDOA7 == 997 | C1PCDOA7 == 998 | C1PCDOA7 == 999)
replace C1PCDOA8 = . if (C1PCDOA8 == 997 | C1PCDOA8 == 998 | C1PCDOA8 == 999)
replace C1PCDOA9 = . if (C1PCDOA9 == 997 | C1PCDOA9 == 998 | C1PCDOA9 == 999)
replace C1PCDOB1 = . if (C1PCDOB1 == 997 | C1PCDOB1 == 998 | C1PCDOB1 == 999)
replace C1PCDOB2 = . if (C1PCDOB2 == 997 | C1PCDOB2 == 998 | C1PCDOB2 == 999)
replace C1PCDOB3 = . if (C1PCDOB3 == 997 | C1PCDOB3 == 998 | C1PCDOB3 == 999)
replace C1PCDOB4 = . if (C1PCDOB4 == 997 | C1PCDOB4 == 998 | C1PCDOB4 == 999)
replace C1PCDOB9 = . if (C1PCDOB9 == 997 | C1PCDOB9 == 998 | C1PCDOB9 == 999)
replace C1PCDOC1 = . if (C1PCDOC1 == 997 | C1PCDOC1 == 998 | C1PCDOC1 == 999)
replace C1PCDOC2 = . if (C1PCDOC2 == 997 | C1PCDOC2 == 998 | C1PCDOC2 == 999)
replace C1PCDOD2 = . if (C1PCDOD2 == 997 | C1PCDOD2 == 998 | C1PCDOD2 == 999)
replace C1PCDOE2 = . if (C1PCDOE2 == 997 | C1PCDOE2 == 998 | C1PCDOE2 == 999)
replace C1PCDOF2 = . if (C1PCDOF2 == 997 | C1PCDOF2 == 998 | C1PCDOF2 == 999)
replace C1PD2A = . if (C1PD2A == 97 | C1PD2A == 98 | C1PD2A == 99)
replace C1PD2B = . if (C1PD2B == 97 | C1PD2B == 98 | C1PD2B == 99)
replace C1PD4A = . if (C1PD4A == 97 | C1PD4A == 98 | C1PD4A == 99)
replace C1PD4B = . if (C1PD4B == 97 | C1PD4B == 98 | C1PD4B == 99)
replace C1PD4C = . if (C1PD4C == 97 | C1PD4C == 98 | C1PD4C == 99)
replace C1PD4D = . if (C1PD4D == 97 | C1PD4D == 98 | C1PD4D == 99)
replace C1PD4E = . if (C1PD4E == 97 | C1PD4E == 98 | C1PD4E == 99)
replace C1PD8AA = . if (C1PD8AA == 7 | C1PD8AA == 8 | C1PD8AA == 9)
replace C1PE1A7A = . if (C1PE1A7A == 7 | C1PE1A7A == 8 | C1PE1A7A == 9)
replace C1PF1A = . if (C1PF1A == 97 | C1PF1A == 98 | C1PF1A == 99)
replace C1PF1B = . if (C1PF1B == 97 | C1PF1B == 98 | C1PF1B == 99)
replace C1PF2AA = . if (C1PF2AA == 97 | C1PF2AA == 98 | C1PF2AA == 99)
replace C1PF2BA = . if (C1PF2BA == 97 | C1PF2BA == 98 | C1PF2BA == 99)
replace C1PF3A = . if (C1PF3A == 97 | C1PF3A == 98 | C1PF3A == 99)
replace C1PF7AA = . if (C1PF7AA == 97 | C1PF7AA == 98 | C1PF7AA == 99)
replace C1PF8AA = . if (C1PF8AA == 97 | C1PF8AA == 98 | C1PF8AA == 99)
replace C1PF12BA = . if (C1PF12BA == 97 | C1PF12BA == 98 | C1PF12BA == 99)
replace C1PF12BB = . if (C1PF12BB == 97 | C1PF12BB == 98 | C1PF12BB == 99)
replace C1SA14OA = . if (C1SA14OA == 97 | C1SA14OA == 98 | C1SA14OA == 99)
replace C1SA14OB = . if (C1SA14OB == 97 | C1SA14OB == 98 | C1SA14OB == 99)
replace C1SA14OC = . if (C1SA14OC == 97 | C1SA14OC == 98 | C1SA14OC == 99)
replace C1SA14OD = . if (C1SA14OD == 97 | C1SA14OD == 98 | C1SA14OD == 99)
replace C1SA14OE = . if (C1SA14OE == 97 | C1SA14OE == 98 | C1SA14OE == 99)
replace C1SA14OF = . if (C1SA14OF == 97 | C1SA14OF == 98 | C1SA14OF == 99)
replace C1SA17IA = . if (C1SA17IA == 97 | C1SA17IA == 98 | C1SA17IA == 99)
replace C1SA17IB = . if (C1SA17IB == 97 | C1SA17IB == 98 | C1SA17IB == 99)
replace C1SA17IC = . if (C1SA17IC == 97 | C1SA17IC == 98 | C1SA17IC == 99)
replace C1SA19A = . if (C1SA19A == 97 | C1SA19A == 98 | C1SA19A == 99)
replace C1SA19B = . if (C1SA19B == 97 | C1SA19B == 98 | C1SA19B == 99)
replace C1SA19C = . if (C1SA19C == 97 | C1SA19C == 98 | C1SA19C == 99)
replace C1SA19D = . if (C1SA19D == 97 | C1SA19D == 98 | C1SA19D == 99)
replace C1SA19E = . if (C1SA19E == 97 | C1SA19E == 98 | C1SA19E == 99)
replace C1SA19F = . if (C1SA19F == 97 | C1SA19F == 98 | C1SA19F == 99)
replace C1SA39ACA = . if (C1SA39ACA == 97 | C1SA39ACA == 98 | C1SA39ACA == 99)
replace C1SA39ACB = . if (C1SA39ACB == 97 | C1SA39ACB == 98 | C1SA39ACB == 99)
replace C1SA44GA = . if (C1SA44GA == 97 | C1SA44GA == 98 | C1SA44GA == 99)
replace C1SA44GB = . if (C1SA44GB == 97 | C1SA44GB == 98 | C1SA44GB == 99)
replace C1SA45A = . if (C1SA45A == 97 | C1SA45A == 98 | C1SA45A == 99)
replace C1SA45B = . if (C1SA45B == 97 | C1SA45B == 98 | C1SA45B == 99)
replace C1SA46GA = . if (C1SA46GA == 97 | C1SA46GA == 98 | C1SA46GA == 99)
replace C1SA46GB = . if (C1SA46GB == 97 | C1SA46GB == 98 | C1SA46GB == 99)
replace C1SA46GC = . if (C1SA46GC == 97 | C1SA46GC == 98 | C1SA46GC == 99)
replace C1SA46GD = . if (C1SA46GD == 97 | C1SA46GD == 98 | C1SA46GD == 99)
replace C1SA46HA = . if (C1SA46HA == 97 | C1SA46HA == 98 | C1SA46HA == 99)
replace C1SA46HB = . if (C1SA46HB == 97 | C1SA46HB == 98 | C1SA46HB == 99)
replace C1SA47A = . if (C1SA47A == 97 | C1SA47A == 98 | C1SA47A == 99)
replace C1SA47B = . if (C1SA47B == 97 | C1SA47B == 98 | C1SA47B == 99)
replace C1SA51KA = . if (C1SA51KA == 97 | C1SA51KA == 98 | C1SA51KA == 99)
replace C1SA51KB = . if (C1SA51KB == 97 | C1SA51KB == 98 | C1SA51KB == 99)
replace C1SA52SA = . if (C1SA52SA == 97 | C1SA52SA == 98 | C1SA52SA == 99)
replace C1SA52SB = . if (C1SA52SB == 97 | C1SA52SB == 98 | C1SA52SB == 99)
replace C1SB8A1A = . if (C1SB8A1A == 97 | C1SB8A1A == 98 | C1SB8A1A == 99)
replace C1SB8A1B = . if (C1SB8A1B == 97 | C1SB8A1B == 98 | C1SB8A1B == 99)
replace C1SB8B1A = . if (C1SB8B1A == 97 | C1SB8B1A == 98 | C1SB8B1A == 99)
replace C1SB8B1B = . if (C1SB8B1B == 97 | C1SB8B1B == 98 | C1SB8B1B == 99)
replace C1SB8B1C = . if (C1SB8B1C == 97 | C1SB8B1C == 98 | C1SB8B1C == 99)
replace C1SB8C1A = . if (C1SB8C1A == 97 | C1SB8C1A == 98 | C1SB8C1A == 99)
replace C1SB8C1B = . if (C1SB8C1B == 97 | C1SB8C1B == 98 | C1SB8C1B == 99)
replace C1SB8C1C = . if (C1SB8C1C == 97 | C1SB8C1C == 98 | C1SB8C1C == 99)
replace C1SB8C1D = . if (C1SB8C1D == 97 | C1SB8C1D == 98 | C1SB8C1D == 99)
replace C1SB8C1E = . if (C1SB8C1E == 97 | C1SB8C1E == 98 | C1SB8C1E == 99)
replace C1SB8C1F = . if (C1SB8C1F == 97 | C1SB8C1F == 98 | C1SB8C1F == 99)
replace C1SB10A = . if (C1SB10A == 7 | C1SB10A == 8 | C1SB10A == 9)
replace C1SB10B = . if (C1SB10B == 7 | C1SB10B == 8 | C1SB10B == 9)
replace C1SB12GA = . if (C1SB12GA == 97 | C1SB12GA == 98 | C1SB12GA == 99)
replace C1SB12GB = . if (C1SB12GB == 97 | C1SB12GB == 98 | C1SB12GB == 99)
replace C1SB16DA = . if (C1SB16DA == 97 | C1SB16DA == 98 | C1SB16DA == 99)
replace C1SB16DB = . if (C1SB16DB == 97 | C1SB16DB == 98 | C1SB16DB == 99)
replace C1SB20GA = . if (C1SB20GA == 97 | C1SB20GA == 98 | C1SB20GA == 99)
replace C1SB20GB = . if (C1SB20GB == 97 | C1SB20GB == 98 | C1SB20GB == 99)
replace C1SB20GC = . if (C1SB20GC == 97 | C1SB20GC == 98 | C1SB20GC == 99)
replace C1SC2LA = . if (C1SC2LA == 97 | C1SC2LA == 98 | C1SC2LA == 99)
replace C1SG35A = . if (C1SG35A == 97 | C1SG35A == 98 | C1SG35A == 99)
replace C1SG35B = . if (C1SG35B == 97 | C1SG35B == 98 | C1SG35B == 99)
replace C1SG35C = . if (C1SG35C == 97 | C1SG35C == 98 | C1SG35C == 99)
replace C1SG37DA = . if (C1SG37DA == 97 | C1SG37DA == 98 | C1SG37DA == 99)
replace C1SG37DB = . if (C1SG37DB == 97 | C1SG37DB == 98 | C1SG37DB == 99)
replace C1SG40A = . if (C1SG40A == 97 | C1SG40A == 98 | C1SG40A == 99)
replace C1SG48EA = . if (C1SG48EA == 97 | C1SG48EA == 98 | C1SG48EA == 99)
replace C1SG48EB = . if (C1SG48EB == 97 | C1SG48EB == 98 | C1SG48EB == 99)
replace C1SI7A = . if (C1SI7A == 97 | C1SI7A == 98 | C1SI7A == 99)
replace C1SN1AA = . if (C1SN1AA == 97 | C1SN1AA == 98 | C1SN1AA == 99)
replace C1SN1BA = . if (C1SN1BA == 97 | C1SN1BA == 98 | C1SN1BA == 99)
replace C1SP4MA = . if (C1SP4MA == 97 | C1SP4MA == 98 | C1SP4MA == 99)
replace C1SP4MB = . if (C1SP4MB == 97 | C1SP4MB == 98 | C1SP4MB == 99)


