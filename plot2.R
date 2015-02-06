fileName <- "household_power_consumption.txt"
fileErrPrmpt <- "Please copy the file to the directory and/or download file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

wd <- getwd()

## Check if the file exists
## Since the file is big(126 MB), script does not try to download but outputs link for the manual download
## If required download.file() can be used
if(!file.exists(fileName)){
  stop(paste(c("\nFile does not exists in ", wd, " .\n", fileErrPrmpt)))
}

# Read the data file
raw_data <- read.csv(fileName, sep=";", na.strings="?", stringsAsFactors=FALSE)

dataset <- subset(raw_data, regexpr("^0?(1|2)/0?2/2007", raw_data$Date)>0)
datetime <- strptime(paste(dataset$Date,dataset$Time), "%d/%m/%Y %H:%M:%S", tz='UTC')

# Open the png device for plotting, type = "cairo" has been added to match the plot with example
# The image file in rdpeng's github (from which fork was done) has transparent background, so adding transparent background
png(file = "./plot2.png", width = 480, height = 480, units = "px", type="cairo", bg="transparent")

# Plot
plot(datetime,dataset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", main = "")

# Close device
dev.off()