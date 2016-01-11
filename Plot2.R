##Note, please set appropriate working directory
#WD <- "YOURWORKINGDIRECTORYHERE"

#loading lubridate for date/time parsing
library(lubridate)

#setting working directory and downloading and unzipping file if not previously downloaded
setwd(WD)
if(!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power_consumption.zip")
  unzip("power_consumption.zip")
}

#preprocessing dataset if not already done
if(!exists("powerconsumption")) {
  powerconsumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
  powerconsumption$Date <- parse_date_time(powerconsumption$Date, "%d/%m/%Y")
  powerconsumption <- powerconsumption[which(powerconsumption$Date >= "2007-02-01" & powerconsumption$Date < "2007-02-03"), ]
  powerconsumption$Global_active_power <- as.numeric(as.character(powerconsumption$Global_active_power))
  powerconsumption$Global_reactive_power <- as.numeric(as.character(powerconsumption$Global_reactive_power))
  powerconsumption$Voltage <- as.numeric(as.character(powerconsumption$Voltage))
  powerconsumption$Sub_metering_1 <- as.numeric(as.character(powerconsumption$Sub_metering_1))
  powerconsumption$Sub_metering_2 <- as.numeric(as.character(powerconsumption$Sub_metering_2))
}

#creating plot2 and saving it as "plot2.png" in WD
par(cex = 0.8)
plot(powerconsumption$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
axis(1, at = c(1, 1441, 2881), labels = c("Thu", "Fri", "Sat"))
dev.copy(png, file = "plot2.png")
dev.off()
graphics.off()
