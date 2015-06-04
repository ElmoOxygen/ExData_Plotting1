library(dplyr)

##checks for file, downloads and unzips if not there
if (!file.exists("household_power_consumption.txt")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "power.zip")
        unzip("power.zip")
}

##read file and filter for dates
power<-read.table("household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE, 
                  as.is = TRUE, 
                  na.strings = "?")
power<-filter(power, Date == "1/2/2007" | Date == "2/2/2007")
##make new row, datetime, in POSIXct format
power<-mutate(power, 
              datetime = as.POSIXct(paste(Date, Time), "%d/%m/%Y %H:%M:%S", tz = ""))

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

##Plot1
plot(power$datetime, power$Global_active_power, 
     type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

##Plot 2
plot(power$datetime, power$Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")

##Plot 3
plot(power$datetime, power$Sub_metering_1, 
     type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)

##Plot 4
plot(power$datetime, power$Global_reactive_power,
     type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()