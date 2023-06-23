## File download
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", exdir = "./")

## Reading in txt file
exdata <- read.table ("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

## Convert the "Date" column to Date format 
exdata$Date <- as.Date(exdata$Date, format = "%d/%m/%Y")
                        
## Subset the dataset based on specific dates
data <- exdata[exdata$Date == as.Date("2007-02-01") | exdata$Date == as.Date("2007-02-02"), ]

## Creating historgram based on subset
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Creating PNG file
dev.copy(device = png, file = "plot1.png", 480, 480)
dev.off()
