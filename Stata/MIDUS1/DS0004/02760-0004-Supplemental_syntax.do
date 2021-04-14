/*-------------------------------------------------------------------------*
 |                                                                         
 |            STATA SUPPLEMENTAL SYNTAX FILE FOR ICPSR 02760
 |           MIDLIFE IN THE UNITED STATES (MIDUS 1), 1995-1996
 |                   (DATASET 0004: TWIN SCREENER DATA)
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

replace IWDATE = "" if (IWDATE == ".")
replace TSTRTHR = . if (TSTRTHR == 97 | TSTRTHR == 98 | TSTRTHR == 99)
replace TSTRTMN = . if (TSTRTMN == 97 | TSTRTMN == 98 | TSTRTMN == 99)
replace Q2BORN1S = . if (Q2BORN1S == 7 | Q2BORN1S == 8 | Q2BORN1S == 9)
replace Q3BIRWTL = . if (Q3BIRWTL == 97 | Q3BIRWTL == 98 | Q3BIRWTL == 99)
replace Q3BIRWTO = . if (Q3BIRWTO == 97 | Q3BIRWTO == 98 | Q3BIRWTO == 99)
replace Q3ARNGL = . if (Q3ARNGL == 97 | Q3ARNGL == 98 | Q3ARNGL == 99)
replace Q3ARNGH = . if (Q3ARNGH == 97 | Q3ARNGH == 98 | Q3ARNGH == 99)
replace Q3BAPPRO = . if (Q3BAPPRO == 7 | Q3BAPPRO == 8 | Q3BAPPRO == 9)
replace Q4TWBWTL = . if (Q4TWBWTL == 97 | Q4TWBWTL == 98 | Q4TWBWTL == 99)
replace Q4TWBWTO = . if (Q4TWBWTO == 97 | Q4TWBWTO == 98 | Q4TWBWTO == 99)
replace Q4ATWRNG = . if (Q4ATWRNG == 97 | Q4ATWRNG == 98 | Q4ATWRNG == 99)
replace Q4ATWRAN = . if (Q4ATWRAN == 97 | Q4ATWRAN == 98 | Q4ATWRAN == 99)
replace Q4BTWAPP = . if (Q4BTWAPP == 7 | Q4BTWAPP == 8 | Q4BTWAPP == 9)
replace Q5SAMEPL = . if (Q5SAMEPL == 7 | Q5SAMEPL == 8 | Q5SAMEPL == 9)
replace Q6SAMECL = . if (Q6SAMECL == 7 | Q6SAMECL == 8 | Q6SAMECL == 9)
replace Q7DRESSL = . if (Q7DRESSL == 7 | Q7DRESSL == 8 | Q7DRESSL == 9)
replace Q8SHARER = . if (Q8SHARER == 7 | Q8SHARER == 8 | Q8SHARER == 9)
replace Q9YRSSHA = . if (Q9YRSSHA == 97.0 | Q9YRSSHA == 98.0 | Q9YRSSHA == 99.0)
replace Q10LEADE = . if (Q10LEADE == 7 | Q10LEADE == 8 | Q10LEADE == 9)
replace Q11ALWAY = . if (Q11ALWAY == 7 | Q11ALWAY == 8 | Q11ALWAY == 9)
replace Q12CKPT = . if (Q12CKPT == 7 | Q12CKPT == 8 | Q12CKPT == 9)
replace Q13DIFFE = . if (Q13DIFFE == 7 | Q13DIFFE == 8 | Q13DIFFE == 9)
replace Q14EYECO = . if (Q14EYECO == 7 | Q14EYECO == 8 | Q14EYECO == 9)
replace Q15HAIRC = . if (Q15HAIRC == 7 | Q15HAIRC == 8 | Q15HAIRC == 9)
replace Q16COMPL = . if (Q16COMPL == 7 | Q16COMPL == 8 | Q16COMPL == 9)
replace Q17FACIA = . if (Q17FACIA == 7 | Q17FACIA == 8 | Q17FACIA == 9)
replace Q18HEIGH = . if (Q18HEIGH == 7 | Q18HEIGH == 8 | Q18HEIGH == 9)
replace Q19WEIGH = . if (Q19WEIGH == 7 | Q19WEIGH == 8 | Q19WEIGH == 9)
replace Q20MOTHE = . if (Q20MOTHE == 7 | Q20MOTHE == 8 | Q20MOTHE == 9)
replace Q21FATHE = . if (Q21FATHE == 7 | Q21FATHE == 8 | Q21FATHE == 9)
replace Q22HHMS = . if (Q22HHMS == 7 | Q22HHMS == 8 | Q22HHMS == 9)
replace Q23OTHRE = . if (Q23OTHRE == 7 | Q23OTHRE == 8 | Q23OTHRE == 9)
replace Q24TEACH = . if (Q24TEACH == 7 | Q24TEACH == 8 | Q24TEACH == 9)
replace Q25ACQUA = . if (Q25ACQUA == 7 | Q25ACQUA == 8 | Q25ACQUA == 9)
replace Q26DIFFT = . if (Q26DIFFT == 7 | Q26DIFFT == 8 | Q26DIFFT == 9)
replace Q27FEET = . if (Q27FEET == 7 | Q27FEET == 8 | Q27FEET == 9)
replace Q27INCHE = . if (Q27INCHE == 97.00 | Q27INCHE == 98.00 | Q27INCHE == 99.00)
replace Q28WEIGH = . if (Q28WEIGH == 997 | Q28WEIGH == 998 | Q28WEIGH == 999)
replace Q29IDFRA = . if (Q29IDFRA == 97 | Q29IDFRA == 98 | Q29IDFRA == 99)
replace Q30PLACE = . if (Q30PLACE == 7 | Q30PLACE == 8 | Q30PLACE == 9)
replace Q31NO_PL = . if (Q31NO_PL == 7 | Q31NO_PL == 8 | Q31NO_PL == 9)
replace Q32TEST = . if (Q32TEST == 7 | Q32TEST == 8 | Q32TEST == 9)
replace Q34DOCTO = . if (Q34DOCTO == 7 | Q34DOCTO == 8 | Q34DOCTO == 9)
replace Q36CKPT = . if (Q36CKPT == 7 | Q36CKPT == 8 | Q36CKPT == 9)
replace Q37LKALI = . if (Q37LKALI == 7 | Q37LKALI == 8 | Q37LKALI == 9)
replace Q38AOREA = . if (Q38AOREA == 7 | Q38AOREA == 8 | Q38AOREA == 9)
replace Q40LIVEW = . if (Q40LIVEW == 7 | Q40LIVEW == 8 | Q40LIVEW == 9)
replace Q41TOTYR = . if (Q41TOTYR == 97.0 | Q41TOTYR == 98.0 | Q41TOTYR == 99.0)
replace Q42TOTYR = . if (Q42TOTYR == 97.00 | Q42TOTYR == 98.00 | Q42TOTYR == 99.00)
replace Q43AGELA = . if (Q43AGELA == 97.00 | Q43AGELA == 98.00 | Q43AGELA == 99.00)
replace Q44SEE_E = . if (Q44SEE_E == 7 | Q44SEE_E == 8 | Q44SEE_E == 9)
replace Q44ASEE_ = . if (Q44ASEE_ == 7 | Q44ASEE_ == 8 | Q44ASEE_ == 9)
replace Q44BSEE_ = . if (Q44BSEE_ == 7 | Q44BSEE_ == 8 | Q44BSEE_ == 9)
replace Q45CONTA = . if (Q45CONTA == 7 | Q45CONTA == 8 | Q45CONTA == 9)
replace Q45ACONT = . if (Q45ACONT == 7 | Q45ACONT == 8 | Q45ACONT == 9)
replace Q45BCONT = . if (Q45BCONT == 7 | Q45BCONT == 8 | Q45BCONT == 9)
replace Q46UNDER = . if (Q46UNDER == 7 | Q46UNDER == 8 | Q46UNDER == 9)
replace Q47RELYO = . if (Q47RELYO == 7 | Q47RELYO == 8 | Q47RELYO == 9)
replace Q48CARE = . if (Q48CARE == 7 | Q48CARE == 8 | Q48CARE == 9)
replace Q49OPENU = . if (Q49OPENU == 7 | Q49OPENU == 8 | Q49OPENU == 9)
replace Q50CRITI = . if (Q50CRITI == 7 | Q50CRITI == 8 | Q50CRITI == 9)
replace Q51DEMAN = . if (Q51DEMAN == 7 | Q51DEMAN == 8 | Q51DEMAN == 9)
replace Q52LETDO = . if (Q52LETDO == 7 | Q52LETDO == 8 | Q52LETDO == 9)
replace Q53NERVE = . if (Q53NERVE == 7 | Q53NERVE == 8 | Q53NERVE == 9)
replace Q54TURNT = . if (Q54TURNT == 7 | Q54TURNT == 8 | Q54TURNT == 9)
replace Q55TW_TU = . if (Q55TW_TU == 7 | Q55TW_TU == 8 | Q55TW_TU == 9)
replace Q56AMOTH = . if (Q56AMOTH == 7 | Q56AMOTH == 8 | Q56AMOTH == 9)
replace Q56BFATH = . if (Q56BFATH == 7 | Q56BFATH == 8 | Q56BFATH == 9)
replace Q58AMOTH = . if (Q58AMOTH == 7 | Q58AMOTH == 8 | Q58AMOTH == 9)
replace Q58BFATH = . if (Q58BFATH == 7 | Q58BFATH == 8 | Q58BFATH == 9)
replace Q57AKIDS = . if (Q57AKIDS == 97 | Q57AKIDS == 98 | Q57AKIDS == 99)
replace Q57BSIBS = . if (Q57BSIBS == 97 | Q57BSIBS == 98 | Q57BSIBS == 99)
replace Q59AKIDS = . if (Q59AKIDS == 97 | Q59AKIDS == 98 | Q59AKIDS == 99)
replace Q59BSIBS = . if (Q59BSIBS == 97 | Q59BSIBS == 98 | Q59BSIBS == 99)
replace Q60PHONE = . if (Q60PHONE == 97 | Q60PHONE == 98 | Q60PHONE == 99)
replace TIMEENDH = . if (TIMEENDH == 97 | TIMEENDH == 98 | TIMEENDH == 99)
replace TIMEENDM = . if (TIMEENDM == 97 | TIMEENDM == 98 | TIMEENDM == 99)


