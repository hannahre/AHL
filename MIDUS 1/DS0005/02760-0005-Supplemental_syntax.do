/*-------------------------------------------------------------------------*
 |                                                                         
 |            STATA SUPPLEMENTAL SYNTAX FILE FOR ICPSR 02760
 |           MIDLIFE IN THE UNITED STATES (MIDUS 1), 1995-1996
 |                    (DATASET 0005: CODED TEXT DATA)
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

replace A1PA11BJA = . if (A1PA11BJA == 97 | A1PA11BJA == 98 | A1PA11BJA == 99)
replace A1PA11BJB = . if (A1PA11BJB == 97 | A1PA11BJB == 98 | A1PA11BJB == 99)
replace A1PA11BJC = . if (A1PA11BJC == 97 | A1PA11BJC == 98 | A1PA11BJC == 99)
replace A1PA28DA = . if (A1PA28DA == 97 | A1PA28DA == 98 | A1PA28DA == 99)
replace A1PA28DB = . if (A1PA28DB == 97 | A1PA28DB == 98 | A1PA28DB == 99)
replace A1PA28DC = . if (A1PA28DC == 97 | A1PA28DC == 98 | A1PA28DC == 99)
replace A1PA28DD = . if (A1PA28DD == 97 | A1PA28DD == 98 | A1PA28DD == 99)
replace A1PA29CJA = . if (A1PA29CJA == 97 | A1PA29CJA == 98 | A1PA29CJA == 99)
replace A1PA29CJB = . if (A1PA29CJB == 97 | A1PA29CJB == 98 | A1PA29CJB == 99)
replace A1PA29CJC = . if (A1PA29CJC == 97 | A1PA29CJC == 98 | A1PA29CJC == 99)
replace A1PA38A = . if (A1PA38A == 97 | A1PA38A == 98 | A1PA38A == 99)
replace A1PA38B = . if (A1PA38B == 97 | A1PA38B == 98 | A1PA38B == 99)
replace A1PA38C = . if (A1PA38C == 97 | A1PA38C == 98 | A1PA38C == 99)
replace A1PA38D = . if (A1PA38D == 97 | A1PA38D == 98 | A1PA38D == 99)
replace A1PA38E = . if (A1PA38E == 97 | A1PA38E == 98 | A1PA38E == 99)
replace A1PA39JA = . if (A1PA39JA == 997 | A1PA39JA == 998 | A1PA39JA == 999)
replace A1PA39JB = . if (A1PA39JB == 997 | A1PA39JB == 998 | A1PA39JB == 999)
replace A1PB3KA = . if (A1PB3KA == 97 | A1PB3KA == 98 | A1PB3KA == 99)
replace A1PB3KB = . if (A1PB3KB == 97 | A1PB3KB == 98 | A1PB3KB == 99)
replace A1PB4GA = . if (A1PB4GA == 97 | A1PB4GA == 98 | A1PB4GA == 99)
replace A1PB4GB = . if (A1PB4GB == 97 | A1PB4GB == 98 | A1PB4GB == 99)
replace A1PB4GC = . if (A1PB4GC == 97 | A1PB4GC == 98 | A1PB4GC == 99)
replace A1PB28KA = . if (A1PB28KA == 97 | A1PB28KA == 98 | A1PB28KA == 99)
replace A1PB28KB = . if (A1PB28KB == 97 | A1PB28KB == 98 | A1PB28KB == 99)
replace A1PB29GA = . if (A1PB29GA == 97 | A1PB29GA == 98 | A1PB29GA == 99)
replace A1PB29GB = . if (A1PB29GB == 97 | A1PB29GB == 98 | A1PB29GB == 99)
replace A1PB29GC = . if (A1PB29GC == 97 | A1PB29GC == 98 | A1PB29GC == 99)
replace A1PB371BDA = . if (A1PB371BDA == 97 | A1PB371BDA == 98 | A1PB371BDA == 99)
replace A1PB371BDB = . if (A1PB371BDB == 97 | A1PB371BDB == 98 | A1PB371BDB == 99)
replace A1PB372BDA = . if (A1PB372BDA == 97 | A1PB372BDA == 98 | A1PB372BDA == 99)
replace A1PB372BDB = . if (A1PB372BDB == 97 | A1PB372BDB == 98 | A1PB372BDB == 99)
replace A1PB373BDA = . if (A1PB373BDA == 97 | A1PB373BDA == 98 | A1PB373BDA == 99)
replace A1PB374BDA = . if (A1PB374BDA == 97 | A1PB374BDA == 98 | A1PB374BDA == 99)
replace A1PB375BDA = . if (A1PB375BDA == 97 | A1PB375BDA == 98 | A1PB375BDA == 99)
replace A1PB376BDA = . if (A1PB376BDA == 97 | A1PB376BDA == 98 | A1PB376BDA == 99)
replace A1PB377BDA = . if (A1PB377BDA == 97 | A1PB377BDA == 98 | A1PB377BDA == 99)
replace A1PB377BDB = . if (A1PB377BDB == 97 | A1PB377BDB == 98 | A1PB377BDB == 99)
replace A1PB3710BDA = . if (A1PB3710BDA == 97 | A1PB3710BDA == 98 | A1PB3710BDA == 99)
replace A1PCBGA = . if (A1PCBGA == 97 | A1PCBGA == 98 | A1PCBGA == 99)
replace A1PCBGB = . if (A1PCBGB == 97 | A1PCBGB == 98 | A1PCBGB == 99)
replace A1PC1DA = . if (A1PC1DA == 97 | A1PC1DA == 98 | A1PC1DA == 99)
replace A1PC1DB = . if (A1PC1DB == 97 | A1PC1DB == 98 | A1PC1DB == 99)
replace A1PC3AEA = . if (A1PC3AEA == 97 | A1PC3AEA == 98 | A1PC3AEA == 99)
replace A1PC7DA = . if (A1PC7DA == 7 | A1PC7DA == 8 | A1PC7DA == 9)
replace A1PC7DB = . if (A1PC7DB == 7 | A1PC7DB == 8 | A1PC7DB == 9)
replace A1PC9AEA = . if (A1PC9AEA == 97 | A1PC9AEA == 98 | A1PC9AEA == 99)
replace A1PC9AEB = . if (A1PC9AEB == 97 | A1PC9AEB == 98 | A1PC9AEB == 99)
replace A1SA11EA = . if (A1SA11EA == 97 | A1SA11EA == 98 | A1SA11EA == 99)
replace A1SA11EB = . if (A1SA11EB == 97 | A1SA11EB == 98 | A1SA11EB == 99)
replace A1SA11EC = . if (A1SA11EC == 97 | A1SA11EC == 98 | A1SA11EC == 99)
replace A1SA11ED = . if (A1SA11ED == 97 | A1SA11ED == 98 | A1SA11ED == 99)
replace A1SA11EE = . if (A1SA11EE == 97 | A1SA11EE == 98 | A1SA11EE == 99)
replace A1SA11EF = . if (A1SA11EF == 97 | A1SA11EF == 98 | A1SA11EF == 99)
replace A1SA11EG = . if (A1SA11EG == 97 | A1SA11EG == 98 | A1SA11EG == 99)
replace A1SA11EH = . if (A1SA11EH == 97 | A1SA11EH == 98 | A1SA11EH == 99)
replace A1SA11EI = . if (A1SA11EI == 97 | A1SA11EI == 98 | A1SA11EI == 99)
replace A1SA30CA = . if (A1SA30CA == 97 | A1SA30CA == 98 | A1SA30CA == 99)
replace A1SA30CB = . if (A1SA30CB == 97 | A1SA30CB == 98 | A1SA30CB == 99)
replace A1SA30CC = . if (A1SA30CC == 97 | A1SA30CC == 98 | A1SA30CC == 99)
replace A1SA30CD = . if (A1SA30CD == 97 | A1SA30CD == 98 | A1SA30CD == 99)
replace A1SA38KA = . if (A1SA38KA == 97 | A1SA38KA == 98 | A1SA38KA == 99)
replace A1SA38KB = . if (A1SA38KB == 97 | A1SA38KB == 98 | A1SA38KB == 99)
replace A1SA38KC = . if (A1SA38KC == 97 | A1SA38KC == 98 | A1SA38KC == 99)
replace A1SA39PA = . if (A1SA39PA == 97 | A1SA39PA == 98 | A1SA39PA == 99)
replace A1SA39PB = . if (A1SA39PB == 97 | A1SA39PB == 98 | A1SA39PB == 99)
replace A1SA39PC = . if (A1SA39PC == 97 | A1SA39PC == 98 | A1SA39PC == 99)
replace A1SA39PD = . if (A1SA39PD == 97 | A1SA39PD == 98 | A1SA39PD == 99)
replace A1SR146A = . if (A1SR146A == 97 | A1SR146A == 98 | A1SR146A == 99)
replace A1SR146B = . if (A1SR146B == 97 | A1SR146B == 98 | A1SR146B == 99)
replace A1SR130A = . if (A1SR130A == 97 | A1SR130A == 98 | A1SR130A == 99)
replace A1SS1OA = . if (A1SS1OA == 97 | A1SS1OA == 98 | A1SS1OA == 99)
replace A1SS1OB = . if (A1SS1OB == 97 | A1SS1OB == 98 | A1SS1OB == 99)
replace A1SS6EA = . if (A1SS6EA == 97 | A1SS6EA == 98 | A1SS6EA == 99)
replace A1SS7EA = . if (A1SS7EA == 97 | A1SS7EA == 98 | A1SS7EA == 99)
replace A1SS7EB = . if (A1SS7EB == 97 | A1SS7EB == 98 | A1SS7EB == 99)
replace A1SS11AA = . if (A1SS11AA == 97 | A1SS11AA == 98 | A1SS11AA == 99)
replace A1SS11AB = . if (A1SS11AB == 97 | A1SS11AB == 98 | A1SS11AB == 99)
replace A1SS15JA = . if (A1SS15JA == 97 | A1SS15JA == 98 | A1SS15JA == 99)
replace A1SS15JB = . if (A1SS15JB == 97 | A1SS15JB == 98 | A1SS15JB == 99)
replace A1SS15JC = . if (A1SS15JC == 97 | A1SS15JC == 98 | A1SS15JC == 99)
replace A1SS15JD = . if (A1SS15JD == 97 | A1SS15JD == 98 | A1SS15JD == 99)


