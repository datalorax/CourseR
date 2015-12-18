---
title       : Homework 3 Review
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

# 1. Write a summary function 
Report the mean, median, standard deviation, minimum, and maximum values


```r
smry <- function(x) {
	if(is.numeric(x) == FALSE) {
		warning("Vector coerced to numeric")
	}
	mn <- mean(as.numeric(x), na.rm = TRUE)
	md <- median(as.numeric(x), na.rm = TRUE)
	stDev <- sd(as.numeric(x), na.rm = TRUE)
	minm <- min(as.numeric(x), na.rm = TRUE)
	maxm <- max(as.numeric(x), na.rm = TRUE)
	
	if(length(x) != length(na.omit(x))) {
		warning("Missing data removed")
	}
	
	stats <- c(mn, md, stDev, minm, maxm)
	names(stats) <- c("Mean", "Median", "Standard Deviation", "Minimum", 
		"Maximum")
return(round(stats, 3))
}
```

---- 
# Load data, apply function


```r
setwd("/Users/Daniel/Dropbox/Teaching/CourseR/")
beer <- read.delim("./data/ratebeer_beerjobber.txt")

Style <- smry(beer$style)
```

```
## Warning in smry(beer$style): Vector coerced to numeric
```

```r
ABV <- smry(beer$abv)
Ratings <- smry(beer$ratings)
Overall_Score <- smry(beer$score.overall)
```

```
## Warning in smry(beer$score.overall): Missing data removed
```

```r
Style_Score <- smry(beer$score.by.style)
```

```
## Warning in smry(beer$score.by.style): Missing data removed
```

----
# Bind results together

```r
rbind(Style, ABV, Ratings, Overall_Score, Style_Score)
```

```
##                  Mean Median Standard Deviation Minimum Maximum
## Style          31.863   35.0             18.532       1    62.0
## ABV             5.900    5.9              2.202       0    12.8
## Ratings       113.605   60.5            148.885       0  1116.0
## Overall_Score  65.850   71.0             24.224       0   100.0
## Style_Score    60.872   62.0             26.877       0   100.0
```

----
# Function for Median


```r
med <- function(x) {
	if(any(is.na(x))) {
		warning("Missing data removed")
		x <- na.omit(x)
	}
	
	ordered <- x[order(x)]

	if((length(ordered) %% 2) == 1) {
		return(ordered[ceiling(length(ordered)/2)])
	}
	
	if((length(ordered) %% 2) == 0) {
		return(mean(c(
				ordered[length(ordered)/2],
				ordered[(length(ordered)/2) + 1]
				)
			)
		)
	}
}
```

----
# Test function


```r
median(beer$score.overall, na.rm = TRUE); med(beer$score.overall)
```

```
## [1] 71
```

```
## Warning in med(beer$score.overall): Missing data removed
```

```
## [1] 71
```

```r
median(beer$abv, na.rm = TRUE); med(beer$abv)
```

```
## [1] 5.9
```

```
## [1] 5.9
```

----


```r
median(c(1:12, NA, NA), na.rm = TRUE); med(c(1:12, NA, NA))
```

```
## [1] 6.5
```

```
## Warning in med(c(1:12, NA, NA)): Missing data removed
```

```
## [1] 6.5
```

```r
median(1:13); med(1:13)
```

```
## [1] 7
```

```
## [1] 7
```

----
# Histogram/Density Plot function


```r
histDens <- function(x, lineCol, ...) {
  x <- as.numeric(x)
  hist(x, 
    probability = TRUE, 
    axes = FALSE,
    main = "", 
    xlab = "", 
    ylab = "")

  lines(density(x, na.rm = TRUE), 
    col = as.character(lineCol), 
    lty = 3, 
    lwd = 3)

  par(new = TRUE)
  hist(x, ...)
}
```

----


```r
histDens(beer$abv, lineCol = "blue", 
	main = "Alcohol by Volumne",
	xlab = "ABV")
```

![plot of chunk unnamed-chunk-8](assets/fig/unnamed-chunk-8-1.png) 

----
# Simulating Rolling Dice


```r
dice <- function(nsides, nrolls, ndice) {
	t(replicate(nrolls, sample(1:nsides, ndice, replace = TRUE)))

} 
```
Simulate rolling 3 dice, each with 8 sides, 100,000
     times.


```r
experiment <- dice(8, 1e5, 3)
head(experiment)
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    1
## [2,]    1    5    1
## [3,]    1    2    4
## [4,]    3    5    5
## [5,]    3    6    6
## [6,]    1    3    1
```

----
# Compute sum for each roll, produce annotated histogram


```r
tot <- rowSums(experiment)

hist(tot, 
	main = "Histogram of Simulated Rolls (3 dice, 8 sides)",
	xlab = "Sum of Roll")
abline(v = mean(tot), col = "red", lwd = 3)
abline(v = mean(tot) - sd(tot), col = "gray", lwd = 2, lty = 2)
abline(v = mean(tot) + sd(tot), col = "gray", lwd = 2, lty = 2)
```

![plot of chunk unnamed-chunk-11](assets/fig/unnamed-chunk-11-1.png) 

----
# Compute probability of second/third dice being 1 greater than  previous


```r
(table(experiment[ ,2] == experiment[ ,1] + 1 & 
	  experiment[ ,3] == experiment[ ,2] + 1) / 1e5) * 100
```

```
## 
##  FALSE   TRUE 
## 98.759  1.241
```
<br>
There is approximately a 1.163% chance of the second and third dice each being
  one greater than the previous. 
