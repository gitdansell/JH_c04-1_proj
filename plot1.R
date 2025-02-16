data = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
sub1 = subset(data, as.Date(Date, format="%d/%m/%Y")==as.Date("2007-02-01") | as.Date(Date, format="%d/%m/%Y")==as.Date("2007-02-02"))

# Convert Global_active_power field from text to number
sub1$Global_active_power = as.numeric(sub1$Global_active_power)

# Draw histogram into plot1.png file
png("plot1.png", width=480, height=480)
hist(sub1$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()

