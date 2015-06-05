# Exploratory Data Analysis
# Project 1 - Plot 3

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

#Plot 3 - Energy sub metering vs Time
plot(powerData$DT, powerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$DT, powerData$Sub_metering_2, type = "l", col = "red" )
lines(powerData$DT, powerData$Sub_metering_3, type = "l", col = "blue" )
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "Plot3.png")
dev.off()
