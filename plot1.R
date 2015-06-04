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

png(file = "plot1.png", width = 480, height = 480)

hist(power$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.off()