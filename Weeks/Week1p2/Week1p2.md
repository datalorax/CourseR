---
title       : Getting Data into R
subtitle    : Week 1.2
author      : Daniel Anderson
job         : R Course
framework   : io2012    # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---
## Directory Management

What is a working directory?
  * Exactly what it sounds like--the directory from which R will work
  * Read and write files from and to this directory

Identify current working directory


```r
getwd()
```

```
## [1] "/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week1p2"
```

------ 
## Looking into a working directory

What's in this directory? Two ways to find out:
* Navigate to the directory and take a look.
<div align = "left">
<img src = assets/img/currentDIR.png width = 500 height = 150>
</div>

* Have R look for you


```r
list.files()
```

```
## [1] "assets"      "Week1p2.Rmd"
```
The `list.files()` function shows what R "sees".

------
## Navigating your directory quickly
* Change directory from current location to a nested folder


```r
setwd("./nested/folders")
```
Here the `.` is essentially a fill-in for `getwd()`. 
* Navigate back one folder


```r
setwd("..")
```
* Navigate back two folders


```r
setwd("../..")
```

------
## Reading Data into R
To read data into R, you must tell R where the data are located by either 
  changing the working directory, or by providing the full path. For 
  example


```r
setwd("/Users/Daniel/Dropbox/Teaching/CourseR/data/")
d <- read.csv("cars.csv")
```
is equivalent to

```r
d <- read.csv("/Users/Daniel/Dropbox/Teaching/CourseR/data/cars.csv")
```
Also note that the shortcuts for changing directories can be used here too, 
  which can often increase efficiency.

----
## My advice
* Set your working directory to where you want to save all your data files.
* Move the data you are working with to that file, or to a nearby folder 
  e.g.,


```r
"(../raw)"
```

----
## What data can be read into R?
* R can read multiple data files
  - text files (csv, tab delimited, pipe delimited, etc)
  - web pages
  - SPSS, SAS, etc. (via the `foreign` or `memisc` packages)
  - Excel (I have not had great success here, and typically just convert it to 
    csv first)
  - relational and non-relational databases (I have no experience here, but I 
    know it is possible)
  - Directly entered data
* Simple text files are typically the most straightforward

<span style="color:green; font-weight:bold">
Fairly good blog post: </span>
http://www.r-bloggers.com/importing-data-into-r-from-different-sources/

----
## Diving deeper into reading data with R

```r
?read.table
```
<div align = "left">
<img src = assets/img/readTable.png width=900 height=500>
</div>

---- &twocol
## Important Arguments
*** =left
* `file`
  - name of file, including extension, in quotes
  - e.g. `"cars.txt"`
* `header` 
  - `read.table` defaults to `FALSE`
  - `read.csv` and others default to `TRUE`

*** =right
* `sep` 
  - `read.table` defaults to `""`
  - `read.csv` defaults to `","`
  - `read.delim` defaults to tab delimiter `"\t"`

* Others
  - `na.strings`
  - `skip`
  - `comment.char`
  - `stringsAsFactors`


---- &twocol
## Examples
*** =left
![excel](assets/img/carsExcel.png)
* Although csv files open in Excel, they are actually just text files

*** =right
![txt](assets/img/carsTxt.png)

----
## Examples


```r
getwd()
```

```
## [1] "/Users/Daniel/Dropbox/Teaching/CourseR/Weeks/Week1p2"
```

```r
cars <- read.csv("./data/cars.csv")
```

```
## Warning in file(file, "rt"): cannot open file './data/cars.csv': No such
## file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```
* Use `head()` `tail()` and `str()` to check that the data were read in properly


```r
head(cars)
```

```
##   speed dist
## 1     4    2
## 2     4   10
## 3     7    4
## 4     7   22
## 5     8   16
## 6     9   10
```

----

```r
tail(cars)
```

```
##    speed dist
## 45    23   54
## 46    24   70
## 47    24   92
## 48    24   93
## 49    24  120
## 50    25   85
```

---- 


```r
str(cars)
```

```
## 'data.frame':	50 obs. of  2 variables:
##  $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
##  $ dist : num  2 10 4 22 16 10 18 26 34 17 ...
```

----
## Learn more with `summary()`


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

---- &twocol
## A more complicated example
*** =left
* No column names
* pipe-delimited
* `NA` coded as 999
* `read.csv()` won't work here

*** =right
<div align = "left">
<img src = assets/img/treesData.png width = 200 height = 600>
</div>



----
* `read.table()`
* Explicit calls to 
  - `sep`, `na`, and `col.names`


```r
trees <- read.table("./data/trees.txt", sep = "|", na = "999", 
	col.names = c("Girth", "Height", "Volume"))
```

```
## Warning in file(file, "rt"): cannot open file './data/trees.txt': No such
## file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
head(trees)
```

```
##   Girth Height Volume
## 1   8.3     70   10.3
## 2   8.6     65   10.3
## 3   8.8     63   10.2
## 4  10.5     72   16.4
## 5  10.7     81   18.8
## 6  10.8     83   19.7
```
* Note that the column names are defined as a vector, via `c`.

---- 
## Last example: SPSS
![spss](assets/img/USViolentActs.png)

----

```r
library(foreign)
violence <- read.spss("./data/USViolentActs.sav", to.data.frame = TRUE)
```

```
## Error in read.spss("./data/USViolentActs.sav", to.data.frame = TRUE): unable to open file: 'No such file or directory'
```

```r
head(violence)
```

```
## Error in head(violence): object 'violence' not found
```

---- &twocol
## More on reading SPSS files

*** =left

* It's a hassle
* Support is limited (and no longer being developed)
* Warnings are (for now) ignorable
* `foreign` package
* `to.data.frame = TRUE` is vital
* `Hmisc` package may be a better alternative (I haven't explored it much, and 
  generally try to avoid SPSS files)

*** =right


```r
?read.spss
```
![spssHelp](assets/img/spssHelp.png)

----
## Your turn
In the repository you cloned earlier in class, there is a folder called "data".
Read in the following files
* longley.csv
* attitude.txt

<span style="color:gray" > (You can work with a partner) </span>

----
The longley file is a csv, with headers, and can be read in pretty simply:


```r
longley <- read.csv("./data/longley.csv")
```

```
## Warning in file(file, "rt"): cannot open file './data/longley.csv': No such
## file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
head(longley)
```

```
##      GNP.deflator     GNP Unemployed Armed.Forces Population Year Employed
## 1947         83.0 234.289      235.6        159.0    107.608 1947   60.323
## 1948         88.5 259.426      232.5        145.6    108.632 1948   61.122
## 1949         88.2 258.054      368.2        161.6    109.773 1949   60.171
## 1950         89.5 284.599      335.1        165.0    110.929 1950   61.187
## 1951         96.2 328.975      209.9        309.9    112.075 1951   63.221
## 1952         98.1 346.999      193.2        359.4    113.270 1952   63.639
```

----
The attitude file is a bit more tricky. It's tab separated. We can use either
  `read.table()` or `read.delim()`.


```r
att <- read.table("./data/attitude.txt", sep = "\t")
```

```
## Warning in file(file, "rt"): cannot open file './data/attitude.txt': No
## such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
att <- read.delim("./data/attitude.txt")
```

```
## Warning in file(file, "rt"): cannot open file './data/attitude.txt': No
## such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
head(att)
```

```
## Error in head(att): object 'att' not found
```

----
## Subsetting data frames
* Data frames can be subset in numerous ways, including indexing equivalent to 
  matrices


```r
head(cars)
```

```
##   speed dist
## 1     4    2
## 2     4   10
## 3     7    4
## 4     7   22
## 5     8   16
## 6     9   10
```
* Select the first 10 rows of the 3rd column


```r
cars[1:10,3]
```

```
## NULL
```

----
Select the same elements, but keep the data frame intact


```r
cars[1:10,3, drop = FALSE]
```

```
## Error in `[.data.frame`(cars, 1:10, 3, drop = FALSE): undefined columns selected
```


----
## `str()` gives us a hint at an alternative subsetting method


```r
str(cars)
```

```
## 'data.frame':	50 obs. of  2 variables:
##  $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
##  $ dist : num  2 10 4 22 16 10 18 26 34 17 ...
```


----
## Selecting columns by name
The `$` operator can also be used to select columns
* Select the `mpg` variable/column


```r
cars$mpg
```

```
## NULL
```

* Select the `cyl` variable/column


```r
cars$cyl
```

```
## NULL
```

---- &twocol
## A brief pause...Why so much focus on subsetting?
*** =left
* Used constantly in applied analysis work
	- analyze specific columns within a dataframe
	- explore differences in one variable by a factor
	- restrict the data (analytic sample as a subset of the full raw sample)

* Examples


```r
# Frequency of cylinders
table(cars$cyl)
```

```
## < table of extent 0 >
```
*** =right


```r
# plot the relation between horse
# power and miles per gallon
plot(cars$hp, cars$mpg)
```

```
## Warning in min(x): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x): no non-missing arguments to max; returning -Inf
```

```
## Warning in min(x): no non-missing arguments to min; returning Inf
```

```
## Warning in max(x): no non-missing arguments to max; returning -Inf
```

```
## Error in plot.window(...): need finite 'xlim' values
```

![plot of chunk unnamed-chunk-27](assets/fig/unnamed-chunk-27-1.png) 
Not the prettiest plot (and we'll make them prettier soon), but the subsetting
  allows us to select the columns we want for the plot.

---- &twocol
## A few more subsetting notes
*** =left
* Names can also be used within the `[]`, as long as they are supplied as a 
  string
* Multiple columns can be selected in this manner if a vector of names is 
  supplied
  - vectors are returned if you are using the `row , column` notation with a 
    single variable and you do not specifiy `drop = FALSE`
  - data frame maintained if only the names are supplied


* The following two lines of code are equivalent


```r
cars[c("mpg","cyl")]
cars[ ,c("mpg","cyl")]
```
*** =right
* As are these


```r
cars["mpg"]
cars[ ,"mpg", drop = FALSE]
```
* However, these are not


```r
cars["mpg"]
cars[ ,"mpg"]
```

* The first maintains the data frame, while the second returns a vector

---- &twocol
## Example

*** =left


```r
cars["mpg"]
```

```
## Error in `[.data.frame`(cars, "mpg"): undefined columns selected
```

*** =right


```r
cars[ ,"mpg"]
```

```
## Error in `[.data.frame`(cars, , "mpg"): undefined columns selected
```

----
## Logical subsetting can also be used with data frames


```r
mpg25up <- cars$mpg > 25
cars[mpg25up, ]
```

```
## [1] speed dist 
## <0 rows> (or 0-length row.names)
```


```r
cars[cars$mpg > 25 & cars$gear == 5, ]
```

```
## [1] speed dist 
## <0 rows> (or 0-length row.names)
```

----
## How do these logical subsets work?


```r
cars$mpg > 25
```

```
## logical(0)
```

```r
cars$mpg > 25 & cars$gear == 5
```

```
## logical(0)
```

----
## Final note on subsetting 
* The `subset()` function can be very useful for subsetting vectors, matrices, 
  or data frames


```r
?subset
```

<div align = "center">
<img src = assets/img/subsetHelp.png width = 1000 height = 650>
</div>


---- &twocol
## Examples of `subset`
* `x` = object to subset
* `subset` logical vector
* `select` optionally used to select columns

*** =left


```r
subset(cars, 
	subset = mpg > 25, 
	select = c("model", "mpg", "hp"))
```

```
## Error in eval(expr, envir, enclos): object 'mpg' not found
```

*** =right


```r
subset(cars, hp > 220)
```

```
## Error in eval(expr, envir, enclos): object 'hp' not found
```

--- .segue
# A Brief Intro to R Markdown

<div align = "right">
<img src = assets/img/exampleRMarkdown.png width = 500 height = 750>
</div>

----
## YAML Front Matter

```
---
title: Example Markdown document
author: Daniel Anderson
date: "2015-09-17"
---
```

![frontMatter](assets/img/frontMatter.png)

* Three dashes before and after the YAML fields
* Case sensitive
* Many other fields are possible.
  + For example, you may want to include an `output:` argument (`pdf_document`,
    `html_document`, `word_document`). Must be specified as it is rendered, if
    not supplied.



---- &twocol
## Headings and Lists

*** =left

```
# Level 1
## Level 2 
### Level 3 (etc.)
```

```
* Unordered list
  - inset
    + inset more
  - etc.

1. Ordered list
  a. blah blah
2. More stuff
```

*** =right

![headersLists](assets/img/headersLists.png)

---- &twocol
## Code chunks

Start a code chunk with \`\`\`{r}, then produce some r code, then close the 
  chunk with three additional back ticks \`\`\`.

*** =left

![codechunk1](assets/img/codeChunk1.png)



```r
a <- 3
b <- 5

a + b * (exp(a)/b)
```

```
## [1] 23.08554
```

You can show code without evaluating it, using `eval = FALSE`. 

![codechunk2](assets/img/codeChunk2.png)

*** =right

Alternatively, you can evaluate the code without displaying it, using `echo = 
  FALSE`.

![codechunk3](assets/img/codeChunk3.png)

![plot of chunk unnamed-chunk-40](assets/fig/unnamed-chunk-40-1.png) 

-----
## Inline code

A single back tick followed by `r` prooduces inline code to be evaluated.

<div align = "center">
<img src = assets/img/inlineCode.png width = 1000 height = 80>
</div>
<br>

This is an example of inline code, where I want to refer to the sum of `a` and
  `b`, which is 8.


----- &twocol
## Rendering the document

*** =left

Through a text editor (e.g., SublimeText)


```r
install.packages("rmarkdown")
library(rmarkdown)
setwd("dir/to/Rmd/doc")
render("ExampleRMarkdown.Rmd", 
  "html_document")
```

Note that the document type need not be specified if `output:` is supplied in 
  the YAML front matter. 

*** =right

Through RStudio

![knitRStudio](assets/img/knitRStudio.png)


----
## Final Product

<div align = "left">
<img src = assets/img/fullRMarkdownDoc.png width = 500 height = 600>
</div>
