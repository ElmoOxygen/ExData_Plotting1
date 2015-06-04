library(dplyr)
if (!file.exists("household_power_consumption.txt")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "power.zip")
        unzip("power.zip")
}

power<-read.table("household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE, 
                  as.is = TRUE, 
                  na.strings = "?")
power<-filter(power, Date == "1/2/2007" | Date == "2/2/2007")
power<-mutate(power, datetime = as.POSIXct(paste(Date, Time), 
                                    "%d/%m/%Y %H:%M:%S", tz = ""))

png(file = "plot3.png", width = 480, height = 480)

plot(power$datetime, power$Sub_metering_1, 
     type = "l", 
     xaxt = 'n', 
     xlab = "", 
     ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)
dev.off()