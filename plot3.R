library(dplyr)
library(lubridate)

# to run the method
# > source("plot3.R")
# > plot3()

plot3 <- function(file) {
  
  # read only data between 1/2 to 2/2 from file
  pwcData <- read.csv("household_power_consumption.txt", sep = ";", skip=66636, nrow=2880)
  
  # setting header
  names(pwcData) <- c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  # add new column to store datetime for X-axis
  pwcData <- mutate(pwcData, DateTime=dmy_hms(paste(pwcData$Date,pwcData$Time)))
  
  # convert columns to numeric
  pwcData$Sub_metering_1 <- as.numeric(pwcData$Sub_metering_1)
  pwcData$Sub_metering_2 <- as.numeric(pwcData$Sub_metering_2)
  pwcData$Sub_metering_3 <- as.numeric(pwcData$Sub_metering_3)
  
  par(mfrow=c(1,1))
  # plot chart x=Day and y=Energy Sub metering
  plot(pwcData$DateTime,pwcData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  # add line chart x=Day and y=Sub_metering_2
  lines(pwcData$DateTime,pwcData$Sub_metering_2,col="red")
  # add line chart x=Day and y=Sub_metering_3
  lines(pwcData$DateTime,pwcData$Sub_metering_3,col="blue")
  
  # create legend at top right corner
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
 
  # generate PNG and save it as plot3.png s
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
 
}