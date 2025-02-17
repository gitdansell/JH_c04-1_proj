df1 = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
df1$theDate = as.Date(df1$Date, format="%d/%m/%Y")
sub1 = subset(df1, theDate==as.Date("2007-02-01") | theDate==as.Date("2007-02-02"))

# Combine Date and Time fields and convert into a POSIXct type
sub1$theDateTime = as.POSIXct(paste(sub1$Date, sub1$Time), format="%d/%m/%Y %H:%M:%S")

# Convert Global_active_power field from text to number
sub1$Global_active_power = as.numeric(sub1$Global_active_power)




# Draw plot into plot2.png file
png("plot2.png", width=480, height=480)
plot(sub1$theDateTime, sub1$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n" )
# Add custom x-axis tick labels
axis.POSIXct(side=1, at=seq(from=min(sub1$theDateTime),to= 24*3600 + max(sub1$theDateTime), by="day"), format="%a")
dev.off()