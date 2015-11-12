---
title       : Homework 1 Review
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

## Homework Review

* Title, author and date
    + Use a YAML header in your document to do this

```
---
title: Example Markdown document
author: Daniel Anderson
date: "2015-11-11"
---
```

---- &twocol
## Homework Review (continued)

* An R code chunk displaying how to load data into R and store it into an 
  object, along with text explaining  the code.

![rCodeChunk](./assets/img/rCodeChunk.png)


----

The following lines of code uses the `read.table` function, to read the trees
  data into an object named `trees`. Columns are separated by a pipe, |, 
  missing data are coded 999, and, and the column names are Girth, Height, and
  Volume


```r
trees <- read.table("./data/trees.txt", 
    sep = "|", na = "999",
    col.names = c("Girth", "Height", "Volume"))
head(trees)
```

```
##   Girth Height Volume
## 1   8.3     NA     NA
## 2    NA     65   10.3
## 3    NA     63     NA
## 4  10.5     72   16.4
## 5  10.7     NA     NA
## 6  10.8     NA   19.7
```

---- &twocol
## Homework Review (continued)

* A generic ordered or unordered list with at least one level of nesting (could 
  even be a shopping list)

*** =left
![nestedList](./assets/img/nestedList.png)

*** =right
# Groceries
* Dairy
    + Cheese
    + Milk
    + Yogurt
* Meat
    + Ground beef
    + Pork chops
* Snacks
    + Chips
    + Crackers

---- 
## Homework Review (continued)

* Some R output of some sort

![rOutput](./assets/img/rOutput.png)

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png) 

---- 
## Homework Review (continued)

* Calculate the mean of a variable, via `mean()` and display it in text. If 
  there are missing data in the vector that you are trying to calculate the mean
  from, you will also need to include the additional argument `na.rm = TRUE`. 
  Make some manipulation to the data (e.g., remove a few random cases) and 
  report the mean in text again, using code.

![inlineCode](./assets/img/inlineCode.png)


The mean girth of trees in the sample was 13.57. 
  For trees below 70 feet the mean girth was 
  12.75.

----
## Homework Review (continued)

# Pairs plot


```r
pairs(trees)
```

![plot of chunk unnamed-chunk-4](assets/fig/unnamed-chunk-4-1.png) 

---- &twocol
## Homework Review (continued)

# Matrices and Vectors

Create the following matrix (which we created during the first class, if you
  saved your syntax)
$$\mathbf{m} = 
\left [
  \begin{array}{ccccc}
    18 & 32 & 11 & 41 & 73 \\\
    61 & 47 & 22 & 87 & 63 \\\
    44 & 52 & 23 & 42 & 77 \\\
    23 & 17 & 5 & 72 & 83
  \end{array}
  \right ]
$$

*** =left


```r
m <- matrix(c(18, 32, 11, 41, 73,
              61, 47, 22, 87, 63,
              44, 52, 23, 42, 77,
              23, 17,  5, 72, 83
              ), 
            byrow = TRUE, ncol = 5
)
m
```
*** =right
<br>


```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]   18   32   11   41   73
## [2,]   61   47   22   87   63
## [3,]   44   52   23   42   77
## [4,]   23   17    5   72   83
```

---- &twocol
## Homework Review (continued)

1) Use three different methods to subset the matrix and obtain the following 
  vector
$$\mathbf{v} = 
\left [
  \begin{array}{ccc}
    52 & 42 & 77
  \end{array}
  \right ]
$$

*** =left


```r
m[3, c(2,4,5)]

m[ ,c(2,4,5)][3, ]

m[3, m[3, ] == 52 |
     m[3, ] == 42 |
     m[3, ] == 77 ]

m[3, c(FALSE, TRUE, FALSE, TRUE, TRUE)]

m[3, ][ m[3, ] > 40 &
        m[3, ] != 44 ]

subset(m, c(FALSE, FALSE, TRUE, FALSE), 
    select = c(2,4,5), drop = TRUE)
```

*** =right


```
## [1] 52 42 77
```

```
## [1] 52 42 77
```

```
## [1] 52 42 77
```

```
## [1] 52 42 77
```

```
## [1] 52 42 77
```

```
## [1] 52 42 77
```

---- &twocol
## Homework Review (continued)

2) Subset $\mathbf{m}$ again to get 
  $\mathbf{v2} = \left [\begin{array}{cc} 87 & 42 \end{array} \right ]$. Then 
  create a new matrix using the following steps:
     
* Drop the final column of matrix $\mathbf{m}$
* Add $\mathbf{v2}$ to the second and fourth rows (this will utilize the property 
    of recycling). 

One possible method

*** =left


```r
v <- m[c(2,3), 4]
v
```

```
## [1] 87 42
```

```r
m2 <- m[ ,-5]
m2[2, ] <-  v + m2[2, ]
m2[4, ] <-  v + m2[4, ]
```

*** =right


```r
m2
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   18   32   11   41
## [2,]  148   89  109  129
## [3,]   44   52   23   42
## [4,]  110   59   92  114
```

---- &twocol
## Homework Review (continued)

# Render the document

*** =left

### Via R Studio
![knitRStudio](assets/img/knitRStudio.png)

*** =right

### Via code
If you don't have the rmarkdown library installed, first run


```r
install.packages("rmarkdown")
```
Then, to render to document


```r
library(rmarkdown)
render("yourFile.Rmd", "html_document")
```

Note that your working directory must be set to the same location as the .Rmd
  file, or you can provide a path to the file in the `render` function.
