x <- 1
print(x)
x
msg <- "hello"
msg

#comment 

x<- 1:20
x

x<- c(0.5,0.6)
x

x <- vector("numeric",length=10)
x

m <-matrix(nrow=2, ncol=3)
m
dim(m)
attributes(m)

m<- matrix (1:6, nrow=2,ncol=3)
m
m<-1:10
m
dim(m) <-c(2,5)
m

x<-1:3
y<-10:12
cbind(x,y)
rbind(x,y)

x <- factor(c("yes","no","yes","no"),levels=c("yes","no"))
x
table(x)
unclass(x)
table(x)
x
unclass(x)

x<- data.frame(foo=1:4,bar=c(T,T,F,T))
x
nrow(x)
ncol(x)

x<-1:3
names(x)
names(x) <- c("foo","bar","norf")
x
names(x)

x<-list(a=1,b=2,c=3)
x

m <-matrix(1:4,nrow=2, ncol=2)
dimnames(m) <-list(c('a','b'),c('c','d'))
m

y <-data.frame (a=1,b="a")
dput(y)

## Send 'dput' output to a file
dput(y, file = "y.R")            
## Read in 'dput' output from a file #cannot understand
new.y <- dget("y.R")             
new.y

x <-list(foo=1:4,bar=0.6)
x
x[1]
x[[1]]

x<-c(3,TRUE)
class(x)

x <-c(1,3,4)
y <-c(1,2,3)
rbind(x,y)

# week1 quiz 11~
hw1 <- read.csv("/Users/Joon/Box/On-line learning/Coursera/R programming/week 1/hw1_data.csv")

nrow(hw1)
hw1[c(1,2),]

#extract last two row
tail(hw1,2)
table(is.na(hw1$Ozone))
summary(is.na(hw1$Ozone)) #summary is ok too
#or sebset it 
subset(hw1,is.na(Ozone))
nrow(subset(hw1,is.na(Ozone)))
#mean
mean(hw1$Ozone, na.rm = T)

#18
oz31 <- subset(hw1,Ozone>31)
oz31
head(oz31)
oz31_temp90 <- subset(oz31,Temp>90)
oz31_temp90
mean(oz31_temp90$Solar.R)
#different way of doing it
oz31_temp90 <- subset(hw1, Ozone>31 & Temp > 90)
oz31_temp90_Solar <- subset(hw1, Ozone>31 & Temp > 90, select = Solar.R) #subset all together, includeing columns
oz31_temp90_Solar
?apply #you can use apply function as well.
apply(oz31_temp90_Solar,2,mean) #2 means column
#another way 
good <- complete.cases(hw1$Ozone, hw1$Solar.R, hw1$Temp) #don't understand the use of complet.cases yet. 
good
mean(hw1$Solar.R[good &hw1$Ozone > 31 & hw1$Temp > 90 ])
mean(hw1$Solar.R[hw1$Ozone > 31 & hw1$Temp > 90], na.rm = T)

#19
mean(hw1$Temp[hw1$Month==6])
#use subset
sub = subset(hw1,Month==6,select=Temp)
apply(sub,2,mean)

#20
which.max(hw1$Ozone[hw1$Month==5])
hw1[c(30),]
#use subset
sub <- subset(hw1, Month==6 & !is.na(Ozone), select = Ozone)
sub
apply(sub,2,max)

library(swirl)
swirl()

