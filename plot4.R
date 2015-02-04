fileName <- "household_power_consumption.txt"
fileErrPrmpt <- "Please copy the file to the directory and/or download file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

wd <- getwd()

## Check if the file exists
if(!file.exists(fileName)){
  stop(paste(c("\nFile does not exists in ", wd, " .\n", fileErrPrmpt)))
}

# Read the data file
raw_data <- read.csv(fileName, sep=";", na.strings="?", stringsAsFactors=FALSE)

dataset <- subset(raw_data, regexpr("^0?(1|2)/0?2/2007", raw_data$Date)>0)
datetime <- strptime(paste(dataset$Date,dataset$Time), "%d/%m/%Y %H:%M:%S", tz='UTC')

# Open the png device for plotting, type = "cairo" has been added to match the plot with example
png(file = "./plot4.png", width = 480, height = 480, units = "px", bg = "white", type="cairo")

par(mfrow=c(2,2))

# Plot1
plot(datetime,dataset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", main = "")

# Plot2
plot(datetime,dataset$Voltage, type = "l", ylab = "Voltage", main = "")

# Plot3
plot(datetime,dataset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", main = "")
lines(datetime,dataset$Sub_metering_2, col = "red")
lines(datetime,dataset$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",col = c("black","red","blue"),lty=1)

# Plot4
plot(datetime,dataset$Global_reactive_power, type = "l", ylab = "Global_Reactive_power", main = "")

# Close device
dev.off()