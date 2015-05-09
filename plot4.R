library(dplyr)
library(lubridate)

# to run the method
# > source("plot3.R")
# > plot3()

plot4 <- function(file) {
  
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
  pwcData$Global_active_power <- as.numeric(pwcData$Global_active_power)
  pwcData$Global_reactive_power <- as.numeric(pwcData$Global_reactive_power)
  pwcData$Voltage <- as.numeric(pwcData$Voltage)
  
  # prepare to plot charts in a 2 by 2 layout
  par(mfrow=c(2,2))
    
  # plot column 1,1 chart 
  plot(pwcData$DateTime,pwcData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    
  # plot column 2,1 chart x=Day y=Voltage
  plot(pwcData$DateTime,pwcData$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  # plot column 1,2 histogram x=Day and y=Energy Sub metering
  plot(pwcData$DateTime,pwcData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  # add line chart x=Day and y=Sub_metering_2
  lines(pwcData$DateTime,pwcData$Sub_metering_2,col="red")
  # add line chart x=Day and y=Sub_metering_3
  lines(pwcData$DateTime,pwcData$Sub_metering_3,col="blue")
  
  # create legend at top right corner
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1),cex=.3, bty="n",inset = c(0,-0.1))
  
  # plot column 2,2 chart x=Day y=Global Reactive Power
  plot(pwcData$DateTime,pwcData$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
    
  # generate PNG and save it as plot4.png 
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  
}