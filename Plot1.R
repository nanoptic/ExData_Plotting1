# Exploratory Data Analysis
# Project 1 - Plot 1

library(dplyr)
library(data.table)

# Read the data, subset, and prepare various fields.
powerData <- fread("household_power_consumption.txt", sep=";", na.strings="?",stringsAsFactors = FALSE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
powerData <- filter(powerData, grep("^[1,2]/2/2007", Date))
powerData$Global_active_power<-as.numeric(powerData$Global_active_power)

DT<- as.POSIXct(paste(powerData$Date, powerData$Time, sep = " "), format="%d/%m/%Y %H:%M:%S")
powerData$Date<-NULL
powerData$Time<-NULL
powerData <- cbind("DT" = DT, powerData)
remove(DT)

# Plot a histogram of Global Active Power, and save copy in PNG format
hist(powerData$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)")
dev.copy(png, file = "Plot1.png")
dev.off()