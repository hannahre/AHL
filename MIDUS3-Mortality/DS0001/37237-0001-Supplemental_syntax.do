/*-------------------------------------------------------------------------*
 |                                                                         
 |            STATA SUPPLEMENTAL SYNTAX FILE FOR ICPSR 37237
 |        MIDLIFE IN THE UNITED STATES (MIDUS 3): MORTALITY DATA,
 |                                  2016
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

replace B1PGENDER = . if (B1PGENDER == -7 | B1PGENDER == -8 | B1PGENDER == -9)
replace DOD_M = . if (DOD_M == -7 | DOD_M == -8 | DOD_M == -9)
replace DOD_Y = . if (DOD_Y == -7 | DOD_Y == -8 | DOD_Y == -9)
replace ICD_SOURCE = . if (ICD_SOURCE == -9 | ICD_SOURCE == -99)


