library(dplyr)
library(lubridate)

# to run the method
# > source("plot2.R")
# > plot2()

plot2 <- function(file) {
  # read only data between 1/2 to 2/2 from file
  pwcData <- read.csv("household_power_consumption.txt", sep = ";", skip=66636, nrow=2880)
  
  # setting header
  names(pwcData) <- c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  # add new column to store datetime for X-axis
  pwcData <- mutate(pwcData, DateTime=dmy_hms(paste(rawData$Date,rawData$Time)))

  # plot Global Active Power histogram x=Day and y=count
  plot(pwcData$DateTime,pwcData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
   # generate PNG and save it as plot2.png 
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
}