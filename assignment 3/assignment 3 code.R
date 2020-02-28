#trying to change working directory 
getwd()
dir()
setwd("~/Dropbox/R programming/week 1,2,3,4/assignment 3/rprog_data_ProgAssignment3-data/")
dir()

#clean global working environment
rm(list=ls())

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

#explore dataframe
head(outcome)
class(outcome)
summary(outcome)
str(outcome)
ncol(outcome)
names(outcome)

outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

#finding the best hospital in a state
best <- function(state, outcome) { 
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 
        fd <- as.data.frame(cbind (data[,2], #hospital name
                                          data[,7], #state
                                          data[,11], #heart attack mortality
                                          data[,17], #heart failure 30 day readmission
                                          data[,23]),
                                   stringsAsFactors = FALSE) # pneumonia 30 day mortality
        colnames(fd) <- c("hospital","state","heart attack","heart failure","pneumonia")
        ## Check that state and outcome are valid
        if (!state %in% fd[,"state"]) {
                stop('invalid state')
        } else if (!outcome %in% c("heart attack","heart failure","pneumonia")) {
                stop('invalid outcome')
        } else {
                si <- which(fd[,'state']==state)
                state_data <- fd[si,]
                state_outcome <- as.numeric(state_data[,eval(outcome)])
                min_val <- min(state_outcome,na.rm=TRUE)
                result <- state_data[,"hospital"][which(state_outcome==min_val)]
                output <- result[order(result)]
        }
        ## Return hospital name in that state with lowest 30-day death ## rate
        return(output)
}


best("SC", "heart attack")

#let's try my way
best2 <- function(state, outcome) { 
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 
        fd <- as.data.frame(cbind (data[,2], #hospital name
                                   data[,7], #state
                                   data[,11], #heart attack mortality
                                   data[,17], #heart failure 30 day readmission
                                   data[,23]),
                            stringsAsFactors = FALSE) # pneumonia 30 day mortality
        colnames(fd) <- c("hospital","state","heart attack","heart failure","pneumonia")
        ## Check that state and outcome are valid
        
        if (!any(fd['state']==state)) {
                 stop('invalid state')
        } else if (!any(colnames(fd)==outcome)) {
                stop('invalid outcome')
                
        } else {
                state_data <- fd[fd$state==state,]
                state_outcome <- suppressWarnings(as.numeric(state_data[,(outcome)]))
                min_val <- min(state_outcome,na.rm=TRUE)
                result <- state_data[which(state_outcome==min_val),'hospital']
                output <- result[order(result)]
        }
        ## Return hospital name in that state with lowest 30-day death ## rate
        return(output)
}
best2("SC", "heart attack")

#3 Ranking hospitals by outcome in a state
rankhospital <- function(state, outcome, rank = "best") { 
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 
        fd <- as.data.frame(cbind (data[,2], #hospital name
                                   data[,7], #state
                                   data[,11], #heart attack mortality
                                   data[,17], #heart failure 30 day readmission
                                   data[,23]),
                            stringsAsFactors = FALSE) # pneumonia 30 day mortality
        colnames(fd) <- c("hospital","state","heart attack","heart failure","pneumonia")
        
## Check that state and outcome are valid
          if (!any(fd['state']==state)) {
                         stop('invalid state')
                } else if (!any(colnames(fd)==outcome)) {
                        stop('invalid outcome')
                } else if (is.numeric(rank)) {
                        state_data <- fd[fd$state==state,]
                        state_outcome <- suppressWarnings(as.numeric(state_data[,(outcome)]))
                        fd1 <- state_data[order(state_outcome,state_data$hospital),]
                        output <- fd1[,"hospital"][rank]                                
                       
    } else if (!is.numeric(rank)){
        if (rank == "best") {
        state_data <- fd[fd$state==state,]
        state_outcome <- suppressWarnings(as.numeric(state_data[,(outcome)]))
        fd1 <- state_data[order(state_outcome),]
        output <- fd1[,"hospital"][1]   
        } else if (rank == "worst") {
        state_data <- fd[fd$state==state,]
        state_outcome <- suppressWarnings(as.numeric(state_data[,(outcome)]))
        fd1 <- state_data[order(state_outcome, state_data$hospital, decreasing = T, na.last = NA),]
        output <- fd1[,"hospital"][1]
        } else {
            stop('invalid rank')
        }
    }
return(output)
}
 
rankhospital("NC", "heart attack", "best")
rankhospital("NC", "heart attack", "worst")          
rankhospital("NC", "heart attack", "1")                   
rankhospital("NC", "heart attack", 4 )                   

#4 Ranking hospitals in all states (not my code, I was not able to understand 100%)
rankall <- function(outcome, num = "best") {
        ## Read outcome data
          data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
        ## Check that state and outcome are valid
          colIndex <- integer(0)
          if('heart attack' == outcome)
            colIndex <- 11
          else if('heart failure' == outcome)
            colIndex <-  17
          else if('pneumonia' == outcome)
            colIndex <- 23
          else {
            stop("invalid outcome")
          }
          
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
          ## Cast outcome column to numeric
          data[ ,colIndex] <- suppressWarnings(as.numeric(data[ ,colIndex]))
          ## Hospitals that do not have data on a particlar outcome chould be excluded
          data <- data[complete.cases(data), ]  
          ## Sort The hospitals, probably a Radix sort underneath 
          bestHospitals <- data[order(data$State, data[,colIndex], data$Hospital.Name), ]
         
          ##Find the levels, just for information, 7 being State
          statelevels <- factor(bestHospitals[ , 7])
        
          ranks <- list()
          if(num == "best") {
            ranks <- tapply(bestHospitals[['Hospital.Name']], statelevels, function(name) { return(name[1]) })
          }
          else if(num == "worst") {
            ranks  <- tapply(bestHospitals[['Hospital.Name']], statelevels, function(name) { return(name[length(name)]) })
          }
          else {
            ranks <- tapply(bestHospitals[['Hospital.Name']], statelevels, function(name) { return(name[num]) })
          }
          
          ##get the hospital name in the alphabetical order
          data.frame(hospital = ranks, state = names(ranks))
}

head(rankall("heart attack", 20), 10)

#quiz
best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")
rankhospital("NC", "heart attack", "best")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
rankhospital("NC", "heart attack", "worst")
