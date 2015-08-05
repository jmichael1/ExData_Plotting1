# plot1.R - Generates a histogram of Global Active Power
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
# convert the date column to a date type
power$Date <- as.Date(power$Date , "%d/%m/%Y")
# we just need a subset of this data for a date range, so extract the relevant rows
power1 <- subset(power, power$Date=="2007-02-01" | power$Date=="2007-02-02")
# we need a png graphics device to which to write the plot
png(file="plot1.png",width=480,height=480)
# now generate the histogram
hist(power1$Global_active_power,xlab="Global Active Power (kw)",col="red",main="Global Active Power")
# be sure to turn our graphics device off or chaos will ensue
dev.off()
setwd(currentdir)
# mission completed

