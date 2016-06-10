---
title       : "Plotting with ggplot2"
subtitle    : Week 8.1
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
Today, we'll be covering the basics of the *ggplot2* package. Note that the majority of this presentation is based on examples from the new *ggplot2* book.

![ggplotBook](./assets/img/ggplotBook.png)


----
## Part of the many reasons Hadley is a cool guy

![freeggplot](./assets/img/freeggplot.png)

----
## Other resources
The *ggplot2* package is one of the most popular R packages. There are a plethora of resources to learn the syntax. 

* Perhaps the most definitive, and index of all the capabilities of ggplot2, along with multiple examples 
	+ http://docs.ggplot2.org/current/index.html#

* RStudio cheat sheet can also be helpful
	+ https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf



---- 
## Components
Every *ggplot* plot has three components

1. data
	* The data used to produce the plot
2. aesthetic mappings
	* between variables and visual properties
3. layer(s)
	* usually through the geom function to produce geometric shape to be rendered

----
## Basic syntax
![ggplotBasicSyntax](./assets/img/ggplotBasicSyntax.png)

Note that Hadley recommends putting each `geom_XXX` on a separate line to ease clarity. I agree with this suggestion, but will not be following it in these slides to help save space.

----
## mpg data
Very similar to the *mtcars* data, but with more cases and a few more interesting variables


```r
library(ggplot2)
data(mpg)
head(mpg)
```

```
## Source: local data frame [6 x 11]
## 
##   manufacturer model displ  year   cyl      trans   drv   cty   hwy    fl
##          (chr) (chr) (dbl) (int) (int)      (chr) (chr) (int) (int) (chr)
## 1         audi    a4   1.8  1999     4   auto(l5)     f    18    29     p
## 2         audi    a4   1.8  1999     4 manual(m5)     f    21    29     p
## 3         audi    a4   2.0  2008     4 manual(m6)     f    20    31     p
## 4         audi    a4   2.0  2008     4   auto(av)     f    21    30     p
## 5         audi    a4   2.8  1999     6   auto(l5)     f    16    26     p
## 6         audi    a4   2.8  1999     6 manual(m5)     f    18    26     p
## Variables not shown: class (chr)
```

----
## Quick example


```r
data(mpg)
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
```

![plot of chunk mpgEx1](assets/fig/mpgEx1-1.png)

----
## Quick example 2
Note that the only thing that has changed here is the `geom` 


```r
data(mpg)
ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth()
```

![plot of chunk mpgEx2](assets/fig/mpgEx2-1.png)

----
## Add an additional layer


```r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth()
```

![plot of chunk mpgEx3](assets/fig/mpgEx3-1.png)

----
## Add an additional aesthetic


```r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() 
```

![plot of chunk mpgEx4](assets/fig/mpgEx4-1.png)

----
## Add smooth line for each class
# Too busy
Note the below spits out some warnings because of the sparsity of the data. I've suppressed them here.


```r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() +
 geom_smooth()
```
![plot of chunk mpgEx5b](assets/fig/mpgEx5b-1.png)

----
## Remove SE


```r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() +
 geom_smooth(se = FALSE)
```

![plot of chunk mpgEx6b, ](assets/fig/mpgEx6b, -1.png)

----
## Change the color of all points


```r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color = "purple") +
 geom_smooth(se = FALSE)
```

![plot of chunk mpgEx7](assets/fig/mpgEx7-1.png)

---- .segue
# Can you guess how we would change the line color?

----


```r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color = "purple") +
 geom_smooth(se = FALSE, color = "gray", size = 2, linetype = "dashed")
```

![plot of chunk mpgEx8](assets/fig/mpgEx8-1.png)

----
Worth mentioning, traditional calls to line color/type/size also work


```r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color = "purple") +
 geom_smooth(se = FALSE, col = "gray", lwd = 2, lty = "dashed")
```

![plot of chunk mpgEx9](assets/fig/mpgEx9-1.png)

----
## Change the "wiggliness" of the smoother


```r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color = "purple") +
 geom_smooth(span = 0.2)
```

![plot of chunk mpgEx10](assets/fig/mpgEx10-1.png)

----
## Geoms for two continuous variables


|Geoms     |Description                                                              |Code             |
|:---------|:------------------------------------------------------------------------|:----------------|
|jitter    |Jitter points (to avoid overlapping)                                     |geom_jitter()    |
|point     |Plot points at each x&#124;y intersection                                |geom_point()     |
|quantile  |Plot lines from quantile regression                                      |geom_quantile()  |
|rug       |Plot 1d scatterplot on margins (stripchart)                              |geom_rug()       |
|smooth    |Plot a smoothing function (many smoothers available)                     |geom_smooth()    |
|text      |Add text annotations                                                     |geom_text()      |
|bin2d     |Bin observations that are close together and color according the density |geom_bin2d()     |
|density2d |Contour lines of the data density                                        |geom_density2d() |
|hex       |Hexagonal bins of data colored according to their density                |geom_hex()       |

----
## Guided practice
* Load (install first, if necessary) the *ggplot2* package. 
* Load the diamonds dataset with `data(diamonds)`
* Set and store the data and aesthetics, in an object `p`, using the following code


```r
p <- ggplot(diamonds, aes(carat, price))
```

* Explore different geoms, with `p + geom_XXX()`. For example, a basic scatterplot could be produced with


```r
p + geom_point()
```

* Add at least one additional layer (i.e., produce a plot with at least two layers)
* Modify the aesthetics to color the points by one of *cut*, *color*, or *clarity*. Store this in `p2`
* Play around and change some more colors, explore other variables, geoms, etc.


-----
## Some possibilities


```r
p + geom_point()
```

![plot of chunk guidedp1_3a](assets/fig/guidedp1_3a-1.png)

----
## Probably better


```r
p + geom_hex()
```

![plot of chunk guidedp1_3b](assets/fig/guidedp1_3b-1.png)

----
## Another similar alternative

```r
p + geom_bin2d()
```

![plot of chunk guidedp1_3c](assets/fig/guidedp1_3c-1.png)

----
## Yet another alternative


```r
p + geom_point(alpha = 0.01) + geom_density2d(color = "red")
```

![plot of chunk guidedp1_3d](assets/fig/guidedp1_3d-1.png)

----
## An alternative with base


```r
dens <- densCols(diamonds$carat, diamonds$price, 
  colramp = colorRampPalette(c("black", "white")))

cols <-  colorRampPalette(c("#000099", "#00FEFF", "#45FE4F", 
                            "#FCFF00", "#FF9400", "#FF3100"))(250)
diamonds$dens <- col2rgb(dens)[1,] + 1
diamonds$col <- cols[diamonds$dens]
diamonds <- diamonds[order(diamonds$dens),]
plot(price ~ carat, 
	 data=diamonds, 
	 pch=20, 
	 col=col, 
	 bty = "n",
	 xlim = c(0,5),
	 ylim = c(0, 20000))
```

----

![plot of chunk baseHDScatter](assets/fig/baseHDScatter-1.png)


----
## Add contour lines


```r
library(MASS)
zd <- na.omit(cbind(diamonds$carat, diamonds$price))
z <- kde2d(zd[ ,1], zd[ ,2], n=50)
contour(z, drawlabels=FALSE, nlevels=8, add=TRUE)
```

![plot of chunk contour2](assets/fig/contour2-1.png)



-----
## Quantiles
Defaults to the 25th, 50th, and 75th percentiles


```r
p + geom_quantile()
```

```
## Smoothing formula not specified. Using: y ~ x
```

![plot of chunk guidedp1_4](assets/fig/guidedp1_4-1.png)

-----
## Quantiles
Change the quantiles to deciles (from 10th to 90th)


```r
p + geom_quantile(quantiles = seq(0.1, 0.9, 0.1))
```

```
## Smoothing formula not specified. Using: y ~ x
```

![plot of chunk guidedp1_5](assets/fig/guidedp1_5-1.png)

----
## Add an extra layer


```r
p + geom_point() + geom_rug() + geom_smooth()
```

![plot of chunk guidedp1_6](assets/fig/guidedp1_6-1.png)

----
## Color by cut


```r
p2cut <- ggplot(diamonds, aes(carat, price, color = cut))
p2cut + geom_point()
```

![plot of chunk guidedp1_7](assets/fig/guidedp1_7-1.png)

----
## Color by color


```r
p2color <- ggplot(diamonds, aes(carat, price, color = color))
p2color + geom_point()
```

![plot of chunk guidedp1_8](assets/fig/guidedp1_8-1.png)

----
## Color by clarity


```r
p2clarity <- ggplot(diamonds, aes(carat, price, color = clarity))
p2clarity + geom_point()
```

![plot of chunk guidedp1_9](assets/fig/guidedp1_9-1.png)

----
## geoms: One variable


|Geoms                  |Description                                                |Code                    |
|:----------------------|:----------------------------------------------------------|:-----------------------|
|area                   |Filled area plot                                           |geom_area(stat = "bin") |
|density                |Density plot                                               |geom_density()          |
|dotplot                |Stacked dotplot, with each dot representing an observation |geom_dotplot()          |
|polygon of Frequencies |Polygon of frequencies                                     |geom_freqpoly           |
|histogram              |Standard histogram                                         |geom_histogram          |
|barplot                |Standard barchart                                          |geom_bar                |

----
## Area plot

```r
price <- ggplot(diamonds, aes(price)) 
price + geom_area(stat = "bin")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk geom_area](assets/fig/geom_area-1.png)

----
# Frequency polygons

```r
price + geom_freqpoly()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk geom_freqPoly](assets/fig/geom_freqPoly-1.png)

----
## Evaluate frequencies by *cut*


```r
price2 <- ggplot(diamonds, aes(price, color = cut))
price2 + geom_freqpoly(bins = 50)
```

![plot of chunk geom_freqPolyClarity](assets/fig/geom_freqPolyClarity-1.png)

----
## Histograms

```r
price + geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk geom_histogram1](assets/fig/geom_histogram1-1.png)

----
# Change binwidth

```r
price + geom_histogram(binwidth = 5)
```

![plot of chunk geom_histogram2](assets/fig/geom_histogram2-1.png)

----
## Barplots


```r
ggplot(mpg, aes(trans)) + geom_bar()
```

![plot of chunk barplot1](assets/fig/barplot1-1.png)

----
## Better: Tufte-esque
* Install and load the *ggthemes* package
* Add white horizontal lines at y-axis labels (via `geom_hline`)


```r
install.packages("ggthemes")
library(ggthemes)
ggplot(mpg, aes(trans)) + geom_bar(fill = "gray") + theme_tufte() + 
	geom_hline(yintercept = seq(20, 80, 20), col = "white")
```
(plot displayed on next slide)

----
![plot of chunk TufteBarplot2](assets/fig/TufteBarplot2-1.png)

---- .segue
# Plotting categorical variables

----
## boxplots
Note that the categorical variable must be categorical or declared as a factor


```r
bp <- ggplot(mpg, aes(drv, hwy))
bp + geom_boxplot()
```

![plot of chunk boxplots1](assets/fig/boxplots1-1.png)

---- &twocol
## stripcharts

*** =left


```r
bp + geom_point()
```

![plot of chunk stripcharts1](assets/fig/stripcharts1-1.png)

*** =right


```r
bp + geom_jitter()
```

![plot of chunk jitterchart1](assets/fig/jitterchart1-1.png)

-----
## Control the amount of jittering


```r
bp + geom_jitter(width = 0.3)
```

![plot of chunk jitter](assets/fig/jitter-1.png)

----
## Useful together


```r
bp + geom_boxplot() + geom_jitter(width = 0.3)
```

![plot of chunk boxplotJitter](assets/fig/boxplotJitter-1.png)

----
## Usually better: Violin plots


```r
bp + geom_violin()
```

![plot of chunk violin](assets/fig/violin-1.png)

---- .segue
# Modifying axes and labels

---- &twocol
## Changing labels

*** =left


```r
ggplot(mpg, aes(cty, hwy)) + geom_point()
```

![plot of chunk labels1](assets/fig/labels1-1.png)

*** =right


```r
ggplot(mpg, aes(cty, hwy)) + geom_point() +
	xlab("MPG (city)") +
	ylab("MPG (highway)")
```

![plot of chunk labels2](assets/fig/labels2-1.png)

----
## Adding a main title


```r
ggplot(mpg, aes(cty, hwy)) + geom_point() +
	xlab("MPG (city)") +
	ylab("MPG (highway)") + 
	ggtitle("Relation between city and highway miles per gallon")
```

![plot of chunk plotTitle](assets/fig/plotTitle-1.png)

----
## Alternative specification


```r
mpgHC <- ggplot(mpg, aes(cty, hwy)) + geom_point()
mpgHC + labs(title = "Relation between city and highway miles per gallon",
				x = "MPG (city)", y = "MPG (highway)")
```

![plot of chunk labs1](assets/fig/labs1-1.png)

----
## Labs also allows you to change legend names


```r
mpgHC2 <- ggplot(mpg, aes(cty, hwy, color = drv)) + geom_point()
mpgHC2 + labs(title = "Relation between city and highway miles per gallon",
				x = "MPG (city)", y = "MPG (highway)", color = "Drivetrain")
```

![plot of chunk labs2](assets/fig/labs2-1.png)

----
## Omit labels


```r
mpgHC2 + xlab(NULL) + ylab(NULL)
```

![plot of chunk labs3](assets/fig/labs3-1.png)

----
## Limit x-axis range


```r
mpgHC2 + xlim(15, 30)
```

```
## Warning: Removed 75 rows containing missing values (geom_point).
```

![plot of chunk limits1](assets/fig/limits1-1.png)

----
## Limit y-axis range


```r
mpgHC2 + ylim(20, 35)
```

```
## Warning: Removed 84 rows containing missing values (geom_point).
```

![plot of chunk limits2](assets/fig/limits2-1.png)


--- .segue
# Faceting

----
## Produce separate plots according to a specific variable
Back to the mpg dataset:
* Produce a separate plot of the relation between engine size and highway miles per gallon for each car type.


```r
hwy <- ggplot(mpg, aes(displ, hwy))
hwy + geom_point() + facet_wrap(~class)
```

![plot of chunk faceting1](assets/fig/faceting1-1.png)

----
## Add a linear function to each plot


```r
hwy <- ggplot(mpg, aes(displ, hwy))
hwy + geom_point() + geom_smooth(method = "lm") + facet_wrap(~class)
```

![plot of chunk faceting2](assets/fig/faceting2-1.png)

----
## Example with growth modeling
The data




```r
# Loaded earlier
head(d, n = 15)
```

```
##         SID   TID ScID    Months RIT
## 2873 332347 30867 1117 8.7387097 192
## 355  400047 69957 1077 1.6387097 182
## 387  400047 69957 1077 4.3225806 179
## 162  400047 69957 1077 8.9677419 191
## 648  400277 69957 1077 1.2053763 196
## 230  400277 69957 1077 4.3225806 197
## 780  400277 69957 1077 8.9677419 209
## 8878 400597 32247 1257 0.9720430 197
## 8914 400597 32247 1257 4.2258065 202
## 8790 400597 32247 1257 8.3053763 211
## 348  400807 28767 1077 1.3387097 178
## 168  400807 28767 1077 4.1935484 190
## 803  400807 28767 1077 8.8053763 178
## 1150 401227 32787 1087 0.9387097 187
## 1269 401227 32787 1087 4.1612903 192
```

----
## Random sampling
There are far too many students to plot every one. Instead, we'll take a random sample of 16 (a couple of times)


```r
set.seed(100)
samp1 <- d[d$SID %in% sample(levels(d$SID), 16), ]
samp2 <- d[d$SID %in% sample(levels(d$SID), 16), ]
samp3 <- d[d$SID %in% sample(levels(d$SID), 16), ]
head(samp1)
```

```
##         SID   TID ScID    Months RIT
## 2803 503177 30867 1117 1.1053763 198
## 2829 503177 30867 1117 4.3548387 202
## 2761 503177 30867 1117 8.7387097 214
## 9275 516037 34167 1267 0.9387097 214
## 9191 516037 34167 1267 4.1612903 205
## 9614 516037 34167 1267 8.5720430 209
```

----
## Sample 1

```r
ggplot(samp1, aes(Months, RIT)) + 
	geom_point() + geom_smooth(color = "red", span = 2, se = FALSE) +
	 facet_wrap(~SID)
```

![plot of chunk DissPLot1](assets/fig/DissPLot1-1.png)

----
## Sample 2

```r
ggplot(samp2, aes(Months, RIT)) + 
	geom_point() + geom_smooth(color = "red", span = 2, se = FALSE) +
	 facet_wrap(~SID)
```

![plot of chunk DissPLot2, ](assets/fig/DissPLot2, -1.png)

----
## Sample 3

```r
ggplot(samp3, aes(Months, RIT)) + 
	geom_point() + geom_smooth(color = "red", span = 2, se = FALSE) +
	 facet_wrap(~SID)
```

![plot of chunk DissPLot3, ](assets/fig/DissPLot3, -1.png)

----
## Alternative: Connect the dots
Note that `group` is specified in the aesthetic now.


```r
ggplot(samp1, aes(Months, RIT, group = SID)) + geom_point() + 
	geom_line()
```

![plot of chunk connectDots](assets/fig/connectDots-1.png)

----
Or, put all lines in a single plot


```r
ggplot(samp1, aes(Months, RIT, group = SID)) + geom_point() + 
	geom_smooth(se = FALSE, span = 2)
```

![plot of chunk smoothDots](assets/fig/smoothDots-1.png)

----
## What happens if you forget to specify the group?


```r
ggplot(samp1, aes(Months, RIT)) + geom_point() + 
	geom_line()
```

![plot of chunk connectDotsError](assets/fig/connectDotsError-1.png)

----
## How bad is the nonlinearity, really?
Overlay a linear trend


```r
ggplot(samp1, aes(Months, RIT)) + 
	geom_point() + geom_smooth(color = "red", span = 2, se = FALSE) +
	 geom_smooth(method = "lm", se = FALSE) + facet_wrap(~SID)
```

![plot of chunk DissPLot4](assets/fig/DissPLot4-1.png)

----

```r
ggplot(samp2, aes(Months, RIT)) + 
	geom_point() + geom_smooth(color = "red", span = 2, se = FALSE) +
	 geom_smooth(method = "lm", se = FALSE) + facet_wrap(~SID)
```

![plot of chunk DissPLot5, ](assets/fig/DissPLot5, -1.png)

----

```r
ggplot(samp3, aes(Months, RIT)) + 
	geom_point() + geom_smooth(color = "red", span = 2, se = FALSE) +
	 geom_smooth(method = "lm", se = FALSE) + facet_wrap(~SID)
```

![plot of chunk DissPLot6, ](assets/fig/DissPLot6, -1.png)

----
## A few notes
* Equivalent plots could be produced at other levels (in this case, the classroom or school levels)
* The previous plots did produce some warnings (only 3 points with the LOESS)


```r
lfit <- loess(RIT ~ Months, data = samp1, subset = SID == 503177, span = 2)
```

```
## Warning in simpleLoess(y, x, w, span, degree = degree, parametric =
## parametric, : span too small. fewer data values than degrees of freedom.
```

```
## Warning in simpleLoess(y, x, w, span, degree = degree, parametric =
## parametric, : Chernobyl! trL>n 3

## Warning in simpleLoess(y, x, w, span, degree = degree, parametric =
## parametric, : Chernobyl! trL>n 3
```

----
## Different faceting
`facet_wrap` vs `facet_grid`

![faceting](./assets/img/faceting.png)

----
## Options for `facet_wrap`
Change the number of columns


```r
f <- ggplot(mpg, aes(displ, hwy)) + geom_point()
f + facet_wrap(~class, ncol = 4)
```

![plot of chunk faceting3](assets/fig/faceting3-1.png)

----
Change the direction plots are produced


```r
f + facet_wrap(~class, ncol = 4, dir = "v")
```

![plot of chunk faceting4](assets/fig/faceting4-1.png)

----
## Facet Grid
Note that `.` must be included on the left, if only a single variable is used


```r
f + facet_grid(. ~ cyl)
```

![plot of chunk facetGrid1](assets/fig/facetGrid1-1.png)

----

```r
f + facet_grid(drv ~ .)
```

![plot of chunk facetGrid2](assets/fig/facetGrid2-1.png)

----
## Two variables


```r
f + facet_grid(drv ~ cyl)
```

![plot of chunk facetGrid3](assets/fig/facetGrid3-1.png)

----
## Two variables

(The LOESS estimator spits out warnings here again)


```r
f + geom_smooth(span = 2) + facet_grid(drv ~ cyl)
```

![plot of chunk facetGrid4](assets/fig/facetGrid4-1.png)

-----
## Scales with faceting
Allow all scales to be produced independently (freely)


```r
f + facet_wrap(~ cyl, scales = "free")
```

![plot of chunk facetScales1](assets/fig/facetScales1-1.png)

----
Free y-axis scale, fixed x


```r
f + facet_wrap(~ cyl, scales = "free_y")
```

![plot of chunk facetScales2](assets/fig/facetScales2-1.png)

----
Free x-axis scale, fixed y


```r
f + facet_wrap(~ cyl, scales = "free_x")
```

![plot of chunk facetScales3](assets/fig/facetScales3-1.png)

----
Change spacing with `facet_grid`


```r
f + facet_grid(drv ~ cyl, scales = "free", space = "free")
```

![plot of chunk facetGrid5](assets/fig/facetGrid5-1.png)

---- &twocol
## Faceting vs Grouping

*** =left


```r
ggplot(mpg, 
	aes(displ, hwy, color = factor(drv))) + 
	geom_point()
```

![plot of chunk facetGrouping1](assets/fig/facetGrouping1-1.png)

*** =right


```r
ggplot(mpg, aes(displ, hwy)) + 
	geom_point() + 
	facet_wrap(~ drv)
```

![plot of chunk facetGrouping2](assets/fig/facetGrouping2-1.png)

----
## Another option
Plot all the points on each plot in the background


```r
mpg2 <- mpg[ ,c("displ", "hwy")]

ggplot(mpg, aes(displ, hwy)) + 
	geom_point(data = mpg2, col = "gray80") + 
	geom_point(aes(color = drv)) +
	facet_wrap(~ drv)
```

![plot of chunk facetGrouping3](assets/fig/facetGrouping3-1.png)

----
## Guided practice

You can view the probability densities of diamond price by cut with the following code.


```r
base <- ggplot(diamonds, aes(price, color = cut))
base + geom_density()
```

* Use faceting to view the conditional densities by *clarity*.
* Modify the code to group by *clarity* and facet by *cut*. Which do you 
  prefer?

You can view the relation between *price* and *carat* with the following code


```r
ggplot(diamonds, aes(carat, price)) + geom_point()
```
* Modify the code so the points are colored according to their color.
* Use faceting to produce separate plots for each color.

----
Use faceting to view the conditional densities by *clarity*.


```r
base <- ggplot(diamonds, aes(price, color = cut))
base + geom_density() + facet_wrap(~ clarity)
```

![plot of chunk guidedp2_4](assets/fig/guidedp2_4-1.png)

----
Modify the code to group by *clarity* and facet by *cut*.


```r
base2 <- ggplot(diamonds, aes(price, color = clarity))
base2 + geom_density() + facet_wrap(~ cut)
```

![plot of chunk guidedp2_5](assets/fig/guidedp2_5-1.png)

----
Modify the code so the points are colored according to their color.


```r
ggplot(diamonds, aes(carat, price, color = color)) + geom_point()
```

![plot of chunk guidedp2_6](assets/fig/guidedp2_6-1.png)

----
Use faceting to produce separate plots for each color.


```r
ggplot(diamonds, aes(carat, price)) + geom_point() + facet_wrap(~ color)
```

![plot of chunk guidedp2_7](assets/fig/guidedp2_7-1.png)

---- .segue
# Themes

----
## Overview of themes
* Themes do not change how the data are rendered
* Only change visual properties
* Many built-in themes
	+ Even more available through extension packages (specifically *ggthemes*)
* Fully customizable (though the syntax becomes lengthier)

----
## theme_gray (default)


```r
baseP <- ggplot(economics, aes(date, unemploy)) + geom_line()
baseP + theme_gray()
```

![plot of chunk theme_gray](assets/fig/theme_gray-1.png)

----
## theme_bw


```r
baseP + theme_bw()
```

![plot of chunk theme_bw](assets/fig/theme_bw-1.png)

----
## theme_classic


```r
baseP + theme_classic()
```

![plot of chunk theme_classic](assets/fig/theme_classic-1.png)

----
## theme_dark


```r
baseP + theme_dark()
```

![plot of chunk theme_dark](assets/fig/theme_dark-1.png)

----
## theme_minimal


```r
baseP + theme_minimal()
```

![plot of chunk theme_minimal](assets/fig/theme_minimal-1.png)

----
## Some from the *ggthemes* packages
# theme_tufte


```r
# install.packages("ggthemes") # (stable) or
# devtools::install_github(""jrnold/ggthemes"") # (development)
library(ggthemes)
baseP + theme_tufte()
```

![plot of chunk theme_tufte](assets/fig/theme_tufte-1.png)

----
## theme_fivethirtyeight


```r
baseP + theme_fivethirtyeight()
```

![plot of chunk theme_fivethirtyeight](assets/fig/theme_fivethirtyeight-1.png)

----
## theme_stata


```r
baseP + theme_stata()
```

![plot of chunk theme_stata](assets/fig/theme_stata-1.png)

----
## theme_base


```r
baseP + theme_base()
```

![plot of chunk theme_base](assets/fig/theme_base-1.png)

----
## theme_solarized


```r
baseP + theme_solarized()
```

![plot of chunk theme_solarized](assets/fig/theme_solarized-1.png)

----
## theme_wsj


```r
baseP + theme_wsj()
```

![plot of chunk theme_wsj](assets/fig/theme_wsj-1.png)

----
## Further customization
(We're probably out of time, so...)
* See http://docs.ggplot2.org/dev/vignettes/themes.html
* See *ggplot2* book, Chapter 8

<br>
**Take Home Message:** If you want it to look a certain way, you can do it (essentially nothing is impossible). Often there are others who have developed themes that will be close to what you want, which is easier than developing your own theme (although that can be rewarding in its own right).

---- .segue
# At the edge of development

----
## ggvis
* Eventual replacement for *ggplot2*
* Currently fairly limited
	+ Can't produce interactive plots within something like this slideshow
Let's take a look! http://ggvis.rstudio.com/interactivity.html

----
## The *gganimate* extension to *ggplot2*

<video   controls loop><source src="assets/fig/gganimate1-.webm" /><p>video of chunk gganimate1</p></video>
**Credit:** David Robinson (http://varianceexplained.org/files/loess.html)


----
## What does LOESS (and LOWESS) stand for again?
* Locally weighted scatterplot smoothing
* non-parametric
* Similar in for to k-nearest neighbor models

Let's visualize it!

----
## Animating LOESS fits with different spans

<video   controls loop><source src="assets/fig/gganimate2-.webm" /><p>video of chunk gganimate2</p></video>
**Credit:** David Robinson (http://varianceexplained.org/files/loess.html)


----
## Other extensions

See https://www.ggplot2-exts.org/ggiraph.html
