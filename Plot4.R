# Exploratory Data Analysis
# Project 1 - Plot 4

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

# Plot 4
par(mfcol = c(2,2))

# First graph in column 1
plot(powerData$DT, powerData$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# Second graph in column 1
plot(powerData$DT, powerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$DT, powerData$Sub_metering_2, type = "l", col = "red" )
lines(powerData$DT, powerData$Sub_metering_3, type = "l", col = "blue" )
legend("topright", lty= 1, col = c("Black", "Red", "Blue"), legend = c( "Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "))

# First graph in column 2
plot(powerData$DT, powerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Second graph in column 2
plot(powerData$DT, powerData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "Plot4.png")
dev.off()
