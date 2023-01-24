# CDS
# 2023-01-24
# Ice mass loss over poles

read.table(file="data/antarctica_mass_200204_202209.txt", skip=31, sep="", header=FALSE, 
           col.names=c("decimal_date", "mass_Gt", "sigma_Gt")) 

#^this is good way to get data from .txt, skip= means it skips first 31 lines, sep= is how data is separated
#now you want to set this equal to a variable:

ant_ice_loss = read.table(file="data/antarctica_mass_200204_202209.txt", skip=31, sep="", header=FALSE, 
                          col.names=c("decimal_date", "mass_Gt", "sigma_Gt")) 
typeof(ant_ice_loss)
class(ant_ice_loss)
dim(ant_ice_loss)


grn_ice_loss = read.table(file="data/greenland_mass_200204_202209.txt", skip=31, sep="", header=FALSE, 
                          col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))
head(grn_ice_loss) #this shows you the first six rows of the data
tail(grn_ice_loss) #this shows you the last 6 rows
summary(ant_ice_loss) #gives summary of each column, will also list missing data
#look at your data as many ways as you can

# plot it:

plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_Gt, type="l", xlab="Year", 
     ylab="Antarctic ice loss (Gt)", ylim=c(-5338.2, 0))
#type="l" makes it a line instead of just the points, "p" would make it go back to points
#xlab= and ylab= changes the label of the x and y axes
#ylim= lets you set the y axis scale
lines(mass_Gt~decimal_date, data=grn_ice_loss, col="red")
#^this is saying y as a function of x, mass as a function of date
#^the plot command that we ran first sets up the graphs, the lines command adds to that first plot
min(grn_ice_loss$mass_Gt)
range(grn_ice_loss$mass_Gt)
plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_Gt, type="l", xlab="Year", 
     ylab="Antarctic ice loss (Gt)", ylim=range(grn_ice_loss$mass_Gt))
lines(mass_Gt~decimal_date, data=grn_ice_loss, col="red")

#but the grace mission had a break at 2017, in the plot this will show as a straight line, but we want to show the gap:
#add data break between Grace missions:

data_break = data.frame(decimal_date=2018.0, mass_Gt=NA, sigma_Gt=NA)
print(data_break)

#insert data break into ice loss data frames:
ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)

dim(ant_ice_loss)
dim(ant_ice_loss_with_NA)
tail(ant_ice_loss_with_NA)
#^could delete these to get them out of the way

order(ant_ice_loss_with_NA$decimal_date)
#use this order function to reorder columns for entire data frame:
ant_ice_loss_with_NA = ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_date), ]
dim(ant_ice_loss_with_NA)
tail(ant_ice_loss_with_NA)

grn_ice_loss_with_NA = grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_date), ]

#change the data frame (?) to include the NA:

plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type="l", xlab="Year", 
     ylab="Antarctic ice loss (Gt)", ylim=range(grn_ice_loss$mass_Gt)) +
lines(mass_Gt~decimal_date, data=grn_ice_loss_with_NA, col="red")

# Error bars:

head(ant_ice_loss_with_NA)
pdf('figures/ice_mass_trends.pdf', width=7, height=5) #this must be before you call the plot
plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type="l", xlab="Year", 
     ylab="Antarctic ice loss (Gt)", ylim=range(grn_ice_loss$mass_Gt)) +
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, lty="dashed") +
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, lty="dashed")
dev.off()

#bar plot with total ice loss:

min(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE) #na.rm=TRUE removes the NA before telling you the min value
max(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE)

tot_ice_loss_ant = min(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE) - max(ant_ice_loss_with_NA$mass_Gt, na.rm=TRUE)
print(tot_ice_loss_ant)

tot_ice_loss_grn = min(grn_ice_loss_with_NA$mass_Gt, na.rm=TRUE) - max(grn_ice_loss_with_NA$mass_Gt, na.rm=TRUE)

barplot(height=c(tot_ice_loss_ant, tot_ice_loss_grn))
barplot(height=-1*c(tot_ice_loss_ant, tot_ice_loss_grn), 
        names.arg=c("Antarctica", "Greenland"))
