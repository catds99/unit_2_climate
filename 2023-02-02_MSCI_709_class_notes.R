# 2023-02-02
# CDS

library("lubridate")
#tools>install packages>write in name of package>install

# while loops practice

x = 1
while (x>0){
  x = x+1
}
#here we didn't r a chance to exit the loop, so it just kept running

x = 10
while (x>0){
  x=x-1
}
x #x became 9, 8, 7, 6, 5, 4, 3, 2, 1, then 0

x = 10
while (x>0){
  x=x-1
  print(x)
}
x

# fishing game - how many fish can you catch until you hitthe DNR limit of 50 lbs

total_catch_lb = 0 #to initialize set =0
n_fish = 0 #to initialize set =0
while(total_catch_lb < 50){
  n_fish = n_fish + 1
  new_fish_weight = rnorm(n=1, mean=2, sd=1) #rnorm will assign a random number
  total_catch_lb = total_catch_lb + new_fish_weight
}

n_fish
total_catch_lb

#similar to for loop, but with a condition (based on true/false instead of a sequence?)

#################################################
#moving on to lesson 2.6 Arctic sea ice extent
#################################################

url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'
arctic_ice = read.delim(url, 
                        skip=2, 
                        sep=",", 
                        header=FALSE, 
                        col.names = c("Year", "Month", "Day", "Extent", 
                                      "Missing", "Source_Data"))
head(arctic_ice)

#this is not set up to look at extent over time - you'd have a bunch of points all lined up in one year (because month and date are separate columns)

#load lubridate into library (usually do this at top of script - see above)

arctic_ice$date = make_date(year=arctic_ice$Year, month=arctic_ice$Month, 
                            day=arctic_ice$Day)

#above we are creating a new column for date using lubridate package

head(arctic_ice)

plot(Extent~date, data=arctic_ice, type="l",xlab="Date", ylab="Arctic Sea Ice Extent (x10^6 km^2)")

#now let's get an annual average and dump the incomplete first year and incomplete most recent year:

tail(arctic_ice)

#initialize results data frame (using NAs)
arctic_ice_averages = data.frame(Year=seq(min(arctic_ice$Year)+1, max(arctic_ice$Year)-1), #this dumps the incomplete years
                                 extent_annual_avg = NA,
                                 extent_5yr_avg = NA)
# mean(arctic_ice$Extent[arctic_ice$Year == 1979])
#im(arctic_ice_averages)[1] #[1] gives just the number of rows
#seq(dim(arctic_ice_averages)[1])
for(i in seq(from=1, to=dim(arctic_ice_averages)[1])){
  arctic_ice_averages$extent_annual_avg[i] = #the [i] here indicates row to place it in, this is important
    mean(arctic_ice$Extent[arctic_ice$Year==arctic_ice_averages$Year[i]])
}

head(arctic_ice_averages)

plot(extent_annual_avg~Year, data=arctic_ice_averages, type ="l")

#now let's do a five year average (as in average for 1993 would be mean for 1991-1995, the middel of 5 years - average of 1994 would be mean for 1992-96):

#the first year we can calculate this average for 1981, the last year would be 2020

dim(arctic_ice_averages)[1]-2

i=42
for(i in seq(from=3, to=dim(arctic_ice_averages)[1]-2)){
  years = seq(from = arctic_ice_averages$Year[i]-2, to= arctic_ice_averages$Year[i]+2) #sets up the years we want to cover?
  arctic_ice_averages$extent_5yr_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year %in% years])
}

head(arctic_ice_averages)
tail(arctic_ice_averages)

plot(extent_annual_avg~Year, data=arctic_ice_averages, type ="l") +
  lines(x=arctic_ice_averages$Year, y=arctic_ice_averages$extent_5yr_avg, col="red")

arctic_ice_averages$date = make_date(year = arctic_ice_averages$Year, month = 7, day =1)

plot(Extent~date, data=arctic_ice, type="l",xlab="Date", 
     ylab="Arctic Sea Ice Extent (x10^6 km^2)") 
lines(extent_annual_avg~date, data=arctic_ice_averages, type="l", col="blue") + 
lines(x=arctic_ice_averages$date, y=arctic_ice_averages$extent_5yr_avg, type="l", col="red")









