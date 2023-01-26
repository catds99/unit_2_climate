# CDS
# 2023-01-26
# Logical, Boolean, If/Else

vec = c(1, 0, 2, 1)
vec
vec[c(TRUE, FALSE, TRUE, FALSE)]

# practice logical operators

1>2
1 > c(0, 1, 2)
c(1, 2, 3) == c(3, 2, 1)
1 %in% c(1, 2, 3)
c(1, 3, 5, 7) %in% c(1, 2, 3)

world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans

world_oceans$avg_depth_m > 4000
deep_oceans = world_oceans[world_oceans$avg_depth_m > 4000, ] #this tells what rows to give, and to give us all the columns (that's the blank space after the comma)
deep_oceans

deep_oceans = world_oceans$ocean[world_oceans$avg_depth_m > 4000] #this tells that we just want the first column which is called oceans
deep_oceans

sum(world_oceans$avg_depth_m > 4000) #how many have avg depth greater than 4000, by coercing trues and falses into 1s and 0s

# imprecise numerics

1+2 == 3
0.1+0.2 == 0.3 #the binary form of the number isn't exactly the same as the decimal, so it may not give you the answer you're expecting
0.3 - (0.1+0.2)
my_error = 0.0001
abs(0.3 - (0.1+0.2)) > my_error
#so whatever the difference is between these values is very small

# Boolean operators

x = 5
x
x>3 & x <15
x < 3 | x > 15
x > 3 | x > 15
x < 10 & x %in%c(1, 2, 3)
x < 10 | x %in%c(1, 2, 3)

world_oceans

# subset

world_oceans[world_oceans$avg_depth_m > 4000 & world_oceans$area_km2 < 50e6, ]
world_oceans$ocean[world_oceans$avg_depth_m > 4000 & world_oceans$area_km2 < 50e6]
world_oceans[world_oceans$avg_depth_m > 4000 | world_oceans$area_km2 < 50e6, ]

z = c(TRUE, FALSE, FALSE)
z
any(z)
all(z)

# handling missing data
 
NA == NA #you would expect this to be true, but it returns NA 
is.na(NA)
vec = c(0, 1, 2, NA, 4)
is.na(vec) #is there an NA in my data
any(is.na(vec)) #does an na exist in my data?
!is.na(vec) #subset rows where ns doesn't appear?

#exercise 2.2 - 
#Is w greater than 10 and less than 20?
#Are any of the values in x positive?
#Are all of the values in x positive?
#Is object y the word February?
#How many values in z are days of the week?

w = 15
x = c(-1, 0, 1)
y = "February"
z = c("Monday", "Tuesday", "January")

w > 10 & w < 20
any(x > 0)
all(x > 0)
y == "February"
sum(any(z == "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

#####################################################
#starting if/else statements - tutorial 2.3
#####################################################

num = 2
num

if(num < 0){
  num = num*-1
}

num

num = -2
num

if(num < 0){
  print("oh no, num is negative")
  num = num*-1
  print("don't worry, i made it positive")
}

num

#exercise 3.1

temp = 101.2

if(temp > 98.6){
  print(temp - 98.6)
  if(temp > 101){
    print("They have a high fever")
  }
}

temp = 99.5

if(temp > 98.6){
  print(temp - 98.6)
  if(temp > 101){
    print("They have a high fever")
  }
}

temp = 98.4

if(temp > 98.6){
  print(temp - 98.6)
  if(temp > 101){
    print("They have a high fever")
  }
}

temp = 98.4

if(temp > 98.6){
  print(temp - 98.6)
  print("They have a fever")
  if(temp > 101){
    print("They have a high fever")
  }
}

temp = 99.5

if(temp > 98.6){
  print(temp - 98.6)
  print("They have a fever")
  if(temp > 101){
    print("They have a high fever")
  }
}

temp = 101.2

if(temp > 98.6){
  print(temp - 98.6)
  print("They have a fever")
  if(temp > 101){
    print("They have a high fever")
  }
}

# adding elses

grade=56
if(grade >= 60){
  print("you pass")
} else {
  print("you fail")
}

a = 87
b = 56
if(a>b){
  print("A won")
} else if(a<b){
  print("B lost")
} else {
  print("they tied")
}

# if/else - best used with simple cases for a single line of code

#three parameters: ifelse(condition, what to do if condition is true, what to do if condition is false)

a= c(1, 0, -5, 18)
reciprocals = ifelse(a!=0, 1/a, NA)
reciprocals

#so this says if a doesn't equal zero, then do the reciprocal, if it does equal zero write NA

my_dat = cbind(a, reciprocals) #this binds columns together
my_dat

# exercise 3.2
#Let’s say you have the number of donuts your Dad bought on Sunday stored in variable n_donuts. 
#Write an if/else chain to print out a statement that states whether Dad bought less than a dozen, a dozen (12), 
#a baker’s dozen (13) or more than a baker’s dozen.

n_donuts = 15
if(n_donuts < 12){
  print("dad bought less than a dozen donuts")
} else if(n_donuts == 12){
  print("dad bought a dozen donuts")
} else if(n_donuts == 13){
  print("dad bought a bakers dozen")
} else {
  print("dad bought more than a bakers dozen")
}

