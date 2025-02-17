df1 = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
df1$theDate = as.Date(df1$Date, format="%d/%m/%Y")
sub1 = subset(df1, theDate==as.Date("2007-02-01") | theDate==as.Date("2007-02-02"))

# Combine Date and Time fields and convert into a POSIXct type
sub1$theDateTime = as.POSIXct(paste(sub1$Date, sub1$Time), format="%d/%m/%Y %H:%M:%S")

# Draw plot into plot3.png file
png("plot3.png", width=480, height=480)
plot(sub1$theDateTime, sub1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n" )
# Add new series and legend
lines(sub1$theDateTime, sub1$Sub_metering_2, col="red")
lines(sub1$theDateTime, sub1$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)

axis.POSIXct(side=1, at=seq(from=min(sub1$theDateTime),to= 24*3600 + max(sub1$theDateTime), by="day"), format="%a")
dev.off()