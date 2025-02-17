df1 = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
df1$theDate = as.Date(df1$Date, format="%d/%m/%Y")
sub1 = subset(df1, theDate==as.Date("2007-02-01") | theDate==as.Date("2007-02-02"))

# Combine Date and Time fields and convert into a POSIXct type
sub1$theDateTime = as.POSIXct(paste(sub1$Date, sub1$Time), format="%d/%m/%Y %H:%M:%S")

# Draw plot into plot4.png file
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(sub1, {
  
  # NW quadrant
  plot(theDateTime, Global_active_power, type="l", xlab="", ylab="Global ACtive Power", xaxt="n" )  
  axis.POSIXct(side=1, at=seq(from=min(sub1$theDateTime),to= 24*3600 + max(sub1$theDateTime), by="day"), format="%a")
  
  # NE quadrant
  plot(theDateTime, Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt="n" )
  axis.POSIXct(side=1, at=seq(from=min(sub1$theDateTime),to= 24*3600 + max(sub1$theDateTime), by="day"), format="%a")
  
  # SW quadrant
  plot(sub1$theDateTime, sub1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n" )
  lines(sub1$theDateTime, sub1$Sub_metering_2, col="red")
  lines(sub1$theDateTime, sub1$Sub_metering_3, col="blue")
  axis.POSIXct(side=1, at=seq(from=min(sub1$theDateTime),to= 24*3600 + max(sub1$theDateTime), by="day"), format="%a")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)  
  
  # SE quadrant
  plot(theDateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global ACtive Power", xaxt="n" )  
  axis.POSIXct(side=1, at=seq(from=min(sub1$theDateTime),to= 24*3600 + max(sub1$theDateTime), by="day"), format="%a")
})
dev.off()