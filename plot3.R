## File download
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="exdata.zip", method="curl")
unzip ("exdata.zip", exdir = "./")

## Read in txt file
exdata <- read.table ("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

## Convert the "Date" column to Date format 
exdata$Date <- as.Date(exdata$Date, format = "%d/%m/%Y")

## Subset the dataset based on specific dates
data <- exdata[exdata$Date == as.Date("2007-02-01") | exdata$Date == as.Date("2007-02-02"), ]

## New dataset replacing "Date" and "Time" columns of 'data' with "DateTime" column
## in 'data2' dataset
data2 <- data 
data2$DateTime <- paste(data$Date, data$Time)
data2$Date <- NULL
data2$Time <- NULL
data2$DateTime <- as.POSIXct(data2$DateTime)

## Create plot with legend
plot(x = data2$DateTime, y = data2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt ="n")
lines(x = data2$DateTime, y = data2$Sub_metering_2, type = "l", col ="red")
lines(x = data2$DateTime, y = data2$Sub_metering_3, type = "l", col ="blue")
positions <- seq(from = min(data2$DateTime), to = max(data2$DateTime), length.out = 3)
axis(side = 1, at = positions, labels = c("Thu", "Fri", "Sat"))
legend("topright", lty=1, lwd=1, , col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Create PNG file
dev.copy(device = png, "plot3.png", 480, 480)
dev.off()
