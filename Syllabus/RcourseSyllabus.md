---
title: "Data Processing, Analysis, and Visualization with R"
author: "Daniel Anderson, University of Oregon - College of Education"
output: pdf_document
---
The purpose of this course is to provide a basic foundation in programming with 
  R. The course has three main components, as the title suggests: data processing/munging/wrangling, basic analysis, and visualization. These three 
  components are routine in applied data analysis work. The focus will be on 
  working with and programming in R, as opposed to the specifics of any given 
  dataset/analysis. The course begins with a basic overview of the R syntax, 
  data structures, overview of object-oriented programming (OOP), and the use 
  and writing of functions, which are the heart of R. We apply these concepts 
  to process “messy” data into workable formats, and analyze the data. We use 
  data visualization to explore both raw data and the results of fitted models. 
  We will also go over the basics of writing an R package, specifically personal 
  R packages. We will be doing some very basic work with *git*, which is a
  version control software that can help when collaborating on code. You will
  also become familiar with *R Markdown*, which is pretty straightforward and is
  a great way to share snippets of code, put together a tutorial, or share the 
  results of an analysis with practitioners. I will be asking for assignments to
  be completed with R Markdown.

This class was constructed with the philosophy that the only way to truly learn 
  R and become proficient with it, is to dive in and practice, practice, 
  practice. Class sessions will be highly interactive. During class, I will be
  asking you to write code with me concurrently, independently other times, and 
  in small groups at other times. Weekly homeworks will also be assigned, which 
  are intended to be brief but get you more practice. These can be completed 
  independently or in small groups, and will be scored on a completion basis. 
  The term project requires you complete the three main components of the course
  described above with a "real" dataset. This can, again, be completed 
  independently or in small groups. I encourage you to find data that you are 
  actually interested in using. If you do not have access to data, please 
  contact me as soon as possible.

## Required Materials
Prior to the first class you should have the latest 
  version of R downloaded and installed on your computer, available through the 
  comprehensive R archive network (CRAN): https://cran.r-project.org. We will 
  be working with various packages as well, but these can be installed as we 
  work through the material. All readings will be provided as PDFs or are 
  freely available online. Please also download and install git: 
  https://git-scm.com/downloads. 

**Recommended Materials:** Prior to the first class, it is highly recommended
  that you spend some time exploring different text editors and/or integrated
  development enviornments (IDEs) for R. I use Sublime Text 
  (http://www.sublimetext.com) which has some really nice features and, to me, 
  is very aesthetically pleasing. By far the most popular IDE is RStudio, which
  is being actively developed and has numerous plugin-like features that make
  many tasks simpler. Most of this is just personal preference. The built in 
  editor for Mac is also pretty nice, but on the Windows side is about as basic
  as can be. Getting a text editor/environment that you feel comfortable with 
  can really ease the process.

**Resources:** One of the great things about R is that it is open-source. Like
  many open-source platforms, there is a tremendous community behind it. Online
  forums can be a great place to find answers to specific problems (e.g., 
  http://stackoverflow.com/questions/tagged/r). There are also lots of sites
  that give basic tutorials (e.g., 
  http://www.statmethods.net/interface/help.html). UCLA has also listed a set of 
  resources that may be helpful (http://www.ats.ucla.edu/stat/r/). In this 
  course, we will primarily rely on the following resources
    * Kabacoff, R, I. (2011). *R in Action: Data analysis and graphics with R*. 
      Shelter Island, NY: Manning Publications.
    * Wickham, H. (2015). *Advanced R*. Available online 
      at http://adv-r.had.co.nz


## Course Website
All the code for this course, as well as lectures and course readings, will be 
  available in a github repository (https://github.com/DJAnderson07/Rcourse). 
  This is where the basic work with git will come in, as I'll be asking you to
  clone the repository onto your local machine and update it periodically as I 
  push new content into the repository.

## Course Objectives
Upon completion of this course, the succeffus student will:
  1. Understand the foundations of the R environment (i.e., OOP, functions, 
       data structures, etc.).
  2. Understand and be able to work efficently with different data types (i.e.,
       string, numeric, integer, factor).
  3. Be able to read various data into R from various sources (e.g., .csv, .sav,
       .txt, etc.) and prep the data for analysis.
  4. Understand the basic structure of plotting with the base graphics and the
      *ggplot2* package.
  5. Be able to conduct basic analyses (e.g., simple and multiple linear 
       regression, basic varying intercept models, etc.) with R, and explore the
       fitted model through visualizations.

## Course Schedule
  **Week 1: Getting Started Introduction and overview of the R environment**  
  * Objectives
    + Clone course github repository
    + Get a text editor or IDE for R
  * Topics
    + Objects in R
    + Reading data into R
    + R packages
    + Getting help
    + The grammar of syntax
    + Introduction to *R Markdown* & *git* 
  * Readings
    + R Markdown
        - http://R Markdown.rstudio.com
        - http://R Markdown.rstudio.com/authoring_basics.html
        - http://R Markdown.rstudio.com/authoring_rcodechunks.html
    + Kabacoff: Chapter 1
  * Homework
    + Creating an *R Markdown* document
  
**Week 2: Data structures (part 1)**

  * Topics
    + Data frames, Matrices, Arrays, Vectors, Scalars
    + Matrix algebra versus element-wise algebra
    + Subsetting
    + Kabacoff: Chapter 2

**Week 3: Data structures (part 2) & routine functions**
  * Topics
    + Lists
    + Data frames as a special type of list
    + Recycling
  * Readings
    + Wickham (http://adv-r.had.co.nz/Data-structures.html)

**Week 4: Functions**

  * Topics
    + Components
  * Readings
    + Wickham (http://adv-r.had.co.nz/Functions.html)

**Week 5: Loops**

  * Topics
    + Apply family
    + For loops

**Week 6: Transforming data**

  * Topics
    + Recoding variables
    + 

## Homeworks
Homeworks are worth 10 points each (100 points total), and are graded on a 
  completion basis. As long as you address each part of each homework, you will 
  get full credit (regardless of correctness). Below is an overview of the
  required homeworks, numbered by week:
  1. Creating an R Markdown document
    * The purpose of this homework is to get you some basic familiarity with 
      *R Markdown*. To receive full credit create and render an *R Markdown* 
      document in html or pdf format that has the following elements.
      - Title
      - Author
      - date
      - an R code chunk displaying how to load data into R and store it into an
        object
      - A generic bulletted or numbered list of some sort (could even be a 
        shopping list)
      - Some R output of some sort.
  2. 

## Final Project



