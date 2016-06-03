---
title       : "String Manipulations: grep and regex"
subtitle    : Week 7.2
author      : Daniel Anderson
job         : CourseR
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- &twocol

<style>
em {
  font-style: italic
}
</style>

<style>
strong {
  font-weight: bold;
}
</style>

## Today's Agenda
String Searching and regular expressions

* Searching strings
	+ `grep()`
	+ `grepl()`
	+ `sub()`
	+ `gsub()`
* Regular expressions
	+ metacharacters
	+ character classes

----
## Needle in a haystack
`grep` and `grepl` can be used to find a needle (string pattern) in a haystack string vector. By default, `grep` will return the location in the vector of any string matching the pattern.


```r
fruits <- c("apple", "orange", "banana", "mango")
grep("b", fruits)
```

```
## [1] 3
```

```r
grep("o", fruits)
```

```
## [1] 2 4
```

-----
## Return values, rather than an index


```r
grep("b", fruits, value = TRUE)
```

```
## [1] "banana"
```

```r
grep("o", fruits, value = TRUE)
```

```
## [1] "orange" "mango"
```

----
## Logical version: `grepl`


```r
grepl("b", fruits)
```

```
## [1] FALSE FALSE  TRUE FALSE
```

```r
grepl("o", fruits)
```

```
## [1] FALSE  TRUE FALSE  TRUE
```

----
## Using `grep` and `grepl` for subsetting


```r
# load data
scCard <- read.csv("./data/CollegeScorecard.csv", 
	stringsAsFactors = FALSE, na = c("NULL", "PrivacySuppressed"))
head(scCard)
```

```
##   UNITID   OPEID opeid6                              INSTNM       CITY
## 1 100654  100200   1002            Alabama A & M University     Normal
## 2 100663  105200   1052 University of Alabama at Birmingham Birmingham
## 3 100690 2503400  25034                  Amridge University Montgomery
## 4 100706  105500   1055 University of Alabama in Huntsville Huntsville
## 5 100724  100500   1005            Alabama State University Montgomery
## 6 100751  105100   1051           The University of Alabama Tuscaloosa
##   STABBR                        INSTURL
## 1     AL                  www.aamu.edu/
## 2     AL                    www.uab.edu
## 3     AL      www.amridgeuniversity.edu
## 4     AL                    www.uah.edu
## 5     AL www.alasu.edu/email/index.aspx
## 6     AL                    www.ua.edu/
##                                                                                    NPCURL
## 1                                          galileo.aamu.edu/netpricecalculator/npcalc.htm
## 2                                         www.collegeportraits.org/AL/UAB/estimator/agree
## 3 tcc.noellevitz.com/(S(miwoihs5stz5cpyifh4nczu0))/Amridge%20University/Freshman-Students
## 4                                                                         finaid.uah.edu/
## 5                                     www.alasu.edu/cost-aid/forms/calculator/index.aspx/
## 6                                                                             oira.ua.edu
##   HCM2 PREDDEG CONTROL LOCALE HBCU PBI ANNHI TRIBAL AANAPII HSI NANTI
## 1    0       3       1     12    1   0     0      0       0   0     0
## 2    0       3       1     12    0   0     0      0       0   0     0
## 3    0       3       2     12    0   0     0      0       0   0     0
## 4    0       3       1     12    0   0     0      0       0   0     0
## 5    0       3       1     12    1   0     0      0       0   0     0
## 6    0       3       1     13    0   0     0      0       0   0     0
##   MENONLY WOMENONLY RELAFFIL SATVR25 SATVR75 SATMT25 SATMT75 SATWR25
## 1       0         0       NA     370     450     350     450      NA
## 2       0         0       NA     520     640     520     650      NA
## 3       0         0       74      NA      NA      NA      NA      NA
## 4       0         0       NA     510     640     510     650      NA
## 5       0         0       NA     380     480     370     480      NA
## 6       0         0       NA     490     620     500     640     480
##   SATWR75 SATVRMID SATMTMID SATWRMID ACTCM25 ACTCM75 ACTEN25 ACTEN75
## 1      NA      410      400       NA      15      19      14      19
## 2      NA      580      585       NA      22      28      22      29
## 3      NA       NA       NA       NA      NA      NA      NA      NA
## 4      NA      575      580       NA      23      29      22      30
## 5      NA      430      425       NA      15      19      14      20
## 6     600      555      570      540      22      30      22      32
##   ACTMT25 ACTMT75 ACTWR25 ACTWR75 ACTCMMID ACTENMID ACTMTMID ACTWRMID
## 1      15      18      NA      NA       17       17       17       NA
## 2      20      26      NA      NA       25       26       23       NA
## 3      NA      NA      NA      NA       NA       NA       NA       NA
## 4      22      28      NA      NA       26       26       25       NA
## 5      15      18      NA      NA       17       17       17       NA
## 6      21      28       6       8       26       27       25        7
##   SAT_AVG SAT_AVG_ALL PCIP01 PCIP03 PCIP04 PCIP05 PCIP09 PCIP10 PCIP11
## 1     823         823 0.0397 0.0199 0.0116 0.0000 0.0000 0.0348 0.0348
## 2    1146        1146 0.0000 0.0000 0.0000 0.0018 0.0456 0.0000 0.0099
## 3      NA          NA 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0411
## 4    1180        1180 0.0000 0.0000 0.0000 0.0000 0.0318 0.0000 0.0273
## 5     830         830 0.0000 0.0000 0.0000 0.0000 0.0733 0.0000 0.0450
## 6    1171        1171 0.0000 0.0054 0.0000 0.0022 0.1084 0.0000 0.0068
##   PCIP12 PCIP13 PCIP14 PCIP15 PCIP16 PCIP19 PCIP22 PCIP23 PCIP24 PCIP25
## 1      0 0.1490 0.1175 0.0348 0.0000 0.0281      0 0.0182 0.0546      0
## 2      0 0.0862 0.0632 0.0000 0.0090 0.0000      0 0.0203 0.0262      0
## 3      0 0.0000 0.0000 0.0000 0.0000 0.0000      0 0.0000 0.6301      0
## 4      0 0.0173 0.2566 0.0000 0.0173 0.0000      0 0.0309 0.0000      0
## 5      0 0.2150 0.0000 0.0000 0.0000 0.0000      0 0.0183 0.0000      0
## 6      0 0.0840 0.0640 0.0000 0.0068 0.0700      0 0.0178 0.0000      0
##   PCIP26 PCIP27 PCIP29 PCIP30 PCIP31 PCIP38 PCIP39 PCIP40 PCIP41 PCIP42
## 1 0.1026 0.0199      0 0.0000 0.0000 0.0000 0.0000 0.0248      0 0.0579
## 2 0.0619 0.0135      0 0.0000 0.0000 0.0095 0.0000 0.0181      0 0.0840
## 3 0.0000 0.0000      0 0.0000 0.0000 0.0000 0.2603 0.0000      0 0.0000
## 4 0.0855 0.0218      0 0.0000 0.0000 0.0082 0.0000 0.0209      0 0.0218
## 5 0.1033 0.0183      0 0.0000 0.0183 0.0000 0.0000 0.0150      0 0.0617
## 6 0.0348 0.0076      0 0.0302 0.0000 0.0060 0.0000 0.0074      0 0.0354
##   PCIP43 PCIP44 PCIP45 PCIP46 PCIP47 PCIP48 PCIP49 PCIP50 PCIP51 PCIP52
## 1 0.0050 0.0364 0.0480      0      0      0      0 0.0166 0.0000 0.1457
## 2 0.0280 0.0244 0.0501      0      0      0      0 0.0415 0.2090 0.1765
## 3 0.0000 0.0000 0.0000      0      0      0      0 0.0000 0.0000 0.0685
## 4 0.0000 0.0000 0.0173      0      0      0      0 0.0346 0.1720 0.2247
## 5 0.1183 0.0650 0.0150      0      0      0      0 0.0567 0.0633 0.1067
## 6 0.0216 0.0124 0.0422      0      0      0      0 0.0360 0.0946 0.2870
##   PCIP54 DISTANCEONLY  UGDS UGDS_WHITE UGDS_BLACK UGDS_HISP UGDS_ASIAN
## 1 0.0000            0  4051     0.0279     0.9501    0.0089     0.0022
## 2 0.0212            0 11200     0.5987     0.2590    0.0258     0.0518
## 3 0.0000            0   322     0.2919     0.4224    0.0093     0.0031
## 4 0.0118            0  5525     0.7012     0.1310    0.0338     0.0364
## 5 0.0067            0  5354     0.0161     0.9285    0.0114     0.0015
## 6 0.0194            0 28692     0.7865     0.1140    0.0313     0.0112
##   UGDS_AIAN UGDS_NHPI UGDS_2MOR UGDS_NRA UGDS_UNKN PPTUG_EF CURROPER
## 1    0.0012    0.0010    0.0000   0.0002    0.0084   0.0622        1
## 2    0.0026    0.0007    0.0344   0.0140    0.0130   0.2579        1
## 3    0.0031    0.0031    0.0000   0.0000    0.2671   0.3727        1
## 4    0.0145    0.0002    0.0161   0.0329    0.0338   0.2395        1
## 5    0.0009    0.0007    0.0064   0.0207    0.0138   0.0902        1
## 6    0.0044    0.0011    0.0210   0.0278    0.0028   0.0852        1
##   NPT4_PUB NPT4_PRIV NPT41_PUB NPT42_PUB NPT43_PUB NPT44_PUB NPT45_PUB
## 1    13415        NA     12683     13292     16104     16944     15416
## 2    14805        NA     12361     13765     16670     17096     17291
## 3       NA      7455        NA        NA        NA        NA        NA
## 4    17520        NA     14652     16334     19016     20263     20306
## 5    11936        NA     12342     10811     11362     13079      2948
## 6    20916        NA     17206     19960     21363     23115     23748
##   NPT41_PRIV NPT42_PRIV NPT43_PRIV NPT44_PRIV NPT45_PRIV PCTPELL RET_FT4
## 1         NA         NA         NA         NA         NA  0.7115  0.6314
## 2         NA         NA         NA         NA         NA  0.3505  0.8016
## 3       6736       9974         NA         NA         NA  0.6839  0.3750
## 4         NA         NA         NA         NA         NA  0.3281  0.8098
## 5         NA         NA         NA         NA         NA  0.8265  0.6219
## 6         NA         NA         NA         NA         NA  0.2107  0.8700
##   RET_FTL4 RET_PT4 RET_PTL4 PCTFLOAN UG25abv GRAD_DEBT_MDN_SUPP
## 1       NA  0.5000       NA   0.8204  0.1049            33611.5
## 2       NA  0.5000       NA   0.5397  0.2422            23117.0
## 3       NA  0.3333       NA   0.7629  0.8540                 NA
## 4       NA  0.4444       NA   0.4728  0.2640            24738.0
## 5       NA  0.3023       NA   0.8735  0.1270            33452.0
## 6       NA  0.6563       NA   0.4148  0.0853            24000.0
##   GRAD_DEBT_MDN10YR_SUPP RPY_3YR_RT_SUPP C150_4_POOLED_SUPP
## 1               373.1566       0.4447139          0.3087183
## 2               256.6461       0.7562667          0.5085498
## 3                     NA       0.6472492                 NA
## 4               274.6425       0.7819979          0.4782113
## 5               371.3858       0.3311989          0.2574820
## 6               266.4492       0.8139413          0.6660094
##   C200_L4_POOLED_SUPP md_earn_wne_p10 gt_25k_p6
## 1                  NA           31400 0.4622980
## 2                  NA           40300 0.6604845
## 3                  NA           38100 0.6466666
## 4                  NA           46600 0.6605657
## 5                  NA           27800 0.3422256
## 6                  NA           42400 0.6610854
```

----
## Select Institution ID and SAT variables


```r
sat <- scCard[ ,c(1, grep("SAT", names(scCard)))]
head(sat)
```

```
##   UNITID SATVR25 SATVR75 SATMT25 SATMT75 SATWR25 SATWR75 SATVRMID SATMTMID
## 1 100654     370     450     350     450      NA      NA      410      400
## 2 100663     520     640     520     650      NA      NA      580      585
## 3 100690      NA      NA      NA      NA      NA      NA       NA       NA
## 4 100706     510     640     510     650      NA      NA      575      580
## 5 100724     380     480     370     480      NA      NA      430      425
## 6 100751     490     620     500     640     480     600      555      570
##   SATWRMID SAT_AVG SAT_AVG_ALL
## 1       NA     823         823
## 2       NA    1146        1146
## 3       NA      NA          NA
## 4       NA    1180        1180
## 5       NA     830         830
## 6      540    1171        1171
```

---- &twocol
## with `grepl`
# Two steps, two methods

*** =left


```r
satVars <- grepl("SAT", names(scCard))
satVars[1] <- TRUE
sat <- scCard[ ,satVars]
head(sat)
```

```
##   UNITID SATVR25 SATVR75 SATMT25 SATMT75 SATWR25 SATWR75 SATVRMID SATMTMID
## 1 100654     370     450     350     450      NA      NA      410      400
## 2 100663     520     640     520     650      NA      NA      580      585
## 3 100690      NA      NA      NA      NA      NA      NA       NA       NA
## 4 100706     510     640     510     650      NA      NA      575      580
## 5 100724     380     480     370     480      NA      NA      430      425
## 6 100751     490     620     500     640     480     600      555      570
##   SATWRMID SAT_AVG SAT_AVG_ALL
## 1       NA     823         823
## 2       NA    1146        1146
## 3       NA      NA          NA
## 4       NA    1180        1180
## 5       NA     830         830
## 6      540    1171        1171
```

*** =right


```r
satVars <- scCard[ ,grepl("SAT", names(scCard))]
sat <- as.data.frame(
		cbind("UNITID" = scCard[ ,1], satVars))
head(sat)
```

```
##   UNITID SATVR25 SATVR75 SATMT25 SATMT75 SATWR25 SATWR75 SATVRMID SATMTMID
## 1 100654     370     450     350     450      NA      NA      410      400
## 2 100663     520     640     520     650      NA      NA      580      585
## 3 100690      NA      NA      NA      NA      NA      NA       NA       NA
## 4 100706     510     640     510     650      NA      NA      575      580
## 5 100724     380     480     370     480      NA      NA      430      425
## 6 100751     490     620     500     640     480     600      555      570
##   SATWRMID SAT_AVG SAT_AVG_ALL
## 1       NA     823         823
## 2       NA    1146        1146
## 3       NA      NA          NA
## 4       NA    1180        1180
## 5       NA     830         830
## 6      540    1171        1171
```

----
## Percentage degrees awarded by program type

<span style="color:gray"> see full data dictionary at </span> https://collegescorecard.ed.gov/data/documentation/


|Variable Name |Program                                                                          |
|:-------------|:--------------------------------------------------------------------------------|
|PCIP01        |Agriculture, Agriculture Operations, and Related Sciences                        |
|PCIP03        |Natural Resources and Conservation                                               |
|PCIP04        |Architecture and Related Services                                                |
|PCIP05        |Area, Ethnic, Cultural, Gender, and Group Studies                                |
|PCIP09        |Communication, Journalism, and Related Programs                                  |
|PCIP10        |Communications Technologies/Technicians and Support Services                     |
|PCIP11        |Computer and Information Sciences and Support Services                           |
|PCIP12        |Personal and Culinary Services                                                   |
|PCIP13        |Education                                                                        |
|PCIP14        |Engineering                                                                      |
|PCIP15        |Engineering Technologies and Engineering-Related Fields                          |
|PCIP16        |Foreign Languages, Literatures, and Linguistics                                  |
|PCIP19        |Family and Consumer Sciences/Human Sciences                                      |
|PCIP22        |Legal Professions and Studies                                                    |
|PCIP23        |English Language and Literature/Letters                                          |
|PCIP24        |Liberal Arts and Sciences, General Studies and Humanities                        |
|PCIP25        |Library Science                                                                  |
|PCIP26        |Biological and Biomedical Sciences                                               |
|PCIP27        |Mathematics and Statistics                                                       |
|PCIP29        |Military Technologies and Applied Sciences                                       |
|PCIP30        |Multi/Interdisciplinary Studies                                                  |
|PCIP31        |Parks, Recreation, Leisure, and Fitness Studies                                  |
|PCIP38        |Philosophy and Religious Studies                                                 |
|PCIP39        |Theology and Religious Vocations                                                 |
|PCIP40        |Physical Sciences                                                                |
|PCIP41        |Science Technologies/Technicians                                                 |
|PCIP42        |Psychology                                                                       |
|PCIP43        |Homeland Security, Law Enforcement, Firefighting and Related Protective Services |
|PCIP44        |Public Administration and Social Service Professions                             |
|PCIP45        |Social Sciences                                                                  |
|PCIP46        |Construction Trades                                                              |
|PCIP47        |Mechanic and Repair Technologies/Technicians                                     |
|PCIP48        |Precision Production                                                             |
|PCIP49        |Transportation and Materials Moving                                              |
|PCIP50        |Visual and Performing Arts                                                       |
|PCIP51        |Health Professions and Related Programs                                          |
|PCIP52        |Business, Management, Marketing, and Related Support Services                    |
|PCIP54        |History                                                                          |

----
## Select percentage degree awarded var


```r
pct <- scCard[ ,c(1, grep("PCIP", names(scCard)))]
head(pct)
```

```
##   UNITID PCIP01 PCIP03 PCIP04 PCIP05 PCIP09 PCIP10 PCIP11 PCIP12 PCIP13
## 1 100654 0.0397 0.0199 0.0116 0.0000 0.0000 0.0348 0.0348      0 0.1490
## 2 100663 0.0000 0.0000 0.0000 0.0018 0.0456 0.0000 0.0099      0 0.0862
## 3 100690 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0411      0 0.0000
## 4 100706 0.0000 0.0000 0.0000 0.0000 0.0318 0.0000 0.0273      0 0.0173
## 5 100724 0.0000 0.0000 0.0000 0.0000 0.0733 0.0000 0.0450      0 0.2150
## 6 100751 0.0000 0.0054 0.0000 0.0022 0.1084 0.0000 0.0068      0 0.0840
##   PCIP14 PCIP15 PCIP16 PCIP19 PCIP22 PCIP23 PCIP24 PCIP25 PCIP26 PCIP27
## 1 0.1175 0.0348 0.0000 0.0281      0 0.0182 0.0546      0 0.1026 0.0199
## 2 0.0632 0.0000 0.0090 0.0000      0 0.0203 0.0262      0 0.0619 0.0135
## 3 0.0000 0.0000 0.0000 0.0000      0 0.0000 0.6301      0 0.0000 0.0000
## 4 0.2566 0.0000 0.0173 0.0000      0 0.0309 0.0000      0 0.0855 0.0218
## 5 0.0000 0.0000 0.0000 0.0000      0 0.0183 0.0000      0 0.1033 0.0183
## 6 0.0640 0.0000 0.0068 0.0700      0 0.0178 0.0000      0 0.0348 0.0076
##   PCIP29 PCIP30 PCIP31 PCIP38 PCIP39 PCIP40 PCIP41 PCIP42 PCIP43 PCIP44
## 1      0 0.0000 0.0000 0.0000 0.0000 0.0248      0 0.0579 0.0050 0.0364
## 2      0 0.0000 0.0000 0.0095 0.0000 0.0181      0 0.0840 0.0280 0.0244
## 3      0 0.0000 0.0000 0.0000 0.2603 0.0000      0 0.0000 0.0000 0.0000
## 4      0 0.0000 0.0000 0.0082 0.0000 0.0209      0 0.0218 0.0000 0.0000
## 5      0 0.0000 0.0183 0.0000 0.0000 0.0150      0 0.0617 0.1183 0.0650
## 6      0 0.0302 0.0000 0.0060 0.0000 0.0074      0 0.0354 0.0216 0.0124
##   PCIP45 PCIP46 PCIP47 PCIP48 PCIP49 PCIP50 PCIP51 PCIP52 PCIP54
## 1 0.0480      0      0      0      0 0.0166 0.0000 0.1457 0.0000
## 2 0.0501      0      0      0      0 0.0415 0.2090 0.1765 0.0212
## 3 0.0000      0      0      0      0 0.0000 0.0000 0.0685 0.0000
## 4 0.0173      0      0      0      0 0.0346 0.1720 0.2247 0.0118
## 5 0.0150      0      0      0      0 0.0567 0.0633 0.1067 0.0067
## 6 0.0422      0      0      0      0 0.0360 0.0946 0.2870 0.0194
```

----
## Create a new variable **max** variable
Variable should include the name of the PCIP that corresponds to its maximum.


```r
# Remove rows with complete missing data
pct2 <- pct[apply(pct[ ,-1], 1, function(x) sum(is.na(x)) != (ncol(pct) -1)), ]

maxLoc <- apply(pct2[ ,-1], 1, which.max) + 1
pct2$maxprop <- sapply(1:nrow(pct2), function(i) {
	names(pct2)[maxLoc[i]]
})
head(pct2[ ,35:40])
```

```
##   PCIP49 PCIP50 PCIP51 PCIP52 PCIP54 maxprop
## 1      0 0.0166 0.0000 0.1457 0.0000  PCIP13
## 2      0 0.0415 0.2090 0.1765 0.0212  PCIP51
## 3      0 0.0000 0.0000 0.0685 0.0000  PCIP24
## 4      0 0.0346 0.1720 0.2247 0.0118  PCIP14
## 5      0 0.0567 0.0633 0.1067 0.0067  PCIP13
## 6      0 0.0360 0.0946 0.2870 0.0194  PCIP52
```

----
## Merge results back in


```r
scCard <- merge(scCard, pct2[ ,c(1, ncol(pct2))], by = 1, all = TRUE)
par(las = 2)
plot(table(scCard$maxprop),
	main = "Frequency of Max Graduation Programs",
	xlab = "Program Code",
	ylab = "Frequency",
	tck = 0,
	cex.axis = 0.6)
```

----

![plot of chunk mergeMaxProp](assets/fig/mergeMaxProp-1.png)

----
## Selecting rows
Select only Oregon schools


```r
OR <- scCard[grep("OR", scCard$STABBR), ] # grepl could be used equivalntly
table(OR$STABBR)
```

```
## 
## OR 
## 96
```

```r
head(OR)
```

```
##      UNITID   OPEID opeid6                            INSTNM      CITY
## 3126 208080 1050700  10507      Academy of Hair Design-Salem     Salem
## 3127 208123 3783400  37834         Abdill Career College Inc   Medford
## 3128 208187 2311000  23110 Paul Mitchell the School-Portland  Portland
## 3129 208239  781900   7819     The Art Institute of Portland  Portland
## 3130 208248 2154400  21544 Beau Monde College of Hair Design  Portland
## 3131 208275  318600   3186   Blue Mountain Community College Pendleton
##      STABBR                         INSTURL
## 3126     OR        academyofhairdesign.info
## 3127     OR                  www.abdill.com
## 3128     OR      portland.paulmitchell.edu:
## 3129     OR www.artinstitutes.edu/portland/
## 3130     OR        www.beaumondecollege.com
## 3131     OR                  www.bluecc.edu
##                                                                           NPCURL
## 3126                           netcalculator.academyofhairdesign.info/npcalc.htm
## 3127                                                 files.abdill.com/npcalc.htm
## 3128                          portland.paulmitchell.edu/programs/finance-options
## 3129 tcc.noellevitz.com/edmc/Freshman-Students?iframe=true&width=600&height=1000
## 3130                                                    www.beaumondecollege.com
## 3131                   www.bluecc.edu/sites/bluecc.edu/files/NetPrice/npcalc.htm
##      HCM2 PREDDEG CONTROL LOCALE HBCU PBI ANNHI TRIBAL AANAPII HSI NANTI
## 3126    0       1       3     12    0   0     0      0       0   0     0
## 3127    0       1       3     13    0   0     0      0       0   0     0
## 3128    0       1       3     11    0   0     0      0       0   0     0
## 3129    0       3       3     11    0   0     0      0       0   0     0
## 3130    0       1       3     11    0   0     0      0       0   0     0
## 3131    0       2       1     41    0   0     0      0       0   0     0
##      MENONLY WOMENONLY RELAFFIL SATVR25 SATVR75 SATMT25 SATMT75 SATWR25
## 3126       0         0       NA      NA      NA      NA      NA      NA
## 3127       0         0       NA      NA      NA      NA      NA      NA
## 3128       0         0       NA      NA      NA      NA      NA      NA
## 3129       0         0       NA      NA      NA      NA      NA      NA
## 3130       0         0       NA      NA      NA      NA      NA      NA
## 3131       0         0       NA      NA      NA      NA      NA      NA
##      SATWR75 SATVRMID SATMTMID SATWRMID ACTCM25 ACTCM75 ACTEN25 ACTEN75
## 3126      NA       NA       NA       NA      NA      NA      NA      NA
## 3127      NA       NA       NA       NA      NA      NA      NA      NA
## 3128      NA       NA       NA       NA      NA      NA      NA      NA
## 3129      NA       NA       NA       NA      NA      NA      NA      NA
## 3130      NA       NA       NA       NA      NA      NA      NA      NA
## 3131      NA       NA       NA       NA      NA      NA      NA      NA
##      ACTMT25 ACTMT75 ACTWR25 ACTWR75 ACTCMMID ACTENMID ACTMTMID ACTWRMID
## 3126      NA      NA      NA      NA       NA       NA       NA       NA
## 3127      NA      NA      NA      NA       NA       NA       NA       NA
## 3128      NA      NA      NA      NA       NA       NA       NA       NA
## 3129      NA      NA      NA      NA       NA       NA       NA       NA
## 3130      NA      NA      NA      NA       NA       NA       NA       NA
## 3131      NA      NA      NA      NA       NA       NA       NA       NA
##      SAT_AVG SAT_AVG_ALL PCIP01 PCIP03 PCIP04 PCIP05 PCIP09 PCIP10 PCIP11
## 3126      NA          NA 0.0000      0      0      0 0.0000 0.0000 0.0000
## 3127      NA          NA 0.0000      0      0      0 0.0000 0.0000 0.0000
## 3128      NA          NA 0.0000      0      0      0 0.0000 0.0000 0.0000
## 3129      NA          NA 0.0000      0      0      0 0.0241 0.0103 0.1724
## 3130      NA          NA 0.0000      0      0      0 0.0000 0.0000 0.0000
## 3131      NA          NA 0.0172      0      0      0 0.0000 0.0000 0.0000
##      PCIP12 PCIP13 PCIP14 PCIP15 PCIP16 PCIP19 PCIP22 PCIP23 PCIP24 PCIP25
## 3126    1.0 0.0000      0 0.0000      0      0 0.0000      0 0.0000      0
## 3127    0.0 0.0000      0 0.0000      0      0 0.0137      0 0.0000      0
## 3128    1.0 0.0000      0 0.0000      0      0 0.0000      0 0.0000      0
## 3129    0.1 0.0000      0 0.0000      0      0 0.0000      0 0.0000      0
## 3130    1.0 0.0000      0 0.0000      0      0 0.0000      0 0.0000      0
## 3131    0.0 0.0931      0 0.0392      0      0 0.0000      0 0.5539      0
##      PCIP26 PCIP27 PCIP29 PCIP30 PCIP31 PCIP38 PCIP39 PCIP40 PCIP41 PCIP42
## 3126      0      0      0      0      0      0      0      0      0      0
## 3127      0      0      0      0      0      0      0      0      0      0
## 3128      0      0      0      0      0      0      0      0      0      0
## 3129      0      0      0      0      0      0      0      0      0      0
## 3130      0      0      0      0      0      0      0      0      0      0
## 3131      0      0      0      0      0      0      0      0      0      0
##      PCIP43 PCIP44 PCIP45 PCIP46 PCIP47 PCIP48 PCIP49 PCIP50 PCIP51 PCIP52
## 3126      0      0      0 0.0000 0.0000 0.0000      0 0.0000 0.0000 0.0000
## 3127      0      0      0 0.0000 0.0000 0.0000      0 0.0000 0.9315 0.0548
## 3128      0      0      0 0.0000 0.0000 0.0000      0 0.0000 0.0000 0.0000
## 3129      0      0      0 0.0000 0.0000 0.0000      0 0.5897 0.0000 0.1034
## 3130      0      0      0 0.0000 0.0000 0.0000      0 0.0000 0.0000 0.0000
## 3131      0      0      0 0.0025 0.0588 0.0074      0 0.0000 0.0809 0.1471
##      PCIP54 DISTANCEONLY UGDS UGDS_WHITE UGDS_BLACK UGDS_HISP UGDS_ASIAN
## 3126      0            0   56     0.7679     0.0536    0.1786     0.0000
## 3127      0            0   80     0.8125     0.0250    0.1375     0.0250
## 3128      0            0   88     0.8750     0.0000    0.0455     0.0000
## 3129      0            0 1348     0.1847     0.0074    0.1031     0.0260
## 3130      0            0  126     0.7302     0.1190    0.1111     0.0079
## 3131      0            0 1550     0.6923     0.0110    0.1910     0.0090
##      UGDS_AIAN UGDS_NHPI UGDS_2MOR UGDS_NRA UGDS_UNKN PPTUG_EF CURROPER
## 3126    0.0000    0.0000    0.0000   0.0000    0.0000   0.0000        1
## 3127    0.0000    0.0000    0.0000   0.0000    0.0000   0.0000        1
## 3128    0.0227    0.0000    0.0114   0.0000    0.0455   0.0000        1
## 3129    0.0037    0.0007    0.0000   0.0000    0.6743   0.3175        1
## 3130    0.0159    0.0000    0.0079   0.0079    0.0000   0.0000        1
## 3131    0.0277    0.0058    0.0368   0.0013    0.0252   0.3761        1
##      NPT4_PUB NPT4_PRIV NPT41_PUB NPT42_PUB NPT43_PUB NPT44_PUB NPT45_PUB
## 3126       NA     10839        NA        NA        NA        NA        NA
## 3127       NA     21353        NA        NA        NA        NA        NA
## 3128       NA        NA        NA        NA        NA        NA        NA
## 3129       NA     27383        NA        NA        NA        NA        NA
## 3130       NA      8653        NA        NA        NA        NA        NA
## 3131    10679        NA      9947     10574     11730     13544     13289
##      NPT41_PRIV NPT42_PRIV NPT43_PRIV NPT44_PRIV NPT45_PRIV PCTPELL
## 3126      10839         NA         NA         NA         NA  1.0000
## 3127      21015      22297      22147      23847      23714  0.8110
## 3128         NA         NA         NA         NA         NA  0.0000
## 3129      25466      27342      28843      31389      30908  0.5645
## 3130       8298      10115      10573         NA         NA  0.4794
## 3131         NA         NA         NA         NA         NA  0.3296
##      RET_FT4 RET_FTL4 RET_PT4 RET_PTL4 PCTFLOAN UG25abv GRAD_DEBT_MDN_SUPP
## 3126      NA   0.7273      NA       NA   1.0000  0.5536            18833.0
## 3127      NA       NA      NA       NA   0.8346  0.4500             9500.0
## 3128      NA       NA      NA       NA   0.0000  0.2159                 NA
## 3129  0.4527       NA  0.4333       NA   0.7974  0.4110            35287.0
## 3130      NA   0.9130      NA       NA   0.5928  0.3413            12295.5
## 3131      NA   0.3221      NA   0.3273   0.2017  0.3920            14549.0
##      GRAD_DEBT_MDN10YR_SUPP RPY_3YR_RT_SUPP C150_4_POOLED_SUPP
## 3126               209.0849       0.3877551                 NA
## 3127               105.4695       0.5403727                 NA
## 3128                     NA              NA                 NA
## 3129               391.7580       0.7190442           0.304133
## 3130               136.5053       0.3333333                 NA
## 3131               161.5237       0.4602941                 NA
##      C200_L4_POOLED_SUPP md_earn_wne_p10 gt_25k_p6 maxprop
## 3126           0.5658000           14500 0.1964286  PCIP12
## 3127           0.5652014              NA 0.4305556  PCIP51
## 3128                  NA              NA        NA  PCIP12
## 3129                  NA           33000 0.4994475  PCIP50
## 3130           0.7814305           20700 0.3461539  PCIP12
## 3131           0.2670621           28800 0.4957265  PCIP24
```

----
## Selecting rows (continued)
Select only schools with ".edu" in their website (i.e., eliminate hair schools, etc.)


```r
eduWeb <- scCard[grep(".edu", scCard$INSTURL), ]
head(eduWeb)
```

```
##   UNITID   OPEID opeid6                              INSTNM       CITY
## 1 100654  100200   1002            Alabama A & M University     Normal
## 2 100663  105200   1052 University of Alabama at Birmingham Birmingham
## 3 100690 2503400  25034                  Amridge University Montgomery
## 4 100706  105500   1055 University of Alabama in Huntsville Huntsville
## 5 100724  100500   1005            Alabama State University Montgomery
## 6 100751  105100   1051           The University of Alabama Tuscaloosa
##   STABBR                        INSTURL
## 1     AL                  www.aamu.edu/
## 2     AL                    www.uab.edu
## 3     AL      www.amridgeuniversity.edu
## 4     AL                    www.uah.edu
## 5     AL www.alasu.edu/email/index.aspx
## 6     AL                    www.ua.edu/
##                                                                                    NPCURL
## 1                                          galileo.aamu.edu/netpricecalculator/npcalc.htm
## 2                                         www.collegeportraits.org/AL/UAB/estimator/agree
## 3 tcc.noellevitz.com/(S(miwoihs5stz5cpyifh4nczu0))/Amridge%20University/Freshman-Students
## 4                                                                         finaid.uah.edu/
## 5                                     www.alasu.edu/cost-aid/forms/calculator/index.aspx/
## 6                                                                             oira.ua.edu
##   HCM2 PREDDEG CONTROL LOCALE HBCU PBI ANNHI TRIBAL AANAPII HSI NANTI
## 1    0       3       1     12    1   0     0      0       0   0     0
## 2    0       3       1     12    0   0     0      0       0   0     0
## 3    0       3       2     12    0   0     0      0       0   0     0
## 4    0       3       1     12    0   0     0      0       0   0     0
## 5    0       3       1     12    1   0     0      0       0   0     0
## 6    0       3       1     13    0   0     0      0       0   0     0
##   MENONLY WOMENONLY RELAFFIL SATVR25 SATVR75 SATMT25 SATMT75 SATWR25
## 1       0         0       NA     370     450     350     450      NA
## 2       0         0       NA     520     640     520     650      NA
## 3       0         0       74      NA      NA      NA      NA      NA
## 4       0         0       NA     510     640     510     650      NA
## 5       0         0       NA     380     480     370     480      NA
## 6       0         0       NA     490     620     500     640     480
##   SATWR75 SATVRMID SATMTMID SATWRMID ACTCM25 ACTCM75 ACTEN25 ACTEN75
## 1      NA      410      400       NA      15      19      14      19
## 2      NA      580      585       NA      22      28      22      29
## 3      NA       NA       NA       NA      NA      NA      NA      NA
## 4      NA      575      580       NA      23      29      22      30
## 5      NA      430      425       NA      15      19      14      20
## 6     600      555      570      540      22      30      22      32
##   ACTMT25 ACTMT75 ACTWR25 ACTWR75 ACTCMMID ACTENMID ACTMTMID ACTWRMID
## 1      15      18      NA      NA       17       17       17       NA
## 2      20      26      NA      NA       25       26       23       NA
## 3      NA      NA      NA      NA       NA       NA       NA       NA
## 4      22      28      NA      NA       26       26       25       NA
## 5      15      18      NA      NA       17       17       17       NA
## 6      21      28       6       8       26       27       25        7
##   SAT_AVG SAT_AVG_ALL PCIP01 PCIP03 PCIP04 PCIP05 PCIP09 PCIP10 PCIP11
## 1     823         823 0.0397 0.0199 0.0116 0.0000 0.0000 0.0348 0.0348
## 2    1146        1146 0.0000 0.0000 0.0000 0.0018 0.0456 0.0000 0.0099
## 3      NA          NA 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0411
## 4    1180        1180 0.0000 0.0000 0.0000 0.0000 0.0318 0.0000 0.0273
## 5     830         830 0.0000 0.0000 0.0000 0.0000 0.0733 0.0000 0.0450
## 6    1171        1171 0.0000 0.0054 0.0000 0.0022 0.1084 0.0000 0.0068
##   PCIP12 PCIP13 PCIP14 PCIP15 PCIP16 PCIP19 PCIP22 PCIP23 PCIP24 PCIP25
## 1      0 0.1490 0.1175 0.0348 0.0000 0.0281      0 0.0182 0.0546      0
## 2      0 0.0862 0.0632 0.0000 0.0090 0.0000      0 0.0203 0.0262      0
## 3      0 0.0000 0.0000 0.0000 0.0000 0.0000      0 0.0000 0.6301      0
## 4      0 0.0173 0.2566 0.0000 0.0173 0.0000      0 0.0309 0.0000      0
## 5      0 0.2150 0.0000 0.0000 0.0000 0.0000      0 0.0183 0.0000      0
## 6      0 0.0840 0.0640 0.0000 0.0068 0.0700      0 0.0178 0.0000      0
##   PCIP26 PCIP27 PCIP29 PCIP30 PCIP31 PCIP38 PCIP39 PCIP40 PCIP41 PCIP42
## 1 0.1026 0.0199      0 0.0000 0.0000 0.0000 0.0000 0.0248      0 0.0579
## 2 0.0619 0.0135      0 0.0000 0.0000 0.0095 0.0000 0.0181      0 0.0840
## 3 0.0000 0.0000      0 0.0000 0.0000 0.0000 0.2603 0.0000      0 0.0000
## 4 0.0855 0.0218      0 0.0000 0.0000 0.0082 0.0000 0.0209      0 0.0218
## 5 0.1033 0.0183      0 0.0000 0.0183 0.0000 0.0000 0.0150      0 0.0617
## 6 0.0348 0.0076      0 0.0302 0.0000 0.0060 0.0000 0.0074      0 0.0354
##   PCIP43 PCIP44 PCIP45 PCIP46 PCIP47 PCIP48 PCIP49 PCIP50 PCIP51 PCIP52
## 1 0.0050 0.0364 0.0480      0      0      0      0 0.0166 0.0000 0.1457
## 2 0.0280 0.0244 0.0501      0      0      0      0 0.0415 0.2090 0.1765
## 3 0.0000 0.0000 0.0000      0      0      0      0 0.0000 0.0000 0.0685
## 4 0.0000 0.0000 0.0173      0      0      0      0 0.0346 0.1720 0.2247
## 5 0.1183 0.0650 0.0150      0      0      0      0 0.0567 0.0633 0.1067
## 6 0.0216 0.0124 0.0422      0      0      0      0 0.0360 0.0946 0.2870
##   PCIP54 DISTANCEONLY  UGDS UGDS_WHITE UGDS_BLACK UGDS_HISP UGDS_ASIAN
## 1 0.0000            0  4051     0.0279     0.9501    0.0089     0.0022
## 2 0.0212            0 11200     0.5987     0.2590    0.0258     0.0518
## 3 0.0000            0   322     0.2919     0.4224    0.0093     0.0031
## 4 0.0118            0  5525     0.7012     0.1310    0.0338     0.0364
## 5 0.0067            0  5354     0.0161     0.9285    0.0114     0.0015
## 6 0.0194            0 28692     0.7865     0.1140    0.0313     0.0112
##   UGDS_AIAN UGDS_NHPI UGDS_2MOR UGDS_NRA UGDS_UNKN PPTUG_EF CURROPER
## 1    0.0012    0.0010    0.0000   0.0002    0.0084   0.0622        1
## 2    0.0026    0.0007    0.0344   0.0140    0.0130   0.2579        1
## 3    0.0031    0.0031    0.0000   0.0000    0.2671   0.3727        1
## 4    0.0145    0.0002    0.0161   0.0329    0.0338   0.2395        1
## 5    0.0009    0.0007    0.0064   0.0207    0.0138   0.0902        1
## 6    0.0044    0.0011    0.0210   0.0278    0.0028   0.0852        1
##   NPT4_PUB NPT4_PRIV NPT41_PUB NPT42_PUB NPT43_PUB NPT44_PUB NPT45_PUB
## 1    13415        NA     12683     13292     16104     16944     15416
## 2    14805        NA     12361     13765     16670     17096     17291
## 3       NA      7455        NA        NA        NA        NA        NA
## 4    17520        NA     14652     16334     19016     20263     20306
## 5    11936        NA     12342     10811     11362     13079      2948
## 6    20916        NA     17206     19960     21363     23115     23748
##   NPT41_PRIV NPT42_PRIV NPT43_PRIV NPT44_PRIV NPT45_PRIV PCTPELL RET_FT4
## 1         NA         NA         NA         NA         NA  0.7115  0.6314
## 2         NA         NA         NA         NA         NA  0.3505  0.8016
## 3       6736       9974         NA         NA         NA  0.6839  0.3750
## 4         NA         NA         NA         NA         NA  0.3281  0.8098
## 5         NA         NA         NA         NA         NA  0.8265  0.6219
## 6         NA         NA         NA         NA         NA  0.2107  0.8700
##   RET_FTL4 RET_PT4 RET_PTL4 PCTFLOAN UG25abv GRAD_DEBT_MDN_SUPP
## 1       NA  0.5000       NA   0.8204  0.1049            33611.5
## 2       NA  0.5000       NA   0.5397  0.2422            23117.0
## 3       NA  0.3333       NA   0.7629  0.8540                 NA
## 4       NA  0.4444       NA   0.4728  0.2640            24738.0
## 5       NA  0.3023       NA   0.8735  0.1270            33452.0
## 6       NA  0.6563       NA   0.4148  0.0853            24000.0
##   GRAD_DEBT_MDN10YR_SUPP RPY_3YR_RT_SUPP C150_4_POOLED_SUPP
## 1               373.1566       0.4447139          0.3087183
## 2               256.6461       0.7562667          0.5085498
## 3                     NA       0.6472492                 NA
## 4               274.6425       0.7819979          0.4782113
## 5               371.3858       0.3311989          0.2574820
## 6               266.4492       0.8139413          0.6660094
##   C200_L4_POOLED_SUPP md_earn_wne_p10 gt_25k_p6 maxprop
## 1                  NA           31400 0.4622980  PCIP13
## 2                  NA           40300 0.6604845  PCIP51
## 3                  NA           38100 0.6466666  PCIP24
## 4                  NA           46600 0.6605657  PCIP14
## 5                  NA           27800 0.3422256  PCIP13
## 6                  NA           42400 0.6610854  PCIP52
```

----
## Select only community colleges


```r
Sys.setlocale('LC_ALL','C')
```

```
## [1] "C/C/C/C/C/en_US.UTF-8"
```

```r
# I was getting some weird warnings with the code below. Google 
# helped me fix it with the above line of code. Still not sure 
# what was going on.

cc <- scCard[grep("Community", scCard$INSTNM), ]
head(cc)
```

```
##    UNITID   OPEID opeid6                                          INSTNM
## 7  100760  100700   1007               Central Alabama Community College
## 12 101028 1218200  12182          Chattahoochee Valley Community College
## 15 101143  101500   1015              Enterprise State Community College
## 16 101161  106000   1060        James H Faulkner State Community College
## 18 101240  101700   1017                 Gadsden State Community College
## 20 101286  101800   1018 George C Wallace State Community College-Dothan
##              CITY STABBR               INSTURL
## 7  Alexander City     AL          www.cacc.edu
## 12    Phenix City     AL            www.cv.edu
## 15     Enterprise     AL          www.escc.edu
## 16    Bay Minette     AL www.faulknerstate.edu
## 18        Gadsden     AL  www.gadsdenstate.edu
## 20         Dothan     AL       www.wallace.edu
##                                                 NPCURL HCM2 PREDDEG
## 7  www.cacc.edu/graphics/netpricecalculator/npcalc.htm    0       2
## 12                      external.cv.edu/npc/npcalc.htm    0       2
## 15                    www.escc.edu/NetPrice/npcalc.htm    0       2
## 16                               www.faulknerstate.edu    0       2
## 18            www.gadsdenstate.edu/netpricecalculator/    0       2
## 20           www.wallace.edu/net_price_calculator.aspx    0       2
##    CONTROL LOCALE HBCU PBI ANNHI TRIBAL AANAPII HSI NANTI MENONLY
## 7        1     32    0   0     0      0       0   0     0       0
## 12       1     41    0   0     0      0       0   0     0       0
## 15       1     32    0   0     0      0       0   0     0       0
## 16       1     32    0   0     0      0       0   0     0       0
## 18       1     13    1   0     0      0       0   0     0       0
## 20       1     41    0   0     0      0       0   0     0       0
##    WOMENONLY RELAFFIL SATVR25 SATVR75 SATMT25 SATMT75 SATWR25 SATWR75
## 7          0       NA      NA      NA      NA      NA      NA      NA
## 12         0       NA      NA      NA      NA      NA      NA      NA
## 15         0       NA      NA      NA      NA      NA      NA      NA
## 16         0       NA      NA      NA      NA      NA      NA      NA
## 18         0       NA      NA      NA      NA      NA      NA      NA
## 20         0       NA      NA      NA      NA      NA      NA      NA
##    SATVRMID SATMTMID SATWRMID ACTCM25 ACTCM75 ACTEN25 ACTEN75 ACTMT25
## 7        NA       NA       NA      NA      NA      NA      NA      NA
## 12       NA       NA       NA      NA      NA      NA      NA      NA
## 15       NA       NA       NA      NA      NA      NA      NA      NA
## 16       NA       NA       NA      NA      NA      NA      NA      NA
## 18       NA       NA       NA      NA      NA      NA      NA      NA
## 20       NA       NA       NA      NA      NA      NA      NA      NA
##    ACTMT75 ACTWR25 ACTWR75 ACTCMMID ACTENMID ACTMTMID ACTWRMID SAT_AVG
## 7       NA      NA      NA       NA       NA       NA       NA      NA
## 12      NA      NA      NA       NA       NA       NA       NA      NA
## 15      NA      NA      NA       NA       NA       NA       NA      NA
## 16      NA      NA      NA       NA       NA       NA       NA      NA
## 18      NA      NA      NA       NA       NA       NA       NA      NA
## 20      NA      NA      NA       NA       NA       NA       NA      NA
##    SAT_AVG_ALL PCIP01 PCIP03 PCIP04 PCIP05 PCIP09 PCIP10 PCIP11 PCIP12
## 7           NA 0.0000      0      0      0 0.0000      0 0.0186 0.0000
## 12          NA 0.0000      0      0      0 0.0000      0 0.0205 0.0000
## 15          NA 0.0000      0      0      0 0.0000      0 0.0085 0.0000
## 16          NA 0.0085      0      0      0 0.0000      0 0.0449 0.0000
## 18          NA 0.0069      0      0      0 0.0057      0 0.0069 0.0631
## 20          NA 0.0000      0      0      0 0.0000      0 0.0081 0.0477
##    PCIP13 PCIP14 PCIP15 PCIP16 PCIP19 PCIP22 PCIP23 PCIP24 PCIP25 PCIP26
## 7       0      0 0.0669      0 0.0000 0.0000      0 0.4833      0      0
## 12      0      0 0.0000      0 0.0000 0.0000      0 0.3846      0      0
## 15      0      0 0.0000      0 0.0085 0.0021      0 0.1855      0      0
## 16      0      0 0.0043      0 0.0000 0.0128      0 0.4637      0      0
## 18      0      0 0.1239      0 0.0183 0.0298      0 0.1950      0      0
## 20      0      0 0.0862      0 0.0467 0.0000      0 0.2069      0      0
##    PCIP27 PCIP29 PCIP30 PCIP31 PCIP38 PCIP39 PCIP40 PCIP41 PCIP42 PCIP43
## 7       0      0 0.0372      0      0      0      0 0.0000      0 0.0000
## 12      0      0 0.0000      0      0      0      0 0.0000      0 0.1077
## 15      0      0 0.0000      0      0      0      0 0.0000      0 0.0000
## 16      0      0 0.0000      0      0      0      0 0.0000      0 0.0000
## 18      0      0 0.0000      0      0      0      0 0.0000      0 0.0000
## 20      0      0 0.0000      0      0      0      0 0.0203      0 0.0101
##    PCIP44 PCIP45 PCIP46 PCIP47 PCIP48 PCIP49 PCIP50 PCIP51 PCIP52 PCIP54
## 7       0      0 0.0000 0.0558 0.0297      0 0.0000 0.2045 0.1041      0
## 12      0      0 0.0000 0.0000 0.0000      0 0.0103 0.3744 0.1026      0
## 15      0      0 0.0000 0.7249 0.0000      0 0.0000 0.0171 0.0533      0
## 16      0      0 0.0000 0.0150 0.0150      0 0.0150 0.3162 0.1047      0
## 18      0      0 0.0218 0.1009 0.0722      0 0.0000 0.2878 0.0677      0
## 20      0      0 0.0568 0.0294 0.0477      0 0.0000 0.4118 0.0284      0
##    DISTANCEONLY UGDS UGDS_WHITE UGDS_BLACK UGDS_HISP UGDS_ASIAN UGDS_AIAN
## 7             0 1779     0.6785     0.2945    0.0118     0.0022    0.0022
## 12            0 1769     0.4675     0.4409    0.0379     0.0136    0.0034
## 15            0 1984     0.6411     0.2661    0.0444     0.0166    0.0055
## 16            0 4182     0.7104     0.2176    0.0263     0.0072    0.0187
## 18            0 5480     0.6792     0.2100    0.0261     0.0055    0.0075
## 20            0 4293     0.6306     0.3196    0.0240     0.0058    0.0051
##    UGDS_NHPI UGDS_2MOR UGDS_NRA UGDS_UNKN PPTUG_EF CURROPER NPT4_PUB
## 7     0.0011    0.0006   0.0011    0.0079   0.4660        1     6407
## 12    0.0028    0.0107   0.0000    0.0232   0.4059        1     1873
## 15    0.0015    0.0176   0.0015    0.0055   0.3538        1     5048
## 16    0.0012    0.0163   0.0007    0.0017   0.3867        1     7404
## 18    0.0015    0.0190   0.0135    0.0378   0.4345        1     4565
## 20    0.0019    0.0128   0.0000    0.0002   0.4675        1     2681
##    NPT4_PRIV NPT41_PUB NPT42_PUB NPT43_PUB NPT44_PUB NPT45_PUB NPT41_PRIV
## 7         NA      6330      6032      7802     10512        NA         NA
## 12        NA      1110      2223      3296      6215      5940         NA
## 15        NA      4486      4699      7476      9713     10060         NA
## 16        NA      6474      6901      9452     10286     10846         NA
## 18        NA      4516      4872      6147      5143        NA         NA
## 20        NA      2386      3243      5046        NA      2590         NA
##    NPT42_PRIV NPT43_PRIV NPT44_PRIV NPT45_PRIV PCTPELL RET_FT4 RET_FTL4
## 7          NA         NA         NA         NA  0.6515      NA   0.4267
## 12         NA         NA         NA         NA  0.6116      NA   0.5165
## 15         NA         NA         NA         NA  0.5121      NA   0.5411
## 16         NA         NA         NA         NA  0.4885      NA   0.5211
## 18         NA         NA         NA         NA  0.6000      NA   0.5589
## 20         NA         NA         NA         NA  0.5548      NA   0.5597
##    RET_PT4 RET_PTL4 PCTFLOAN UG25abv GRAD_DEBT_MDN_SUPP
## 7       NA   0.4159   0.4777  0.3153                 NA
## 12      NA   0.3293   0.1948  0.3876               7000
## 15      NA   0.4500   0.2673  0.3399              11073
## 16      NA   0.3981   0.4042  0.2909               9153
## 18      NA   0.3865   0.0000  0.3733                 NA
## 20      NA   0.4627   0.0000  0.3920                 NA
##    GRAD_DEBT_MDN10YR_SUPP RPY_3YR_RT_SUPP C150_4_POOLED_SUPP
## 7                      NA       0.4384018                 NA
## 12               77.71435       0.5287081                 NA
## 15              122.93300       0.5543018                 NA
## 16              101.61706       0.5908529                 NA
## 18                     NA              NA                 NA
## 20                     NA              NA                 NA
##    C200_L4_POOLED_SUPP md_earn_wne_p10 gt_25k_p6 maxprop
## 7            0.2891894           27100 0.4461358  PCIP24
## 12           0.2398542           27700 0.4287710  PCIP24
## 15           0.3382836           26300 0.4896142  PCIP47
## 16           0.1640982           28900 0.4334661  PCIP24
## 18           0.2107528           26900 0.3863238  PCIP51
## 20           0.2604453           27100 0.4051502  PCIP51
```


----
## Substituting characters


```r
sentences <- c("Here's some text. Here's some more text.", 
			  "Red text makes me feel bad.",
			  "Green text makes me feel good.")
sub("text", "food", sentences) # replace only the first match within each element
```

```
## [1] "Here's some food. Here's some more text."
## [2] "Red food makes me feel bad."             
## [3] "Green food makes me feel good."
```

```r
gsub("text", "food", sentences) # replace all matches
```

```
## [1] "Here's some food. Here's some more food."
## [2] "Red food makes me feel bad."             
## [3] "Green food makes me feel good."
```

----
## Real example


```r
cam <- read.csv("./data/CamdenBoroughs.csv", na = "999")
head(cam$Percentage)
```

```
## [1]       29.6% 27.2% 43.2% 12.2% 54.3%
## 297 Levels:  0% 0.7% 0.8% 1.4% 1.6% 1.9% 10% 10.2% 10.4% 10.5% ... 98.1%
```

```r
cam$frl <- as.numeric( sub("%", "", cam$Percentage.Claiming.Free.School.Meals) )
str(cam$frl)
```

```
##  num [1:664] NA 29.6 27.2 43.2 12.2 54.3 3.7 32.7 20.5 NA ...
```
Note that in the above we can use either `sub` or `gsub` equivalently, because there's only one instance. In other cases, this would not be the case. For example, if we wanted to change the format of the dates.

-----
## Change census date format


```r
cam$censusDate <- sub("/", "-", cam$Census.Date) 
head(cam$censusDate) # Not what we want
```

```
## [1] "16-01/2014" "16-01/2014" "16-01/2014" "16-01/2014" "16-01/2014"
## [6] "16-01/2014"
```

```r
cam$censusDate <- gsub("/", "-", cam$Census.Date) 
head(cam$censusDate) # What we want
```

```
## [1] "16-01-2014" "16-01-2014" "16-01-2014" "16-01-2014" "16-01-2014"
## [6] "16-01-2014"
```

---- .segue
# Regular Expressions

----
## What is a regular expression?
* "an 'instruction' given to a function on what and how to match or replace strings" (Eden, 2007)
* *Metacharacters* are special characters that define specific operations
	+ can be interpreted as standard characters, provided the appropriate syntax is used.
	+ include the following: 


```
##  [1] $  *  +  .  ?  [  ^  {  |  (  \\
```
* *Sequences* define sequences of characters to match
* *Character classes* define ranges to match or not match

----
## Why does this matter?
Many of the built-in string functions in R take regular expressions as their arguments. If you're unaware of how regular expressions work, you could end up with unexpected behavior. For example, the following seems like it should work, but it will not.


```r
string <- "School is fun. Especially recess. That's the best part. I love recess."
strsplit(string, ".")
```

```
## [[1]]
##  [1] "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
## [24] "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
## [47] "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
## [70] ""
```

----
We can get the behavior we intend by overriding the metacharacter


```r
strsplit(string, "\\.")
```

```
## [[1]]
## [1] "School is fun"         " Especially recess"    " That's the best part"
## [4] " I love recess"
```

----
## Quick overview of metacharacters
(we'll talk about each in more detail)


|Metacharacter |Operation                                           |
|:-------------|:---------------------------------------------------|
|$             |Matches the end of a string                         |
|*             |Matches preceding character at least 0 times        |
|+             |Matches preceding character at least 1 time         |
|.             |Matches any single character (i.e., skip operator)  |
|?             |Matches preceding character 0 or 1 time             |
|[             |Define character list or character classes          |
|^             |Matches the start of a string                       |
|{             |Define n to m matches of preceding character        |
|&#124;        |Or operator                                         |
|(             |Define groupings for backreferencing                |
|\             |Suppress metacharacters and define anchor sequences |

----
## Quantifiers

|Metacharacter |Operation                                    |
|:-------------|:--------------------------------------------|
|*             |Matches preceding character at least 0 times |
|+             |Matches preceding character at least 1 time  |
|?             |Matches preceding character 0 or 1 time      |
|{             |Define n to m matches of preceding character |
<span style="color:gray; font-size:8pt;">Examples taken from http://stat545.com/block022_regular-expression.html </span>


```r
letterSet <- c("a", "ab", "acb", "accb", "acccb", "accccb")
grep("ac*b", letterSet, value = TRUE)
```

```
## [1] "ab"     "acb"    "accb"   "acccb"  "accccb"
```

```r
grep("ac+b", letterSet, value = TRUE)
```

```
## [1] "acb"    "accb"   "acccb"  "accccb"
```

----

|Metacharacter |Operation                                    |
|:-------------|:--------------------------------------------|
|?             |Matches preceding character 0 or 1 time      |
|{             |Define n to m matches of preceding character |


```
## [1] "a"      "ab"     "acb"    "accb"   "acccb"  "accccb"
```


```r
grep("ac?b", letterSet, value = TRUE)
```

```
## [1] "ab"  "acb"
```

```r
grep("ac{2}b", letterSet, value = TRUE)
```

```
## [1] "accb"
```

```r
grep("ac{2,}b", letterSet, value = TRUE)
```

```
## [1] "accb"   "acccb"  "accccb"
```

-----


```
## [1] "a"      "ab"     "acb"    "accb"   "acccb"  "accccb"
```


```r
grep("ac{1,3}b", letterSet, value = TRUE)
```

```
## [1] "acb"   "accb"  "acccb"
```

```r
grep("ac{0,3}b", letterSet, value = TRUE)
```

```
## [1] "ab"    "acb"   "accb"  "acccb"
```

---- &twocol
## Position matching

*** =left


|Metacharacter |Operation                                           |
|:-------------|:---------------------------------------------------|
|$             |Matches the end of a string                         |
|^             |Matches the start of a string                       |
|\             |Suppress metacharacters and define anchor sequences |
Anchor sequences are provided on the right (from Sanchez, p. 61). These should not be confused with R escape characters, such as `\n` and `\t`, for new line and tab, respectively. 

*** =right

<div align = "center">
<img src = ./assets/img/anchorSequences.png width = 500 height = 500>
</div>

----
## Match the end of a string


```r
itemIDs <- c("RF3L02E03", "RF3M08E05", "RF3H10E08", "RL1L03E03", "RL1M05E05",
 			 "RL1H10E04", "RI2L03E07", "RI2M06E05", "RI2HSAMPLEE06", 
 			 "WR4L02E03", "WR4M06E06", "WR4H09E03", "WR9L03E04", "WR9M08E04", 
 			 "WR9H12E04", "LA1L01E11", "LA1M06E04", "LA1H09E04", "WR2L03E05", 
 			 "WR2M06E05", "WR2H10E05", "LA2LSAMPLEE03", "LA2M06E04", 
 			 "LA2H09E08", "RF4L02E03", "RF4M08E06", "RF4H09E07", "RL7L02E07", 
 			 "RL7M06E06", "RL7H10E06", "RI1L02E07", "RI1M07E08", "RI1H11E07", 
 			 "WR1L02E07", "WR1M07E07", "WR1H11E08")

# Select fourth grade items
grep("4$", itemIDs, value = TRUE)
```

```
## [1] "RL1H10E04" "WR9L03E04" "WR9M08E04" "WR9H12E04" "LA1M06E04" "LA1H09E04"
## [7] "LA2M06E04"
```

----
## Match the start of a string


```r
# Select RL items
grep("^RF", itemIDs, value = TRUE)
```

```
## [1] "RF3L02E03" "RF3M08E05" "RF3H10E08" "RF4L02E03" "RF4M08E06" "RF4H09E07"
```

```r
# Select WR items
grep("^WR", itemIDs, value = TRUE)
```

```
##  [1] "WR4L02E03" "WR4M06E06" "WR4H09E03" "WR9L03E04" "WR9M08E04"
##  [6] "WR9H12E04" "WR2L03E05" "WR2M06E05" "WR2H10E05" "WR1L02E07"
## [11] "WR1M07E07" "WR1H11E08"
```
<br>

Note that in this case, the result would be the same without using the `^` metacharacter, but it's safer to go ahead and use it anyway. In other cases, there may be matches with the same pattern that are not at the beginning.

----
## Other examples

<span style="color:gray; font-size:8pt;">Examples taken from http://stat545.com/block022_regular-expression.html </span>


```r
string2 <- c("abcd", "cdab", "cabd", "c abd")
grep("ab", string2, value = TRUE)
```

```
## [1] "abcd"  "cdab"  "cabd"  "c abd"
```

```r
grep("^ab", string2, value = TRUE)
```

```
## [1] "abcd"
```

```r
grep("ab$", string2, value = TRUE)
```

```
## [1] "cdab"
```

----
## Search start of words, rather than strings


```
## [1] "abcd"  "cdab"  "cabd"  "c abd"
```


```r
grep("\\ba", string2, value = TRUE)
```

```
## [1] "abcd"  "c abd"
```

```r
grep("\\b a", string2, value = TRUE)
```

```
## [1] "c abd"
```

----


```r
ids <- c("123225-5417", "132123-132975", "321579-123569")
grep("123", ids, value = TRUE)
```

```
## [1] "123225-5417"   "132123-132975" "321579-123569"
```

```r
grep("^123", ids, value = TRUE)
```

```
## [1] "123225-5417"
```

```r
grep("\\b123", ids, value = TRUE) # New word starts with 123
```

```
## [1] "123225-5417"   "321579-123569"
```

```r
grep("\\B123", ids, value = TRUE) # New word does not start with 123
```

```
## [1] "132123-132975"
```

----
## Digits


```r
digits <- c("Charlie", "Charlie2", "Mary", "Marianne", "Mary2", "15")
grep("\\d", digits, value = TRUE)
```

```
## [1] "Charlie2" "Mary2"    "15"
```

```r
grep("\\D", digits, value = TRUE)
```

```
## [1] "Charlie"  "Charlie2" "Mary"     "Marianne" "Mary2"
```

----
## Spaces


```r
string
```

```
## [1] "School is fun. Especially recess. That's the best part. I love recess."
```

```r
gsub("\\s", "_", string)
```

```
## [1] "School_is_fun._Especially_recess._That's_the_best_part._I_love_recess."
```

```r
gsub("\\S", "_", string)
```

```
## [1] "______ __ ____ __________ _______ ______ ___ ____ _____ _ ____ _______"
```

----
## Words


```r
gsub("\\w", "_", string)
```

```
## [1] "______ __ ___. __________ ______. ____'_ ___ ____ ____. _ ____ ______."
```

```r
gsub("\\W", "_", string)
```

```
## [1] "School_is_fun__Especially_recess__That_s_the_best_part__I_love_recess_"
```

----
## Operators


|Metacharacter |Operation                                           |
|:-------------|:---------------------------------------------------|
|.             |Matches any single character (i.e., skip operator)  |
|[             |Define character list or character classes          |
|&#124;        |Or operator                                         |
|(             |Define groupings for backreferencing                |
|\             |Suppress metacharacters and define anchor sequences |

-----
## Skip characters


```r
string2 
```

```
## [1] "abcd"  "cdab"  "cabd"  "c abd"
```

```r
grep(".ab", string2, value = TRUE)
```

```
## [1] "cdab"  "cabd"  "c abd"
```

```r
grep("ab.", string2, value = TRUE)
```

```
## [1] "abcd"  "cabd"  "c abd"
```

----
## Select high items (easy)

```r
head(itemIDs)
```

```
## [1] "RF3L02E03" "RF3M08E05" "RF3H10E08" "RL1L03E03" "RL1M05E05" "RL1H10E04"
```

```r
grep("H", itemIDs, value = TRUE)
```

```
##  [1] "RF3H10E08"     "RL1H10E04"     "RI2HSAMPLEE06" "WR4H09E03"    
##  [5] "WR9H12E04"     "LA1H09E04"     "WR2H10E05"     "LA2H09E08"    
##  [9] "RF4H09E07"     "RL7H10E06"     "RI1H11E07"     "WR1H11E08"
```

----
## Select low items (more difficult)


```r
head( grep("L", itemIDs, value = TRUE) ) # Fails
```

```
## [1] "RF3L02E03"     "RL1L03E03"     "RL1M05E05"     "RL1H10E04"    
## [5] "RI2L03E07"     "RI2HSAMPLEE06"
```

```r
grep("...L", itemIDs, value = TRUE) # Fails
```

```
##  [1] "RF3L02E03"     "RL1L03E03"     "RI2L03E07"     "RI2HSAMPLEE06"
##  [5] "WR4L02E03"     "WR9L03E04"     "LA1L01E11"     "WR2L03E05"    
##  [9] "LA2LSAMPLEE03" "RF4L02E03"     "RL7L02E07"     "RI1L02E07"    
## [13] "WR1L02E07"
```

```r
grep("^.{3}L", itemIDs, value = TRUE) # Success!
```

```
##  [1] "RF3L02E03"     "RL1L03E03"     "RI2L03E07"     "WR4L02E03"    
##  [5] "WR9L03E04"     "LA1L01E11"     "WR2L03E05"     "LA2LSAMPLEE03"
##  [9] "RF4L02E03"     "RL7L02E07"     "RI1L02E07"     "WR1L02E07"
```

----
## Or

Select RL or WR Items


```r
grep("RL|WR", itemIDs, value = TRUE)
```

```
##  [1] "RL1L03E03" "RL1M05E05" "RL1H10E04" "WR4L02E03" "WR4M06E06"
##  [6] "WR4H09E03" "WR9L03E04" "WR9M08E04" "WR9H12E04" "WR2L03E05"
## [11] "WR2M06E05" "WR2H10E05" "RL7L02E07" "RL7M06E06" "RL7H10E06"
## [16] "WR1L02E07" "WR1M07E07" "WR1H11E08"
```

----


```r
string3 <- c("^ab", "ab", "abc", "abd", "abe", "ab 12")
grep("bc|be", string3, value = TRUE)
```

```
## [1] "abc" "abe"
```

```r
grep("1|c", string3, value = TRUE)
```

```
## [1] "abc"   "ab 12"
```


----
## Backreferences

Find and reference any number of patterns.


```r
catMat <- "The cat sat on the mat."
gsub("(.at)", "\\1!", catMat)
```

```
## [1] "The cat! sat! on the mat!."
```

```r
gsub("(.)at", "\\1ot", catMat)
```

```
## [1] "The cot sot on the mot."
```

```r
gsub("(.he) (.at)", "__\\1__ \\2!", catMat)
```

```
## [1] "__The__ cat! sat on __the__ mat!."
```
<span style="color:gray; font-size:8pt;">Examples adapted from https://www.stat.auckland.ac.nz/~paul/ItDT/HTML/node84.html </span>


----
## Suppress metacharacters


```r
string3
```

```
## [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 12"
```

```r
grep("^ab", string3, value = TRUE)
```

```
## [1] "ab"    "abc"   "abd"   "abe"   "ab 12"
```

```r
grep("\\^ab", string3, value = TRUE)
```

```
## [1] "^ab"
```

----


```r
string
```

```
## [1] "School is fun. Especially recess. That's the best part. I love recess."
```

```r
gsub(".", "___", string)
```

```
## [1] "__________________________________________________________________________________________________________________________________________________________________________________________________________________"
```

```r
gsub("\\.", "____", string)
```

```
## [1] "School is fun____ Especially recess____ That's the best part____ I love recess____"
```

----
## More examples

```r
set.seed(300)
d <- data.frame(rnorm(3), rbinom(3, 1, 0.5), rpois(3, 2))
d
```

```
##    rnorm.3. rbinom.3..1..0.5. rpois.3..2.
## 1 1.3737909                 1           4
## 2 0.8621069                 0           4
## 3 0.4734891                 0           1
```

```r
names(d) <- gsub(pattern = "\\.+", replacement = "", names(d))
```

---- .segue
# Character classes

----
## Search/specify entire classes of characters


```r
string3 <- c("^ab", "ab", "abc", "abd", "abe", "ab 12")
grep("ab[cd]", string3, value = TRUE)
```

```
## [1] "abc" "abd"
```

```r
grep("ab[c-e]", string3, value = TRUE)
```

```
## [1] "abc" "abd" "abe"
```

----

```r
textNum <- paste0(rep(letters[1:14], each = 7), 1:7)
textNum
```

```
##  [1] "a1" "a2" "a3" "a4" "a5" "a6" "a7" "b1" "b2" "b3" "b4" "b5" "b6" "b7"
## [15] "c1" "c2" "c3" "c4" "c5" "c6" "c7" "d1" "d2" "d3" "d4" "d5" "d6" "d7"
## [29] "e1" "e2" "e3" "e4" "e5" "e6" "e7" "f1" "f2" "f3" "f4" "f5" "f6" "f7"
## [43] "g1" "g2" "g3" "g4" "g5" "g6" "g7" "h1" "h2" "h3" "h4" "h5" "h6" "h7"
## [57] "i1" "i2" "i3" "i4" "i5" "i6" "i7" "j1" "j2" "j3" "j4" "j5" "j6" "j7"
## [71] "k1" "k2" "k3" "k4" "k5" "k6" "k7" "l1" "l2" "l3" "l4" "l5" "l6" "l7"
## [85] "m1" "m2" "m3" "m4" "m5" "m6" "m7" "n1" "n2" "n3" "n4" "n5" "n6" "n7"
```

```r
grep("[a-e][3-5]", textNum, value = TRUE)
```

```
##  [1] "a3" "a4" "a5" "b3" "b4" "b5" "c3" "c4" "c5" "d3" "d4" "d5" "e3" "e4"
## [15] "e5"
```
Invert the character list with `^`.


```r
grep("[^a-e][3-5]", textNum, value = TRUE)
```

```
##  [1] "f3" "f4" "f5" "g3" "g4" "g5" "h3" "h4" "h5" "i3" "i4" "i5" "j3" "j4"
## [15] "j5" "k3" "k4" "k5" "l3" "l4" "l5" "m3" "m4" "m5" "n3" "n4" "n5"
```

----
## POSIX character classes


|Code       |Description                            |Equivalent Code                  |
|:----------|:--------------------------------------|:--------------------------------|
|[:digit:]  |Digits, 0-9                            |[0-9]                            |
|[:lower:]  |Lower case letters                     |[a-z]                            |
|[:upper:]  |Upper case letters                     |[A-Z]                            |
|[:alpha:]  |Alphabetic characters                  |[[:lower:][:upper:]] or [A-z]    |
|[:alnum:]  |Alphanumeric characters                |[[:alpha:][:digit:]] or [A-z0-9] |
|[:xdigit:] |Base 16 hexadecimal                    |[0-9A-Fa-f]                      |
|[:blank:]  |Blank characters (space and tab)       |                                 |
|[:space:]  |Space characters (all)                 |                                 |
|[:punct:]  |Punctuation characters                 |                                 |
|[:graph:]  |Human readable characters              |[[:alnum:][:punct:]]             |
|[:print:]  |Printable characters                   |[[:alnum:][:punct:]\\\s]         |
|[:cntrl:]  |Control characters (line breaks, etc.) |                                 |

----


```r
string4 <- c("ab", "ab12", "Dc a", "BB", "Here's some text.", "Here's a \n new line.")
cat(string4)
```

```
## ab ab12 Dc a BB Here's some text. Here's a 
##  new line.
```

```r
grep("[[:digit:]]", string4, value = TRUE)
```

```
## [1] "ab12"
```

```r
grep("[[:lower:]]", string4, value = TRUE)
```

```
## [1] "ab"                    "ab12"                  "Dc a"                 
## [4] "Here's some text."     "Here's a \n new line."
```

```r
grep("[[:upper:]]", string4, value = TRUE)
```

```
## [1] "Dc a"                  "BB"                    "Here's some text."    
## [4] "Here's a \n new line."
```

----

```r
grep("[[:space:]]", string4, value = TRUE)
```

```
## [1] "Dc a"                  "Here's some text."     "Here's a \n new line."
```

```r
grep("[[:punct:]]", string4, value = TRUE)
```

```
## [1] "Here's some text."     "Here's a \n new line."
```

```r
strsplit(sentences, "[[:space:]]")
```

```
## [[1]]
## [1] "Here's" "some"   "text."  "Here's" "some"   "more"   "text." 
## 
## [[2]]
## [1] "Red"   "text"  "makes" "me"    "feel"  "bad." 
## 
## [[3]]
## [1] "Green" "text"  "makes" "me"    "feel"  "good."
```

----

```r
strsplit(sentences, "[[:space:][:punct:]]")
```

```
## [[1]]
##  [1] "Here" "s"    "some" "text" ""     "Here" "s"    "some" "more" "text"
## 
## [[2]]
## [1] "Red"   "text"  "makes" "me"    "feel"  "bad"  
## 
## [[3]]
## [1] "Green" "text"  "makes" "me"    "feel"  "good"
```

-----
## Things we still haven't covered
* `sprintf` (useful for padding numbers)
* `regexpr`
* `gregexpr`
* `regexec`
* Matching
	+ `regmatches`
	+ `match`
	+ `pmatch`
	+ `charmatch`
* (...still more I'm probably missing)
* *stringr* package (part of the Hadleyverse, contains many useful functions for manipulating strings)

---- .segue
# Example with real data
<span style="color:gray; font-size:8pt;">Examples taken from https://rstudio-pubs-static.s3.amazonaws.com/74603_76cd14d5983f47408fdf0b323550b846.html </span>

----
## Gapminder data


```r
install.packages("gapminder")
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/wr/3cb759291pl5vg9x64565c4w0000gn/T//RtmpQavlE9/downloaded_packages
```

```r
library(gapminder)
data(gapminder)
head(gapminder)
```

```
##       country continent year lifeExp      pop gdpPercap
## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
## 4 Afghanistan      Asia 1967  34.020 11537966  836.1971
## 5 Afghanistan      Asia 1972  36.088 13079460  739.9811
## 6 Afghanistan      Asia 1977  38.438 14880372  786.1134
```

-----
## Quick aside
Data are also available online. We haven't talked about this much, but you can always read data into R directly from the web


```r
gapMinder <- read.delim("http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderDataFiveYear.txt", 
	header = TRUE)
head(gapMinder)
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia  28.801  779.4453
## 2 Afghanistan 1957  9240934      Asia  30.332  820.8530
## 3 Afghanistan 1962 10267083      Asia  31.997  853.1007
## 4 Afghanistan 1967 11537966      Asia  34.020  836.1971
## 5 Afghanistan 1972 13079460      Asia  36.088  739.9811
## 6 Afghanistan 1977 14880372      Asia  38.438  786.1134
```

----
## Searching countries
Find all countries that end with *land*, and have an "i" or "t" in them.


```r
grep("(.*[it].*)land$", gapminder$country, value = TRUE)
```

```
##  [1] "Finland"     "Finland"     "Finland"     "Finland"     "Finland"    
##  [6] "Finland"     "Finland"     "Finland"     "Finland"     "Finland"    
## [11] "Finland"     "Finland"     "Swaziland"   "Swaziland"   "Swaziland"  
## [16] "Swaziland"   "Swaziland"   "Swaziland"   "Swaziland"   "Swaziland"  
## [21] "Swaziland"   "Swaziland"   "Swaziland"   "Swaziland"   "Switzerland"
## [26] "Switzerland" "Switzerland" "Switzerland" "Switzerland" "Switzerland"
## [31] "Switzerland" "Switzerland" "Switzerland" "Switzerland" "Switzerland"
## [36] "Switzerland" "Thailand"    "Thailand"    "Thailand"    "Thailand"   
## [41] "Thailand"    "Thailand"    "Thailand"    "Thailand"    "Thailand"   
## [46] "Thailand"    "Thailand"    "Thailand"
```

----
## Backreferencing
Replace *land* for *LAND* for countries with an "i" or "t" in them


```r
gapminder$country <- gsub("(.*[it].*)land$", "\\1LAND", gapminder$country)
unique(
	grep("LAND", gapminder$country, value = TRUE)
	)
```

```
## [1] "FinLAND"     "SwaziLAND"   "SwitzerLAND" "ThaiLAND"
```

----
## Abbreviated lab
* Find countries that begin with "South"
* Find countries that have "Ga" at the beginning of either word (not string)
* Find countries that have 2 consecutive e's

# Advanced
* write a function that takes a generic string variable and makes the following manipulations: 
	+ keeps only alpha-numeric characters
	+ removes all spaces
	+ converts to lower case
As an example, if the string Coeur d'Alene were fed to the function, it should return coeurdalene. (you can use this to test your function)

<span style="color:gray; font-size:8pt;">Examples taken from https://rstudio-pubs-static.s3.amazonaws.com/74603_76cd14d5983f47408fdf0b323550b846.html </span>

----
# Find countries that begin with "South"


```r
unique( grep("^South", gapminder$country, value = TRUE) )
```

```
## [1] "South Africa"
```

```r
#Alternatively
grep("^South", levels(gapminder$country), value = TRUE)
```

```
## character(0)
```

----
# Find countries that have "Ga" at the beginning of either word (not string)


```r
grep("\\bGa", levels(gapminder$country), value = TRUE)
```

```
## character(0)
```

----
# Write function
* Keep only alpha-numeric characters
* Remove all spaces
* Convert to lower case


```r
cleanString <- function(x) {
	string <- gsub("[^[:alnum:]]", "", x)
	string <- tolower(string)
return(string)
}
cleanString("Coeur d'Alene")
```

```
## [1] "coeurdalene"
```

----

```r
gapminder$country[1555]
```

```
## [1] "Trinidad and Tobago"
```

```r
cleanString(gapminder$country)[1555]
```

```
## [1] "trinidadandtobago"
```
