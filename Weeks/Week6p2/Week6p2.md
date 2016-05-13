---
title       : "Group-level Summaries and Code Sharing"
subtitle    : Week 6.2
author      : Daniel Anderson
job         : CourseR
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

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
* Group-level summaries
* Code sharing
	+ Me: Constructing a longitudinal dataset
	+ Joe: R Markdown

<br>

<span style="color:red"> Reschedule/Cancel May 27th Meeting</span>
<span style="color:gray"> Because I apparently don't know how to read my own
	calendar</span>

----
## Applying function by group

The `tapply()` function is useful for applying any generic function to each
  level of a grouping factor

![tapply](./assets/img/tapply.png)


----
## Load the beer data

```r
beer <- read.delim("./data/ratebeer_beerjobber.txt") # Load beer data
head(beer)
```

```
##                                  name                 brewer
## 1                     Abbey Monks Ale Abbey Beverage Company
## 2                  Abbey Monks Tripel Abbey Beverage Company
## 3                     Abbey Monks Wit Abbey Beverage Company
## 4 Alameda Barn Owl Imperial Brown Ale    Alameda Brewing Co.
## 5         Alameda Black Bear XX Stout    Alameda Brewing Co.
## 6       Alameda El Torero Organic IPA    Alameda Brewing Co.
##                     style abv ratings score.overall score.by.style
## 1             Belgian Ale 5.2      96            50             49
## 2            Abbey Tripel 8.0       3            NA             NA
## 3 Belgian White (Witbier) 5.1      46            23             19
## 4               Brown Ale 7.9      13            74             81
## 5           Foreign Stout 6.8     172            94             76
## 6    India Pale Ale (IPA) 7.2      56            74             43
```

----
## Mean overall score by brewer


```r
tapply(beer$score.overall, beer$brewer, mean, na.rm = TRUE)
```

```
##                         Abbey Beverage Company 
##                                       36.50000 
##                            Alameda Brewing Co. 
##                                       83.16667 
##                                 Ale Industries 
##                                       93.00000 
##                       American Brewing Company 
##                                       76.00000 
##               Appalachian Brewing Company (PA) 
##                                       56.57143 
##                     Bent River Brewing Company 
##                                       54.50000 
##                          Bison Brewing Company 
##                                       63.50000 
##                          Blue Mountain Brewery 
##                                       81.66667 
##                             Blue Point Brewing 
##                                       65.76923 
##                         Boxcar Brewing Company 
##                                       23.33333 
##             Brewers Alley Restaurant & Brewery 
##                                       58.50000 
##                       Carolina Brewing Company 
##                                       61.60000 
##                        Cavalry Brewing Company 
##                                       33.75000 
##                             Colorado Cider Co. 
##                                       59.50000 
##                      Crow Peak Brewing Company 
##                                       54.33333 
##                Devils Backbone Brewing Company 
##                                       70.50000 
##                      Devils Canyon Brewing Co. 
##                                       68.25000 
##                           Diamond Knot Brewery 
##                                       69.37500 
##                          Dicks Brewing Company 
##                                       73.58333 
##                           Dry Dock Brewing Co. 
##                                       91.00000 
##                         DuClaw Brewing Company 
##                                       80.71429 
##                Eddyline Restaurant and Brewery 
##                                       42.00000 
##                         Elevation Beer Company 
##                                       80.00000 
##                            Elysian Brewing Co. 
##                                       86.41176 
##                           Erie Brewing Company 
##                                       49.90000 
##                       Evil Genius Beer Company 
##                                       38.66667 
##                       Figure Eight Brewing LLC 
##                                       51.33333 
##                              Flat 12 Bierwerks 
##                                       79.20000 
##                           Fort Collins Brewery 
##                                       72.42857 
##                       French Broad Brewing Co. 
##                                       75.50000 
##                            Great River Brewery 
##                                       70.00000 
##                                     Hales Ales 
##                                       72.00000 
##                         Harlem Brewing Company 
##                                       20.00000 
##                        Heretic Brewing Company 
##                                       87.00000 
##                     High Noon Saloon & Brewery 
##                                       26.33333 
##                       Highland Brewing Company 
##                                       75.75000 
##                      Hilliards Brewing Company 
##                                       57.66667 
##                         Hopworks Urban Brewery 
##                                       89.80000 
##                        Huebert Brewing Company 
##                                            NaN 
##                      La Cumbre Brewing Company 
##                                      100.00000 
##              Laurelwood Public House & Brewery 
##                                       84.87500 
##                  Lazy Magnolia Brewing Company 
##                                       65.60000 
##     Left Coast/Oggis Pizza and Brewing Company 
##                                       80.57143 
##                              Mad River Brewery 
##                                       82.00000 
##                  Madison River Brewing Company 
##                                       44.00000 
##                                 Marble Brewery 
##                                       92.50000 
##                     Millstream Brewing Company 
##                                       60.30000 
##                                Mission Brewery 
##                                       72.33333 
##                       Monocacy Brewing Company 
##                                            NaN 
##                    Mother Road Brewing Company 
##                                            NaN 
##                   Moylans Brewery & Restaurant 
##                                       84.00000 
##                   Narragansett Brewing Company 
##                                       37.14286 
##                           Odin Brewing Company 
##                                       69.66667 
##                     Pale Horse Brewing Company 
##                                       66.50000 
##                   Philadelphia Brewing Company 
##                                       55.80000 
##                      Port City Brewing Company 
##                                       70.00000 
##                            Rahr & Sons Brewing 
##                                       32.00000 
##                                 Red Lodge Ales 
##                                       47.16667 
##                       Renegade Brewing Company 
##                                       72.00000 
## Rio Grande Brewing Co. (Sierra Blanca Brewing) 
##                                       23.75000 
##                              Rivertown Brewing 
##                                       60.58824 
##                       Santa Fe Brewing Company 
##                                       77.00000 
##                       Sierra Blanca Brewing Co 
##                                       41.20000 
##                             Six Rivers Brewery 
##                                       56.40000 
##                                Straight To Ale 
##                                       91.00000 
##                         Strike Brewing Company 
##                                            NaN 
##                      Telluride Brewing Company 
##                                            NaN 
##                          Terrapin Beer Company 
##                                       83.25000 
##                    Thunderhead Brewing Company 
##                                       39.50000 
##                           Twisted Pine Brewing 
##                                       42.80000 
##                        Upslope Brewing Company 
##                                       48.80000 
##                             Voodoo Brewing Co. 
##                                       75.66667
```

----
## Number of beers rated by brewer


```r
tapply(beer$name, beer$brewer, length)
```

```
##                         Abbey Beverage Company 
##                                              3 
##                            Alameda Brewing Co. 
##                                              7 
##                                 Ale Industries 
##                                              3 
##                       American Brewing Company 
##                                              3 
##               Appalachian Brewing Company (PA) 
##                                             14 
##                     Bent River Brewing Company 
##                                              2 
##                          Bison Brewing Company 
##                                              6 
##                          Blue Mountain Brewery 
##                                              6 
##                             Blue Point Brewing 
##                                             13 
##                         Boxcar Brewing Company 
##                                              3 
##             Brewers Alley Restaurant & Brewery 
##                                              4 
##                       Carolina Brewing Company 
##                                              5 
##                        Cavalry Brewing Company 
##                                              5 
##                             Colorado Cider Co. 
##                                              4 
##                      Crow Peak Brewing Company 
##                                              3 
##                Devils Backbone Brewing Company 
##                                              2 
##                      Devils Canyon Brewing Co. 
##                                              4 
##                           Diamond Knot Brewery 
##                                              8 
##                          Dicks Brewing Company 
##                                             12 
##                           Dry Dock Brewing Co. 
##                                              3 
##                         DuClaw Brewing Company 
##                                              7 
##                Eddyline Restaurant and Brewery 
##                                              5 
##                         Elevation Beer Company 
##                                              1 
##                            Elysian Brewing Co. 
##                                             17 
##                           Erie Brewing Company 
##                                             10 
##                       Evil Genius Beer Company 
##                                              4 
##                       Figure Eight Brewing LLC 
##                                              6 
##                              Flat 12 Bierwerks 
##                                              7 
##                           Fort Collins Brewery 
##                                              7 
##                       French Broad Brewing Co. 
##                                              6 
##                            Great River Brewery 
##                                              4 
##                                     Hales Ales 
##                                              8 
##                         Harlem Brewing Company 
##                                              1 
##                        Heretic Brewing Company 
##                                              5 
##                     High Noon Saloon & Brewery 
##                                              3 
##                       Highland Brewing Company 
##                                              8 
##                      Hilliards Brewing Company 
##                                              3 
##                         Hopworks Urban Brewery 
##                                              5 
##                        Huebert Brewing Company 
##                                              4 
##                      La Cumbre Brewing Company 
##                                              1 
##              Laurelwood Public House & Brewery 
##                                              8 
##                  Lazy Magnolia Brewing Company 
##                                              5 
##     Left Coast/Oggis Pizza and Brewing Company 
##                                              7 
##                              Mad River Brewery 
##                                              6 
##                  Madison River Brewing Company 
##                                              4 
##                                 Marble Brewery 
##                                              4 
##                     Millstream Brewing Company 
##                                             10 
##                                Mission Brewery 
##                                              6 
##                       Monocacy Brewing Company 
##                                              1 
##                    Mother Road Brewing Company 
##                                              3 
##                   Moylans Brewery & Restaurant 
##                                             13 
##                   Narragansett Brewing Company 
##                                              7 
##                           Odin Brewing Company 
##                                              3 
##                     Pale Horse Brewing Company 
##                                              6 
##                   Philadelphia Brewing Company 
##                                             10 
##                      Port City Brewing Company 
##                                              5 
##                            Rahr & Sons Brewing 
##                                              4 
##                                 Red Lodge Ales 
##                                              6 
##                       Renegade Brewing Company 
##                                              1 
## Rio Grande Brewing Co. (Sierra Blanca Brewing) 
##                                              4 
##                              Rivertown Brewing 
##                                             17 
##                       Santa Fe Brewing Company 
##                                              9 
##                       Sierra Blanca Brewing Co 
##                                              5 
##                             Six Rivers Brewery 
##                                              5 
##                                Straight To Ale 
##                                              1 
##                         Strike Brewing Company 
##                                              5 
##                      Telluride Brewing Company 
##                                              1 
##                          Terrapin Beer Company 
##                                              4 
##                    Thunderhead Brewing Company 
##                                              2 
##                           Twisted Pine Brewing 
##                                              5 
##                        Upslope Brewing Company 
##                                              5 
##                             Voodoo Brewing Co. 
##                                              6
```

----
## Average overall score by abv 


```r
tapply(beer$score.overall, round(beer$abv), mean, na.rm = TRUE)
```

```
##        0        4        5        6        7        8        9       10 
## 51.63636 43.68571 54.64706 65.58416 76.33333 79.91111 88.25000 85.38462 
##       11       12       13 
## 96.00000 87.66667 97.00000
```

----
## Make a summary by abv


```r
abv <- round(beer$abv)

smry <- data.frame(
  row.names = names(table(abv)),
  meanOverallScore = tapply(beer$score.overall, abv, mean, na.rm = TRUE),
  numberRatings = tapply(beer$ratings, abv, sum, na.rm = TRUE),
  numberBreweries = tapply(beer$brewer, abv, function(x) length(unique(x)))
  )
```

----

```r
smry
```

```
##    meanOverallScore numberRatings numberBreweries
## 0          51.63636           531              18
## 4          43.68571          3231              25
## 5          54.64706         10061              44
## 6          65.58416         13704              46
## 7          76.33333          6575              39
## 8          79.91111          5722              29
## 9          88.25000          2362              13
## 10         85.38462          2656              10
## 11         96.00000            14               1
## 12         87.66667           487               3
## 13         97.00000            99               1
```

----
## An alternative to tapply for summation

Just as `rowSums` and `colSums` are optimized versions of `apply` for summation, `rowsum` is an optimized version of `tapply` for summation.

Compute the total number of ratings by brewer


```r
rowsum(beer$ratings, beer$brewer)
```

```
##                                                [,1]
## Abbey Beverage Company                          145
## Alameda Brewing Co.                             434
## Ale Industries                                   38
## American Brewing Company                        116
## Appalachian Brewing Company (PA)               1321
## Bent River Brewing Company                       92
## Bison Brewing Company                          1220
## Blue Mountain Brewery                           162
## Blue Point Brewing                             3198
## Boxcar Brewing Company                           56
## Brewers Alley Restaurant & Brewery              192
## Carolina Brewing Company                        284
## Cavalry Brewing Company                          58
## Colorado Cider Co.                               30
## Crow Peak Brewing Company                       178
## Devils Backbone Brewing Company                 150
## Devils Canyon Brewing Co.                       106
## Diamond Knot Brewery                           1027
## Dicks Brewing Company                           955
## Dry Dock Brewing Co.                            217
## DuClaw Brewing Company                          638
## Eddyline Restaurant and Brewery                  63
## Elevation Beer Company                           16
## Elysian Brewing Co.                            3361
## Erie Brewing Company                           1605
## Evil Genius Beer Company                         54
## Figure Eight Brewing LLC                         75
## Flat 12 Bierwerks                               189
## Fort Collins Brewery                           2527
## French Broad Brewing Co.                        765
## Great River Brewery                             238
## Hales Ales                                      946
## Harlem Brewing Company                           65
## Heretic Brewing Company                         388
## High Noon Saloon & Brewery                       53
## Highland Brewing Company                       2715
## Hilliards Brewing Company                        58
## Hopworks Urban Brewery                          611
## Huebert Brewing Company                          12
## La Cumbre Brewing Company                       112
## Laurelwood Public House & Brewery               446
## Lazy Magnolia Brewing Company                   962
## Left Coast/Oggis Pizza and Brewing Company      632
## Mad River Brewery                              2485
## Madison River Brewing Company                   210
## Marble Brewery                                  195
## Millstream Brewing Company                     1217
## Mission Brewery                                 886
## Monocacy Brewing Company                          6
## Mother Road Brewing Company                      17
## Moylans Brewery & Restaurant                   5148
## Narragansett Brewing Company                    514
## Odin Brewing Company                             91
## Pale Horse Brewing Company                       72
## Philadelphia Brewing Company                    762
## Port City Brewing Company                       299
## Rahr & Sons Brewing                             570
## Red Lodge Ales                                  140
## Renegade Brewing Company                         25
## Rio Grande Brewing Co. (Sierra Blanca Brewing)  205
## Rivertown Brewing                               718
## Santa Fe Brewing Company                       1229
## Sierra Blanca Brewing Co                        286
## Six Rivers Brewery                              252
## Straight To Ale                                  41
## Strike Brewing Company                           14
## Telluride Brewing Company                         8
## Terrapin Beer Company                          1678
## Thunderhead Brewing Company                      55
## Twisted Pine Brewing                            764
## Upslope Brewing Company                         220
## Voodoo Brewing Co.                              825
```

----
## Calculate average overall score for each brewer


```r
tot <- rowsum(beer$score.overall, beer$brewer)
n <- tapply(beer$score.overall, beer$brewer, length)
av <- tot[ ,1]/n # Note tot is an integer matrix
as.matrix(av)
```

```
##                                                     [,1]
## Abbey Beverage Company                                NA
## Alameda Brewing Co.                                   NA
## Ale Industries                                        NA
## American Brewing Company                        76.00000
## Appalachian Brewing Company (PA)                56.57143
## Bent River Brewing Company                      54.50000
## Bison Brewing Company                           63.50000
## Blue Mountain Brewery                           81.66667
## Blue Point Brewing                              65.76923
## Boxcar Brewing Company                          23.33333
## Brewers Alley Restaurant & Brewery              58.50000
## Carolina Brewing Company                        61.60000
## Cavalry Brewing Company                               NA
## Colorado Cider Co.                                    NA
## Crow Peak Brewing Company                       54.33333
## Devils Backbone Brewing Company                 70.50000
## Devils Canyon Brewing Co.                       68.25000
## Diamond Knot Brewery                            69.37500
## Dicks Brewing Company                           73.58333
## Dry Dock Brewing Co.                            91.00000
## DuClaw Brewing Company                          80.71429
## Eddyline Restaurant and Brewery                       NA
## Elevation Beer Company                          80.00000
## Elysian Brewing Co.                             86.41176
## Erie Brewing Company                            49.90000
## Evil Genius Beer Company                              NA
## Figure Eight Brewing LLC                              NA
## Flat 12 Bierwerks                                     NA
## Fort Collins Brewery                            72.42857
## French Broad Brewing Co.                        75.50000
## Great River Brewery                             70.00000
## Hales Ales                                      72.00000
## Harlem Brewing Company                          20.00000
## Heretic Brewing Company                         87.00000
## High Noon Saloon & Brewery                      26.33333
## Highland Brewing Company                        75.75000
## Hilliards Brewing Company                       57.66667
## Hopworks Urban Brewery                          89.80000
## Huebert Brewing Company                               NA
## La Cumbre Brewing Company                      100.00000
## Laurelwood Public House & Brewery               84.87500
## Lazy Magnolia Brewing Company                   65.60000
## Left Coast/Oggis Pizza and Brewing Company      80.57143
## Mad River Brewery                               82.00000
## Madison River Brewing Company                   44.00000
## Marble Brewery                                  92.50000
## Millstream Brewing Company                      60.30000
## Mission Brewery                                 72.33333
## Monocacy Brewing Company                              NA
## Mother Road Brewing Company                           NA
## Moylans Brewery & Restaurant                          NA
## Narragansett Brewing Company                    37.14286
## Odin Brewing Company                            69.66667
## Pale Horse Brewing Company                            NA
## Philadelphia Brewing Company                    55.80000
## Port City Brewing Company                       70.00000
## Rahr & Sons Brewing                             32.00000
## Red Lodge Ales                                  47.16667
## Renegade Brewing Company                        72.00000
## Rio Grande Brewing Co. (Sierra Blanca Brewing)  23.75000
## Rivertown Brewing                               60.58824
## Santa Fe Brewing Company                        77.00000
## Sierra Blanca Brewing Co                        41.20000
## Six Rivers Brewery                              56.40000
## Straight To Ale                                 91.00000
## Strike Brewing Company                                NA
## Telluride Brewing Company                             NA
## Terrapin Beer Company                           83.25000
## Thunderhead Brewing Company                     39.50000
## Twisted Pine Brewing                            42.80000
## Upslope Brewing Company                         48.80000
## Voodoo Brewing Co.                              75.66667
```

----
## The `by()` function

Apply a function to groups.


```r
library(openintro) # Lots of nice datasets (which I just discovered)
data(census)
head(census)
```

```
##   censusYear stateFIPScode totalFamilyIncome age    sex     raceGeneral
## 1       2000       Florida             14550  44   Male Two major races
## 2       2000       Florida             22800  20 Female           White
## 3       2000       Florida                 0  20   Male           Black
## 4       2000       Florida             23000   6 Female           White
## 5       2000       Florida             48000  55   Male           White
## 6       2000       Florida             74000  43 Female           White
##            maritalStatus totalPersonalIncome
## 1 Married/spouse present                   0
## 2   Never married/single               13000
## 3   Never married/single               20000
## 4   Never married/single                  NA
## 5 Married/spouse present               36000
## 6 Married/spouse present               27000
```

----
## Calculate means by state, race, and sex


```r
means <- by(census$totalPersonalIncome, 
              list(census$stateFIPScode, 
                   census$raceGeneral,
                   census$sex), mean, na.rm = TRUE)
means # Note there's a lot of missing data
```

```
## : Alabama
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Colorado
## : American Indian or Alaska Native
## : Female
## [1] 26700
## -------------------------------------------------------- 
## : Connecticut
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : American Indian or Alaska Native
## : Female
## [1] 20000
## -------------------------------------------------------- 
## : Minnesota
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : American Indian or Alaska Native
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Black
## : Female
## [1] 7100
## -------------------------------------------------------- 
## : Arizona
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Black
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : California
## : Black
## : Female
## [1] 40000
## -------------------------------------------------------- 
## : Colorado
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Black
## : Female
## [1] 3600
## -------------------------------------------------------- 
## : Delaware
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Black
## : Female
## [1] 40000
## -------------------------------------------------------- 
## : Georgia
## : Black
## : Female
## [1] 19066.67
## -------------------------------------------------------- 
## : Hawaii
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Black
## : Female
## [1] 30000
## -------------------------------------------------------- 
## : Indiana
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Black
## : Female
## [1] 9500
## -------------------------------------------------------- 
## : Massachusetts
## : Black
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : Michigan
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Black
## : Female
## [1] 700
## -------------------------------------------------------- 
## : Missouri
## : Black
## : Female
## [1] 54000
## -------------------------------------------------------- 
## : Montana
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Black
## : Female
## [1] 18500
## -------------------------------------------------------- 
## : New Mexico
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Black
## : Female
## [1] 9025
## -------------------------------------------------------- 
## : North Carolina
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Black
## : Female
## [1] 19604
## -------------------------------------------------------- 
## : Oklahoma
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Black
## : Female
## [1] 27000
## -------------------------------------------------------- 
## : Rhode Island
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Black
## : Female
## [1] 15000
## -------------------------------------------------------- 
## : Tennessee
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Black
## : Female
## [1] 10000
## -------------------------------------------------------- 
## : Utah
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Black
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : Chinese
## : Female
## [1] 0
## -------------------------------------------------------- 
## : Colorado
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Chinese
## : Female
## [1] 34600
## -------------------------------------------------------- 
## : Idaho
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Chinese
## : Female
## [1] 0
## -------------------------------------------------------- 
## : North Carolina
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Chinese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Colorado
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Japanese
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Other
## : Female
## [1] 15300
## -------------------------------------------------------- 
## : Arizona
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : Other
## : Female
## [1] 1900
## -------------------------------------------------------- 
## : Colorado
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Other
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : Iowa
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Other
## : Female
## [1] 0
## -------------------------------------------------------- 
## : Michigan
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Other
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : New Mexico
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Other
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : Pennsylvania
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Other
## : Female
## [1] 0
## -------------------------------------------------------- 
## : Utah
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Other
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : Other Asian or Pacific Islander
## : Female
## [1] 21150
## -------------------------------------------------------- 
## : Colorado
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Other Asian or Pacific Islander
## : Female
## [1] 22000
## -------------------------------------------------------- 
## : Idaho
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Other Asian or Pacific Islander
## : Female
## [1] 0
## -------------------------------------------------------- 
## : North Carolina
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Other Asian or Pacific Islander
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : West Virginia
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Other Asian or Pacific Islander
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : Two major races
## : Female
## [1] 0
## -------------------------------------------------------- 
## : Colorado
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Two major races
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : New Hampshire
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Two major races
## : Female
## [1] 25000
## -------------------------------------------------------- 
## : North Carolina
## : Two major races
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : Ohio
## : Two major races
## : Female
## [1] 0
## -------------------------------------------------------- 
## : Oklahoma
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Two major races
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : White
## : Female
## [1] 20000
## -------------------------------------------------------- 
## : Arkansas
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : California
## : White
## : Female
## [1] 17994.44
## -------------------------------------------------------- 
## : Colorado
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : White
## : Female
## [1] 34300
## -------------------------------------------------------- 
## : Delaware
## : White
## : Female
## [1] 9100
## -------------------------------------------------------- 
## : District of Columbia
## : White
## : Female
## [1] 30000
## -------------------------------------------------------- 
## : Florida
## : White
## : Female
## [1] 17229.41
## -------------------------------------------------------- 
## : Georgia
## : White
## : Female
## [1] 28410
## -------------------------------------------------------- 
## : Hawaii
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : White
## : Female
## [1] 15781.82
## -------------------------------------------------------- 
## : Indiana
## : White
## : Female
## [1] 19390
## -------------------------------------------------------- 
## : Iowa
## : White
## : Female
## [1] 14300
## -------------------------------------------------------- 
## : Kansas
## : White
## : Female
## [1] 484
## -------------------------------------------------------- 
## : Kentucky
## : White
## : Female
## [1] 13600
## -------------------------------------------------------- 
## : Louisiana
## : White
## : Female
## [1] 16050
## -------------------------------------------------------- 
## : Maine
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : White
## : Female
## [1] 36850
## -------------------------------------------------------- 
## : Massachusetts
## : White
## : Female
## [1] 35042.86
## -------------------------------------------------------- 
## : Michigan
## : White
## : Female
## [1] 240
## -------------------------------------------------------- 
## : Minnesota
## : White
## : Female
## [1] 24550
## -------------------------------------------------------- 
## : Mississippi
## : White
## : Female
## [1] 25000
## -------------------------------------------------------- 
## : Missouri
## : White
## : Female
## [1] 7800
## -------------------------------------------------------- 
## : Montana
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : White
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : New Hampshire
## : White
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : New Jersey
## : White
## : Female
## [1] 15052.5
## -------------------------------------------------------- 
## : New Mexico
## : White
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : New York
## : White
## : Female
## [1] 29825.56
## -------------------------------------------------------- 
## : North Carolina
## : White
## : Female
## [1] 8200
## -------------------------------------------------------- 
## : Ohio
## : White
## : Female
## [1] 17914.29
## -------------------------------------------------------- 
## : Oklahoma
## : White
## : Female
## [1] 27100
## -------------------------------------------------------- 
## : Oregon
## : White
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : Pennsylvania
## : White
## : Female
## [1] 10850
## -------------------------------------------------------- 
## : Rhode Island
## : White
## : Female
## [1] 44004
## -------------------------------------------------------- 
## : South Carolina
## : White
## : Female
## [1] 23000
## -------------------------------------------------------- 
## : Tennessee
## : White
## : Female
## [1] 12200
## -------------------------------------------------------- 
## : Texas
## : White
## : Female
## [1] 10640
## -------------------------------------------------------- 
## : Utah
## : White
## : Female
## [1] 15000
## -------------------------------------------------------- 
## : Virginia
## : White
## : Female
## [1] 8500
## -------------------------------------------------------- 
## : Washington
## : White
## : Female
## [1] 8300
## -------------------------------------------------------- 
## : West Virginia
## : White
## : Female
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : White
## : Female
## [1] 20000
## -------------------------------------------------------- 
## : Wyoming
## : White
## : Female
## [1] NaN
## -------------------------------------------------------- 
## : Alabama
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Colorado
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New York
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : American Indian or Alaska Native
## : Male
## [1] 0
## -------------------------------------------------------- 
## : West Virginia
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : American Indian or Alaska Native
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : Black
## : Male
## [1] 57190
## -------------------------------------------------------- 
## : Colorado
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Black
## : Male
## [1] 11066.67
## -------------------------------------------------------- 
## : Georgia
## : Black
## : Male
## [1] 25025
## -------------------------------------------------------- 
## : Hawaii
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Black
## : Male
## [1] 4000
## -------------------------------------------------------- 
## : Iowa
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Black
## : Male
## [1] 51900
## -------------------------------------------------------- 
## : Louisiana
## : Black
## : Male
## [1] 6350
## -------------------------------------------------------- 
## : Maine
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Black
## : Male
## [1] 10400
## -------------------------------------------------------- 
## : Massachusetts
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Black
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : Missouri
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Black
## : Male
## [1] 36000
## -------------------------------------------------------- 
## : New Mexico
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Black
## : Male
## [1] 3180
## -------------------------------------------------------- 
## : North Carolina
## : Black
## : Male
## [1] 14000
## -------------------------------------------------------- 
## : Ohio
## : Black
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : Oklahoma
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Black
## : Male
## [1] 6500
## -------------------------------------------------------- 
## : Rhode Island
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Black
## : Male
## [1] 8796.667
## -------------------------------------------------------- 
## : Utah
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Black
## : Male
## [1] 31800
## -------------------------------------------------------- 
## : Washington
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Black
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : Chinese
## : Male
## [1] 20000
## -------------------------------------------------------- 
## : Colorado
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Chinese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Japanese
## : Male
## [1] 45000
## -------------------------------------------------------- 
## : Arkansas
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Colorado
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Japanese
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : Other
## : Male
## [1] 10900
## -------------------------------------------------------- 
## : Colorado
## : Other
## : Male
## [1] 13000
## -------------------------------------------------------- 
## : Connecticut
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Other
## : Male
## [1] 24250
## -------------------------------------------------------- 
## : Georgia
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Other
## : Male
## [1] 40600
## -------------------------------------------------------- 
## : Indiana
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Mexico
## : Other
## : Male
## [1] 10600
## -------------------------------------------------------- 
## : New York
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Other
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : Oregon
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Other
## : Male
## [1] 0
## -------------------------------------------------------- 
## : Rhode Island
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Other
## : Male
## [1] 16000
## -------------------------------------------------------- 
## : West Virginia
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Other
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : Other Asian or Pacific Islander
## : Male
## [1] 95000
## -------------------------------------------------------- 
## : Colorado
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Georgia
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Hawaii
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Other Asian or Pacific Islander
## : Male
## [1] 39920
## -------------------------------------------------------- 
## : Iowa
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Massachusetts
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Minnesota
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : Other Asian or Pacific Islander
## : Male
## [1] 23000
## -------------------------------------------------------- 
## : New Hampshire
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Other Asian or Pacific Islander
## : Male
## [1] 317000
## -------------------------------------------------------- 
## : New Mexico
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : North Carolina
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Other Asian or Pacific Islander
## : Male
## [1] 12000
## -------------------------------------------------------- 
## : Oklahoma
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Tennessee
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Other Asian or Pacific Islander
## : Male
## [1] 15000
## -------------------------------------------------------- 
## : West Virginia
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Other Asian or Pacific Islander
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arizona
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Arkansas
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : Two major races
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : Colorado
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Connecticut
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Delaware
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Florida
## : Two major races
## : Male
## [1] 0
## -------------------------------------------------------- 
## : Georgia
## : Two major races
## : Male
## [1] 19700
## -------------------------------------------------------- 
## : Hawaii
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Illinois
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Indiana
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Iowa
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kansas
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Kentucky
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Louisiana
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maine
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Maryland
## : Two major races
## : Male
## [1] 22460
## -------------------------------------------------------- 
## : Massachusetts
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Michigan
## : Two major races
## : Male
## [1] 69000
## -------------------------------------------------------- 
## : Minnesota
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Mississippi
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Missouri
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Montana
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nebraska
## : Two major races
## : Male
## [1] 40000
## -------------------------------------------------------- 
## : Nevada
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Hampshire
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New Jersey
## : Two major races
## : Male
## [1] 24500
## -------------------------------------------------------- 
## : New Mexico
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : New York
## : Two major races
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : North Carolina
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Ohio
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oklahoma
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Oregon
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Pennsylvania
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Rhode Island
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : South Carolina
## : Two major races
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : Tennessee
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Texas
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Utah
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Virginia
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Washington
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : West Virginia
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wisconsin
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Wyoming
## : Two major races
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Alabama
## : White
## : Male
## [1] 47950
## -------------------------------------------------------- 
## : Arizona
## : White
## : Male
## [1] 14000
## -------------------------------------------------------- 
## : Arkansas
## : White
## : Male
## [1] NA
## -------------------------------------------------------- 
## : California
## : White
## : Male
## [1] 77400
## -------------------------------------------------------- 
## : Colorado
## : White
## : Male
## [1] 223050
## -------------------------------------------------------- 
## : Connecticut
## : White
## : Male
## [1] 25500
## -------------------------------------------------------- 
## : Delaware
## : White
## : Male
## [1] NA
## -------------------------------------------------------- 
## : District of Columbia
## : White
## : Male
## [1] 17190
## -------------------------------------------------------- 
## : Florida
## : White
## : Male
## [1] 29291.11
## -------------------------------------------------------- 
## : Georgia
## : White
## : Male
## [1] 60212
## -------------------------------------------------------- 
## : Hawaii
## : White
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Idaho
## : White
## : Male
## [1] 23000
## -------------------------------------------------------- 
## : Illinois
## : White
## : Male
## [1] 32940
## -------------------------------------------------------- 
## : Indiana
## : White
## : Male
## [1] 21250
## -------------------------------------------------------- 
## : Iowa
## : White
## : Male
## [1] 28500
## -------------------------------------------------------- 
## : Kansas
## : White
## : Male
## [1] 41000
## -------------------------------------------------------- 
## : Kentucky
## : White
## : Male
## [1] 240000
## -------------------------------------------------------- 
## : Louisiana
## : White
## : Male
## [1] 40575
## -------------------------------------------------------- 
## : Maine
## : White
## : Male
## [1] 10700
## -------------------------------------------------------- 
## : Maryland
## : White
## : Male
## [1] 46850
## -------------------------------------------------------- 
## : Massachusetts
## : White
## : Male
## [1] 24166.67
## -------------------------------------------------------- 
## : Michigan
## : White
## : Male
## [1] 49966.67
## -------------------------------------------------------- 
## : Minnesota
## : White
## : Male
## [1] 14333.33
## -------------------------------------------------------- 
## : Mississippi
## : White
## : Male
## [1] 25000
## -------------------------------------------------------- 
## : Missouri
## : White
## : Male
## [1] 14600
## -------------------------------------------------------- 
## : Montana
## : White
## : Male
## [1] 36000
## -------------------------------------------------------- 
## : Nebraska
## : White
## : Male
## [1] NA
## -------------------------------------------------------- 
## : Nevada
## : White
## : Male
## [1] NaN
## -------------------------------------------------------- 
## : New Hampshire
## : White
## : Male
## [1] 14700
## -------------------------------------------------------- 
## : New Jersey
## : White
## : Male
## [1] 11420
## -------------------------------------------------------- 
## : New Mexico
## : White
## : Male
## [1] 44000
## -------------------------------------------------------- 
## : New York
## : White
## : Male
## [1] 46487
## -------------------------------------------------------- 
## : North Carolina
## : White
## : Male
## [1] 21526.67
## -------------------------------------------------------- 
## : Ohio
## : White
## : Male
## [1] 33161.43
## -------------------------------------------------------- 
## : Oklahoma
## : White
## : Male
## [1] 43866.67
## -------------------------------------------------------- 
## : Oregon
## : White
## : Male
## [1] 12000
## -------------------------------------------------------- 
## : Pennsylvania
## : White
## : Male
## [1] 36202.22
## -------------------------------------------------------- 
## : Rhode Island
## : White
## : Male
## [1] 43000
## -------------------------------------------------------- 
## : South Carolina
## : White
## : Male
## [1] 26960
## -------------------------------------------------------- 
## : Tennessee
## : White
## : Male
## [1] 61675
## -------------------------------------------------------- 
## : Texas
## : White
## : Male
## [1] 57515
## -------------------------------------------------------- 
## : Utah
## : White
## : Male
## [1] 72600
## -------------------------------------------------------- 
## : Virginia
## : White
## : Male
## [1] 18900
## -------------------------------------------------------- 
## : Washington
## : White
## : Male
## [1] 26525
## -------------------------------------------------------- 
## : West Virginia
## : White
## : Male
## [1] 0
## -------------------------------------------------------- 
## : Wisconsin
## : White
## : Male
## [1] 36672.86
## -------------------------------------------------------- 
## : Wyoming
## : White
## : Male
## [1] NA
```

----
## Structure of means


```r
str(means)
```

```
##  by [1:47, 1:8, 1:2] NA NA NA NA 26700 NA NA NA NA NA ...
##  - attr(*, "dimnames")=List of 3
##   ..$ : chr [1:47] "Alabama" "Arizona" "Arkansas" "California" ...
##   ..$ : chr [1:8] "American Indian or Alaska Native" "Black" "Chinese" "Japanese" ...
##   ..$ : chr [1:2] "Female" "Male"
##  - attr(*, "call")= language by.default(data = census$totalPersonalIncome, INDICES = list(census$stateFIPScode,      census$raceGeneral, census$sex), FUN = mean, na.rm = TRUE)
```

----
## Compute marginal means by state


```r
apply(means, 1, mean, na.rm = TRUE)
```

```
##              Alabama              Arizona             Arkansas 
##             23450.00             26333.33                  NaN 
##           California             Colorado          Connecticut 
##             31048.59             87583.33             21133.33 
##             Delaware District of Columbia              Florida 
##              9100.00             23595.00             20306.20 
##              Georgia               Hawaii                Idaho 
##             30482.73             28300.00             23000.00 
##             Illinois              Indiana                 Iowa 
##             29830.45             21140.00             21400.00 
##               Kansas             Kentucky            Louisiana 
##             20742.00            101833.33             20991.67 
##                Maine             Maryland        Massachusetts 
##             10700.00             25212.00             19736.51 
##             Michigan            Minnesota          Mississippi 
##             34801.67             19441.67             16900.00 
##             Missouri              Montana             Nebraska 
##             25466.67             36000.00             40000.00 
##               Nevada        New Hampshire           New Jersey 
##             23000.00             14700.00             70412.08 
##           New Mexico             New York       North Carolina 
##             27300.00             16216.79             14575.56 
##                 Ohio             Oklahoma               Oregon 
##             16535.94             35483.33             12000.00 
##         Pennsylvania         Rhode Island       South Carolina 
##             16110.44             43502.00             21653.33 
##            Tennessee                Texas                 Utah 
##             36937.50             17390.33             43800.00 
##             Virginia           Washington        West Virginia 
##             19733.33             13165.00                 0.00 
##            Wisconsin              Wyoming 
##             28336.43                  NaN
```

----
## Compute marginal means by race/ethnicity


```r
apply(means, 2, mean, na.rm = TRUE)
```

```
## American Indian or Alaska Native                            Black 
##                         15566.67                         20332.29 
##                          Chinese                         Japanese 
##                         13650.00                         45000.00 
##                            Other  Other Asian or Pacific Islander 
##                         12050.00                         60563.33 
##                  Two major races                            White 
##                         22295.56                         31991.83
```

----
## Compute marginal means by sex


```r
apply(means, 3, mean, na.rm = TRUE)
```

```
##   Female     Male 
## 17245.31 37826.64
```

----
## Look within a particular state


```r
means["Oregon", , ]
```

```
##                                  Female  Male
## American Indian or Alaska Native     NA    NA
## Black                                NA    NA
## Chinese                              NA    NA
## Japanese                             NA    NA
## Other                               NaN    NA
## Other Asian or Pacific Islander      NA    NA
## Two major races                      NA    NA
## White                               NaN 12000
```

----
## Only individuals identifying as Black


```r
means[ ,"Black", ]
```

```
##                        Female      Male
## Alabama               7100.00        NA
## Arizona                    NA        NA
## Arkansas                  NaN        NA
## California           40000.00 57190.000
## Colorado                   NA        NA
## Connecticut           3600.00        NA
## Delaware                   NA        NA
## District of Columbia       NA        NA
## Florida              40000.00 11066.667
## Georgia              19066.67 25025.000
## Hawaii                     NA        NA
## Idaho                      NA        NA
## Illinois             30000.00        NA
## Indiana                    NA  4000.000
## Iowa                       NA        NA
## Kansas                     NA        NA
## Kentucky                   NA 51900.000
## Louisiana                  NA  6350.000
## Maine                      NA        NA
## Maryland              9500.00 10400.000
## Massachusetts             NaN        NA
## Michigan                   NA        NA
## Minnesota                  NA        NA
## Mississippi            700.00       NaN
## Missouri             54000.00        NA
## Montana                    NA        NA
## Nebraska                   NA        NA
## Nevada                     NA        NA
## New Hampshire              NA        NA
## New Jersey           18500.00 36000.000
## New Mexico                 NA        NA
## New York              9025.00  3180.000
## North Carolina             NA 14000.000
## Ohio                 19604.00       NaN
## Oklahoma                   NA        NA
## Oregon                     NA        NA
## Pennsylvania         27000.00  6500.000
## Rhode Island               NA        NA
## South Carolina       15000.00        NA
## Tennessee                  NA        NA
## Texas                10000.00  8796.667
## Utah                       NA        NA
## Virginia                   NA 31800.000
## Washington                 NA        NA
## West Virginia              NA        NA
## Wisconsin                  NA        NA
## Wyoming                    NA        NA
```

----
## Only Males


```r
means[ , ,"Male"]
```

```
##                      American Indian or Alaska Native     Black Chinese
## Alabama                                            NA        NA      NA
## Arizona                                            NA        NA      NA
## Arkansas                                           NA        NA      NA
## California                                         NA 57190.000   20000
## Colorado                                           NA        NA      NA
## Connecticut                                        NA        NA      NA
## Delaware                                           NA        NA      NA
## District of Columbia                               NA        NA      NA
## Florida                                            NA 11066.667      NA
## Georgia                                            NA 25025.000      NA
## Hawaii                                             NA        NA      NA
## Idaho                                              NA        NA      NA
## Illinois                                           NA        NA      NA
## Indiana                                            NA  4000.000      NA
## Iowa                                               NA        NA      NA
## Kansas                                             NA        NA      NA
## Kentucky                                           NA 51900.000      NA
## Louisiana                                          NA  6350.000      NA
## Maine                                              NA        NA      NA
## Maryland                                           NA 10400.000      NA
## Massachusetts                                      NA        NA      NA
## Michigan                                           NA        NA      NA
## Minnesota                                          NA        NA      NA
## Mississippi                                        NA       NaN      NA
## Missouri                                           NA        NA      NA
## Montana                                            NA        NA      NA
## Nebraska                                           NA        NA      NA
## Nevada                                             NA        NA      NA
## New Hampshire                                      NA        NA      NA
## New Jersey                                         NA 36000.000      NA
## New Mexico                                         NA        NA      NA
## New York                                           NA  3180.000      NA
## North Carolina                                     NA 14000.000      NA
## Ohio                                               NA       NaN      NA
## Oklahoma                                           NA        NA      NA
## Oregon                                             NA        NA      NA
## Pennsylvania                                       NA  6500.000      NA
## Rhode Island                                       NA        NA      NA
## South Carolina                                     NA        NA      NA
## Tennessee                                          NA        NA      NA
## Texas                                              NA  8796.667      NA
## Utah                                               NA        NA      NA
## Virginia                                           NA 31800.000      NA
## Washington                                          0        NA      NA
## West Virginia                                      NA        NA      NA
## Wisconsin                                          NA        NA      NA
## Wyoming                                            NA        NA      NA
##                      Japanese Other Other Asian or Pacific Islander
## Alabama                    NA    NA                              NA
## Arizona                 45000    NA                              NA
## Arkansas                   NA    NA                              NA
## California                 NA 10900                           95000
## Colorado                   NA 13000                              NA
## Connecticut                NA    NA                              NA
## Delaware                   NA    NA                              NA
## District of Columbia       NA    NA                              NA
## Florida                    NA 24250                              NA
## Georgia                    NA    NA                              NA
## Hawaii                     NA    NA                              NA
## Idaho                      NA    NA                              NA
## Illinois                   NA 40600                              NA
## Indiana                    NA    NA                           39920
## Iowa                       NA    NA                              NA
## Kansas                     NA    NA                              NA
## Kentucky                   NA    NA                              NA
## Louisiana                  NA    NA                              NA
## Maine                      NA    NA                              NA
## Maryland                   NA    NA                              NA
## Massachusetts              NA    NA                              NA
## Michigan                   NA    NA                              NA
## Minnesota                  NA    NA                              NA
## Mississippi                NA    NA                              NA
## Missouri                   NA    NA                              NA
## Montana                    NA    NA                              NA
## Nebraska                   NA    NA                              NA
## Nevada                     NA    NA                           23000
## New Hampshire              NA    NA                              NA
## New Jersey                 NA    NA                          317000
## New Mexico                 NA 10600                              NA
## New York                   NA    NA                              NA
## North Carolina             NA    NA                              NA
## Ohio                       NA    NA                           12000
## Oklahoma                   NA   NaN                              NA
## Oregon                     NA    NA                              NA
## Pennsylvania               NA     0                              NA
## Rhode Island               NA    NA                              NA
## South Carolina             NA    NA                              NA
## Tennessee                  NA    NA                              NA
## Texas                      NA    NA                              NA
## Utah                       NA    NA                              NA
## Virginia                   NA    NA                              NA
## Washington                 NA 16000                           15000
## West Virginia              NA    NA                              NA
## Wisconsin                  NA    NA                              NA
## Wyoming                    NA    NA                              NA
##                      Two major races     White
## Alabama                           NA  47950.00
## Arizona                           NA  14000.00
## Arkansas                          NA        NA
## California                       NaN  77400.00
## Colorado                          NA 223050.00
## Connecticut                       NA  25500.00
## Delaware                          NA        NA
## District of Columbia              NA  17190.00
## Florida                            0  29291.11
## Georgia                        19700  60212.00
## Hawaii                            NA        NA
## Idaho                             NA  23000.00
## Illinois                          NA  32940.00
## Indiana                           NA  21250.00
## Iowa                              NA  28500.00
## Kansas                            NA  41000.00
## Kentucky                          NA 240000.00
## Louisiana                         NA  40575.00
## Maine                             NA  10700.00
## Maryland                       22460  46850.00
## Massachusetts                     NA  24166.67
## Michigan                       69000  49966.67
## Minnesota                         NA  14333.33
## Mississippi                       NA  25000.00
## Missouri                          NA  14600.00
## Montana                           NA  36000.00
## Nebraska                       40000        NA
## Nevada                            NA       NaN
## New Hampshire                     NA  14700.00
## New Jersey                     24500  11420.00
## New Mexico                        NA  44000.00
## New York                         NaN  46487.00
## North Carolina                    NA  21526.67
## Ohio                              NA  33161.43
## Oklahoma                          NA  43866.67
## Oregon                            NA  12000.00
## Pennsylvania                      NA  36202.22
## Rhode Island                      NA  43000.00
## South Carolina                   NaN  26960.00
## Tennessee                         NA  61675.00
## Texas                             NA  57515.00
## Utah                              NA  72600.00
## Virginia                          NA  18900.00
## Washington                        NA  26525.00
## West Virginia                     NA      0.00
## Wisconsin                         NA  36672.86
## Wyoming                           NA        NA
```

----
## The `aggregate()` Function

Aggregate is another way of summarizing data, but the output returned is different.

Note that a formula can be used.


```r
ag <- aggregate(totalPersonalIncome ~ stateFIPScode + raceGeneral + sex, 
        data = census, mean, na.rm = TRUE)
str(ag)
```

```
## 'data.frame':	139 obs. of  4 variables:
##  $ stateFIPScode      : Factor w/ 47 levels "Alabama","Arizona",..: 5 22 1 4 6 9 10 13 20 24 ...
##  $ raceGeneral        : Factor w/ 8 levels "American Indian or Alaska Native",..: 1 1 2 2 2 2 2 2 2 2 ...
##  $ sex                : Factor w/ 2 levels "Female","Male": 1 1 1 1 1 1 1 1 1 1 ...
##  $ totalPersonalIncome: num  26700 20000 7100 40000 3600 ...
```

----
## View output


```r
ag[3:15, ]
```

```
##    stateFIPScode raceGeneral    sex totalPersonalIncome
## 3        Alabama       Black Female             7100.00
## 4     California       Black Female            40000.00
## 5    Connecticut       Black Female             3600.00
## 6        Florida       Black Female            40000.00
## 7        Georgia       Black Female            19066.67
## 8       Illinois       Black Female            30000.00
## 9       Maryland       Black Female             9500.00
## 10   Mississippi       Black Female              700.00
## 11      Missouri       Black Female            54000.00
## 12    New Jersey       Black Female            18500.00
## 13      New York       Black Female             9025.00
## 14          Ohio       Black Female            19604.00
## 15  Pennsylvania       Black Female            27000.00
```

----
## Compare to `tapply()`
The below output (and syntax, essentially) will produce exactly the same array
  produced earlier with `by()`, but that of course is different than `aggregate()`.


```r
means2 <- with(census, tapply(totalPersonalIncome, 
                            list(stateFIPScode, raceGeneral, sex),
                          mean, na.rm = TRUE))
str(means2)
```

```
##  num [1:47, 1:8, 1:2] NA NA NA NA 26700 NA NA NA NA NA ...
##  - attr(*, "dimnames")=List of 3
##   ..$ : chr [1:47] "Alabama" "Arizona" "Arkansas" "California" ...
##   ..$ : chr [1:8] "American Indian or Alaska Native" "Black" "Chinese" "Japanese" ...
##   ..$ : chr [1:2] "Female" "Male"
```

----
## Contrasting functions
Why `tapply()` or `by()` or `aggregate()`?
* The `aggregate()` function provides different output from the other two, 
  which may be preferable at times.
* `tapply()` and `by()` are essentially the same, but `by()` can occasionally
  produce summaries when `tapply()` fails

----
## Contrasting functions example
(Note. The example shown is from SabDeM on [SO](http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega) (the response from joran there is also worth reading))


```r
data(iris)
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

----
Note that `tapply()` fails in this context


```r
tapply(iris, iris$Species, summary)
```

```
## Error in tapply(iris, iris$Species, summary): arguments must have same length
```
<br>

But `by()` can handle this situation

----

```r
by(iris, iris$Species, summary)
```

```
## iris$Species: setosa
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.300   Min.   :2.300   Min.   :1.000   Min.   :0.100  
##  1st Qu.:4.800   1st Qu.:3.200   1st Qu.:1.400   1st Qu.:0.200  
##  Median :5.000   Median :3.400   Median :1.500   Median :0.200  
##  Mean   :5.006   Mean   :3.428   Mean   :1.462   Mean   :0.246  
##  3rd Qu.:5.200   3rd Qu.:3.675   3rd Qu.:1.575   3rd Qu.:0.300  
##  Max.   :5.800   Max.   :4.400   Max.   :1.900   Max.   :0.600  
##        Species  
##  setosa    :50  
##  versicolor: 0  
##  virginica : 0  
##                 
##                 
##                 
## -------------------------------------------------------- 
## iris$Species: versicolor
##   Sepal.Length    Sepal.Width     Petal.Length   Petal.Width   
##  Min.   :4.900   Min.   :2.000   Min.   :3.00   Min.   :1.000  
##  1st Qu.:5.600   1st Qu.:2.525   1st Qu.:4.00   1st Qu.:1.200  
##  Median :5.900   Median :2.800   Median :4.35   Median :1.300  
##  Mean   :5.936   Mean   :2.770   Mean   :4.26   Mean   :1.326  
##  3rd Qu.:6.300   3rd Qu.:3.000   3rd Qu.:4.60   3rd Qu.:1.500  
##  Max.   :7.000   Max.   :3.400   Max.   :5.10   Max.   :1.800  
##        Species  
##  setosa    : 0  
##  versicolor:50  
##  virginica : 0  
##                 
##                 
##                 
## -------------------------------------------------------- 
## iris$Species: virginica
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.900   Min.   :2.200   Min.   :4.500   Min.   :1.400  
##  1st Qu.:6.225   1st Qu.:2.800   1st Qu.:5.100   1st Qu.:1.800  
##  Median :6.500   Median :3.000   Median :5.550   Median :2.000  
##  Mean   :6.588   Mean   :2.974   Mean   :5.552   Mean   :2.026  
##  3rd Qu.:6.900   3rd Qu.:3.175   3rd Qu.:5.875   3rd Qu.:2.300  
##  Max.   :7.900   Max.   :3.800   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    : 0  
##  versicolor: 0  
##  virginica :50  
##                 
##                 
## 
```

----
## Finally: `sweep()`
* Used when you want to *sweep* a function across an array.
* Generally used when you want to apply an operation to an array, but the
  values differ for each column.

![sweep](./assets/img/sweep.png)

----
## Example

`sweep()` can be an efficient way to **center** variables, because you need to
   subtract each value within a column by the mean of that column (rather than subtracting a specific value from each column, in which case we'd just us `apply()`)

----
## Centering columns 4-7 in beer data

```r
head(beer)
```

```
##                                  name                 brewer
## 1                     Abbey Monks Ale Abbey Beverage Company
## 2                  Abbey Monks Tripel Abbey Beverage Company
## 3                     Abbey Monks Wit Abbey Beverage Company
## 4 Alameda Barn Owl Imperial Brown Ale    Alameda Brewing Co.
## 5         Alameda Black Bear XX Stout    Alameda Brewing Co.
## 6       Alameda El Torero Organic IPA    Alameda Brewing Co.
##                     style abv ratings score.overall score.by.style
## 1             Belgian Ale 5.2      96            50             49
## 2            Abbey Tripel 8.0       3            NA             NA
## 3 Belgian White (Witbier) 5.1      46            23             19
## 4               Brown Ale 7.9      13            74             81
## 5           Foreign Stout 6.8     172            94             76
## 6    India Pale Ale (IPA) 7.2      56            74             43
```

----

```r
col_M <- colMeans(beer[ ,4:ncol(beer)], na.rm = TRUE)
col_M
```

```
##            abv        ratings  score.overall score.by.style 
##        5.90015      113.60500       65.85014       60.87193
```

```r
centered <- sweep(beer[ ,4:ncol(beer)], 2, col_M, "-")
head(centered)
```

```
##        abv  ratings score.overall score.by.style
## 1 -0.70015  -17.605    -15.850136      -11.87193
## 2  2.09985 -110.605            NA             NA
## 3 -0.80015  -67.605    -42.850136      -41.87193
## 4  1.99985 -100.605      8.149864       20.12807
## 5  0.89985   58.395     28.149864       15.12807
## 6  1.29985  -57.605      8.149864      -17.87193
```

----

```r
names(centered) <- paste0(names(centered), "_c")
names(centered)
```

```
## [1] "abv_c"            "ratings_c"        "score.overall_c" 
## [4] "score.by.style_c"
```

```r
# Check that centering worked properly
round(colMeans(centered, na.rm = TRUE), digits = 2)
```

```
##            abv_c        ratings_c  score.overall_c score.by.style_c 
##                0                0                0                0
```

----
## Put it all back together

```r
beer <- cbind(beer, centered)
head(beer)
```

```
##                                  name                 brewer
## 1                     Abbey Monks Ale Abbey Beverage Company
## 2                  Abbey Monks Tripel Abbey Beverage Company
## 3                     Abbey Monks Wit Abbey Beverage Company
## 4 Alameda Barn Owl Imperial Brown Ale    Alameda Brewing Co.
## 5         Alameda Black Bear XX Stout    Alameda Brewing Co.
## 6       Alameda El Torero Organic IPA    Alameda Brewing Co.
##                     style abv ratings score.overall score.by.style
## 1             Belgian Ale 5.2      96            50             49
## 2            Abbey Tripel 8.0       3            NA             NA
## 3 Belgian White (Witbier) 5.1      46            23             19
## 4               Brown Ale 7.9      13            74             81
## 5           Foreign Stout 6.8     172            94             76
## 6    India Pale Ale (IPA) 7.2      56            74             43
##      abv_c ratings_c score.overall_c score.by.style_c
## 1 -0.70015   -17.605      -15.850136        -11.87193
## 2  2.09985  -110.605              NA               NA
## 3 -0.80015   -67.605      -42.850136        -41.87193
## 4  1.99985  -100.605        8.149864         20.12807
## 5  0.89985    58.395       28.149864         15.12807
## 6  1.29985   -57.605        8.149864        -17.87193
```

----
## Final Guided Practice
MLB salary data


```r
data(MLB)
head(MLB)
```

```
##          player                 team      position salary
## 1  Brandon Webb Arizona Diamondbacks       Pitcher   8500
## 2   Danny Haren Arizona Diamondbacks       Pitcher   8250
## 3  Chris Snyder Arizona Diamondbacks       Catcher   5250
## 4 Edwin Jackson Arizona Diamondbacks       Pitcher   4600
## 5  Adam LaRoche Arizona Diamondbacks First Baseman   4500
## 6   Chad Qualls Arizona Diamondbacks       Pitcher   4185
```

----
## Salary by position and team
First, transform salary to represent salary in millions


```r
MLB$salary <- MLB$salary / 1000
```
Next, compute the average salary by team and position using the following two
  methods:


```r
array <- by(MLB$salary, list(MLB$team, MLB$position), mean)
dtaframe <- aggregate(salary ~ team + position, data = MLB, mean)
```
Use either of the summaries from above to answer the following two questions

1. Which team spends the most, on average, on pitchers?
2. Which team spends the least, on average, on shortstops?

Finally, compute the total salary by position an team, and answer Questions 1 and 2 again (only in sum, instead of on average).

----
## Solutions w/array


```r
array[ ,"Pitcher"]
```

```
##  Arizona Diamondbacks        Atlanta Braves     Baltimore Orioles 
##              2.545231              3.751764              2.540577 
##        Boston Red Sox          Chicago Cubs     Chicago White Sox 
##              4.271456              5.011286              4.663750 
##       Cincinnati Reds     Cleveland Indians      Colorado Rockies 
##              3.993409              2.163253              2.801267 
##        Detroit Tigers       Florida Marlins        Houston Astros 
##              3.474361              2.022709              2.632071 
##    Kansas City Royals   Los Angeles Angeles   Los Angeles Dodgers 
##              3.021670              3.992538              2.717310 
##     Milwaukee Brewers       Minnesota Twins         New York Mets 
##              3.417119              2.492321              4.691864 
##      New York Yankees     Oakland Athletics Philadelphia Phillies 
##              7.240249              1.186465              4.184289 
##    Pittsburgh Pirates      San Diego Padres  San Francisco Giants 
##              1.385821              1.768108              4.039236 
##      Seattle Mariners   St. Louis Cardinals        Tampa Bay Rays 
##              2.434292              3.604305              2.033936 
##         Texas Rangers     Toronto Blue Jays  Washington Nationals 
##              1.635851              1.071218              1.369867
```

```r
array[ ,"Pitcher"][which.max(array[ ,"Pitcher"])]
```

```
## New York Yankees 
##         7.240249
```

```r
array[ ,"Shortstop"][which.min(array[ ,"Shortstop"])]
```

```
## Oakland Athletics 
##             0.405
```


----
## Solutions w/dtaframe


```r
pitchers <- subset(dtaframe, position == "Pitcher")
pitchers[which.max(pitchers$salary), ]
```

```
##                 team position   salary
## 118 New York Yankees  Pitcher 7.240249
```

```r
shortstops <- subset(dtaframe, position == "Shortstop")
shortstops[which.min(shortstops$salary), ]
```

```
##                  team  position salary
## 179 Oakland Athletics Shortstop  0.405
```

----
## Recalculate with summing


```r
arraySum <- by(MLB$salary, list(MLB$team, MLB$position), sum)
dtaframeSum <- aggregate(salary ~ team + position, data = MLB, sum)

arraySum[ ,"Pitcher"][which.max(arraySum[ ,"Pitcher"])]
```

```
## New York Yankees 
##         86.88299
```

```r
arraySum[ ,"Shortstop"][which.min(arraySum[ ,"Shortstop"])]
```

```
## Oakland Athletics 
##             0.405
```
