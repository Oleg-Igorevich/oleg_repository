# Working Directories -----------------------------------------------------

getwd()
setwd("C:/Users/O/Desktop/R")

https://github.com/Oleg-Igorevich/oleg_repository.git

# Git ---------------------------------------------------------------------

#   https://github.com/Oleg-Igorevich/oleg_repository.git

# the following commands should be run in the terminal:
#   git clone [paste link to online repository] <- creates a copy of the
#                                                  repository folder locally
#   cd                                          <- shows your current repository
#   cd [name of repository]                     <- sets repository to stated location
#   git add -A                                  <- essentially, says that all changes
#                                                  will be committed (-A stand for all)
#   git commit -m "type a message here"         <- saves commit locally 
#   git push                                    <- pushes commit to online copy
#                                                  of the repository
#   git pull                                    <- pulls the most recent version of the repository

# MATRIX creation ---------------------------------------------------------

m1 <- matrix(1:8, nrow = 2, ncol = 4)
View(m1)

m2 <- c(1:8)
dim(m2) <- c(2, 4)
m2

v1 <- c(1:4)
v2 <- c(3:6)

m3 <- cbind(v1, v2)
m4 <- rbind(v1, v2)

# Reading/Writing tabular data --------------------------------------------

# read.table
#   file <- the name of a file or a connection
#   hear <- logical, indicates if file has header
#   sep <-  string, indicates how columns are separated
#   colClasses <- character vector, indicates class of each column in the dataset
#   nrows <- number of rows in the dataset
#   comment.char <- character string, indicates comment character
#   skip <- number of lines ot skip from the beginning
#   stringsAsFactors <- should character variables be coded as factors?
# NB: R will automatically
#   skip lines that begin with a #
#   figure out how many rows there are (and how much memory needs to be allocated)
#   figure what type of var. is in each column of table
#       NB2: telling R all these things directly will makes it run faster/more efficiently
#   For reading in Larger Dataset, study help page for function carefully
#     - make a rough calculation of memory required to store your dataset
#     - save space by setting comment.char = "" if there are no commented lines in your file
#     - use the colClasses argument. This can make function up to 2x faster.
#       - but to do this, you need know the calss of each column in data frame
#       - e.g. all columns numeric, so colClasses = "numeric"
#       - to quickly figure out classes of each column:
#         - initial <- read.table("datatable.txt", nrows = 100)
#         - classes <- sapply(initial, class)
#         - tabAll <- read.table("datatable.txt", colClasses = classes)
# OOOOOH, and the math now!
# e.g. 1,500,000 rows; 120 columns
# 1,500,000 * 120 * 8 bytes/numeric
# = 1440000000
# = 1440000000 / 2^20 bytes/MB
# = 1373.29 MB
# = 1.34 GB + a bit more overhead...usally need about 2x, so need 2.7 GB...


# read.csv
#   read.csv is identical to read.table, except that default separator is comma instead of space
#   read.csv always defaults to header = T

# write.table

# Reading/writing lines of a text file
# readLines
# writeLines

# Reading/writing in R code files -----------------------------------------

# dump and dput as methods to output data are textual format functions
# textual formats are edit-able and, sometimes, recoverable when corruption!
# preserve the metadata (sacrificing some readability), so that it doesn't need to be respecified

# dput
# dget
y <- data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")

# dump is similar to dput, but can be used to save multiple objects
# dump
# source
x <- "foo"
y <- data.frame(a = 1, b = "a")
dump(c("x", "y"), file = "data.R")
rm(x, y)
source("data.R")

# Reading/writing in saved workspaces
# load
# save

# Reading/writing single R objects in binary form
# unserialize
# serialize


# Inerfaces to the Outside World ------------------------------------------

# file <- opens a connection to a file
str(file)
#         description is the name of the file
#         open is a code that indicates
#           r <- read only
#           w <- writing (and initializing a new file)
#           a <- appending
#           rb, wb, ab <- reading, writing, appending in binary mode (Windows)

# gzfile <- opens a connection to a file compressed with gzip algorithm
# bzfile <- opens a connection to a file compressed with bzip2 algorithm
# url <- opens a conenction to a webpage

# e.g.
# con <- file("foo.txt", "r")
# data <- read.csv(con)
# close(con)
# above three lines do the same as
# data <- read.csv("foo.txt")
# so, not really a good case for using connection
#   in other cases useful to read parts of a file
# con <- gzfile("words.gz")
# x <- readLines(con, 10)
# writeLines takes a character vector and writes each element one line at a time to a text file
# readLines can be used, in combination with url(), to reading in lines from webpages

con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)


# Subsetting --------------------------------------------------------------

# number of operators can be used to extract subsets of R objects
# [ always returns object of same class; can select more than one element (one exception)
# [[ used to extract elements of a list or data frame; can be used to extract
#   single element and class of returned object need not be a list or data frame
# $ used to extract elements of a list or data frame by name
x <- c("a", "b", "c", "d", "e", "f", "g")
x[1]
x[2]
x[1:4]
x[x > "a"] # relies of lexigraphical order - ooh-la-la
u <- x > "a"
u
x[u]


# Subsetting Lists --------------------------------------------------------

x <- list(foo = 1:4, bar = 0.6)
x[1]
# returns a list that contains a single element $foo, which is a sequence of 1:4
x[[1]]
# get back a sequence of 1:4 - so list vs. just sequence <- [] vs [[]]
x$bar
x[["bar"]]
x["bar"]

x[c(1, 2)]
x[(1:2)]
# so, can't use double-bracket or $ to extract multiple elements of a list
# BUT
# double-bracket can be used with computed indices
name <- "foo" 
x[[name]] ## computed index for 'foo'
x$name ## element 'name' doesn't exist...
x$foo ## element 'foo' does!
# double-bracket can take an integer sequence
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 1)]]
x[[c(1, 2)]]
x[[c(1, 3)]]
x[[1]][[3]]
x[[c(2, 1)]]
x[[c(1, 2)]]


# Subsetting Matrices -----------------------------------------------------

x <- matrix(1:6, 2, 3)
x[1, 2]
x[1, 2, drop = FALSE]
x[2, 1]
x[1, ]
x[, 1]
x[1, ]
x[1, , drop = F]


# Subsetting - Partial Matching -------------------------------------------

x <- list(aardvark = 1:5)
x$a
# in the above case, the $ looks for a name that matches the first element specified
# BUT
x[["a"]]
# double-bracket doesn't do partial matching
# but there is a secondary argument
x[["a", exact = FALSE]]


# Removing NA Values ------------------------------------------------------

x <- c(1, 2, NA, 4, NA, 5)
# create logical vector that tells you where the missing values are
bad <- is.na(x)
x[!bad]
# ! is "bang operator"
# multiple objects with missing values:
x <- x
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
x[good]
y[good]

z <- c(4, 5, 8, 6, 7, 9)

m1 <- cbind(x, z)
m1
good <- complete.cases(m1)
good
m1[good, ][1:3, ]
# erm ok...
# QUESTION what if one wants to see complete columns instead of rows tho?


# Vectorized Operations ---------------------------------------------------

# things can happen in parallel when computing

x <- 1:4; y <- 6:9
x + y
x > 2
x >= 2
y == 8
x * y
x / y

x <- matrix(1:4, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x
y
# element-wise multiplication and division
x * y
x / y

x %*% y # true matrix multiplication - muah-ha-ha

# vectorized operations allow one to avoid the use of for-loops


# QUIZ 1 ------------------------------------------------------------------

# 1) R was developed by statisticians working at: The University of Auckland

# 2) the definition of free software includes
# The freedom to run the program as you wish, for any purpose (freedom 0).
# The freedom to study how the program works, and change it so it does your computing as you wish (freedom 1). Access to the source code is a precondition for this.
# The freedom to redistribute copies so you can help your neighbor (freedom 2).
# The freedom to distribute copies of your modified versions to others (freedom 3). By doing this you can give the whole community a chance to benefit from your changes. Access to the source code is a precondition for this.
# AND EXCLUDES
# The freedom to improve the program, and release your improvements to the public, so that the whole community benefits.
# The freedom to prevent users from using the software for undesirable purposes.
# The freedom to sell the software for any price.
# The freedom to restrict access to the source code for the software.

# 3) R has the following five atomic data types:
# character
# numeric (real numbers)
# integer 
# complex
# logical (True/False)

# NON ATOMIC
# array
# list
# data frame
# table
# matrix

# 4) x <- 4 produces str(x) is numeric

# 5) x <- c(4, "a", TRUE) ## defaults to the lowest common denominator, character

# 6) if x <- c(1, 3, 5) and y <- c(3, 2, 10), then rbind(x, y) produces a 2x3 matrix

# 7) key property of vectors in R is that: elements of a vector all must be of the same class

# 8) if x <- list(2, "a", "b", TRUE), the x[[1]] produces: numeric vector containing the element 2

# 9) if x <- 1:4 and y <- 2, then x + y produces: a numeric vector with elements 3, 4, 5, and 6

# 10) have x <- c(3, 5, 1, 10, 12, 6) and want to set all elements of this vector
#     that are less than 6 to be equal to zero, what's the code?
x <- c(3, 5, 1, 10, 12, 6)
x[x < 6] <- 0
x

# 11) 
# zippydidoo <- "https://d396qusza40orc.cloudfront.net/rprog/data/quiz1_data.zip"

quizfile <- read.csv("hw1_data.csv")

head(quizfile)
# Ozone, Solar.R, Wind, Temp, Month, Day

# 12)
quizfile[1:2, ]

# 13)
length(quizfile[, 1])
# 153

# 14)
quizfile[152:153, ]
# QUESTION is there a way to cite the last row directly?

# 15) 
quizfile[47, "Ozone"]
quizfile[47, 1]
# 21

# 16) 
liamneesonsmissingdaughter <- is.na(quizfile[, 1])
liamneesonsmissingdaughter
sum(liamneesonsmissingdaughter)
# 37

# 17)
mean(quizfile$Ozone, na.rm = T)
# roughly 42.1
mean(quizfile$Ozone)
# ooops

# 18)
q18subset <- quizfile[quizfile$Ozone > 31 & quizfile$Temp > 90, ]
mean(q18subset$Solar.R, na.rm = T)
# 212.8

# 19) 
q19subset <- quizfile[quizfile$Month == 6, ]
mean(q19subset$Temp, na.rm = T)
# 79.1
# OR
mean(quizfile[quizfile$Month == 6, ]$Temp, na.rm = T)

# 20)
max(quizfile[quizfile$Month == 5, ]$Ozone, na.rm = T)
# 115

# AH...crap...can't get the...marks


# Week 2 ------------------------------------------------------------------

# control structures allow for control of the flow of execution of a program

# if, else: testing a condition
# for: execute a loop a fixed number of times
# while: execute a loop WHILE a condition is true
# repeat: execute an infinite loop
# break: break the execution of a loop
# next: skip an iteration of a loop
# return: exit a function


# IF ----------------------------------------------------------------------

if(<condition>) {
  ## do something
  
} else {
  ## do that other thing, ok?
}

if(<condition 1>) {
  ## do something
} else if (<conditon 2>) {
  ## do something else
} else {
  ## do that other thing, ok?
}


# FOR ---------------------------------------------------------------------

# most basic
for(i in 1:10) {
  print(i)
}

# four ways of making the same for loop

x <- c("a", "b", "c", "d")

for(i in 1:4) {
  print(x[1])
}

for(i in seq_along(x)) {
  print(x[i])
}

for(letter in x) {
  print(letter)
}

for(i in 1:4) print(x[i])

# for loops can be nested!

x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}

# Meanwhile, WHILE LOOPS --------------------------------------------------

count <- 0

while(count <- 10) {
  print(count)
  count <- count + 1
}


z <- 5

while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5)
  
  if(coin == 1) { ## random walk
    z <- z + 1
  } else {
    z <- z - 1
  }
}


# REPEAT NEXT BREAK -------------------------------------------------------

# repeat initiates an infinite loop; these are not commonly used in statistical
# applications but they do have their uses.
# the only way to exit a "repeat" loop is to call "break"

x0 <- 1
tol <- 1e-8

repeat{
  x1 <- computeEstimate()
  
  it(abs(x1 - x0) < tol) {
    break
  } else {
    x0 <- x1
  }
}

# PROBLEM: the above loop may not stop, potentially.
# best to set a hard limit on the number of iterations
# then report whether convergence was achieved or not

 # "next" is used to skip an iteration
 
for(i in 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next
  }
  ## do something here
}

# "return" signals that a function should exit and return a given value

# generally, "if, while, for" aren't great in a console setting
# BUT "apply" functions are handy for command-line interactive work


# FUNCTIONS! --------------------------------------------------------------

add_two <- function(x, y) { ## don't forget to specify the arguments!
  x + y
}

above_10 <- function(x) {
  use <- x > 10
  x[use]  ## returns the subset of x that is above 10
}

above <- function(x, n) {
  use <- x > n
  x[use]
}

x <- 1:20

above(x, 12)

above(x)
# oops, n?

# let's specify a default value for n

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}

above(x)

# ta-da!

columnmean <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc) {
    means[i] <- mean(y[, i], na.rm = removeNA)
  }
  means
}

# air quality data set...

columnmean(airquality)

#

# Week 2 Continued - 2019-07-31 -------------------------------------------

# created using 'function()' "directive"
# stored as R objects - class 'function'
# first class objects - i.e. can be treated like any other R object
# can be passed as 'arguments' to other functions - important for statistics
# can be 'nested' - i.e. can define a function inside of another function...inside of another function...inside of another function...
# 'return' value of a function is the last expression in the function body to be evaluated
# have 'named arguments' that often have 'default values'
#   'formal arguments' are included in the function defenition
#   'formals' function returns a list of all the formal arguments of a function
#   not every function call in R makes use of all the formal arguments of a function
#   function arguments can be 'missing' or might have default values

# R functions arguments can be matches positionally or by name
#   following calls to 'sd' are all equivalent
mydata <- rnorm(100) ## 100 random observations following normal distribution
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata) ## these changes to the argument order are
sd(na.rm = FALSE, mydata) ## technically not a problem, but confusing to read

# Mixing 'positional' matching and matching 'by name'
# by default, the argument list of a function dictates the order in which arguments are to be entered
args(lm)
lm(y ~ x, thedata, 1:100, model = FALSE)

# but, specifying an argument by name pulls it out of the default order
lm(data = thedata, y ~ x, model = FALSE, 1:100)

# above two lm() are identical in function

# some arguments NEED to be specified because do not have default values
# e.g. 'data' argument

# lm

# Defining a Function -----------------------------------------------------

# e.g.
f <- function(a, b = 1, c = 2, d = NULL) {
  theThing <- a * b + 2 + d
  return(theThing)
}
# notice difference between a and d ...
# functionally, can't run above function without specifying a
#     ... but also can't run without specifying d, because get numeric(0)...

# arguments are evaluated "lazily"...i.e. only as needed

f2 <- function(a, b) {
  a ^ 2
}

f2(2)
# b is included in function argument list but not the function itself, so...
#     no worries about b, because 2 is just positionally matched to a!

f3 <- function(a, b) {
  print(a)
  print(b)
}

f3(45)
# prints out 45, but when it hits 'print(b)', error message comes up


# THE ... -----------------------------------------------------------------

# USE CASE 1
# '...' is used when extending another function to avoid copying entire argument list of original
myplot <- function(x, y, type = "1", ...) {
  plot(x, y, type = type, ...)
}

# in the above case, it carries over the unspecified remainder of the plot()
#   function's argument list

# USE CASE 2
# passing extra arguments to methods with generic funcitons (?), but more on this later

# USE CASE 3

# some functions, e.g. paste() and cat(), can operate with a variable number of arguments
# when you don't know the number of arguments in advance, can also use '...'
args(paste)
args(cat)

# THE CATCH
# any arguments that appear after the '...' must be named explicitly
#     these cannot be partially matched or positionally matched

paste("a", "b", sep = ":")
paste("a", "b", se = ":")


# SCOPING -----------------------------------------------------------------

lm <- function(x) {x * x}
lm

# lm is a default function in R
# above example assigns a new function to 'lm'
# how does R decide whether you mean the linear-model lm or the x * x lm?
#     R binds value to a symbol
#     searches through a series of 'environments' to find match
#     generally, in command line, the search order is
#         1. search global environment
#         2. search namespaces of each of the packages on search list
# search list is found by
search()

# Order of search packages matters!
#     by default, global environment or user's workspace is always first element of search list
#     'base' package is always the last
#     User can configure which packages get loaded on startup
#     loading a package with 'library' puts the namespace of that package on the searchlist
#     e.g.
library(dplyr)
search()
# note, dplyr is now second in list, boom

# NOTE: R has separate namespaces for functions and non-functions
#   therefore, possible to have an object named c, and function named c

# scoping rules of R are the main features that distinguish it from the original S language
#   scoping rules determing how a value is associated with a free variable in a function
#   R uses 'lexical scoping' and 'static scoping'
#       a common alternative is 'dynamic scoping'
#   related matter is how R uses the search 'list' to bind a value to a symbol
#   lexical scoping cool for statistical computations

# example
f <- function(x, y) {
  x ^ 2 + y / z
}

# two formal arguments, x and y
#   z is a "free variable"
#     scoping rules of a language determine how values are assigned to free variables
#     free variables are neither formal arguments, nor local variables
#       local variables are ones assigned inside the function body

# LEXICAL SCOPING IN R
#   ok, "the values of free variables are searched for in the environment,
#   in which the function was defined."

# ok...what's an environment?
#   collection of (symbol, value) pairs, e.g. symbol x with a value of 3.14
#   every environment has a parent environment
#   possible for an environment to have multiple "children"
#   only environment without parent is 'the empty environment'
#   function + an environment = a closure (or function closure)

# if value of symbol is not found in environment where function is defined
#   the search is continued in the 'parent environment'
#   search continues down the sequence of parent environments
#   eventually, gets to 'top-level environment'
#     usually this is the 'global environment' (aka, the workspace)
#     OR the namespace of a package
#   after 'top-level' search continues down the search list until
#     arrive at empty environment (after the base package)
#     ...at which point an error occurs

# What is the point of all of this?
#   typically, functions defined in global environment
#     the values of free variables, then, are drawn from the user's workspace
#   BUT, can define functions inside of functions inside of functions inside of fun...
#     (some languages *cough* C *cough* can't do this...)
#     In this scenario, the body of a function in which another is defined,
#     becomes the latter's environment

make.power <- function(n) {
  pow <- function(x) {
    x ^ n
  }
  pow
}

cube <- make.power(3)
square <- make.power(2)
cube(2)
square(2)

# make.power is a "constructor" function...you use it to make other functions

# What's in a function's environment?

ls(environment(cube))
get("n", environment(cube))

ls(environment(square))
get("n", environment(square))
get("pow", environment(square))


# Lexical vs. Dynamic Scoping ---------------------------------------------

y <- 10

f <- function(x) {
  y <- 2
  y ^ 2 + g(x)
}

g <- function(x){
  x * y
}

f(3)

# g(x), because defined in the global environment, takes the value of y
#   ...from the global environment, i.e. y == 10

# f(x), in it's own environment, re-assigns value of y, so y == 2
#   but! because g(x) is, effectively, a "free variable,"
#   it still retains y == 10 when f(x) pulls x == 3 through it
#     so, ultimately, as far as f(x) is concerned, g(x) == 3 * 10 == 30

# the above is how it works in lexical scoping, 
#   functions are looked up in the environment where they are created
# in dynamic scoping, value of y is looked up in the environment where it's called
#   so, it would be y == 2, instead of y == 10

# in R, the "calling environment" (where a function is called),
# is known as "the parent frame"

# creating and then calling a function in the global environment can create the illusion of dynamic scoping
# e.g.
g <- function(x) {
  a <- 3
  x + a + y
}

g(2)
y <- 3
g(2)

# erm...ok


# CONSEQUENCES OF LEXICAL SCOPING -----------------------------------------

# all objects must be stored in memory
# all functions must carry a pointer to their respective defining environments
# in S-PLUS, free variables are always looked up in the global workspace
#   everything can be stored on the disk


# Assignment 1 ------------------------------------------------------------


specdata <- "C:/Users/O/Desktop/R/oleg_repository/specdata"

# PART 1

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the results!
  
  the_files <- list.files(path = directory, 
                    pattern ="*.csv",
                    full.names = TRUE)
  
  the_values <- numeric()
  
  for (i in id) {
    the_data <- read.csv(the_files[i])
    the_values <- c(the_values, the_data[[pollutant]])
  }
  
  mean(the_values, na.rm = T)
}
  
# Testing Results:

pollutantmean(specdata, "sulfate", 1:10)
# 4.064128

pollutantmean(specdata, "nitrate", 1:10)
# 0.7976266

pollutantmean(specdata, "nitrate", 70:72)
# 1.706047

pollutantmean(specdata, "nitrate", 23)
# 1.280833

# taking it apart:

the_files <- list.files(path = specdata, 
                       pattern ="*.csv",
                       full.names = TRUE)

the_values <- numeric()

for (i in 1:10) {
  the_data <- read.csv(the_files[i])
  the_values <- c(the_values, the_data[["sulfate"]])
}

mean(the_values, na.rm = T)


# PART 2

# NEED to: read directory full of files
#          report the number of complete observed cases in each data file
#          return a dataframe where first column is the name of the file
#          second column is the number of complete cases

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1 117
  ## 2 1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the 
  ## number of complete cases
  the_files <- list.files(path = directory, 
                         pattern ="*.csv",
                         full.names = TRUE)
  
  nobs <- numeric()
  
  for (i in id) {
    the_data <- read.csv(the_files[i])
    nobs <- c(nobs, sum(complete.cases(the_data)))
  }
  data.frame(id, nobs)
}

# Testing Results:

complete(specdata, 1)
# yup.

complete(specdata, c(2, 4, 8, 10, 12))
# yup.

complete(specdata, 30:25)
# yup...wait, what?
complete(specdata, 25:30)
# ohhhh, yup.

complete(specdata, 3)
# yup.

# QUESTION: why does the test file successfully seem to run
complete("specdata", 3)
# while I get an error?

# PART 3

corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
  
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed cases (on all variables)
        ## required to compute the correlation between
        ## nitrate and sulfate; the default is 0
  
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
  the_files <- list.files(path = directory, 
                         pattern ="*.csv",
                         full.names = TRUE)
  
  the_correlations <- vector()
  
  for (i in 1:332) {
    the_data <- read.csv(the_files[i])
    the_data <- the_data[complete.cases(the_data), ]
    if(nrow(the_data) > threshold) {
    the_correlations <- c(the_correlations, 
                          cor(the_data[, "sulfate"], 
                              the_data[, "nitrate"]))
    }
  }
  return(the_correlations)
}

# Ok, so to debug

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed cases (on all variables)
  ## required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  # browser()
  
  the_files <- list.files(path = directory, 
                          pattern ="*.csv",
                          full.names = TRUE)
  
  the_correlations <- vector()
  
  for (i in 1:332) {
    the_data <- read.csv(the_files[i])
    the_data <- the_data[complete.cases(the_data), ]
    if(nrow(the_data) > threshold) {
      the_correlations <- c(the_correlations, 
                            cor(the_data[, "sulfate"], 
                                the_data[, "nitrate"]))
    }
  }
  return(the_correlations)
}

