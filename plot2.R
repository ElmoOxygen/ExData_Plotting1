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

##png and plot
png(file = "plot2.png", width = 480, height = 480)

plot(power$datetime, power$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
     
dev.off()