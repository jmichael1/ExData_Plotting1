# plot2.R - Generates a plot of Global Active Power by Date and Time
# author J Michael
# cache current directory
currentdir <- getwd()
# create a working directory for this analysis - we are using eda for Exploratory Data Analysis
if (!dir.exists("eda")) dir.create("eda")
if (!dir.exists("eda")) stop("Cannot create working directory. Check write permissions for current directory.")
setwd("./eda")
# if the file hasn't been downloaded then try to download it
if (!file.exists("power.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.zip")
}
if (!file.exists("power.zip")) stop("Failed to download data file. Check network and try again.")
# if the file has not yet been decompressed then unzip the file
if (!file.exists("household_power_consumption.txt")) unzip("power.zip")
if (!file.exists("household_power_consumption.txt")) stop("Required data file not found in zip archive.")
# read the csv file with appropriate na.string and sep values for this data file
power <- read.csv("household_power_consumption.txt",header=TRUE,na.strings="?",sep=";")
# convert the date column to a date type so we can restrict the date range
power$Date <- as.Date(power$Date , "%d/%m/%Y")
# we just need a subset of this data for a date range, so extract the relevant rows
power1 <- subset(power, power$Date=="2007-02-01" | power$Date=="2007-02-02")
# add a column with the date and time combined
library(dplyr)
power2 <- mutate(power1,DateTime = paste(Date,Time))
# convert it to a POSIX datetime
power2$DateTime <- strptime(power2$DateTime,"%Y-%m-%d %H:%M:%S")
# create the graphics device for the plot
png(filename="plot2.png",height=480,width=480)
plot(power2$DateTime,power2$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")
# turn graphics device off
dev.off()
setwd(currentdir)
# mission completed


