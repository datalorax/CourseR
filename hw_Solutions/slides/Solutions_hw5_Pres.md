---
title       : Homework 5 Review
subtitle    : 
author      : Daniel Anderson
job         : CourseR
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- &twocol





## Disclaimer
There are multiple ways to complete this homework. These slides represent the
  methods I used (today, as I write this), and alternative methods are certainly possible.

---
# Question 1
Load the *countyComplete* dataset from the *openintro* package. 
	
  + Use a `for()` loop to calculate the grand mean for the following variables: white, black, native, asian, pac_isl, two_plus_races, hispanic, white_not_hispanic, hs_grad, bachelors, housing_units, home_ownership, housing_multi_unit, median_val_owner_occupied, households. 
  + Calculate the same values using an `apply` family loop.
  + Conduct a test (i.e., not just visual comparison) to ensure the same means were produced by both methods.

----


```r
library(openintro)
data(countyComplete)
d <- countyComplete
head(d)
```

```
##     state           name FIPS pop2010 pop2000 age_under_5 age_under_18
## 1 Alabama Autauga County 1001   54571   43671         6.6         26.8
## 2 Alabama Baldwin County 1003  182265  140415         6.1         23.0
## 3 Alabama Barbour County 1005   27457   29038         6.2         21.9
## 4 Alabama    Bibb County 1007   22915   20826         6.0         22.7
## 5 Alabama  Blount County 1009   57322   51024         6.3         24.6
## 6 Alabama Bullock County 1011   10914   11714         6.8         22.3
##   age_over_65 female white black native asian pac_isl two_plus_races
## 1        12.0   51.3  78.5  17.7    0.4   0.9      NA            1.6
## 2        16.8   51.1  85.7   9.4    0.7   0.7      NA            1.5
## 3        14.2   46.9  48.0  46.9    0.4   0.4      NA            0.9
## 4        12.7   46.3  75.8  22.0    0.3   0.1      NA            0.9
## 5        14.7   50.5  92.6   1.3    0.5   0.2      NA            1.2
## 6        13.5   45.8  23.0  70.2    0.2   0.2      NA            0.8
##   hispanic white_not_hispanic no_move_in_one_plus_year foreign_born
## 1      2.4               77.2                     86.3          2.0
## 2      4.4               83.5                     83.0          3.6
## 3      5.1               46.8                     83.0          2.8
## 4      1.8               75.0                     90.5          0.7
## 5      8.1               88.9                     87.2          4.7
## 6      7.1               21.9                     88.5          1.1
##   foreign_spoken_at_home hs_grad bachelors veterans mean_work_travel
## 1                    3.7    85.3      21.7     5817             25.1
## 2                    5.5    87.6      26.8    20396             25.8
## 3                    4.7    71.9      13.5     2327             23.8
## 4                    1.5    74.5      10.0     1883             28.3
## 5                    7.2    74.7      12.5     4072             33.2
## 6                    3.8    74.7      12.0      943             28.1
##   housing_units home_ownership housing_multi_unit
## 1         22135           77.5                7.2
## 2        104061           76.7               22.6
## 3         11829           68.0               11.1
## 4          8981           82.9                6.6
## 5         23887           82.0                3.7
## 6          4493           76.9                9.9
##   median_val_owner_occupied households persons_per_household
## 1                    133900      19718                  2.70
## 2                    177200      69476                  2.50
## 3                     88200       9795                  2.52
## 4                     81200       7441                  3.02
## 5                    113700      20605                  2.73
## 6                     66300       3732                  2.85
##   per_capita_income median_household_income poverty
## 1             24568                   53255    10.6
## 2             26469                   50147    12.2
## 3             15875                   33219    25.0
## 4             19918                   41770    12.6
## 5             21070                   45549    13.4
## 6             20289                   31602    25.3
##   private_nonfarm_establishments private_nonfarm_employment
## 1                            877                      10628
## 2                           4812                      52233
## 3                            522                       7990
## 4                            318                       2927
## 5                            749                       6968
## 6                            120                       1919
##   percent_change_private_nonfarm_employment nonemployment_establishments
## 1                                      16.6                         2971
## 2                                      17.4                        14175
## 3                                     -27.0                         1527
## 4                                     -14.0                         1192
## 5                                     -11.4                         3501
## 6                                     -18.5                          390
##   firms black_owned_firms native_owned_firms asian_owned_firms
## 1  4067              15.2                 NA               1.3
## 2 19035               2.7                0.4               1.0
## 3  1667                NA                 NA                NA
## 4  1385              14.9                 NA                NA
## 5  4458                NA                 NA                NA
## 6   417                NA                 NA                NA
##   pac_isl_owned_firms hispanic_owned_firms women_owned_firms
## 1                  NA                  0.7              31.7
## 2                  NA                  1.3              27.3
## 3                  NA                   NA              27.0
## 4                  NA                   NA                NA
## 5                  NA                   NA              23.2
## 6                  NA                   NA              38.8
##   manufacturer_shipments_2007 mercent_whole_sales_2007   sales
## 1                          NA                       NA  598175
## 2                     1410273                       NA 2966489
## 3                          NA                       NA  188337
## 4                           0                       NA  124707
## 5                      341544                       NA  319700
## 6                          NA                       NA   43810
##   sales_per_capita accommodation_food_service building_permits
## 1            12003                      88157              191
## 2            17166                     436955              696
## 3             6334                         NA               10
## 4             5804                      10757                8
## 5             5622                      20941               18
## 6             3995                       3670                1
##   fed_spending    area density
## 1       331142  594.44    91.8
## 2      1119082 1589.78   114.6
## 3       240308  884.88    31.0
## 4       163201  622.58    36.8
## 5       294114  644.78    88.9
## 6       108846  622.81    17.5
```

----

# `for()` loop method

```r
varLocs <- c(10:17, 21, 22, 25:29)
means <- rep(NA, length(varLocs))
for(i in seq_along(means)) {
	means[i] <- mean(d[ ,varLocs[i]], na.rm = TRUE)
}

round(means, 2)
```

```
##  [1]     82.89      8.93      2.03      1.17      0.15      1.98      8.28
##  [8]     78.29     83.11     19.03  41904.15     73.26     12.33 132544.93
## [15]  36346.16
```

----
# apply family loop


```r
means2 <- apply(d[ ,varLocs], 2, mean, na.rm = TRUE)
round(means2, 2)
```

```
##                     white                     black 
##                     82.89                      8.93 
##                    native                     asian 
##                      2.03                      1.17 
##                   pac_isl            two_plus_races 
##                      0.15                      1.98 
##                  hispanic        white_not_hispanic 
##                      8.28                     78.29 
##                   hs_grad                 bachelors 
##                     83.11                     19.03 
##             housing_units            home_ownership 
##                  41904.15                     73.26 
##        housing_multi_unit median_val_owner_occupied 
##                     12.33                 132544.93 
##                households 
##                  36346.16
```

----
# Test equivalence


```r
table(means == means2)
```

```
## 
## TRUE 
##   15
```

----
# Question 2
Calculate the *difference* between the means for each of the preceding
  variables and the mean for each state. Do so using only `for()` loops, and then again using only the apply family of loops.


```r
## For loop method

stateMeanDiff <- matrix(#	 NROWS						NCOLS
					rep(NA, length(unique(d$state)) * length(varLocs)),
				ncol = length(varLocs)
				)

s <- split(d[ ,varLocs], d$state)

for(i in seq_along(s)) {
	for(j in 1:ncol(s[[1]])) {
		stateMeanDiff[i, j] <- means[j] - mean(s[[i]][ ,j], na.rm = TRUE)
	}
}

# Make it prettier
dimnames(stateMeanDiff) <- list(names(s), names(s[[1]]))
```

----
# Show first six rows and columns


```r
stateMeanDiff[1:6, 1:6] 
```

```
##                white      black      native         asian     pac_isl
## Alabama    15.637508 -19.461987   1.3397469  0.5872629478  0.09289995
## Alaska     30.581821   7.737447 -30.6805824 -3.7267360228 -0.32376671
## Arizona    12.985269   7.103884 -11.7270192 -0.0002992412  0.01401107
## Arkansas    4.135936  -6.930783   1.3623141  0.5271782363  0.01764743
## California 12.811131   5.665033  -0.3305824 -5.4991498159 -0.13391997
## Colorado   -4.281919   7.401979   0.6356891  0.1101174255  0.06801107
##            two_plus_races
## Alabama         0.6272019
## Alaska         -5.5131996
## Arizona        -1.0835444
## Arkansas        0.3457889
## California     -2.5994065
## Colorado       -0.4469819
```

----
## apply family method


```r
stateMeanDiff2 <- sapply(seq_along(varLocs), function(i) {
	means[i] - tapply(d[ ,varLocs[i]], d[ ,1], mean, na.rm = TRUE)
})

#Give column names
colnames(stateMeanDiff2) <- names(d[ ,varLocs])
stateMeanDiff2[1:6, 1:6]
```

```
##                white      black      native         asian     pac_isl
## Alabama    15.637508 -19.461987   1.3397469  0.5872629478  0.09289995
## Alaska     30.581821   7.737447 -30.6805824 -3.7267360228 -0.32376671
## Arizona    12.985269   7.103884 -11.7270192 -0.0002992412  0.01401107
## Arkansas    4.135936  -6.930783   1.3623141  0.5271782363  0.01764743
## California 12.811131   5.665033  -0.3305824 -5.4991498159 -0.13391997
## Colorado   -4.281919   7.401979   0.6356891  0.1101174255  0.06801107
##            two_plus_races
## Alabama         0.6272019
## Alaska         -5.5131996
## Arizona        -1.0835444
## Arkansas        0.3457889
## California     -2.5994065
## Colorado       -0.4469819
```

---
# Test equivalence

```r
table(stateMeanDiff == stateMeanDiff2)
```

```
## 
## TRUE 
##  765
```

----
# Question 3
Load the *births* dataset. Use `by()` **or** `tapply()` to calculate the
  mean birth weight by the following: weeks, premature, sexBaby, smoke. Calculate the same means using `aggregate()`
  + Use the output to report the following:
  	- Mean birth weights across weeks for full term non-smokers.
  	- Mean birth weights across weeks for premature babies from mothers
  	  who smoke.
  	- Mean birth weights for weeks 38-40 for full term males across smokers
  	- Mean birth weights across weeks for female babies of nonsmoker
  	  mothers, between premie and full term.

----

```r
data(births)
d2 <- births

# by method

weightMeans <- by(d2$weight, 
				as.list(d2[ ,c(3, 4, 8, 9)]),
				mean, na.rm = TRUE)
weightMeans[ ,"full term", ,"nonsmoker"]
```

```
##      sexBaby
## weeks   female     male
##    26       NA       NA
##    28       NA       NA
##    29       NA       NA
##    32       NA       NA
##    33       NA       NA
##    34       NA       NA
##    35       NA       NA
##    36       NA       NA
##    37 7.090000 7.500000
##    38 7.174444 7.056667
##    39 7.272222 7.920000
##    40 7.723333 7.547333
##    41 7.752857 8.202000
##    42 6.500000 7.780000
##    43 7.810000       NA
##    44       NA 7.655000
```

----

```r
weightMeans[ ,"premie", ,"smoker"]
```

```
##      sexBaby
## weeks female  male
##    26     NA    NA
##    28     NA    NA
##    29     NA    NA
##    32   2.19 2.690
##    33     NA 3.220
##    34     NA    NA
##    35   5.50 4.500
##    36     NA 6.125
##    37     NA    NA
##    38     NA    NA
##    39     NA    NA
##    40     NA    NA
##    41     NA    NA
##    42     NA    NA
##    43     NA    NA
##    44     NA    NA
```

----

```r
weightMeans[10:14, "full term", "male", ]
```

```
##      smoke
## weeks nonsmoker   smoker
##    38  7.056667 7.282500
##    39  7.920000 7.583333
##    40  7.547333 7.937500
##    41  8.202000 7.800000
##    42  7.780000 7.380000
```

----

```r
weightMeans[ , , "female","nonsmoker"]
```

```
##      premature
## weeks full term premie
##    26        NA     NA
##    28        NA  1.630
##    29        NA  2.630
##    32        NA  6.500
##    33        NA  5.690
##    34        NA     NA
##    35        NA     NA
##    36        NA  6.845
##    37  7.090000     NA
##    38  7.174444     NA
##    39  7.272222     NA
##    40  7.723333     NA
##    41  7.752857     NA
##    42  6.500000     NA
##    43  7.810000     NA
##    44        NA     NA
```

----
# aggregate method


```r
weightMeans2 <- aggregate(weight ~ weeks + premature + sexBaby + smoke, 
	data = d2, mean, na.rm = TRUE)
subset(weightMeans2, premature == "full term" & smoke == "nonsmoker")
```

```
##    weeks premature sexBaby     smoke   weight
## 1     37 full term  female nonsmoker 7.090000
## 2     38 full term  female nonsmoker 7.174444
## 3     39 full term  female nonsmoker 7.272222
## 4     40 full term  female nonsmoker 7.723333
## 5     41 full term  female nonsmoker 7.752857
## 6     42 full term  female nonsmoker 6.500000
## 7     43 full term  female nonsmoker 7.810000
## 13    37 full term    male nonsmoker 7.500000
## 14    38 full term    male nonsmoker 7.056667
## 15    39 full term    male nonsmoker 7.920000
## 16    40 full term    male nonsmoker 7.547333
## 17    41 full term    male nonsmoker 8.202000
## 18    42 full term    male nonsmoker 7.780000
## 19    44 full term    male nonsmoker 7.655000
```

----

```r
subset(weightMeans2, premature == "premie" & smoke == "smoker")
```

```
##    weeks premature sexBaby  smoke weight
## 31    32    premie  female smoker  2.190
## 32    35    premie  female smoker  5.500
## 40    32    premie    male smoker  2.690
## 41    33    premie    male smoker  3.220
## 42    35    premie    male smoker  4.500
## 43    36    premie    male smoker  6.125
```

----

```r
subset(weightMeans2, weeks %in% 38:42 & premature == "full term" & 
	sexBaby == "male")
```

```
##    weeks premature sexBaby     smoke   weight
## 14    38 full term    male nonsmoker 7.056667
## 15    39 full term    male nonsmoker 7.920000
## 16    40 full term    male nonsmoker 7.547333
## 17    41 full term    male nonsmoker 8.202000
## 18    42 full term    male nonsmoker 7.780000
## 34    38 full term    male    smoker 7.282500
## 35    39 full term    male    smoker 7.583333
## 36    40 full term    male    smoker 7.937500
## 37    41 full term    male    smoker 7.800000
## 38    42 full term    male    smoker 7.380000
```

----

```r
subset(weightMeans2, sexBaby == "female" & smoke == "nonsmoker")
```

```
##    weeks premature sexBaby     smoke   weight
## 1     37 full term  female nonsmoker 7.090000
## 2     38 full term  female nonsmoker 7.174444
## 3     39 full term  female nonsmoker 7.272222
## 4     40 full term  female nonsmoker 7.723333
## 5     41 full term  female nonsmoker 7.752857
## 6     42 full term  female nonsmoker 6.500000
## 7     43 full term  female nonsmoker 7.810000
## 8     28    premie  female nonsmoker 1.630000
## 9     29    premie  female nonsmoker 2.630000
## 10    32    premie  female nonsmoker 6.500000
## 11    33    premie  female nonsmoker 5.690000
## 12    36    premie  female nonsmoker 6.845000
```
