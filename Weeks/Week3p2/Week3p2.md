---
title       : Data Structures
subtitle    : Week 3.2
author      : Daniel Anderson
job         : CourseR
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Today's Agenda
* A note on matrix algebra vs element-wise algebra
* Lists
* Data frames
* Classes


--- &twocol

## Matrix Multiplication Versus Element-wise

Multiplication of matrices in R is completed element-wise, not with matrix
  algebra.

*** =left


```r
m1 <- matrix(round(rnorm(12, 10, 3)),
		ncol = 4)
m1
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   11    3    7   14
## [2,]    8    6    6   11
## [3,]   13   11   12   14
```

```r
m2 <- matrix(round(rnorm(12, 10, 3)),
		ncol = 3)
m2
```

```
##      [,1] [,2] [,3]
## [1,]   14    8    7
## [2,]   11   11   10
## [3,]    8    8    9
## [4,]    7    6   13
```

*** =right


```r
m1 * m2
```

```
## Error in m1 * m2: non-conformable arrays
```

```r
m1 %*% m2
```

```
##      [,1] [,2] [,3]
## [1,]  341  261  352
## [2,]  303  244  313
## [3,]  497  405  491
```

----
## Matrix algebra

<div align = "center">
<img src = assets/img/matrixMultDiag.png width = 500 height = 500>
</div>

----
## Marix product rules
<br>
<div align = "center">
<img src = assets/img/matrixMulti.png width = 500 height = 300>
</div>

---- &twocol
## One more example

*** =left


```r
m1 <- matrix(1:16, ncol = 4)
m1
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    5    9   13
## [2,]    2    6   10   14
## [3,]    3    7   11   15
## [4,]    4    8   12   16
```

```r
m2 <- matrix(21:36, ncol = 4)
m2
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   21   25   29   33
## [2,]   22   26   30   34
## [3,]   23   27   31   35
## [4,]   24   28   32   36
```

*** =right


```r
m1 * m2
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   21  125  261  429
## [2,]   44  156  300  476
## [3,]   69  189  341  525
## [4,]   96  224  384  576
```

```r
m1 %*% m2
```

```
##      [,1] [,2] [,3] [,4]
## [1,]  650  762  874  986
## [2,]  740  868  996 1124
## [3,]  830  974 1118 1262
## [4,]  920 1080 1240 1400
```

---- &twocol
## Lists
Elements of lists can be of any type, including lists

*** =left


```r
l <- list(
	c("a", "b", "c"),
	1:5,
	rep(c(T,F), 7),
	rnorm(3, 100, 25)
		  )
```

*** =right


```r
l
```

```
## [[1]]
## [1] "a" "b" "c"
## 
## [[2]]
## [1] 1 2 3 4 5
## 
## [[3]]
##  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE
## [12] FALSE  TRUE FALSE
## 
## [[4]]
## [1]  84.25054  92.20372 115.32656
```

---- &twocol
## Accessing List Elements
* List elements can be accessed in two methods: Using the `$` with the element 
  names, or through indexing with a double bracket `[[]]`.
* If a single bracket index is used, `[]`, the element will be returned, but of 
  type list.

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
## Access list elements via names

# Provide element names


```r
names(l) <- c("letters", "numbers", "logical", "double")
str(l)
```

```
## List of 4
##  $ letters: chr [1:3] "a" "b" "c"
##  $ numbers: int [1:5] 1 2 3 4 5
##  $ logical: logi [1:14] TRUE FALSE TRUE FALSE TRUE FALSE ...
##  $ double : num [1:3] 84.3 92.2 115.3
```
<br>

# Access element


```r
l$letters
```

```
## [1] "a" "b" "c"
```

----
## Lists returned by functions
* We'll talk about this more when we get into functions, but many functions 
  return a list of objects. For example: `lm`.


```r
data(mtcars)
mod <- lm(hp ~ mpg, data = mtcars)
str(mod)
```

```
## List of 12
##  $ coefficients : Named num [1:2] 324.08 -8.83
##   ..- attr(*, "names")= chr [1:2] "(Intercept)" "mpg"
##  $ residuals    : Named num [1:32] -28.7 -28.7 -29.8 -25.1 16 ...
##   ..- attr(*, "names")= chr [1:32] "Mazda RX4" "Mazda RX4 Wag" "Datsun 710" "Hornet 4 Drive" ...
##  $ effects      : Named num [1:32] -829.8 296.3 -23.6 -20 19.3 ...
##   ..- attr(*, "names")= chr [1:32] "(Intercept)" "mpg" "" "" ...
##  $ rank         : int 2
##  $ fitted.values: Named num [1:32] 139 139 123 135 159 ...
##   ..- attr(*, "names")= chr [1:32] "Mazda RX4" "Mazda RX4 Wag" "Datsun 710" "Hornet 4 Drive" ...
##  $ assign       : int [1:2] 0 1
##  $ qr           :List of 5
##   ..$ qr   : num [1:32, 1:2] -5.657 0.177 0.177 0.177 0.177 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:32] "Mazda RX4" "Mazda RX4 Wag" "Datsun 710" "Hornet 4 Drive" ...
##   .. .. ..$ : chr [1:2] "(Intercept)" "mpg"
##   .. ..- attr(*, "assign")= int [1:2] 0 1
##   ..$ qraux: num [1:2] 1.18 1.02
##   ..$ pivot: int [1:2] 1 2
##   ..$ tol  : num 1e-07
##   ..$ rank : int 2
##   ..- attr(*, "class")= chr "qr"
##  $ df.residual  : int 30
##  $ xlevels      : Named list()
##  $ call         : language lm(formula = hp ~ mpg, data = mtcars)
##  $ terms        :Classes 'terms', 'formula' length 3 hp ~ mpg
##   .. ..- attr(*, "variables")= language list(hp, mpg)
##   .. ..- attr(*, "factors")= int [1:2, 1] 0 1
##   .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. ..$ : chr [1:2] "hp" "mpg"
##   .. .. .. ..$ : chr "mpg"
##   .. ..- attr(*, "term.labels")= chr "mpg"
##   .. ..- attr(*, "order")= int 1
##   .. ..- attr(*, "intercept")= int 1
##   .. ..- attr(*, "response")= int 1
##   .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
##   .. ..- attr(*, "predvars")= language list(hp, mpg)
##   .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
##   .. .. ..- attr(*, "names")= chr [1:2] "hp" "mpg"
##  $ model        :'data.frame':	32 obs. of  2 variables:
##   ..$ hp : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
##   ..$ mpg: num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##   ..- attr(*, "terms")=Classes 'terms', 'formula' length 3 hp ~ mpg
##   .. .. ..- attr(*, "variables")= language list(hp, mpg)
##   .. .. ..- attr(*, "factors")= int [1:2, 1] 0 1
##   .. .. .. ..- attr(*, "dimnames")=List of 2
##   .. .. .. .. ..$ : chr [1:2] "hp" "mpg"
##   .. .. .. .. ..$ : chr "mpg"
##   .. .. ..- attr(*, "term.labels")= chr "mpg"
##   .. .. ..- attr(*, "order")= int 1
##   .. .. ..- attr(*, "intercept")= int 1
##   .. .. ..- attr(*, "response")= int 1
##   .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
##   .. .. ..- attr(*, "predvars")= language list(hp, mpg)
##   .. .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
##   .. .. .. ..- attr(*, "names")= chr [1:2] "hp" "mpg"
##  - attr(*, "class")= chr "lm"
```

----
You can access the elements through the list


```r
mod$coefficients
```

```
## (Intercept)         mpg 
##  324.082314   -8.829731
```

Note that some times there are more efficient methods


```r
coef(mod)
```

```
## (Intercept)         mpg 
##  324.082314   -8.829731
```
In this case the methods are roughly equivalent, but sometimes it can make a
  difference (IRT)

----
## Other functions will transform data into lists


```r
lst <- split(mtcars, mtcars$cyl)
str(lst)
```

```
## List of 3
##  $ 4:'data.frame':	11 obs. of  11 variables:
##   ..$ mpg : num [1:11] 22.8 24.4 22.8 32.4 30.4 33.9 21.5 27.3 26 30.4 ...
##   ..$ cyl : num [1:11] 4 4 4 4 4 4 4 4 4 4 ...
##   ..$ disp: num [1:11] 108 146.7 140.8 78.7 75.7 ...
##   ..$ hp  : num [1:11] 93 62 95 66 52 65 97 66 91 113 ...
##   ..$ drat: num [1:11] 3.85 3.69 3.92 4.08 4.93 4.22 3.7 4.08 4.43 3.77 ...
##   ..$ wt  : num [1:11] 2.32 3.19 3.15 2.2 1.61 ...
##   ..$ qsec: num [1:11] 18.6 20 22.9 19.5 18.5 ...
##   ..$ vs  : num [1:11] 1 1 1 1 1 1 1 1 0 1 ...
##   ..$ am  : num [1:11] 1 0 0 1 1 1 0 1 1 1 ...
##   ..$ gear: num [1:11] 4 4 4 4 4 4 3 4 5 5 ...
##   ..$ carb: num [1:11] 1 2 2 1 2 1 1 1 2 2 ...
##  $ 6:'data.frame':	7 obs. of  11 variables:
##   ..$ mpg : num [1:7] 21 21 21.4 18.1 19.2 17.8 19.7
##   ..$ cyl : num [1:7] 6 6 6 6 6 6 6
##   ..$ disp: num [1:7] 160 160 258 225 168 ...
##   ..$ hp  : num [1:7] 110 110 110 105 123 123 175
##   ..$ drat: num [1:7] 3.9 3.9 3.08 2.76 3.92 3.92 3.62
##   ..$ wt  : num [1:7] 2.62 2.88 3.21 3.46 3.44 ...
##   ..$ qsec: num [1:7] 16.5 17 19.4 20.2 18.3 ...
##   ..$ vs  : num [1:7] 0 0 1 1 1 1 0
##   ..$ am  : num [1:7] 1 1 0 0 0 0 1
##   ..$ gear: num [1:7] 4 4 3 3 4 4 5
##   ..$ carb: num [1:7] 4 4 1 1 4 4 6
##  $ 8:'data.frame':	14 obs. of  11 variables:
##   ..$ mpg : num [1:14] 18.7 14.3 16.4 17.3 15.2 10.4 10.4 14.7 15.5 15.2 ...
##   ..$ cyl : num [1:14] 8 8 8 8 8 8 8 8 8 8 ...
##   ..$ disp: num [1:14] 360 360 276 276 276 ...
##   ..$ hp  : num [1:14] 175 245 180 180 180 205 215 230 150 150 ...
##   ..$ drat: num [1:14] 3.15 3.21 3.07 3.07 3.07 2.93 3 3.23 2.76 3.15 ...
##   ..$ wt  : num [1:14] 3.44 3.57 4.07 3.73 3.78 ...
##   ..$ qsec: num [1:14] 17 15.8 17.4 17.6 18 ...
##   ..$ vs  : num [1:14] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ am  : num [1:14] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ gear: num [1:14] 3 3 3 3 3 3 3 3 3 3 ...
##   ..$ carb: num [1:14] 2 4 3 3 3 4 4 4 2 2 ...
```

----
## More on lists
* Note that previously slide looked like a nested list (list of lists). This is 
  because data frames are lists, where each element is the same length.
* lists are tremendously useful and flexible, but essentially require at least a 
  basic understanding of functions and loops.

For example: 


```r
sapply(lst, function(x) cor(x$mpg, x$hp))
```

```
##          4          6          8 
## -0.5235034 -0.1270678 -0.2836357
```
(Note `tapply` is a more efficent method for doing the same thing as above 
  without spliting the data frame first)

---- &twocol
# Lists and data frames

*** =left


```r
l <- list(
	lets = letters[1:5],
	ints = 9:5,
	dbl = rnorm(5, 12, 0.75)
	)
str(l)
```

```
## List of 3
##  $ lets: chr [1:5] "a" "b" "c" "d" ...
##  $ ints: int [1:5] 9 8 7 6 5
##  $ dbl : num [1:5] 11.3 12.3 13 12.7 12.7
```

```r
as.data.frame(l)
```

```
##   lets ints      dbl
## 1    a    9 11.30182
## 2    b    8 12.32591
## 3    c    7 13.01539
## 4    d    6 12.65257
## 5    e    5 12.72735
```

*** =right

Or equivalently


```r
dframe <- data.frame(
	lets = letters[1:5],
	ints = 9:5,
	dbl = rnorm(5, 12, 0.75)
	)
dframe
```

```
##   lets ints      dbl
## 1    a    9 11.70672
## 2    b    8 12.58865
## 3    c    7 11.87292
## 4    d    6 11.74504
## 5    e    5 13.05823
```

----
## Your turn



----


```r
d <- read.csv("./data/CamdenBoroughs.csv", 
	na = c("Not applicable", "999"), 
	stringsAsFactors = FALSE)
```

```
## Warning in file(file, "rt"): cannot open file './data/CamdenBoroughs.csv':
## No such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
d$Area <- substr(d$Middle.Super.Output.Area, 
				1,
				nchar(d$Middle.Super.Output.Area) - 4
				)
```

```
## Error in substr(d$Middle.Super.Output.Area, 1, nchar(d$Middle.Super.Output.Area) - : cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week3p2/.cache/unnamed-chunk-16_6c94227c2b34d402ee4019852388bfc5.rdb': No such file or directory
```

```r
d$Area <- as.factor(d$Area)
```

```
## Warning in is.factor(x): restarting interrupted promise evaluation
```

```
## Error in is.factor(x): cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week3p2/.cache/unnamed-chunk-16_6c94227c2b34d402ee4019852388bfc5.rdb': No such file or directory
```

```r
contrasts(d$Area)
```

```
## Warning in contrasts(d$Area): restarting interrupted promise evaluation
```

```
## Error in contrasts(d$Area): cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week3p2/.cache/unnamed-chunk-16_6c94227c2b34d402ee4019852388bfc5.rdb': No such file or directory
```

```r
d$FRL <- substr(d$Percentage.Claiming.Free.School.Meals, 
			1, 
			nchar(d$Percentage.Claiming.Free.School.Meals) - 1)
```

```
## Warning in substr(d$Percentage.Claiming.Free.School.Meals, 1, nchar(d
## $Percentage.Claiming.Free.School.Meals) - : restarting interrupted promise
## evaluation
```

```
## Error in substr(d$Percentage.Claiming.Free.School.Meals, 1, nchar(d$Percentage.Claiming.Free.School.Meals) - : cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week3p2/.cache/unnamed-chunk-16_6c94227c2b34d402ee4019852388bfc5.rdb': No such file or directory
```

```r
d$FRL <- as.numeric(d$FRL)
```

```
## Warning: restarting interrupted promise evaluation
```

```
## Error in eval(expr, envir, enclos): cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week3p2/.cache/unnamed-chunk-16_6c94227c2b34d402ee4019852388bfc5.rdb': No such file or directory
```

```r
mod <- lm(FRL ~ Area, data = d)
```

```
## Warning in is.data.frame(data): restarting interrupted promise evaluation
```

```
## Error in is.data.frame(data): cannot open file '/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week3p2/.cache/unnamed-chunk-16_6c94227c2b34d402ee4019852388bfc5.rdb': No such file or directory
```


