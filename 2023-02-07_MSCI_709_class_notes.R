# 2023-02-07
# CDS

# user-defined functions

x = c(1,2,3)

avg = function(x){
  s = sum(x)
  n = length(x)
  return(s/n) #this just tells the function to only return this value
} #x is going to be our vector

avg(x)
mean(x)
avg(c(1,3,5))
mean(c(1,3,5))
s #anything created inside the function is destroyed when the function is over
#it's almost like the function creates a second environment, the function will
#only access things inside it's own environment
#so the x in the function only refers to x within the function - not the 
#vector x that we made

#we just did the arithmetic mean, what about geometric mean (when all 
#the elements in the vector are multiplied and then the nth root is taken)

#to switch between arithmetic and geometric means:

avg = function(x, arithmetic=TRUE){ #arithmetic=TRUE will be the default version
  n = length(x)
  result = ifelse(arithmetic, sum(x)/n, prod(x)^(1/n)) #if arithmetic is true, do sum(x)/n if arithmetic is false do prod(x)^(1/n)
  return(result)
}

dat = c(1, 3, 5, 7)

avg(dat)
mean(dat)
avg(dat, arithmetic = TRUE)
avg(x=dat, arithmetic = FALSE) #now we can get the geometric mean, 3.201086

avg(arithmetic = FALSE, x=dat) #it's fine that we switched parameters here because we named dat as our vector x
avg(FALSE, dat) #this is out of order but won't work
avg(dat, FALSE) #this will work, but it's best to explicitly define the parameters, i.e. x=, and arithmetic=


is.numeric(FALSE)

avg = function(x, arithmetic=TRUE){
  if(!is.numeric(x)){
    stop("x must be numeric") #this says "if x is not numeric print x must be numeric" and it's a way to idiot proof the code
  } 
  n = length(x)
  result = ifelse(arithmetic, sum(x)/n, prod(x)^(1/n)) 
  return(result)
}

dat= c(1,3,5,7)
avg(dat, FALSE)
avg(c(2,4,6), FALSE)
avg(FALSE, dat)

# Exercise 7.1
#Create a function that reads in someone’s grade percentage points and returns 
#their letter grade (A: 90-100, B: 80-90, etc.). 
#You can imagine how you could make this function fancier by including grading 
#scheme info in the parameters to ask if the function user wanted to also know 
#if the student earned a B+, B or B-.

grade = function(percentage){ 
  if(percentage %in% c(90:100)){
    print("A")
  }
  if(percentage %in% c(80:90)){
    print("B")
  }
  if(percentage %in% c(70:80)){
    print("C")
  }
  if(percentage %in% c(60:70)){
    print("D")
  }
  if(percentage < 60){
    print("F")
  }
}

grade(45)

#class solution:

letter = function(grade){
  if(grade>=90){
    return("A")
  } else if(grade>=80){
    return("B")
  } else if (grade>=70){
    return("C")
  } else if (grade>=60){
    return("D")
  } else{
    return("F")
  }
}

letter(45)

########################################################
#2.8 global temperature
########################################################

url = 'https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt'
url = 'https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt'
temp_anomaly = read.delim(url, 
                          skip=5, 
                          sep="", 
                          header=FALSE, 
                          col.names = c("Year", "No_Smoothing", "Lowess_5"))

head(temp_anomaly)
class(temp_anomaly)
summary((temp_anomaly))
dim(temp_anomaly)
tail(temp_anomaly)

plot(No_Smoothing ~ Year, data=temp_anomaly, type="b", ylab="Global temp anomaly") + 
  lines(Lowess_5 ~ Year, data=temp_anomaly, col="red", lwd=2)

  #type = "b" gives lines and points
  #lwd means line width, default is 1

#seems like there's a pause ~2012, let's take a closer look:

temp_1998 = temp_anomaly$No_Smoothing[temp_anomaly$Year==1998]
temp_2012 = temp_anomaly$No_Smoothing[temp_anomaly$Year==2012]

plot(No_Smoothing ~ Year, data=temp_anomaly, type="b", ylab="Global temp anomaly") + 
  lines(Lowess_5 ~ Year, data=temp_anomaly, col="red", lwd=2) +
  abline(v=1998, lty="dashed") +
  abline(v=2012, lty="dashed") + #this adds a vertical line (the v), use h for a horizontal line
  lines(c(temp_1998, temp_2012) ~ c(1998, 2012), col="blue", lwd=2.5) #this will add the horizontal line from the 1998 point to the 2012 point

#but if you cherry pick you can paint any story you want to tell

calc_rolling_avg = function(data, moving_window=5){ #5 is the moving window default, the user can change this when they are using the function
  result = rep(NA, length(data))
  for(i in seq(from=moving_window, to=length(data))){ #i starts at moving window for a meaningful moving average, until the end of the data
    result[i] = mean(data[seq(from=(i-moving_window+1), to=i)]) #when i = 5, we start from (5-5+1 = 1) to 5, so for i = 5, it's seq(1:5), when i=10, it's 10-5:1 = 6 to 10 or seq(6:10)
  }
  return(result)
}

temp_anomaly$avg_5_yr = calc_rolling_avg(data=temp_anomaly$No_Smoothing, moving_window = 5)
temp_anomaly$avg_10_yr = calc_rolling_avg(data=temp_anomaly$No_Smoothing, moving_window = 10)

head(temp_anomaly)

plot(No_Smoothing ~ Year, data=temp_anomaly, type="b", ylab="Global temp anomaly") + 
  lines(avg_5_yr ~ Year, data=temp_anomaly, col="red", lwd=2) +
  lines(avg_10_yr ~ Year, data=temp_anomaly, col="blue", lwd =2)
