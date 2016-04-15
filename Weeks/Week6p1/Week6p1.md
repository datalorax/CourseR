---
title       : "A review of where we've been"
subtitle    : Week 6.1
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
* Review everything we've covered to date
* Finish up from last session (group-level summaries)
    + We may still have a hard time getting here.

<br>

<span style="color:red"> Schedule the rest of spring term dates </span>


---- &twocol
## Review everything we've covered to date

*** =left

* Object assignment
* Data 
    - Types: Logical, integer, double, character, factors (and coercions)
    - Structures: Vectors, matrices, arrays, lists, data frames
    - Attributes
    - Subsetting
* Basic plotting
    - Scatterplots
    - Boxplots
    - Histograms & density plots

*** =right

* Functions
    - Writing generic functions
    - Writing plot functions
* Loops
    - `for()` loops
    - `apply()`, `lapply()`, and `sapply()`
    - Using loops with custom functions

----
## Object assignment

Fluent object-oriented programming begins with understanding object assignment


```r
a <- 5
b <- c(2, 4, 7)
c <- matrix(1:12, ncol = 4)
a + b
```

```
## [1]  7  9 12
```

```r
b * c # element-wise multiplication
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    2    8   14   20
## [2,]    8   20   32   44
## [3,]   21   42   63   84
```

----
## Essentially everything should be stored in objects


```r
d <- read.csv("./data/CamdenBoroughs.csv")
mod <- lm(School.Capacity ~ Town, data = d)
summary(mod)
```

```
## 
## Call:
## lm(formula = School.Capacity ~ Town, data = d)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -673.29 -198.94 -126.76   26.99 1643.24 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)  
## (Intercept)       525.00     256.80   2.044   0.0414 *
## TownBarnet        -92.68     269.97  -0.343   0.7315  
## TownCamden        625.00     444.79   1.405   0.1605  
## TownEdgware       -89.50     274.53  -0.326   0.7445  
## TownFinchley     -315.00     444.79  -0.708   0.4791  
## TownHarrow        418.29     291.18   1.437   0.1514  
## TownLondon       -118.24     257.29  -0.460   0.6460  
## TownNew Barnet    785.00     444.79   1.765   0.0781 .
## TownWembley       236.42     269.97   0.876   0.3816  
## TownWest Hendon  -285.00     444.79  -0.641   0.5219  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 363.2 on 574 degrees of freedom
##   (80 observations deleted due to missingness)
## Multiple R-squared:  0.06895,	Adjusted R-squared:  0.05436 
## F-statistic: 4.723 on 9 and 574 DF,  p-value: 4.488e-06
```

----
## Data types
# Logical
`FALSE` or `TRUE`


```r
library(car)
data(Vocab)
head(Vocab)
```

```
##          year    sex education vocabulary
## 20040001 2004 Female         9          3
## 20040002 2004 Female        14          6
## 20040003 2004   Male        14          9
## 20040005 2004 Female        17          8
## 20040008 2004   Male        14          1
## 20040010 2004   Male        14          7
```

----
## Logical example
Calculate proportion of vocabulary scores between 3 and 6


```r
voc36 <- with(Vocab, vocabulary > 2 & vocabulary < 7) 
str(voc36)
```

```
##  logi [1:21638] TRUE TRUE FALSE FALSE FALSE FALSE ...
```
<br>


```r
table(voc36) / nrow(Vocab)
```

```
## voc36
##    FALSE     TRUE 
## 0.456789 0.543211
```
Note that logical vectors coerce to 0/1 (numeric) and "TRUE"/"FALSE" (character)

----
## Integer versus Double


```r
int <- as.integer(c(2.56, 3.01, 3.99, 7, 2, 4))
dbl <- as.double(c(2.56, 3.01, 3.99, 7, 2, 4))
int
```

```
## [1] 2 3 3 7 2 4
```

```r
dbl
```

```
## [1] 2.56 3.01 3.99 7.00 2.00 4.00
```

----
## Character

* Most flexible: Essentially everything can be coerced to character


```r
as.character(c(TRUE, 3.12, 6L, "some string"))
```

```
## [1] "TRUE"        "3.12"        "6"           "some string"
```

* Lots of operations can be conducted on string variables (as we'll begin to discuss next class)

----
## Data structures
# Atomic Vectors
* All elements must be of the same type
    + leads to "implicit" coercion


```r
c(TRUE, 3.12, 6L)
```

```
## [1] 1.00 3.12 6.00
```

* Represent the foundation of essentially all other data types (outside of lists and data frames)

---- &twocol
## Matrices
Atomic vectors with a dimension attribute

*** =left


```r
v <- rnorm(24, 10, 2)
str(v)
```

```
##  num [1:24] 9.69 7.8 10.95 8.71 9.42 ...
```

```r
class(v)
```

```
## [1] "numeric"
```

```r
typeof(v)
```

```
## [1] "double"
```

*** =right


```r
dim(v) <- c(6, 4)
class(v)
```

```
## [1] "matrix"
```

```r
v
```

```
##           [,1]      [,2]      [,3]     [,4]
## [1,]  9.686813 10.593215 11.864307 10.24485
## [2,]  7.802726 12.188578  9.086948 11.08758
## [3,] 10.951121  5.423095  7.270462  6.67204
## [4,]  8.707661 10.373064  9.507949 13.25668
## [5,]  9.420642  9.898664 11.645751 11.33760
## [6,] 10.539067 10.232313 12.004451 12.22630
```

---- &twocol
## More typical matrix generation

*** =left


```r
m1 <- matrix(c(1, 2.5, 3,
               5, 12, 8,
               14, 1, 9
            ), 
    nrow = 3, 
    ncol = 3,
    byrow = TRUE)
m1
```

```
##      [,1] [,2] [,3]
## [1,]    1  2.5    3
## [2,]    5 12.0    8
## [3,]   14  1.0    9
```

*** =right
Be careful about the `byrow` argument


```r
m2 <- matrix(c(1, 2.5, 3,
               5, 12, 8,
               14, 1, 9
            ), 
    nrow = 3, 
    ncol = 3)
m2
```

```
##      [,1] [,2] [,3]
## [1,]  1.0    5   14
## [2,]  2.5   12    1
## [3,]  3.0    8    9
```

----
## Arrays
*n* dimensional matrices (essentially)


```r
dim(v) <- c(2, 2, 2, 3)
v
```

```
## , , 1, 1
## 
##          [,1]      [,2]
## [1,] 9.686813 10.951121
## [2,] 7.802726  8.707661
## 
## , , 2, 1
## 
##           [,1]     [,2]
## [1,]  9.420642 10.59321
## [2,] 10.539067 12.18858
## 
## , , 1, 2
## 
##           [,1]      [,2]
## [1,]  5.423095  9.898664
## [2,] 10.373064 10.232313
## 
## , , 2, 2
## 
##           [,1]     [,2]
## [1,] 11.864307 7.270462
## [2,]  9.086948 9.507949
## 
## , , 1, 3
## 
##          [,1]     [,2]
## [1,] 11.64575 10.24485
## [2,] 12.00445 11.08758
## 
## , , 2, 3
## 
##          [,1]    [,2]
## [1,]  6.67204 11.3376
## [2,] 13.25668 12.2263
```

----
## Other attributes
# Add row and column names


```r
rownames(m1) <- c("r1", "r2", "r3")
colnames(m1) <- c("c1", "c2", "c3")
m
```

```
## Error in eval(expr, envir, enclos): cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week6p1/.cache/unnamed-chunk-24_0b5f804f766cc5538a19220fe2580b77.rdb': No such file or directory
```

----
# Name the specific elements of the matrix


```r
names(m1) <- letters[1:9]
m1
```

```
##    c1   c2 c3
## r1  1  2.5  3
## r2  5 12.0  8
## r3 14  1.0  9
## attr(,"names")
## [1] "a" "b" "c" "d" "e" "f" "g" "h" "i"
```

----
## Subsetting atomic vectors

Indexing with the bracket function, `[`:


```r
# Third element of int
int[3]
```

```
## [1] 3
```

```r
# Third through fifth
int[3:5]
```

```
## [1] 3 7 2
```

```r
# First, third, and fifth
int[c(1, 3, 5)]
```

```
## [1] 2 3 2
```

----
## Subsetting atomic vectors with a dimension attribute 
(i.e., matrices and arrays)


```r
# First row, third column
m1[1, 3]
```

```
## [1] 3
```

```r
# Entire second row
m1[2, ]
```

```
## c1 c2 c3 
##  5 12  8
```

```r
# Extract first row, second column, from all matrices in array
v[1, 2, , ]
```

```
##          [,1]     [,2]     [,3]
## [1,] 10.95112 9.898664 10.24485
## [2,] 10.59321 7.270462 11.33760
```

----
## Names in subsetting


```r
m1[ ,"c1"]
```

```
## r1 r2 r3 
##  1  5 14
```

```r
m1["d"]
```

```
##   d 
## 2.5
```

----
## Lists and data frames
**Lists**: can contain any type of data, including other lists
**Data Frames**: Lists of equal-length vectors


```r
l <- list(
  c("a", "b", "c"),
  list(1:5),
  rep(c(T,F), 7),
  rnorm(3, 100, 25)
      )
str(l)
```

```
## List of 4
##  $ : chr [1:3] "a" "b" "c"
##  $ :List of 1
##   ..$ : int [1:5] 1 2 3 4 5
##  $ : logi [1:14] TRUE FALSE TRUE FALSE TRUE FALSE ...
##  $ : num [1:3] 95.2 126.6 78
```

---- &twocol
## Accessing List Elements
* List elements can be accessed in two methods: Using the `$` with the element 
  names, or through indexing with a double bracket `[[]]`.
* If a single bracket index is used, `[]`, the element will be returned, but
  of type list.

*** =left


```r
typeof(l)
```

```
## [1] "list"
```

```r
typeof(l[1])
```

```
## [1] "list"
```

```r
typeof(l[[1]])
```

```
## [1] "character"
```

*** =right


```r
l[1]
```

```
## [[1]]
## [1] "a" "b" "c"
```

```r
l[[1]]
```

```
## [1] "a" "b" "c"
```

----
## Switching between lists and data frames


```r
l2 <- list(rnorm(5, 100, 10), letters[5:9], c(T, T, F, F, T))
names(l2) <- c("rand", "letters", "log")
str(l2)
```

```
## List of 3
##  $ rand   : num [1:5] 69.1 94.6 97.6 99.4 112.5
##  $ letters: chr [1:5] "e" "f" "g" "h" ...
##  $ log    : logi [1:5] TRUE TRUE FALSE FALSE TRUE
```

```r
l2
```

```
## $rand
## [1]  69.06197  94.61790  97.61475  99.44264 112.51614
## 
## $letters
## [1] "e" "f" "g" "h" "i"
## 
## $log
## [1]  TRUE  TRUE FALSE FALSE  TRUE
```

----


```r
df <- as.data.frame(l2)
df
```

```
##        rand letters   log
## 1  69.06197       e  TRUE
## 2  94.61790       f  TRUE
## 3  97.61475       g FALSE
## 4  99.44264       h FALSE
## 5 112.51614       i  TRUE
```

```r
as.list(df)
```

```
## $rand
## [1]  69.06197  94.61790  97.61475  99.44264 112.51614
## 
## $letters
## [1] e f g h i
## Levels: e f g h i
## 
## $log
## [1]  TRUE  TRUE FALSE FALSE  TRUE
```

---
## Factors
* Used to store categorical data
* Can only store predefined values
* String variables default to factors when reading in data 


```r
colors <- factor(c("black", "green", "blue", "blue", "black"))
attributes(colors)
```

```
## $levels
## [1] "black" "blue"  "green"
## 
## $class
## [1] "factor"
```

```r
str(colors)
```

```
##  Factor w/ 3 levels "black","blue",..: 1 3 2 2 1
```

----
## Adding elements to factors


```r
colors[6] <- "blue"
colors
```

```
## [1] black green blue  blue  black blue 
## Levels: black blue green
```

```r
colors[7] <- "purple"
```

```
## Warning in `[<-.factor`(`*tmp*`, 7, value = "purple"): invalid factor
## level, NA generated
```

```r
colors
```

```
## [1] black green blue  blue  black blue  <NA> 
## Levels: black blue green
```

---- 
## Benefits of factors
* No need for multiple variables to define a categorical variable: internal 
  contrast-coding
<br>
<span style="color:gray" >  
(Remember the slides discussing dummy-coding and other contrast coding schemes with factors)
</span>

----
## Factors and attributes

* Factors are atomic integer vectors with a "levels" attribute.


```r
is.atomic(colors)
```

```
## [1] TRUE
```

```r
typeof(colors)
```

```
## [1] "integer"
```

Note: Be careful with `is.vector()`. It only returns `TRUE` if the vector has no
  attributes outside of names


```r
is.vector(colors)
```

```
## [1] FALSE
```

---- &twocol
## Basic plotting
# Scatterplots

Examine the relation between education and vocabulary

*** =left


```r
# Basic plot
library(lme4)
data(sleepstudy)
with(sleepstudy, plot(Days, Reaction))
```

*** =right

![plot of chunk scatter1b](assets/fig/scatter1b-1.png)

---- &twocol
## Extending the basic plot
Provide more meaningful labels, change points

*** =left


```r
with(sleepstudy, 
  plot(Days, Reaction, 
    xlab = "Days w/3hrs of Sleep",
    ylab = "Reaction time",
    main = "Sleep Deprivation and 
      Reaction Time",
    pch = 21, 
    bg = "gray", 
    col = "steelblue")
)
```

*** =right

![plot of chunk scatter3](assets/fig/scatter3-1.png)


----
## Extending the plot further
Plotting multiple fits


```r
# Linear model
mod1 <- lm(Reaction ~ Days, data = sleepstudy)

# Quadratic model
mod2 <- lm(Reaction ~ poly(Days, 2), data = sleepstudy)

# Increasingly complex models

mod3 <- lm(Reaction ~ poly(Days, 3), data = sleepstudy)
mod4 <- lm(Reaction ~ poly(Days, 4), data = sleepstudy)
mod5 <- lm(Reaction ~ poly(Days, 5), data = sleepstudy)
```

----
## Add lines to the plot


```r
lines(x = 0:10, y = predict(mod1, newdata = data.frame(Days = 0:10)),
  lwd = 2, lty = 1)
lines(x = 0:10, y = predict(mod2, newdata = data.frame(Days = 0:10)),
  col = "blue", lwd = 2, lty = 2)
lines(x = 0:10, y = predict(mod3, newdata = data.frame(Days = 0:10)),
  col = "red", lwd = 2, lty = 3)
lines(x = 0:10, y = predict(mod4, newdata = data.frame(Days = 0:10)),
  col = "orange", lwd = 2, lty = 4)
lines(x = 0:10, y = predict(mod5, newdata = data.frame(Days = 0:10)),
  col = "purple", lwd = 2, lty = 5)
```

----

![plot of chunk lines2](assets/fig/lines2-1.png)

---- &twocol
## Boxplots

*** =left

When you plot the relation between a categorical predictor and continuous outcome, the default `plot()` method is a boxplot.

*** =right


```r
plot(vocabulary ~ sex, data = Vocab)
```

![plot of chunk boxplot1](assets/fig/boxplot1-1.png)

---- &twocol
## Extending boxplots
<span style="color:gray" >
(Note: to really extend the boxplot, move to violin or bean plots)
</span>
*** =left


```r
par(bty = "n")
plot(vocabulary ~ sex, data = Vocab, 
  notch = TRUE,
  col = "deepskyblue",
  main = "Vocabulary Scores by Sex")
```

*** =right

![plot of chunk boxplot2b](assets/fig/boxplot2b-1.png)

---- &twocol
## Basic Histograms & Densities

*** =left


```r
hist(sleepstudy$Reaction)
```

![plot of chunk unnamed-chunk-6](assets/fig/unnamed-chunk-6-1.png)
*** =right


```r
plot(density(sleepstudy$Reaction))
```

![plot of chunk unnamed-chunk-7](assets/fig/unnamed-chunk-7-1.png)

----
## Functions
Anything that carries out an operation in R is a function. For example


```r
3 + 5 + 7
```

```
## [1] 15
```
Could also be written


```r
`+`(3, `+`(5, 7))
```

```
## [1] 15
```
In other words, the `+` operator is itself a function that takes two arguments (both numeric), which it sums. The `+` operator is an example of an infix function, which we'll discuss more later today.

----
## Functions are also objects


```r
a <- lm
data(mtcars)
summary( a(hp ~ drat + wt, data = mtcars) )
```

```
## 
## Call:
## a(formula = hp ~ drat + wt, data = mtcars)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -83.873 -33.910 -12.853   9.585 171.597 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)   
## (Intercept)  -27.782    127.992  -0.217  0.82968   
## drat           5.354     25.511   0.210  0.83524   
## wt            48.244     13.940   3.461  0.00169 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 53.29 on 29 degrees of freedom
## Multiple R-squared:  0.4348,	Adjusted R-squared:  0.3958 
## F-statistic: 11.15 on 2 and 29 DF,  p-value: 0.0002552
```

----
## Function components
# Functions have three components
* `body()`
* `formals()`

![bodyFormals](./assets/img/bodyFormals.png)

----
## Writing a function
Often it's useful to know the location of variables quickly. Let's write a function that provides us with an output of all the variable names in a dataset, and their location, with a clean and convenient output.

> * What would the formal arguments be here?
> * We should only need one formal argument, the data set.

----
## Doing it without a function to start


```r
varNames <- names(d)
head(varNames)
```

```
## [1] "Unique.Reference.Number" "Local.Authority.Code"   
## [3] "Local.Authority.Name"    "Establishment.Number"   
## [5] "Establishment.Name"      "Type.Of.Establishment"
```

```r
length(varNames)
```

```
## [1] 81
```

----

```r
cbind(1:length(varNames), varNames)
```

```
##            varNames                                     
##  [1,] "1"  "Unique.Reference.Number"                    
##  [2,] "2"  "Local.Authority.Code"                       
##  [3,] "3"  "Local.Authority.Name"                       
##  [4,] "4"  "Establishment.Number"                       
##  [5,] "5"  "Establishment.Name"                         
##  [6,] "6"  "Type.Of.Establishment"                      
##  [7,] "7"  "Establishment.Status"                       
##  [8,] "8"  "Reason.Establishment.Opened"                
##  [9,] "9"  "Open.Date"                                  
## [10,] "10" "Reason.Establishment.Closed"                
## [11,] "11" "Close.Date"                                 
## [12,] "12" "Phase.Of.Education"                         
## [13,] "13" "Statutory.Low.Age"                          
## [14,] "14" "Statutory.High.Age"                         
## [15,] "15" "Boarders"                                   
## [16,] "16" "Official.Sixth.Form"                        
## [17,] "17" "Gender"                                     
## [18,] "18" "Religious.Character"                        
## [19,] "19" "Diocese"                                    
## [20,] "20" "Admissions.Policy"                          
## [21,] "21" "School.Capacity"                            
## [22,] "22" "Special.Classes"                            
## [23,] "23" "Census.Date"                                
## [24,] "24" "Number.Of.Pupils"                           
## [25,] "25" "Number.Of.Boys"                             
## [26,] "26" "Number.Of.Girls"                            
## [27,] "27" "Percentage.Claiming.Free.School.Meals"      
## [28,] "28" "Trust.School"                               
## [29,] "29" "Trust.Name"                                 
## [30,] "30" "School.Sponsored"                           
## [31,] "31" "School.Sponsor"                             
## [32,] "32" "Federation"                                 
## [33,] "33" "Federation.Name"                            
## [34,] "34" "Unique.Property.Reference.Number"           
## [35,] "35" "Further.Higher.Education.Identifier"        
## [36,] "36" "Further.Education.Type"                     
## [37,] "37" "Ofsted.Last.Inspected"                      
## [38,] "38" "Ofsted.Special.Measures"                    
## [39,] "39" "Last.Changed.Date"                          
## [40,] "40" "Street"                                     
## [41,] "41" "Locality"                                   
## [42,] "42" "Address.3"                                  
## [43,] "43" "Town"                                       
## [44,] "44" "County"                                     
## [45,] "45" "Postcode"                                   
## [46,] "46" "Website"                                    
## [47,] "47" "Telephone.Number"                           
## [48,] "48" "Head.Title"                                 
## [49,] "49" "Head.First.Name"                            
## [50,] "50" "Head.Last.Name"                             
## [51,] "51" "Head.Honours"                               
## [52,] "52" "Head.Preferred.Job.Title"                   
## [53,] "53" "Teen.Mothers"                               
## [54,] "54" "Teen.Mothers.Places"                        
## [55,] "55" "Child.Care.Facilities"                      
## [56,] "56" "Special.Education.Needs.Pupil.Referral.Unit"
## [57,] "57" "Emotional.Behavioural.Difficulties"         
## [58,] "58" "Full.Time.Provision"                        
## [59,] "59" "Education.By.Other"                         
## [60,] "60" "Section.41.Approved"                        
## [61,] "61" "Special.Education.Needs.1"                  
## [62,] "62" "Special.Education.Needs.2"                  
## [63,] "63" "Region"                                     
## [64,] "64" "Administrative.Ward"                        
## [65,] "65" "Parliamentary.Constituency"                 
## [66,] "66" "Urban.Rural"                                
## [67,] "67" "GSSLA.Code"                                 
## [68,] "68" "Easting"                                    
## [69,] "69" "Northing"                                   
## [70,] "70" "Middle.Super.Output.Area"                   
## [71,] "71" "Lower.Super.Output.Area"                    
## [72,] "72" "Boarding.Establishment"                     
## [73,] "73" "Previous.Local.Authority.Code"              
## [74,] "74" "Previous.Local.Authority.Name"              
## [75,] "75" "Previous.Establishment.Number"              
## [76,] "76" "Longitude"                                  
## [77,] "77" "Latitude"                                   
## [78,] "78" "Spatial.Accuracy"                           
## [79,] "79" "Last.Uploaded"                              
## [80,] "80" "Location"                                   
## [81,] "81" "Socrata.ID"
```

----
## Wrapping it in a function


```r
nms <- function(d) {
  varNames <- names(d)
return(cbind(1:length(varNames), varNames))
}
nms(sleepstudy)
```

```
##          varNames  
## [1,] "1" "Reaction"
## [2,] "2" "Days"    
## [3,] "3" "Subject"
```

----
## Classes and Methods

* **Class**: Identifies characteristics about the object
* **Methods**: Define how a function operates

In other words, a generic function, like `plot()` will change in behavior depending on the specific class of object fed to it (i.e., the methods will change).

----
## Quick example (one I've actually written)

Generic function that produces a regression plot w/Standard error.
* Formals: `x`, `y` **OR** an object of class *lm* (i.e., the results of a linear model)

# Define generic function

```r
regPlot <- function(x, y, lcol = "blue", 
        se = TRUE, secol = c(0, 0, 0.5, 0.2), ...) UseMethod("regPlot")
```

----
# Define default method


```r
regPlot.default <- function(x, y, lcol = "blue", 
        se = TRUE, secol = c(0, 0, 0.5, 0.2), ...) {

  mod <- lm(y ~ x)
  nd <- data.frame(x = c(min(x, na.rm = TRUE) - sd(x, na.rm = TRUE),
               unique(x),
               max(x, na.rm = TRUE) + sd(x, na.rm = TRUE)))
  
  pred <- predict(mod, 
    newdata = nd, 
    se.fit = TRUE)
  
  plot(x, y, ...)
  abline(mod, col = lcol, lwd = 2)
  
  if(se == TRUE) {
    polygon(c(nd$x, rev(nd$x)), 
      c(pred$fit - (1.96 * pred$se.fit), 
        rev(pred$fit + (1.96 * pred$se.fit))),
    col = rgb(secol[1], secol[2], secol[3], secol[4]), border = NA)
  }
}
```

-----
# Define method for class `lm`


```r
regPlot.lm <- function(mod, lcol = "blue", 
        se = TRUE, secol = c(0, 0, 0.5, 0.2), ...) {
  x <- mod$model[[2]]
  y <- mod$model[[1]]

  nd <- data.frame(x = c(min(x, na.rm = TRUE) - sd(x, na.rm = TRUE),
              unique(x),
              max(x, na.rm = TRUE) + sd(x, na.rm = TRUE)))
  names(nd) <- names(mod$model)[2]

  pred <- predict(mod, 
    newdata = nd, 
    se.fit = TRUE) 
  plot(x, y, ...)
  lines(nd[[1]], pred$fit, col = lcol)
  
  if(se == TRUE) {
    polygon(c(nd[[1]], rev(nd[[1]])), 
      c(pred$fit - (1.96 * pred$se.fit), 
        rev(pred$fit + (1.96 * pred$se.fit))),
    col = rgb(secol[1], secol[2], secol[3], secol[4]), border = NA)
  }
}
```

----
# Test it out: Default method


```r
regPlot(sleepstudy$Days, sleepstudy$Reaction)
```

![plot of chunk classMeth4](assets/fig/classMeth4-1.png)

---- &twocol
# Test it out: `lm` method

*** =left


```r
test <- lm(Reaction ~ Days + 
            I(Days^2) + I(Days^3) + 
            I(Days^4), 
          data = sleepstudy)

regPlot(test, 
  xlab = "Days",
  ylab = "Reaction Time",
  main = "Overfit model")
```

*** =right

![plot of chunk classMeth5b](assets/fig/classMeth5b-1.png)

----
# Limitations 
* `poly()` function can't be used within the lm.
* Only linear relations are shown when two variables are fed to the function
* x and y shown on x and y axes. May want to make it default to the variable
  names.

<span style="color:blue" > 
We could fix these issues!
</span>

---- &twocol
## for loops

*** =left
<div align = "left">
<img src = ./assets/img/forLoops.png width = 450 height = 200>
</div>

*** =right


```r
a <- letters[1:26]
a
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
## [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
```

```r
for(i in 1:5){
  print(a[i])
}
```

```
## [1] "a"
## [1] "b"
## [1] "c"
## [1] "d"
## [1] "e"
```

----
## Another basic example

Simulate tossing a coin, record results


```r
b <- rep(NA, 10)
b
```

```
##  [1] NA NA NA NA NA NA NA NA NA NA
```

```r
for(i in seq_along(b)) {
  b[i] <- sample(c("Heads", "Tails"), 1)
}
b
```

```
##  [1] "Heads" "Heads" "Heads" "Tails" "Tails" "Tails" "Tails" "Heads"
##  [9] "Heads" "Tails"
```

----
## Batch processing with for loops
# Look at the HSB_pieces folder, within the data folder.

![HSBFiles](./assets/img/HSBFiles.png)

---- &twocol
## Load all files


```r
# List all files in directory
files <- list.files("./data/HSB_pieces/")
files
```

```
## [1] "NonWhiteFemaleHSB.csv" "NonWhiteMaleHSB.csv"   "WhiteFemaleHSB.csv"   
## [4] "WhiteMaleHSB.csv"
```

```r
# Create empty list
l <- vector("list", length(files))
l
```

```
## [[1]]
## NULL
## 
## [[2]]
## NULL
## 
## [[3]]
## NULL
## 
## [[4]]
## NULL
```

----
## For loop to batch read files


```r
for(i in seq_along(files)) {
  l[[i]] <- read.csv(paste0("./data/HSB_pieces/", files[i]))
}

# Name elements of the list according to the file name
names(l) <- substr(files, 1, nchar(files) - 4)
```

----
## Inspect the structure of the list


```r
str(l)
```

```
## List of 4
##  $ NonWhiteFemaleHSB:'data.frame':	1065 obs. of  5 variables:
##   ..$ id      : int [1:1065] 1224 1288 1296 1296 1296 1296 1296 1296 1296 1296 ...
##   ..$ minority: int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female  : int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses     : num [1:1065] -1.248 -1.468 -0.148 -1.568 -0.288 ...
##   ..$ mathach : num [1:1065] 4.75 10.66 12.67 4.97 8.28 ...
##  $ NonWhiteMaleHSB  :'data.frame':	909 obs. of  5 variables:
##   ..$ id      : int [1:909] 1224 1224 1224 1288 1288 1296 1296 1296 1296 1296 ...
##   ..$ minority: int [1:909] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female  : int [1:909] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses     : num [1:909] -1.528 0.142 -1.658 -0.328 -0.158 ...
##   ..$ mathach : num [1:909] 4.145 -1.688 0.122 10.171 5.552 ...
##  $ WhiteFemaleHSB   :'data.frame':	2730 obs. of  5 variables:
##   ..$ id      : int [1:2730] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority: int [1:2730] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female  : int [1:2730] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses     : num [1:2730] -1.528 -0.588 -0.618 -0.888 -1.448 ...
##   ..$ mathach : num [1:2730] 5.88 19.71 -2.83 1.53 9.47 ...
##  $ WhiteMaleHSB     :'data.frame':	2481 obs. of  5 variables:
##   ..$ id      : int [1:2481] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority: int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female  : int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses     : num [1:2481] -0.528 -0.668 -0.158 0.022 -0.998 -0.458 -0.468 0.332 -0.298 -0.078 ...
##   ..$ mathach : num [1:2481] 20.349 8.781 17.898 4.583 0.523 ...
```

----
## Create a new variable
For each data frame, we're going to create a new variable that is a
  standardized version of `mathach`. Note that this variable will be standardized relative to the specific group.


```r
# First, write a z-score function
standardize <- function(x) (x - mean(x, na.rm = TRUE)) / (sd(x, na.rm = TRUE))

# Next, loop through the list to create each new variable
for(i in seq_along(l)) {
  l[[i]]$math_z <- standardize(l[[i]]$mathach)
}
head(l[[1]])
```

```
##     id minority female    ses mathach     math_z
## 1 1224        1      1 -1.248   4.753 -0.6949256
## 2 1288        1      1 -1.468  10.664  0.2485645
## 3 1296        1      1 -0.148  12.668  0.5684350
## 4 1296        1      1 -1.568   4.968 -0.6606082
## 5 1296        1      1 -0.288   8.278 -0.1322792
## 6 1296        1      1 -1.088   6.244 -0.4569382
```

----

```r
str(l)
```

```
## List of 4
##  $ NonWhiteFemaleHSB:'data.frame':	1065 obs. of  6 variables:
##   ..$ id      : int [1:1065] 1224 1288 1296 1296 1296 1296 1296 1296 1296 1296 ...
##   ..$ minority: int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female  : int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses     : num [1:1065] -1.248 -1.468 -0.148 -1.568 -0.288 ...
##   ..$ mathach : num [1:1065] 4.75 10.66 12.67 4.97 8.28 ...
##   ..$ math_z  : num [1:1065] -0.695 0.249 0.568 -0.661 -0.132 ...
##  $ NonWhiteMaleHSB  :'data.frame':	909 obs. of  6 variables:
##   ..$ id      : int [1:909] 1224 1224 1224 1288 1288 1296 1296 1296 1296 1296 ...
##   ..$ minority: int [1:909] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female  : int [1:909] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses     : num [1:909] -1.528 0.142 -1.658 -0.328 -0.158 ...
##   ..$ mathach : num [1:909] 4.145 -1.688 0.122 10.171 5.552 ...
##   ..$ math_z  : num [1:909] -0.9376 -1.7968 -1.5301 -0.0499 -0.7303 ...
##  $ WhiteFemaleHSB   :'data.frame':	2730 obs. of  6 variables:
##   ..$ id      : int [1:2730] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority: int [1:2730] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female  : int [1:2730] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses     : num [1:2730] -1.528 -0.588 -0.618 -0.888 -1.448 ...
##   ..$ mathach : num [1:2730] 5.88 19.71 -2.83 1.53 9.47 ...
##   ..$ math_z  : num [1:2730] -1.11 1.028 -2.455 -1.782 -0.553 ...
##  $ WhiteMaleHSB     :'data.frame':	2481 obs. of  6 variables:
##   ..$ id      : int [1:2481] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority: int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female  : int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses     : num [1:2481] -0.528 -0.668 -0.158 0.022 -0.998 -0.458 -0.468 0.332 -0.298 -0.078 ...
##   ..$ mathach : num [1:2481] 20.349 8.781 17.898 4.583 0.523 ...
##   ..$ math_z  : num [1:2481] 0.824 -0.892 0.461 -1.514 -2.117 ...
```

----
## Apply family of loops
* Exceptionally useful, and can often speed up your code.
* Advantages over for loops include
  + No need for initialization of objects
  + Automatic indexing of an object (if you want)
  + Simplification of results (can be a massive benefit)

----
## apply
Each of the members of the apply family function a little bit differently. The `apply()` function is probably the most straight forward.

<div align = "center">
<img src = assets/img/apply.png width = 1000 height = 600>
</div>

----
## Examples of `apply()`


```r
m <- matrix(1:12, ncol = 4)
m
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
```


```r
# Mean of each row
apply(m, 1, mean)
```

```
## [1] 5.5 6.5 7.5
```

```r
# Mean of each column
apply(m, 2, mean)
```

```
## [1]  2  5  8 11
```

----
## A few more examples: LSAT data


```r
lsat <- read.csv("./data/LSAT_theta.csv")
head(lsat)
```

```
##   Item.1 Item.2 Item.3 Item.4 Item.5 Obs      Exp        z1     se.z1
## 1      0      0      0      0      0   3 2.277412 -1.895344 0.7954828
## 2      0      0      0      0      0   3 2.277412 -1.895344 0.7954828
## 3      0      0      0      0      0   3 2.277412 -1.895344 0.7954828
## 4      0      0      0      0      1   6 5.860769 -1.479314 0.7960948
## 5      0      0      0      0      1   6 5.860769 -1.479314 0.7960948
## 6      0      0      0      0      1   6 5.860769 -1.479314 0.7960948
```

----
## Calculate raw scores


```r
lsat$raw <- apply(lsat[ ,1:5], 1, sum) # Only item-level data
head(lsat)
```

```
##   Item.1 Item.2 Item.3 Item.4 Item.5 Obs      Exp        z1     se.z1 raw
## 1      0      0      0      0      0   3 2.277412 -1.895344 0.7954828   0
## 2      0      0      0      0      0   3 2.277412 -1.895344 0.7954828   0
## 3      0      0      0      0      0   3 2.277412 -1.895344 0.7954828   0
## 4      0      0      0      0      1   6 5.860769 -1.479314 0.7960948   1
## 5      0      0      0      0      1   6 5.860769 -1.479314 0.7960948   1
## 6      0      0      0      0      1   6 5.860769 -1.479314 0.7960948   1
```

```r
table(lsat$raw)
```

```
## 
##   0   1   2   3   4   5 
##   3  20  85 237 357 298
```

----
## Calculate p values


```r
apply(lsat[ ,1:5], 2, mean, na.rm = TRUE)
```

```
## Item.1 Item.2 Item.3 Item.4 Item.5 
##  0.924  0.709  0.553  0.763  0.870
```
Notice that additional arguments to the function (in this case `mean`) just
  get passed as additional arguments to `apply()`.


----
## lapply and sapply
* `lapply()` allows you to apply a function to a **l**ist. You can also use it
   similarly to a `for` loop. In both cases, `lapply()` will return a **l**ist.
* `sapply()` does the same thing as `lapply()`, but simplifies the result if it
  can, into a vector, matrix, or array.

----
## Basic structure of an lapply loop
![lapply](./assets/img/lapply.png)

----
## Batch loading
# Alternative to for loop


```r
files <- list.files("./data/HSB_pieces/")
l <- lapply(seq_along(files), function(i) {
  read.csv(paste0("./data/HSB_pieces/", files[i]))
})
names(l) <- substr(files, 1, nchar(files) - 4)
str(l)
```

```
## List of 4
##  $ NonWhiteFemaleHSB:'data.frame':	1065 obs. of  5 variables:
##   ..$ id      : int [1:1065] 1224 1288 1296 1296 1296 1296 1296 1296 1296 1296 ...
##   ..$ minority: int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female  : int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses     : num [1:1065] -1.248 -1.468 -0.148 -1.568 -0.288 ...
##   ..$ mathach : num [1:1065] 4.75 10.66 12.67 4.97 8.28 ...
##  $ NonWhiteMaleHSB  :'data.frame':	909 obs. of  5 variables:
##   ..$ id      : int [1:909] 1224 1224 1224 1288 1288 1296 1296 1296 1296 1296 ...
##   ..$ minority: int [1:909] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female  : int [1:909] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses     : num [1:909] -1.528 0.142 -1.658 -0.328 -0.158 ...
##   ..$ mathach : num [1:909] 4.145 -1.688 0.122 10.171 5.552 ...
##  $ WhiteFemaleHSB   :'data.frame':	2730 obs. of  5 variables:
##   ..$ id      : int [1:2730] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority: int [1:2730] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female  : int [1:2730] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses     : num [1:2730] -1.528 -0.588 -0.618 -0.888 -1.448 ...
##   ..$ mathach : num [1:2730] 5.88 19.71 -2.83 1.53 9.47 ...
##  $ WhiteMaleHSB     :'data.frame':	2481 obs. of  5 variables:
##   ..$ id      : int [1:2481] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority: int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female  : int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses     : num [1:2481] -0.528 -0.668 -0.158 0.022 -0.998 -0.458 -0.468 0.332 -0.298 -0.078 ...
##   ..$ mathach : num [1:2481] 20.349 8.781 17.898 4.583 0.523 ...
```

----
## Create group-standardized mathach variable


```r
standardize <- function(x) (x - mean(x, na.rm = TRUE)) / (sd(x, na.rm = TRUE))
l <- lapply(l, function(x) {
  x$mathach_z <- standardize(x$mathach)
  return(x) # This part is important if you want the full data frame returned
})
str(l)
```

```
## List of 4
##  $ NonWhiteFemaleHSB:'data.frame':	1065 obs. of  6 variables:
##   ..$ id       : int [1:1065] 1224 1288 1296 1296 1296 1296 1296 1296 1296 1296 ...
##   ..$ minority : int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female   : int [1:1065] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses      : num [1:1065] -1.248 -1.468 -0.148 -1.568 -0.288 ...
##   ..$ mathach  : num [1:1065] 4.75 10.66 12.67 4.97 8.28 ...
##   ..$ mathach_z: num [1:1065] -0.695 0.249 0.568 -0.661 -0.132 ...
##  $ NonWhiteMaleHSB  :'data.frame':	909 obs. of  6 variables:
##   ..$ id       : int [1:909] 1224 1224 1224 1288 1288 1296 1296 1296 1296 1296 ...
##   ..$ minority : int [1:909] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ female   : int [1:909] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses      : num [1:909] -1.528 0.142 -1.658 -0.328 -0.158 ...
##   ..$ mathach  : num [1:909] 4.145 -1.688 0.122 10.171 5.552 ...
##   ..$ mathach_z: num [1:909] -0.9376 -1.7968 -1.5301 -0.0499 -0.7303 ...
##  $ WhiteFemaleHSB   :'data.frame':	2730 obs. of  6 variables:
##   ..$ id       : int [1:2730] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority : int [1:2730] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female   : int [1:2730] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ ses      : num [1:2730] -1.528 -0.588 -0.618 -0.888 -1.448 ...
##   ..$ mathach  : num [1:2730] 5.88 19.71 -2.83 1.53 9.47 ...
##   ..$ mathach_z: num [1:2730] -1.11 1.028 -2.455 -1.782 -0.553 ...
##  $ WhiteMaleHSB     :'data.frame':	2481 obs. of  6 variables:
##   ..$ id       : int [1:2481] 1224 1224 1224 1224 1224 1224 1224 1224 1224 1224 ...
##   ..$ minority : int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ female   : int [1:2481] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ ses      : num [1:2481] -0.528 -0.668 -0.158 0.022 -0.998 -0.458 -0.468 0.332 -0.298 -0.078 ...
##   ..$ mathach  : num [1:2481] 20.349 8.781 17.898 4.583 0.523 ...
##   ..$ mathach_z: num [1:2481] 0.824 -0.892 0.461 -1.514 -2.117 ...
```

----
## Example without return


```r
standardized <- lapply(l, function(x) standardize(x$mathach))
str(standardized)
```

```
## List of 4
##  $ NonWhiteFemaleHSB: num [1:1065] -0.695 0.249 0.568 -0.661 -0.132 ...
##  $ NonWhiteMaleHSB  : num [1:909] -0.9376 -1.7968 -1.5301 -0.0499 -0.7303 ...
##  $ WhiteFemaleHSB   : num [1:2730] -1.11 1.028 -2.455 -1.782 -0.553 ...
##  $ WhiteMaleHSB     : num [1:2481] 0.824 -0.892 0.461 -1.514 -2.117 ...
```

----
## Revisiting the convoluted random matrix from previous class


```r
m <- matrix(rep(NA, 40*100), ncol = 100)

for(i in 1:40) {
  for(j in seq(0, 500, length.out = 40)[i]) {
    m[i, ] <- rnorm(100, 0, j)
  }
}
head(m)
```

```
##            [,1]       [,2]       [,3]      [,4]       [,5]       [,6]
## [1,]   0.000000   0.000000   0.000000   0.00000   0.000000   0.000000
## [2,] -15.901417   6.692079 -13.278174 -12.09773  -2.592434   8.425621
## [3,]  -4.109758 -21.915940   3.488718 -29.26741  37.688986  13.207934
## [4,] -32.796448 -60.967704 -26.054358 -24.36699 -24.883939   2.162377
## [5,]  15.539905   7.165158 -28.513560 -24.14611 -47.986888 -35.741857
## [6,]  78.047582 -26.063894  83.955734  15.91297  20.716142 -24.003322
##            [,7]      [,8]        [,9]      [,10]      [,11]     [,12]
## [1,]    0.00000   0.00000   0.0000000   0.000000   0.000000  0.000000
## [2,]   -2.74075  12.51826   0.6070224  10.906622 -20.800591 -4.585555
## [3,]   27.25254 -14.16425  -3.1125098 -10.452098  20.567278 37.011860
## [4,]   26.02519  47.93508  12.9768432   2.622276 -55.006210 -5.660309
## [5,] -103.64904 -28.74068 -82.9839779  60.524084  29.483887 15.502434
## [6,]  114.46809  52.12749  61.7972473  -9.368109   5.353927 24.911284
##           [,13]     [,14]      [,15]      [,16]      [,17]       [,18]
## [1,]    0.00000   0.00000   0.000000   0.000000   0.000000    0.000000
## [2,]   15.25347  -2.77838  -1.472848   1.339489  22.192172   -4.606376
## [3,]  -14.61707 -36.80635 -25.015231   4.758911   6.845663  -37.629567
## [4,]   85.06458 -11.27767 -49.760476  16.471657  -4.119282  -66.821283
## [5,]  -20.63657 -17.90934  63.786641 -67.443993 -48.252315    4.822226
## [6,] -116.78587 -91.18495 -41.644127  54.365237  41.556347 -113.723048
##          [,19]      [,20]        [,21]      [,22]      [,23]      [,24]
## [1,]   0.00000   0.000000    0.0000000   0.000000   0.000000   0.000000
## [2,] -19.21279  28.901714   -0.6738588  -6.672577  -6.799772   6.437543
## [3,] -17.76038 -29.227207    8.1333866 -34.907560   9.985881 -25.243133
## [4,]  32.39479  -3.170860   23.9012859  15.242339   3.715891 -32.490611
## [5,]  99.12650   2.822819   39.2012397 -64.850173 -15.381669   5.029176
## [6,] -63.37258 -26.336678 -116.7421386  -1.733077  37.468848 -36.871127
##            [,25]      [,26]     [,27]     [,28]      [,29]     [,30]
## [1,]   0.0000000   0.000000   0.00000   0.00000   0.000000  0.000000
## [2,]   0.9232484   5.007945 -14.50219  21.34232  -1.357849 11.621599
## [3,]  -8.9440054  28.688916  10.63827 -50.95247  17.703783  5.672405
## [4,]  -8.9187592  34.527149  13.77493  24.50149  25.824937  8.487011
## [5,] -69.4008599  83.711935 -40.80161  22.62998 -43.217846 10.580966
## [6,] -81.5473709 -91.839094  94.80766 128.37698 -19.726548 40.592225
##           [,31]     [,32]      [,33]       [,34]     [,35]     [,36]
## [1,]   0.000000   0.00000   0.000000   0.0000000  0.000000  0.000000
## [2,]  -9.161721 -23.75528  20.729079   3.7406959 -4.630815 20.392170
## [3,] -47.804870 -41.39326  11.487964   9.1755032 24.527959 39.281137
## [4,]  23.000288 -24.85563   5.021422  60.8530769 56.142973 -3.947849
## [5,]  47.601309  91.43734 -46.529436  -0.1729558 -6.243566 69.332122
## [6,]  15.170865  10.77129  65.874336 -13.9766235  2.011215 43.084030
##           [,37]      [,38]     [,39]      [,40]     [,41]      [,42]
## [1,]   0.000000   0.000000   0.00000   0.000000  0.000000   0.000000
## [2,]  13.698047 -24.250794 -21.61200   5.605746 -4.157591  -3.462992
## [3,]  31.686061  -8.527367 -54.91130 -34.630202 -2.346416  -3.407530
## [4,] -15.444722  22.174441 -76.86636  19.410203 -6.001523 -58.376575
## [5,]  -7.160314 -77.593411  -2.14163  53.657471 15.095720 -22.791338
## [6,] -83.154499 -56.294591  37.58481 -88.947037 58.976719  -9.347453
##            [,43]      [,44]     [,45]       [,46]      [,47]      [,48]
## [1,]   0.0000000   0.000000  0.000000   0.0000000   0.000000   0.000000
## [2,]  -0.1383491  24.526541 -2.976668   0.9932247   6.636409   7.266249
## [3,]  -3.6587251   4.807565 30.364460  14.3148554 -37.809132   7.893043
## [4,]  10.1904516 -17.477434 -2.592000 -22.8917683   2.683019  -5.523062
## [5,] -18.6105155 -88.045768 -3.242841 -34.3464602 -26.383226 -15.196919
## [6,] -32.8339954 -74.496357 63.269568  -5.7459829  37.645782 -47.463645
##          [,49]      [,50]       [,51]      [,52]     [,53]      [,54]
## [1,]   0.00000   0.000000    0.000000   0.000000  0.000000   0.000000
## [2,] -15.95869  -3.232611  -18.613798  -7.677884  7.253293  -1.792184
## [3,] -29.36777 -21.131493   -4.849606  -1.263359 48.626933 -19.774476
## [4,] -19.17892  44.524093  -47.813604 -37.149839 26.945023  37.285398
## [5,]  19.85879 -11.433320 -118.087002  10.776159 53.537503   8.227051
## [6,]  28.18338 -32.179032  -31.098002 -31.633267 44.519645  19.892524
##          [,55]    [,56]      [,57]      [,58]       [,59]     [,60]
## [1,]  0.000000  0.00000  0.0000000   0.000000    0.000000  0.000000
## [2,] -4.886707 13.43793 -7.4961202 -12.040679    2.034381 -9.194037
## [3,] 23.861359 42.74949  0.4390268  -8.250974   20.847087 -2.473192
## [4,] 51.904156 49.48940 37.1180130 -11.440497   -2.718884 -7.285614
## [5,] 94.513912 70.19344 34.8183674  34.783069 -124.728153 16.030176
## [6,] 59.636119 19.57190 53.7363456  21.359750  -77.096704 48.402149
##          [,61]       [,62]      [,63]      [,64]      [,65]     [,66]
## [1,]   0.00000    0.000000   0.000000   0.000000   0.000000  0.000000
## [2,] -10.80856  -12.081731  -8.375378  -1.159107   6.014193 11.272629
## [3,]  22.93971    3.070622  -1.768868  19.257971  -2.405191 -5.254178
## [4,]  31.58197   17.983389  15.784469  -4.245444 -56.997003  9.888967
## [5,] -12.11409    8.171176 120.368227  25.921873   8.242505  6.822238
## [6,]  59.11491 -118.291848 -31.287085 -14.562248  50.203950 60.835569
##           [,67]      [,68]      [,69]      [,70]      [,71]      [,72]
## [1,]   0.000000   0.000000   0.000000   0.000000   0.000000   0.000000
## [2,]   1.149754 -11.398471   9.207471  -8.512701 -11.064390   2.509554
## [3,]  -5.873220  -5.349971  20.364312 -55.243914 -34.462115  44.340200
## [4,] 145.881260   7.045592 -52.208464  16.817290 -38.628803 -56.599806
## [5,]  42.582866 -45.034345  13.116498  45.944273  42.619754  59.377671
## [6,] -72.078884 -51.443465 -13.605259 -19.610588   1.626341  66.017369
##          [,73]      [,74]      [,75]       [,76]       [,77]      [,78]
## [1,]   0.00000   0.000000   0.000000    0.000000    0.000000   0.000000
## [2,] -17.02947  -2.737641   3.078645   -3.744269   -4.154523 -11.152326
## [3,]  34.21451  25.675743  20.336278   36.756221   29.594838 -34.437379
## [4,]  17.85659   4.317480  38.227665    7.587675  -23.505611  -5.795782
## [5,]  41.58968  22.964972 -55.411556   67.105257   74.557167 -15.325077
## [6,]  10.62719 145.910004  40.567504 -149.928856 -178.000017  27.637861
##            [,79]      [,80]      [,81]      [,82]       [,83]      [,84]
## [1,]   0.0000000   0.000000   0.000000   0.000000    0.000000   0.000000
## [2,]  -0.8457265   3.120595   5.409692 -15.155615    3.966796  -9.750145
## [3,]  12.7937374  -8.455431 -10.267471 -39.327646   -7.332408  32.260539
## [4,] -21.6549613   7.713138 -36.405895  19.350904  -66.936827 -10.026393
## [5,]   4.3472728 -25.412418  71.490844  58.202676  -69.276084  -4.749001
## [6,]  12.6038123  88.112521 -62.156160   3.906602 -114.314397 -43.938013
##           [,85]      [,86]     [,87]      [,88]      [,89]      [,90]
## [1,]   0.000000   0.000000   0.00000   0.000000   0.000000   0.000000
## [2,]  -3.573794   0.772551  16.08083  16.312618  12.530800  -0.236288
## [3,] -61.614204 -16.431354 -58.75831  -9.682328  -1.613151  -5.729850
## [4,]  21.961469 -34.842616 -35.24762  62.894795 -46.525057  38.098471
## [5,] -33.109477  45.690839  -2.58272 -26.964605  61.981004 -39.296685
## [6,]  -7.905711  87.852541 140.08195 -68.188275  31.580281   2.477313
##           [,91]     [,92]       [,93]       [,94]      [,95]      [,96]
## [1,]   0.000000   0.00000   0.0000000   0.0000000   0.000000   0.000000
## [2,]   1.962359  11.53551  -0.2478778  -0.7565568   6.016198 -16.969643
## [3,] -18.285172 -16.07544 -27.3954854 -33.5140943  11.827339   3.559823
## [4,]  22.599043  21.04386  29.2447927   1.4983882 -70.104143 -62.499015
## [5,] -25.591177 -27.33050 -10.3930265 -38.6098601  45.300456 -51.722188
## [6,] -16.389590  76.18115  87.6655926  26.7492116 -93.561332  19.849536
##           [,97]      [,98]      [,99]      [,100]
## [1,]  0.0000000   0.000000   0.000000   0.0000000
## [2,] 12.3183501  -9.240587  -2.528448  -0.8585512
## [3,]  4.2917547   9.948150  16.692381  -0.6653001
## [4,] -0.8704822  16.438706  -7.411683 -27.6564506
## [5,] 75.7639691 -31.560144 -29.380535 -33.5886927
## [6,] 18.4822353  73.002767 118.507709  23.5167695
```

----
## Creating the same matrix with lapply


```r
norm <- lapply(seq(0, 500, length.out = 40), function(i) rnorm(100, 0, i))
str(norm)
```

```
## List of 40
##  $ : num [1:100] 0 0 0 0 0 0 0 0 0 0 ...
##  $ : num [1:100] -1.668 -6.69 -12.056 -1.148 -0.416 ...
##  $ : num [1:100] -10.86 1.64 -7.88 20.33 -28.33 ...
##  $ : num [1:100] 34.68 -1.57 -18.35 46.2 -27.97 ...
##  $ : num [1:100] -19.32 -37.58 -6.78 -23.49 51.74 ...
##  $ : num [1:100] -17.33 98.45 -2.83 16.97 75.18 ...
##  $ : num [1:100] 7.03 -187.74 -10.05 181.87 29.97 ...
##  $ : num [1:100] 90.31 -46.06 7.84 106.93 -51.71 ...
##  $ : num [1:100] -243.09 135.43 -189.85 1.72 -69.27 ...
##  $ : num [1:100] 171.6 -33.3 60.7 15.8 220.8 ...
##  $ : num [1:100] 79.5 -92.7 -110 418.1 146.9 ...
##  $ : num [1:100] -123.86 1.32 120.85 -166.64 -206.59 ...
##  $ : num [1:100] -254.9 92 -45.6 119 254.9 ...
##  $ : num [1:100] 41.2 273.9 170.6 79.8 -99.6 ...
##  $ : num [1:100] 16.8 -106.9 19 83.5 270 ...
##  $ : num [1:100] -124 -54.3 -154.2 63.9 -122.2 ...
##  $ : num [1:100] 255.7 382.5 381.3 50.1 193.5 ...
##  $ : num [1:100] 45 493.7 -107.9 57.2 101 ...
##  $ : num [1:100] -216.49 -7.48 -139.19 -287.69 95.91 ...
##  $ : num [1:100] 280.02 -181.19 -2.43 -122.86 -292.27 ...
##  $ : num [1:100] -296 336 -538 127 598 ...
##  $ : num [1:100] 224.98 -9.56 -102.8 -167.06 18.02 ...
##  $ : num [1:100] -165 -521 -485 539 218 ...
##  $ : num [1:100] 237 495 178 -446 191 ...
##  $ : num [1:100] -584.02 6.55 408.25 -478.94 56.25 ...
##  $ : num [1:100] 50.9 -673.3 261 651.4 277.9 ...
##  $ : num [1:100] 172 559 371 114 403 ...
##  $ : num [1:100] -45 27.2 194.1 57 54.5 ...
##  $ : num [1:100] 544.7 380.9 643.5 451.8 -22.6 ...
##  $ : num [1:100] 747 -299 -205 -269 -448 ...
##  $ : num [1:100] -255.6 -192.5 -374.5 84.7 19.3 ...
##  $ : num [1:100] -358 570 -610 -174 -148 ...
##  $ : num [1:100] 18.8 -687.2 708.4 242.1 -529.6 ...
##  $ : num [1:100] -30.4 -254.2 54.1 -43.2 -487.2 ...
##  $ : num [1:100] -221 478 244 -829 -578 ...
##  $ : num [1:100] 272.8 62.3 -131 68.2 -783.9 ...
##  $ : num [1:100] -595 -321 -699 -370 -294 ...
##  $ : num [1:100] 538 157.7 -945.4 -207 -97.5 ...
##  $ : num [1:100] -400 -527 -184 -120 653 ...
##  $ : num [1:100] 37.9 -249.7 -261.6 79.6 117.9 ...
```

----

```r
m <- matrix(unlist(norm), ncol = 100, byrow = TRUE)
head(m)
```

```
##            [,1]       [,2]       [,3]       [,4]        [,5]       [,6]
## [1,]   0.000000   0.000000   0.000000   0.000000   0.0000000   0.000000
## [2,]  -1.668448  -6.690100 -12.056474  -1.148419  -0.4160852 -13.814066
## [3,] -10.858090   1.640743  -7.884659  20.331996 -28.3300123   1.156611
## [4,]  34.680868  -1.569867 -18.349792  46.201253 -27.9747167  55.620659
## [5,] -19.324772 -37.583307  -6.784195 -23.487781  51.7392666 -36.133013
## [6,] -17.325463  98.449489  -2.825901  16.972878  75.1781848 -45.820569
##            [,7]       [,8]      [,9]      [,10]       [,11]      [,12]
## [1,]  0.0000000   0.000000   0.00000   0.000000    0.000000   0.000000
## [2,] 15.6316773   5.015839  14.48833   6.750727   -2.153041  29.377379
## [3,] 20.1401577  24.315536  43.58465 -39.264953   16.562652  37.979156
## [4,] -8.1896285  19.951344  52.59909  21.642304  -16.903322 -32.773155
## [5,]  0.6526817 -20.247425 -32.32824 -27.383023   45.743823  -2.656071
## [6,] -5.7910893 -88.425275 -60.78531  52.983713 -122.124424 102.735774
##           [,13]       [,14]      [,15]      [,16]      [,17]      [,18]
## [1,]   0.000000    0.000000   0.000000   0.000000   0.000000  0.0000000
## [2,]   3.872770   -2.993028 -12.565545   3.859122   6.189846 -0.7541435
## [3,]  38.301493   11.657386  24.036751 -18.290370   5.987426 25.1857181
## [4,]  15.833988  -33.420121  41.452438 -37.205352 -24.349967 65.3006794
## [5,] -41.634070   54.889734  19.868876 -36.664580 -26.446708 42.6352959
## [6,]  -5.259113 -103.621424   2.572286 -20.386402  28.455339 48.8379331
##           [,19]      [,20]      [,21]      [,22]      [,23]      [,24]
## [1,]   0.000000   0.000000   0.000000   0.000000   0.000000   0.000000
## [2,]  -3.878077   2.933336  21.024072  -2.825438   7.712429  -2.635413
## [3,] -21.684121  22.380722  -3.464351   3.431267  -6.077953   3.660869
## [4,]   3.598591  63.899797  18.322140  27.662553 -27.401146  15.362186
## [5,] -74.874095 -22.467809   5.273254 -62.918697  54.093794 -40.406031
## [6,] 128.408080 -53.542511 -57.713372 -11.376136   4.054820  39.864115
##          [,25]      [,26]      [,27]      [,28]      [,29]     [,30]
## [1,]   0.00000   0.000000   0.000000   0.000000   0.000000  0.000000
## [2,] -10.04029   4.432320  -5.445368 -27.840619   1.836833 11.656290
## [3,] -37.80432  72.338932  -5.238572   1.825467  -8.701536 37.964509
## [4,] -19.87567 -23.525330 -85.221106   3.370368  63.974620 -8.404856
## [5,]  47.94937   3.721690  33.839774   3.680622 -69.709211  7.877923
## [6,] -66.35029  -6.430469  80.442098   3.079393  -6.815232 55.360430
##           [,31]     [,32]     [,33]      [,34]     [,35]      [,36]
## [1,]   0.000000   0.00000   0.00000   0.000000  0.000000   0.000000
## [2,] -15.466104  16.85696  17.23718   6.020820 -2.229892  -7.449164
## [3,]  16.749171 -21.10730  14.65648 -21.737104  7.166410   3.733197
## [4,]  66.808563 -53.52351  43.53938 -58.368621 40.620827  21.075858
## [5,] -44.850733 -17.27759  24.02897   1.408954 40.105318 104.613641
## [6,]  -1.604172  47.17692 -48.04598 -96.730237 34.771697  38.095149
##            [,37]      [,38]     [,39]      [,40]      [,41]     [,42]
## [1,]    0.000000   0.000000   0.00000   0.000000   0.000000   0.00000
## [2,]  -10.483929  -2.023277 -14.75537   2.569152   2.731748 -17.09618
## [3,]   -1.463157 -12.388190 -41.66917 -34.785164   3.378732 -12.90700
## [4,]   28.653980  24.470231 -22.55843  35.681735  50.591217  26.62513
## [5,] -117.258661 -53.047490 -29.73462 -20.220600 -80.708032  43.72825
## [6,]  -99.892993  14.870443 -31.53956  35.227339 -19.113860  19.57015
##             [,43]      [,44]      [,45]        [,46]      [,47]      [,48]
## [1,]   0.00000000   0.000000   0.000000   0.00000000   0.000000   0.000000
## [2,]   1.16416009  -1.348760   2.348876   0.05221328   1.302305   2.147038
## [3,]  -0.06684969 -37.773286 -11.686102  -8.64675325  21.668932 -14.005776
## [4,] -17.04361266 -19.405549  32.383851  14.77902728 -32.151437  -5.208572
## [5,] -11.92399923 -45.917237 103.516457   1.17050171  88.213716 -29.475409
## [6,]  98.96941103  -6.752344  -6.260803 104.78667390 -48.899231   2.621173
##           [,49]      [,50]      [,51]     [,52]     [,53]     [,54]
## [1,]   0.000000   0.000000    0.00000   0.00000  0.000000   0.00000
## [2,]   3.253058   1.916409  -19.61748  -3.61830  3.917685  14.27682
## [3,]  21.864841  -3.893890   43.51255  49.74667  2.748404  22.87788
## [4,] -22.176329  20.569898  -10.09897  39.14890 14.611748 -62.49246
## [5,] -47.775550 -41.869476   75.97717  28.31601 66.319339 -10.45079
## [6,]   9.211470 -60.396819 -130.68907 118.01824 12.709062  79.53086
##          [,55]     [,56]      [,57]      [,58]      [,59]     [,60]
## [1,]   0.00000  0.000000   0.000000   0.000000   0.000000   0.00000
## [2,] -22.04105 -6.221702  -4.520458  28.320077   7.466391 -12.93335
## [3,]  22.47559  1.694675  23.203486 -17.040949  -8.650782 -11.53952
## [4,] -17.28721 11.944445 -38.541398  54.212713 -40.593693  17.75571
## [5,]  13.26865 -9.154220 107.320907  -2.844428 -57.185077  19.93729
## [6,]  13.02228 73.305000 -82.772239 -39.273193 161.886934  38.51308
##          [,61]      [,62]      [,63]       [,64]      [,65]      [,66]
## [1,]   0.00000   0.000000   0.000000   0.0000000   0.000000   0.000000
## [2,]  13.46173   8.638003  -8.864838   4.1187900   2.118769   0.640006
## [3,]  -4.45164  -8.036563 -19.977469   0.2402426   5.627845  18.866776
## [4,] -59.68713 -51.616624 -42.432124 -73.6382236 -39.956165 -45.663865
## [5,]  16.39995  37.626624 -16.781344 -92.3778152 -27.483488 -14.421144
## [6,] -53.46311  48.180236  33.311617   5.6483665  55.469305 101.544238
##          [,67]      [,68]      [,69]      [,70]       [,71]       [,72]
## [1,]   0.00000   0.000000   0.000000    0.00000   0.0000000   0.0000000
## [2,]  10.54963  -5.946644 -14.614049   18.01798   0.1322605   1.7211781
## [3,]  49.33957 -55.953639  -4.148094   11.20513 -13.7580942   0.9031015
## [4,] -12.21674  35.148668   5.040067   44.27258  -8.2794995 -28.0317399
## [5,] -26.43625  19.502097  -8.692192  -16.97901 -12.5808590  78.5286086
## [6,] -84.57641  57.388749  53.801789 -144.78780  43.3142103 -18.4126641
##            [,73]      [,74]     [,75]      [,76]      [,77]      [,78]
## [1,]    0.000000   0.000000   0.00000   0.000000   0.000000   0.000000
## [2,]   -7.258430   5.693761 -22.33372   4.173476  -2.951079  17.888028
## [3,]    4.196081 -18.765665 -45.82158  47.793707  31.178096   2.510757
## [4,]   59.495274   3.523752 -24.71489 -31.374825 -56.089571  -6.392057
## [5,]   22.417598  52.375735 -32.52890   9.228271   7.040404 -80.849043
## [6,] -108.407959  34.803279 -39.83333  35.694685  18.092320  62.713156
##          [,79]      [,80]      [,81]     [,82]       [,83]     [,84]
## [1,]   0.00000   0.000000   0.000000   0.00000   0.0000000   0.00000
## [2,] -14.86076   1.697515  -2.543077 -11.40359  -9.7212938  19.09233
## [3,] -43.60732 -15.536761  -9.747185 -21.43777 -89.7336360  50.75991
## [4,]  61.27414  24.000445 -31.174403  16.19702   2.6164602 -59.35510
## [5,] -62.58995 -53.439152  97.937040  57.72559  14.2790160  44.06448
## [6,] -73.32678  48.263388 197.210011 -51.20721   0.8885727 -51.77939
##          [,85]     [,86]      [,87]     [,88]      [,89]     [,90]
## [1,]   0.00000   0.00000   0.000000   0.00000   0.000000  0.000000
## [2,] -18.86887  10.19607 -38.800722  29.54179   5.275063 12.478245
## [3,]   8.57348  15.03450   3.529961 -39.66652   7.462059 24.824812
## [4,]  29.80030 -14.09602 -17.998393 -54.14904   7.218777 -3.170133
## [5,] -27.82038 -10.85809  61.339022  37.75318 -27.906673  4.672236
## [6,] -51.36292 -51.72131  44.762188  60.53460  79.244292 26.715650
##          [,91]      [,92]      [,93]      [,94]      [,95]       [,96]
## [1,]   0.00000   0.000000   0.000000   0.000000   0.000000   0.0000000
## [2,] -16.52844  -3.072762 -18.199124   1.213597  -2.803700  22.3791582
## [3,]  26.50948  -5.745642   4.247375  -3.316162  17.792756   0.5726569
## [4,] -11.11673 -18.364881  -7.576757 -13.218200 -46.025444  35.8901540
## [5,]  81.92906  80.342304 -62.454471   6.656907 -13.490016 -52.3135350
## [6,]  48.77759  76.325120  85.732025   4.261140   6.563379  52.1087610
##          [,97]      [,98]      [,99]     [,100]
## [1,]   0.00000   0.000000   0.000000   0.000000
## [2,]  12.58056  -4.683570   5.901572  -6.865248
## [3,] -20.56562 -47.085978 -28.737847 -30.917394
## [4,]  16.04222  46.663144  -2.106224 -11.050232
## [5,] -17.77727  22.557778  -4.119156  15.878391
## [6,] -56.06061   7.973415  15.334696 -30.241173
```

----
## Even better, use sapply


```r
m <- sapply(seq(0, 500, length.out = 40), function(i) rnorm(100, 0, i))
head(m) 
```

```
##      [,1]       [,2]        [,3]      [,4]      [,5]       [,6]       [,7]
## [1,]    0   3.958883 -10.8209418 12.609370 -94.52339  -2.424006 -21.624639
## [2,]    0  -2.689198 -13.7304067 45.272672 -34.94908   9.647170 -92.145211
## [3,]    0  13.255154   0.5609675 33.601448 -58.67623   5.115557 -97.930847
## [4,]    0  -5.001251   9.1473431  9.049052 -23.80552 -61.108409  73.873029
## [5,]    0 -14.738158 -36.7213745 26.453801  16.08995  59.274086  -4.478517
## [6,]    0   5.420713 -25.1297784 12.211885  14.10672  71.716641 -93.664143
##            [,8]      [,9]       [,10]      [,11]       [,12]      [,13]
## [1,] 116.204557 -35.24249 -263.520855 -262.57687 -197.316860   45.13790
## [2,] -87.227588  16.48088   16.213701   63.23928  119.672343   14.64364
## [3,]   5.902483 -30.85940  -21.028583 -120.31257    2.569428  -98.47190
## [4,] -13.340777 -99.04901  170.152729  -90.39392 -124.434016   89.51757
## [5,]  34.719007 -67.34179   -8.294864   44.09148   -8.074291 -318.62317
## [6,]  63.796914 149.83665  155.999370   37.17018  197.618335   20.58740
##           [,14]      [,15]      [,16]      [,17]      [,18]       [,19]
## [1,]   43.92708  -54.28319 157.495772  -16.59467  159.31113 -279.301807
## [2,]  102.56447  278.56899   9.188212 -139.05664 -195.81531  265.790594
## [3,]  116.10508 -236.47629 161.547235  205.55581  123.59101  324.724465
## [4,]  285.43910   20.88773 105.154838  -20.68520   87.34074  521.747143
## [5,] -323.94720  182.43185  70.535586  -44.34975  349.52126    3.553238
## [6,]  -52.14630 -215.87944 -32.180134   43.57174  121.88598    2.335836
##           [,20]      [,21]      [,22]      [,23]       [,24]      [,25]
## [1,]  -40.00007   33.89771  -21.62556 -211.51509    8.968658  -16.24613
## [2,] -203.18482   35.10798   82.55199   81.01470 -297.319347 -203.85347
## [3,] -347.28917  458.75055 -305.15402  -48.79516 -512.798402  253.94222
## [4,] -256.53709  -67.16797  104.15245   65.92752 -234.633931  123.43522
## [5,] -277.38671 -584.24040  412.10308 -335.16089  322.058015 -422.39288
## [6,]   54.99392   12.36004  211.75126 -446.07368   25.595631  359.46253
##           [,26]      [,27]      [,28]       [,29]       [,30]      [,31]
## [1,]  211.15295 -430.44394   4.440089 -102.398230  456.087874  432.56198
## [2,]  509.11710  815.26589 -20.715840   64.129605 -671.038290 -515.01013
## [3,]  222.88898  731.36951 227.420096  -54.341658 -441.734484  -54.59492
## [4,]  269.40267  194.10831 524.194022  170.466453   -4.013891  126.89425
## [5,]   71.97949  348.02607  80.777853  380.025725  -13.389967   68.45146
## [6,] -530.85238  -51.14684 -53.793831    2.892316  173.758142  435.64821
##           [,32]      [,33]     [,34]       [,35]      [,36]      [,37]
## [1,] -592.00719  199.22592 -284.8627 -1354.79754 -633.20661  944.86615
## [2,] -261.19734 -302.22164 -149.6057  -161.48716   34.96284   51.14773
## [3,] -574.05112 -212.41871  804.6984  -183.06367  571.21439   37.06082
## [4,] -256.56449 -354.79023 -541.9790   -89.26599 -274.58918  443.44316
## [5,]  -39.40967  -42.50872  115.9619   598.48475 -245.91640 -444.22558
## [6,]  157.56023 -832.19830  -47.9916 -1005.15165  -56.77347 -147.15075
##           [,38]      [,39]      [,40]
## [1,] -375.63348 -721.22774 -352.19009
## [2,]  -95.89811 -304.31766  221.25533
## [3,] -246.77751 -247.28365  819.77890
## [4,]  186.07722   95.43785   46.73523
## [5,] -109.24333 -362.51365  274.72786
## [6,] -926.68565 -866.72978  -28.07760
```

----
Note that by default, sapply returned the transpose of the matrix we were
 going for before. That's really not a problem, now each column represent 100 draws from the corresponding random normal distribution rather than rows. We can easily verify this.


```r
nrow(m)
```

```
## [1] 100
```

```r
ncol(m)
```

```
## [1] 40
```
<br>
Of course, we can also easily get the matrix back by just transposing it.


```r
m <- t(m)
head(m)
```

```
##            [,1]       [,2]        [,3]       [,4]      [,5]       [,6]
## [1,]   0.000000   0.000000   0.0000000   0.000000   0.00000   0.000000
## [2,]   3.958883  -2.689198  13.2551543  -5.001251 -14.73816   5.420713
## [3,] -10.820942 -13.730407   0.5609675   9.147343 -36.72137 -25.129778
## [4,]  12.609370  45.272672  33.6014483   9.049052  26.45380  12.211885
## [5,] -94.523391 -34.949076 -58.6762263 -23.805525  16.08995  14.106724
## [6,]  -2.424006   9.647170   5.1155569 -61.108409  59.27409  71.716641
##           [,7]       [,8]       [,9]     [,10]     [,11]      [,12]
## [1,]   0.00000   0.000000   0.000000   0.00000   0.00000   0.000000
## [2,] -25.71180 -38.266131  -5.588034 -13.03626  10.38890  -4.458304
## [3,]  34.68302  15.665933 -28.769476 -30.96300  35.18347  45.048532
## [4,]  64.46154  -9.703649   5.862733 -47.41931 -69.65916 -35.040743
## [5,]  34.87941 189.161598 -25.001270 -26.16564  14.05259  -3.745932
## [6,]  32.50848  57.711220 -61.271684 -74.13893 -20.02874  88.433307
##          [,13]      [,14]      [,15]     [,16]     [,17]       [,18]
## [1,]   0.00000   0.000000   0.000000  0.000000   0.00000    0.000000
## [2,] -15.73285  -3.284342  -3.202013 -4.989235  13.50975   18.189822
## [3,] -59.16096   2.230372  10.679634 -3.867952 -21.17652    2.779087
## [4,]  15.51417 -55.401776 -36.505955  8.576130 -47.14738   44.260385
## [5,] -27.09101 -43.532198  35.537570 -3.620942  10.68652   -2.859888
## [6,]  71.00156  95.311355  32.113512 30.642222 -20.46112 -124.581656
##           [,19]      [,20]     [,21]     [,22]      [,23]      [,24]
## [1,]   0.000000   0.000000   0.00000   0.00000   0.000000   0.000000
## [2,]   2.198603  21.715276  -2.09943  22.21909  15.095060   8.499528
## [3,] -22.453393   2.784214 -48.09851   5.17483   5.756273 -31.585053
## [4,]  -3.875761 -64.835407  23.09825 -52.75809  36.400839 -65.096808
## [5,]  82.252936  57.506696 -37.86708 -54.90121  19.647060  10.933670
## [6,]  37.518734  11.261424  42.80058 103.99009 -15.261420   7.024513
##           [,25]     [,26]      [,27]       [,28]     [,29]      [,30]
## [1,]   0.000000  0.000000   0.000000   0.0000000   0.00000   0.000000
## [2,]   4.523169 -5.382418   2.659241   9.1082754  16.52755   1.075054
## [3,] -12.390385  2.331017  13.799118 -11.0152342 -16.31490  -4.454141
## [4,]  26.495661 32.809711 -17.855704 -40.3070606  18.79098  37.137094
## [5,]  18.244134 90.370838 -19.875560   1.4412989  43.98483 -48.355758
## [6,] -66.981399 44.557218  42.106292  -0.3007626 -14.32874  62.994386
##          [,31]       [,32]       [,33]      [,34]      [,35]      [,36]
## [1,]   0.00000    0.000000    0.000000   0.000000   0.000000   0.000000
## [2,]  16.95758    6.084711   -3.301858  31.007448  -8.097324  -5.026649
## [3,]  13.27396  -10.867892   11.628326   3.203094  10.592250  28.022051
## [4,] -58.20477   -8.374713  -57.490921 -22.155747 -40.943734  15.080428
## [5,]  50.80360   50.625093  -51.033508 -47.309994 -71.440189  37.115183
## [6,] -32.67718 -111.041660 -127.271114 -65.858811  14.456591 -24.794779
##          [,37]      [,38]     [,39]      [,40]        [,41]      [,42]
## [1,]   0.00000   0.000000   0.00000   0.000000    0.0000000   0.000000
## [2,] -15.94244  -6.957890   3.73388   8.220151   -0.4352652  -8.101576
## [3,] -17.28126  -8.336394 -11.34262 -14.904240  -10.5816116 -21.358351
## [4,]  56.44570  79.471262 -37.30948 -50.754009   28.4136877  -7.602245
## [5,] -39.68158 -35.186920 -13.19222 -49.904289 -101.8202374  -8.941822
## [6,]  44.18431 -46.175929 -24.90562 -76.585494   -9.0828804  17.386348
##            [,43]        [,44]      [,45]      [,46]      [,47]      [,48]
## [1,]   0.0000000    0.0000000   0.000000   0.000000   0.000000  0.0000000
## [2,] -19.7991116    0.6225006 -13.140888 -12.045406   4.341366  2.9974901
## [3,] -31.0146496   45.9563057  -6.760662  35.705602 -22.766774  0.7282281
## [4,]   0.7498296   41.1213108  -2.180929   6.537437  -8.504374 26.8366747
## [5,]  96.9019582   91.9921907  -1.538619  30.744142  29.699602 74.6447206
## [6,]  -1.3779309 -184.4490239  14.606334  44.899421  24.387728 87.6651129
##           [,49]       [,50]      [,51]      [,52]      [,53]       [,54]
## [1,]    0.00000    0.000000   0.000000    0.00000   0.000000    0.000000
## [2,]   27.42382   -6.828509  10.846412   22.82584 -23.262863    1.088933
## [3,]   24.68907   21.703032   8.220682   51.37589   8.237237   20.778658
## [4,]   16.64321   71.863804  20.785254  -28.27521  44.232138  -53.137361
## [5,] -108.73704 -107.716843 -23.843594 -105.72649 -21.515617  -32.144437
## [6,]  -52.19502   34.927882   9.449023   67.18494 -13.086112 -153.024457
##           [,55]      [,56]     [,57]      [,58]      [,59]      [,60]
## [1,]   0.000000   0.000000  0.000000   0.000000   0.000000   0.000000
## [2,]   3.590067  -6.985735 -4.597349  -3.772382   5.084753  -7.291547
## [3,]  -1.368248  10.394755 -2.930481  46.902351 -27.990195 -13.898020
## [4,]  39.252099  18.717324 17.159015 -33.924243  37.699396   2.323817
## [5,] -42.462242   5.046882 49.176516 -52.598789   2.482768 -33.097021
## [6,] -25.379402 -11.178609 82.557987 -46.122509  15.911433 -31.730537
##            [,61]     [,62]      [,63]     [,64]      [,65]       [,66]
## [1,]    0.000000   0.00000   0.000000   0.00000   0.000000    0.000000
## [2,]   17.386942 -19.28365 -10.454057 -28.56306 -34.131036   16.554951
## [3,]  -72.395885  23.83015  -5.641064  21.60768  -1.705492    8.062195
## [4,]    8.759926 -17.59425 -46.686900  37.43037  11.911484   60.167026
## [5,]  -13.771929  44.33221 -46.950899  32.83828 -16.610044   18.561937
## [6,] -130.287109 -27.92241 -55.466105 -14.94534 -52.105945 -145.496485
##           [,67]       [,68]     [,69]       [,70]      [,71]     [,72]
## [1,]   0.000000   0.0000000  0.000000    0.000000   0.000000   0.00000
## [2,]  16.067483  -0.9696223  3.314208   10.145165  11.154309  10.23121
## [3,]  28.443452   2.4073587 -4.130331   27.443797 -27.747091 -12.08235
## [4,]   5.859833  36.1693602 20.480713    9.830452 -74.710049  25.94993
## [5,]  -1.155195   7.9330210 10.085826 -128.981427  -5.301913 -18.44581
## [6,] -54.907775 -38.3641496 13.197540  -77.370035 -71.549546  27.75478
##           [,73]    [,74]       [,75]       [,76]      [,77]       [,78]
## [1,]   0.000000  0.00000   0.0000000    0.000000   0.000000   0.0000000
## [2,] -15.250567 14.49689  -0.4696322   13.203495   3.156974   2.7815931
## [3,] -36.670304 27.54577  40.5641497   -6.803133  25.853914  -8.4625262
## [4,]  39.733948 15.88561  28.5062957   16.819828  12.909512 -23.2192081
## [5,] -18.239722 -7.56339 -18.5431843   16.603513  22.623374   0.2036405
## [6,]   6.959646 37.38523 144.9754140 -107.910123 -39.029562 -28.6010681
##           [,79]      [,80]       [,81]      [,82]     [,83]      [,84]
## [1,]   0.000000   0.000000   0.0000000   0.000000   0.00000   0.000000
## [2,]   5.411837   5.427578   0.3703462  -2.239524  -5.18005   8.702374
## [3,]  26.055285   7.911959   9.6007976 -15.926423  45.30197  17.247200
## [4,] -71.977481  54.323190  16.3764252  23.457128  46.00554  32.182836
## [5,]  40.655659 -38.269787 -32.8601331 -17.542101 -58.19160 -32.703213
## [6,]  48.122188  12.986068   8.9189211 -18.823197 -51.94488 216.500146
##           [,85]      [,86]      [,87]      [,88]     [,89]     [,90]
## [1,]   0.000000   0.000000   0.000000   0.000000  0.000000   0.00000
## [2,]   1.358130  22.326592   5.226444  -8.631334  4.887209 -18.33518
## [3,] -46.233892  -6.782536 -45.245378  20.797663 41.884339  14.51245
## [4,]  53.188491  28.880138 -54.458206 -39.692098  9.644894 -45.40327
## [5,]  -4.768764 -48.375228  23.067706  49.186286 41.947343  43.71762
## [6,]  -8.626360  60.102158 -12.930031 -46.270414 87.289711  77.49817
##          [,91]      [,92]     [,93]      [,94]       [,95]     [,96]
## [1,]   0.00000   0.000000   0.00000   0.000000   0.0000000   0.00000
## [2,]  12.19988 -16.985412 -10.21286  -4.408451  -0.8173196  10.29837
## [3,] -15.23480 -10.317163  47.27398  15.537443  14.3890102  28.14998
## [4,]  37.52643  60.487297 -35.21162 -17.946978  46.2212837 -45.49473
## [5,]  15.88630  94.061853 -31.80506  45.300828  61.4943679  43.94502
## [6,]  38.00659  -5.138399 -13.87581  69.566452 -22.1837200 -35.46954
##          [,97]      [,98]      [,99]      [,100]
## [1,]  0.000000   0.000000   0.000000   0.0000000
## [2,]  8.799801  14.537093   4.687445   0.1962426
## [3,] 36.144528   7.743164 -28.581881   2.9235502
## [4,] 27.570637   4.248378  33.230048  11.2312693
## [5,] 22.099964 -12.986845   2.930807  64.3900488
## [6,] 70.450750  75.803101 -54.726849 -54.4244757
```

----
## Contrasting lapply and sapply


```r
sapply(l, function(x) cor(x$ses, x$mathach_z, use = "complete.obs"))
```

```
## NonWhiteFemaleHSB   NonWhiteMaleHSB    WhiteFemaleHSB      WhiteMaleHSB 
##         0.3242966         0.2606627         0.3371732         0.2839241
```


```r
lapply(l, function(x) cor(x$ses, x$mathach_z, use = "complete.obs"))
```

```
## $NonWhiteFemaleHSB
## [1] 0.3242966
## 
## $NonWhiteMaleHSB
## [1] 0.2606627
## 
## $WhiteFemaleHSB
## [1] 0.3371732
## 
## $WhiteMaleHSB
## [1] 0.2839241
```

----
## Summary on lapply/sapply
Major benefits over for loops include:
* No need to initialize objects
* Names from the list are maintained
* Overall, can substantially reduce the amount of code you may need to write,
  and can therefore also make your code more clear.

---- .segue
# Summaries by grouping variables

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
#(rounded to nearest whole number)


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


