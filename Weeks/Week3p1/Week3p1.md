---
title       : Data Structures
subtitle    : Week 3.1
author      : Daniel Anderson
job         : CourseR
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Today's Agenda (not exactly ordered)

* Vectors, Matrices and (breifly) arrays
* Data types: Logical, Integer, Double (numeric), Character
* Coercion 
* Attributes: Names, Dimensions, Custom

# Next week
* A note on matrix algebra vs element-wise algebra
* Classes
* Lists
* Data frames

<br>
Note that much of this presentation is based off Wickham (2015): 
  http://adv-r.had.co.nz/Data-structures.html

--- 
## Data structures


|Dimensions |Homogenous    |Heterogeneous |
|:----------|:-------------|:-------------|
|1          |Atomic Vector |List          |
|2          |Matrix        |Data frame    |
|n          |Array         |              |
<br>
* Note: Table taken from Wickham (2015)

----
## Properties of Vectors

# Type 
* Type of elements stored in the vector
    - use `typeof()` or `is.character()`, `is.integer()`, etc.

# Length
* Number of elements in the vector
    - use `length()`

# Attributes
* Arbitrary metadata
    - use `attributes()` and/or `attr()`
* What's metadata
    - data about the data (i.e., information that describes the data)

---- &twocol
## Atomic Vectors vs Lists

*** =left

* Atomic
    - All elements of the same type

* Lists
    - Element types differ

<br>

We will wait until next class to talk about lists.

*** =right


```r
atomic <- c(1, 7, 9, 23, 5)
atomic
```

```
## [1]  1  7  9 23  5
```

```r
lst <- list("a", 2, TRUE)
lst
```

```
## [[1]]
## [1] "a"
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] TRUE
```

---- &twocol
## Data types

*** =left
* Double
    - numeric with arbitrary precision
* Integer
    - numeric whole number
* Logical
    - true/false
* Character
    - string elements

*** =right


```r
dbl <- c(1.357, 2, 4.67)
int <- c(2L, 5L, 7L, 1L)
log <- c(TRUE, FALSE, T, F)
chr <- c("a", "b", "c")
```
Note the specific "L" placed after each number on the integer vector to coerce
  the elements to integer, rather than double.


```r
int
```

```
## [1] 2 5 7 1
```

---- &twocol
## Determining and Testing Types

*** =left


```r
typeof(dbl)
```

```
## [1] "double"
```

```r
is.double(dbl)
```

```
## [1] TRUE
```

```r
is.integer(dbl)
```

```
## [1] FALSE
```

```r
is.atomic(dbl)
```

```
## [1] TRUE
```

*** =right
# Be careful of more generic tests


```r
is.numeric(dbl)
```

```
## [1] TRUE
```

```r
is.numeric(int)
```

```
## [1] TRUE
```

----
## Check in
* What data types are the following vectors?


```r
w <- c(TRUE, FALSE, FALSE, TRUE)
x <- c(3, 5, 8, 9, 2.5)
y <- c("green", "red", "blue")
z <- c(5L, 7L, 2L, 18L)
```

----
## Coercion

# Take a guess: What will the following vectors produce?


```r
w <- c("1", 2, 3)
x <- c(1, TRUE, FALSE)
y <- c(3.25, 5L, 7L)
z <- c("a", "b", 7, TRUE)
```

---- &twocol

*** =left


```r
c("1", 2, 3); is.character(w)
```

```
## [1] "1" "2" "3"
```

```
## [1] TRUE
```

```r
c(1, TRUE, FALSE); is.double(x)
```

```
## [1] 1 1 0
```

```
## [1] TRUE
```

*** =right


```r
c(3.25, 5L, 7L); is.double(y)
```

```
## [1] 3.25 5.00 7.00
```

```
## [1] TRUE
```

```r
c("a", "b", 7, TRUE); is.character(z)
```

```
## [1] "a"    "b"    "7"    "TRUE"
```

```
## [1] TRUE
```

----
## Coercion rules
Remember: Atomic vectors must contain data of the same type.

* Most flexible: Character
* Least flexible: Logical

When logical vectors are coerced to be numeric, `TRUE` are coded 1, and `FALSE`
  are coded 0.

Explicitely coerce via `as.___`.

---- &twocol
## Explicit coercion

*** =left

# Override default coercions


```r
c(FALSE,1,TRUE,0)
```

```
## [1] 0 1 1 0
```

```r
as.logical(c(FALSE,1,TRUE,0))
```

```
## [1] FALSE  TRUE  TRUE FALSE
```

```r
c("1", 2, 3)
```

```
## [1] "1" "2" "3"
```

```r
as.double(c("1", 2, 3))
```

```
## [1] 1 2 3
```
*** =right

# Convert to specific type


```r
as.character(1:5)
```

```
## [1] "1" "2" "3" "4" "5"
```
<br>
# Careful with specific coercsions


```r
c("a", "b", 7, "TRUE")
```

```
## [1] "a"    "b"    "7"    "TRUE"
```

```r
as.integer(c("a", "b", 7, "TRUE"))
```

```
## Warning: NAs introduced by coercion
```

```
## [1] NA NA  7 NA
```

----
## Check in
* Predict how each vector will be coerced.


```r
c(1, FALSE)
c("a", TRUE)
c("b", 1L)
c(1L, 2)
```
----
# Why does this all matter?

----

```r
c(1, FALSE)
```

```
## [1] 1 0
```

```r
c("a", TRUE)
```

```
## [1] "a"    "TRUE"
```

```r
c("b", 1L)
```

```
## [1] "b" "1"
```

```r
c(1L, 2)
```

```
## [1] 1 2
```

----
## Your turn

Create and coerce the following vectors to the specified type


```r
c(0, 0, 1, TRUE) # Logical
c(1, 5, 3.25, FALSE) # Integer
c(TRUE, FALSE, FALSE, TRUE) # Double
c("Male", "Female", 0, 1) # Character
c(TRUE, TRUE, FALSE, TRUE) # Character
c(2.3, 2.5, 2.999999, 3.01) # Integer
```

---- &twocol

*** =left


```r
as.logical(c(0, 0, 1, TRUE))
```

```
## [1] FALSE FALSE  TRUE  TRUE
```

```r
as.integer(c(1, 5, 3.25, FALSE))
```

```
## [1] 1 5 3 0
```

```r
as.double(c(TRUE, FALSE, FALSE, TRUE))
```

```
## [1] 1 0 0 1
```

*** =right


```r
c("Male", "Female", 0, 1)
```

```
## [1] "Male"   "Female" "0"      "1"
```

```r
as.character(c(TRUE, TRUE, FALSE, TRUE))
```

```
## [1] "TRUE"  "TRUE"  "FALSE" "TRUE"
```

```r
as.integer(c(2.3, 2.999999, 2.49, 3.01))
```

```
## [1] 2 2 2 3
```

---- .segue
![bikeAttr](./assets/img/bikeAttr.png)
# Attributes


----
## Important attributes
* `names()`, `colnames()`, `rownames()`
* Dimensions (used to convert vectors to matrices and arrays)
* Class: points R to correct functions to execute (e.g., `print()`, `plot()`, 
  etc.)

What is an attribute? Metadata (data about the data) for an object.

---- &twocol
# `names()`

*** =left

* Names can be assigned to an object in a couple different ways.


```r
y <- c("A" = 1, "B" = 2, "C" = 3)
y
```

```
## A B C 
## 1 2 3
```

```r
names(y)
```

```
## [1] "A" "B" "C"
```

*** =right


```r
z <- 1:3
z
```

```
## [1] 1 2 3
```

```r
names(z) <- c("A", "B", "C")
z
```

```
## A B C 
## 1 2 3
```

```r
names(z)
```

```
## [1] "A" "B" "C"
```

----
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

---- &twocol
## Benefits of factors
*** =left
* No need for multiple variables to define a categorical variable: internal 
  dummy-coding


```r
contrasts(colors)
```

```
##       blue green
## black    0     0
## blue     1     0
## green    0     1
```
*** =right

* Change the reference group by defining a new contrast matrix. For example, we 
  can set green to the reference group with the following code.


```r
contrasts(colors) <- matrix(
	c(1, 0,
	  0, 1,
	  0, 0),
byrow = TRUE, ncol = 2)
```

---- &twocol
# Contrast coding (continued)

Alternatively, use some of the built in functions for defining new contrasts 
  matrices 

*** =left


```r
contr.helmert(3)
```

```
##   [,1] [,2]
## 1   -1   -1
## 2    1   -1
## 3    0    2
```

```r
contr.sum(3)
```

```
##   [,1] [,2]
## 1    1    0
## 2    0    1
## 3   -1   -1
```
<br>
(see: http://www.ats.ucla.edu/stat/r/library/contrast_coding.htm)
*** =right


```r
contrasts(colors) <- contr.helmert(3)
contrasts(colors)
```

```
##       [,1] [,2]
## black   -1   -1
## blue     1   -1
## green    0    2
```

```r
contrasts(colors) <- contr.sum(3)
contrasts(colors)
```

```
##       [,1] [,2]
## black    1    0
## blue     0    1
## green   -1   -1
```

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

----
## Your turn (15 minutes)

# Sort of tricky: Will require you do some searching on your own

* Create a factor for free or reduced lunch status, of length 150, that has
  three levels: free, reduced, pay. (hint: use/look at the documentation for 
  `rep`)

* Specify a new contrast matrix using a custom matrix (you can use dummy-coding
  still, but just change the reference group).

* Create a random variable with `rnorm()` of the same length, with a mean of 
  100 and standard deviation of 15. (hint: look at the documentation for `rnorm`
  )

* Fit a linear regression model with the factor predicting the random variable

---- &twocol

*** =left


```r
frl <- factor(rep(
  c("free", "reduced", "pay"), 
  50)
)

effect_code <- matrix(c(-1, -1,
						 1, 0,
						 0, 1),
					  ncol = 2, 
            byrow = TRUE)
contrasts(frl) <- effect_code
contrasts(frl)
```

```
##         [,1] [,2]
## free      -1   -1
## pay        1    0
## reduced    0    1
```
*** =right




```r
set.seed(38)
outcome <- rnorm(150, 100, 15)
mod <- lm(outcome ~ frl)
library(arm)
display(mod, detail = TRUE)
```

```
## lm(formula = outcome ~ frl)
##             coef.est coef.se t value Pr(>|t|)
## (Intercept) 100.15     1.15   87.21    0.00  
## frl1         -3.50     1.62   -2.15    0.03  
## frl2          3.15     1.62    1.94    0.05  
## ---
## n = 150, k = 3
## residual sd = 14.06, R-Squared = 0.04
```

---- 
## What's going on here? Plot the data to find out!

![plot of chunk unnamed-chunk-32](assets/fig/unnamed-chunk-32-1.png) 


---- &twocol
## Dimension attribute

*** =left

The way we have created matrices in the past in through the `matrix` function


```r
m <- matrix(1:12, ncol = 3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
```

*** =right

The object `m` is really just an atomic vector with a dimension attribute


```r
attributes(m)
```

```
## $dim
## [1] 4 3
```

```r
is.atomic(m)
```

```
## [1] TRUE
```

---- &twocol
## Alternative construction of the same matrix

*** =left
# Construct matrix


```r
m <- 1:12
m
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12
```

```r
dim(m) <- c(4, 3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
```
*** =right

# Add row and column names


```r
rownames(m) <- c("r1", "r2", "r3", "r4")
m
```

```
##    [,1] [,2] [,3]
## r1    1    5    9
## r2    2    6   10
## r3    3    7   11
## r4    4    8   12
```

```r
colnames(m) <- c("c1", "c2", "c3")
m
```

```
##    c1 c2 c3
## r1  1  5  9
## r2  2  6 10
## r3  3  7 11
## r4  4  8 12
```

---- &twocol
## Construct matrix, but fill by row

*** =left
# Construct the transpose of the matrix

```r
m <- 1:12
dim(m) <- c(3, 4)
m
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
```

*** =right
# Transpose the matrix

```r
m <- t(m)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
## [4,]   10   11   12
```

---- &twocol
## Arrays: "Layered" Matrices


```r
a <- 1:16
dim(a) <- c(2, 2, 4)
a
```

This is a 3-dimensional array, but more dimensions are possible
*** =left


```
## , , 1
## 
##      [1,] [2,]
## [1,]    1    3
## [2,]    2    4
## 
## , , 2
## 
##      [1,] [2,]
## [1,]    5    7
## [2,]    6    8
```

*** =right


```
## , , 3
## 
##      [1,] [2,]
## [1,]    9   11
## [2,]   10   12
## 
## , , 4
## 
##      [1,] [2,]
## [1,]   13   15
## [2,]   14   16
```

---- &twocol
## When would you use arrays?
# One example: Differential item functioning

*** =left


```
## , , Score = 0
## 
##           Male Female
## Incorrect   53     51
## Correct     42     34
## 
## , , Score = 1
## 
##           Male Female
## Incorrect   40     65
## Correct     50     20
## 
## , , Score = 2
## 
##           Male Female
## Incorrect   16     24
## Correct     46     34
```

*** =right


```
## , , Score = 3
## 
##           Male Female
## Incorrect   64     24
## Correct     61     48
## 
## , , Score = 4
## 
##           Male Female
## Incorrect   34     65
## Correct     53     66
## 
## , , Score = 5
## 
##           Male Female
## Incorrect   32     48
## Correct     42     30
```

----
## Let's try

1. Create the following vector
$$
\begin{equation*}
  \textbf{vect} = \qquad 
  \begin{bmatrix}
    23 & 41 & 18 & 27 & 16 & 11 & 72 & 29 & 18 & 51 & 32 & 63
  \end{bmatrix}
\end{equation*}
$$

2. Use attributes to transform it to the following matrix
$$
\begin{equation*}
  \textbf{mat} = \qquad 
  \begin{bmatrix}
    23 & 27 & 72 & 51 \\
    41 & 16 & 29 & 32 \\ 
    18 & 11 & 18 & 63
  \end{bmatrix}
\end{equation*}
$$
3. Provide some arbitrary row and column names
4. Use attributes to transform $\textbf{vect}$ into a $3 * 2 * 2$ array

----
## More on the names attributes
For atomic vectors, and specifically matrices, `rownames()` and `colnames()` 
  must be used, rather than `names()`. The `names()` attribute is for individual
  elements.


```r
names(m)
```

```
## NULL
```

```r
names(m) <- c("a", "b", "c")
attr(m, "names")
```

```
##  [1] "a" "b" "c" NA  NA  NA  NA  NA  NA  NA  NA  NA
```

---- &twocol
## Names attributes (continued)

*** =left

After row, column, and element names are assigned, they can be used in 
  subsetting


```r
m["r1", ]
```

```
## Error in m["r1", ]: no 'dimnames' attribute for array
```

```r
m["r3","c2"] 
```

```
## Error in m["r3", "c2"]: no 'dimnames' attribute for array
```

```r
m["b"] 
```

```
## b 
## 4
```

*** =right

You can also specify the row and column names via `dimnames()` and a list of 
  vectors (ordered by row names, then column names, then the 3rd dimension for 
  arrays)


```r
dimnames(m) <- list(
	c("row1", "row2", "row3", "row4"), 
	c("col1", "col2", "col3")
					)
m
```

```
##      col1 col2 col3
## row1    1    2    3
## row2    4    5    6
## row3    7    8    9
## row4   10   11   12
## attr(,"names")
##  [1] "a" "b" "c" NA  NA  NA  NA  NA  NA  NA  NA  NA
```

---- 
## Adding custom attributes

Occassionally there are instances when it makes sense to add a custom attribute 
  of some sort. Here are a few examples


```r
comment(m) <- "Here are some  important things to remember: x, y, z"
attr(m, "comment")
```

```
## [1] "Here are some  important things to remember: x, y, z"
```

```r
attr(m, "new_attribute") <- "Just a different comment, but this one shows when m is printed"
attr(m, "new_attribute")
```

```
## [1] "Just a different comment, but this one shows when m is printed"
```

Remember that you can see all the attributes of an object via `attributes(x)`

---- &twocol
## Final notes on attributes

*** =left

When you modify a vector, the attributes are generally lost.


```r
attributes(sum(m))
```

```
## NULL
```

But in some cases you may want to strip the attributes from an object. You can 
  do this by setting the attributes to `NULL`.

*** =right

To remove the dimension names


```r
attr(m, "dimnames") <- NULL
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
## [4,]   10   11   12
## attr(,"names")
##  [1] "a" "b" "c" NA  NA  NA  NA  NA  NA  NA  NA  NA 
## attr(,"new_attribute")
## [1] "Just a different comment, but this one shows when m is printed"
```

----

To remove all the attributes, and return to a basic vector


```r
attributes(m) <- NULL
m
```

```
##  [1]  1  4  7 10  2  5  8 11  3  6  9 12
```

----
## Lab
$$
\begin{equation*}
  \textbf{m} = \qquad 
  \begin{bmatrix}
    11 & 26\\
    33 & 11 \\
    27 &  5 \\
    91 & 18 \\
  \end{bmatrix}
\end{equation*}
$$

* Create the above matrix using two methods, save them into objects m1 and m2
* Give the dimension names of each matrix using a different method for each
* Give each matrix one additional (and different) attribute
* Coerce the vector 
$ 
  \begin{bmatrix}
    T & F\\
  \end{bmatrix}
$
to type double or integer and add it to the third row of the matrix.



