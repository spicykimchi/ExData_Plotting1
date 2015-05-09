library(dplyr)
library(lubridate)

# to run the method
# > source("plot1.R")
# > plot1()

plot1 <- function(file) {
  # read only data between 1/2 to 2/2 from file
  pwcData <- read.csv("household_power_consumption.txt", sep = ";", skip=66636, nrow=2880)
  
  # setting header
  names(pwcData) <- c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  # plot Global Active Power histogram x=Global_active_power and y=count
  hist(pwcData$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
  
  # generate PNG and save it as plot1.png 
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
}