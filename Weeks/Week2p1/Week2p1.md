---
title       : Data Structures
subtitle    : Week 2.1
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

* Scalars, Vectors, Matrices, Arrays, Data frames
* Data types: Logical, Integer, Double (numeric), Character
* Attributes: Names, Dimensions, Custom
* Coercion 

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
```


---- .segue
# Attributes

----
## Important attributes
* `names()`, `colnames()`, `rownames()`
* Dimensions (used to convert vectors to matrices and arrays)
* Class: points R to correct functions to execute (e.g., `print()`, `plot()`, 
  etc.)

What is an attribute? Metadata for an object.

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
## Your turn

* Create a factor for free or reduced lunch status that has three levels: free, 
  reduced, pay. 

* Specify a new contrast matrix using either a custom matrix or a built-in 
  function

----

```r
frl <- factor(rep(c("free", "reduced", "pay"), 5))
frl
```

```
##  [1] free    reduced pay     free    reduced pay     free    reduced
##  [9] pay     free    reduced pay     free    reduced pay    
## Levels: free pay reduced
```

```r
effect_code <- matrix(c(-1, -1,
						 1, 0,
						 0, 1),
					  ncol = 2, byrow = TRUE)
contrasts(frl) <- effect_code
contrasts(frl)
```

```
##         [,1] [,2]
## free      -1   -1
## pay        1    0
## reduced    0    1
```


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
## c1 c2 c3 
##  1  5  9
```

```r
m[ ,"c2"]
```

```
## r1 r2 r3 r4 
##  5  6  7  8
```

```r
m["c"] 
```

```
## c 
## 3
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
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
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
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12
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
* Give the dimension names of each matrix using a different method
* Give each matrix one additional (and different) attribute
* Coerce the vector 
$ 
  \begin{bmatrix}
    T & F\\
  \end{bmatrix}
$
to type double or integer and add it to the third row of the matrix.



