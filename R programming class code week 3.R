library(swirl)

swirl()

install.packages("swirl", dependencies=TRUE)

#week 3 quiz
library(datasets)
data("iris")
?iris

#1
tapply(iris$Sepal.Length, iris$Species, mean)

#2
str(iris)
summary(iris)
head(iris)
dim(iris)

#3 
library(datasets)
data("mtcars")
?mtcars

head(mtcars)
with(mtcars,tapply(mpg,cyl,mean))
sapply(split(mtcars$mpg,mtcars$cyl),mean)
tapply(mtcars$mpg,mtcars$cyl,mean)

split(mtcars,mtcars$cyl)

#4
mean(mtcars$hp[mtcars$cyl=="4"])-mean(mtcars$hp[mtcars$cyl=="8"])

debug(ls)

#project 2 example
makeVector <- function(x = numeric()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        list(set = set, get = get,
             setmean = setmean,
             getmean = getmean)
}

