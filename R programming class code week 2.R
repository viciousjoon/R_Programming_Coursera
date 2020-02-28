
# if
if (x>3) {
  y <- 10
} else {
  y<-0
}
#this one works too
y<- if (x>3) {
  10
} else {
  0
}

#for loop 
for (i in 1:10) {
  print (i)
}

x <- c("a",'b','c','d')
for(i in 1:4) {
  print(x[i])
}
for (i in seq_along(x)) {
  print (x[i])
}
?seq_along
for (letter in x) {
  print(letter)
}

#nested for loops
x <- matrix (1:6,2,3)
x
for(i in seq_len(nrow(x))) {
  for (j in seq_len(ncol(x))) {
    print (x[i,j]) 
  }
} # why 1,1 1,2 1,3 ? difficult to understand...

x <- matrix (1:6,2,3)
x
for(i in seq_len(nrow(x))) {
    print (x[i,1])
}

#while loop
count <-0 
while (count<10) {
  print(count)
  count <- count + 1
}

  z<- 5
  while(z>=3 && z<=10) {
    print(z)
    coin <- rbinom(1,1,0.5)
    if (coin ==1) {
      z<-z+1
    } else {
      z <- z-1
    }
  }

  #repeat loops  <- hard to understand...
  x0 <- 1
  tol <- 1e - 8 
  repeat {
    x1 <- computeEstimate() #this is not a real function 
    if (abs(x1-x0)<tol) {
      break
    } else {
      x0 <- x1
    }
  }
  
  #next, return
  for(i in 1:100) {
    if(i<=20) {
      next
    }
    print (i)
  }
  
  #function
  add2 <- function(x,y) {
    x+y
  }
  
  above10 <-function(x) {
    use <- x>10
    x[use]
  }
  
  above1 <- function(x,n) {
    use <- x>n
    x[use]
  }
  
  columnmean <- function(y, removeNA=TRUE) {
    nc <-ncol(y)
    means <- numeric (nc)
    for (i in 1:nc) {
      means[i] <- mean(y[,i], na.rm=removeNA)
    }
    means
  }
  columnmean(airquality)
  
#remove environment  
remove(list=ls())

#functions
f <- function (num) {
  hello <- "hello, world!\n"
  for (i in seq_len(num)) {
    cat (hello)
  }
  chars <- nchar(hello) *num
  chars
}
meaningoflife <-f(3)
print(meaningoflife)

  ?cat
?nchar  

#lexical scoping 
make.power 