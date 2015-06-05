# Exploratory Data Analysis
# Project 1 - Plot 2

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

#Plot 2 - Global Active Power vs Time
plot(powerData$DT, powerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")
dev.copy(png, file = "Plot2.png")
dev.off()
