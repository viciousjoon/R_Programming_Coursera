

#practice        
nums <- c(2,6,3,2,5,6)
dup <- numeric()
for (num in nums) {
        dup <- c(dup, num)
}

mean(data[['sulfate']], na.rm = TRUE)

#part 1 
pollutantmean <- function (directory, pollutant, id = 1:332) {
        filelist <- list.files(path = directory, pattern = ".csv",full.names = T)
        values <- numeric()
        
        for (i in id) {
                data <- read.csv(filelist[i])
                values <- c(values, data[[pollutant]]) 
        }
        mean(values, na.rm=T)
}

pollutantmean("/Users/Joon/Dropbox/R programming/week 1,2/specdata/","sulfate")
?list.files

#trying to change working directory 
getwd()
dir()
setwd("~/Dropbox/R programming/week 1,2/specdata")
dir()

# doing step 1 using working directory 
pollutantmean1 <- function (directory, pollutant, id = 1:332) {
        filelist <- list.files(path = ".", pattern = ".csv", full.name=F) #getting the name of the files. dont need to do full.name T                                                                                 here because we are working int he working directory. 
        values <- numeric()
        for (i in id) {
                data <- read.csv(filelist[i])
                values <- c(values, data[,pollutant]) #Error in data[["sulfate"]] : object of type 'closure' is not subsettable? when                                                         I tried to save source on save 
        }
        mean (values, na.rm=T)
}

pollutantmean1 (,"sulfate",) #why exclamation mark? 

filelist <- list.files(path = ".", pattern = ".csv", full.name=F)

#part 2
getwd()
setwd("~/Dropbox/R programming/week 1,2")
getwd() #be careful when you want to source on save... 
ls() #shows what data sets and functions a user has defined.  
dir()

data <- read.csv("specdata/001.csv")
complete.cases(data)
table(complete.cases(data))
sum(complete.cases(data)) 
filelist <- list.files(path = "specdata", pattern = '.csv',full.names = T)
length(filelist)
filelist[1]
read.csv(filelist[1])
complete.cases(read.csv(filelist[1]))
sum(complete.cases(read.csv(filelist[1])))

nobs <- numeric()
nobs <- c(nobs, sum(complete.cases(read.csv(filelist[1]))))
nobs
nobs <- c(nobs, sum(complete.cases(read.csv(filelist[2]))))
nobs #keep adding values to nobs vector

complete <- function(directory, id = 1:332) {
        filelist <- list.files(path = directory, pattern = '.csv',full.names = T)       
        nobs <- numeric()
        
        for (i in id) {
                data <- read.csv(filelist[i])
                nobs <- c(nobs, sum(complete.cases(data)))
        }
        data.frame(id,nobs)
}

complete(directory="specdata/",1)


complete1 <- function (directory, id = 1:332) {
        filelist <- list.files(path = directory,pattern = '.csv',full.names = T)        
        nobs <- numeric()
        for (i in id) {
                nobs <- c(nobs, sum(complete.cases(read.csv(filelist[i]))))  #why is this not working? we need to read data first? ->                                                                                 there was a problem with directory. 
        }
        data.frame(id,nobs)
}

complete1(directory="specdata/",c(1,5))
test<- complete1(directory="specdata/",)

#part 3 - my code (can't believe it is working...)
data[complete.cases(data)==T,]

corr <- function(directory,threshold = 0) {
        id = 1:332
        filelist <- list.files(path = directory,pattern = '.csv',full.names = T)
        nobs <- numeric()
        cr <- numeric()
        
        for (i in id) {
                data <- read.csv(filelist[i])
                data <- data[complete.cases(data)==T,]
                nobs <- c(nobs, sum(complete.cases(data)))
                cr <- c(cr,cor(x=data[['nitrate']],y=data[['sulfate']]))
                
        }
     cr_data <- data.frame(id,nobs,cr)
     cr_data$cr[cr_data$nobs>threshold] #i don't know how to avoid $ here yet. cr_data[[cr[cr_data$nobs>threshold]]] <- it does not work
cr_data[]        
}

#different way to do part 3 (from https://tomsihap.wordpress.com/2015/10/19/r-programming-course-assignment-1-air-pollution-part-3/comment-page-1/)
corr <- function(directory, threshold = 0) {
        id = 1:332
        filename <- list.files(directory, full.names = TRUE)
        
        result <-vector(mode="numeric", length=0)
        
        for(i in seq(filename)) {
                airquality <- read.csv(filename[i])
                good <- complete.cases(airquality)
                airquality <- airquality[good, ]
                if (nrow(airquality) > threshold) {
                        # We need [[]] around pollutant instead of [] since airquality["sulfate"]
                        # is a data.frame but we need a vector here. Hence, [[]]. Please note thatusing either
                        #[[]] or [] gives the same results as the test cases
                        correlation <- cor(airquality[["sulfate"]], airquality[["nitrate"]])
                        result <- append(result, correlation)
                        #print(correlation)
                }
        }
        result
}

c(n, round(cr[sample(n, 5)], 4))

#test part 3 : working great!!!!!!!!!
corr("specdata/",threshold = 100)
cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)

cr <- corr("specdata")
summary(cr)
length(cr)

#quiz
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

cr <- corr("specdata")                
cr <- sort(cr)   
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)    
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
