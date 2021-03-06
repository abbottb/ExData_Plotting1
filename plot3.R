# This script was developed for an assignment for Coursera's Exploratory Data Analysis course
# It creates Plot 3 of the Week 1 course project

# Note - This script assumes that the 'household_power_comsumption.txt' file has been saved
# to the working directory

# Read the data file, which has values separated by ";" and NAs represented by "?"
# Found note online that comment.char = "" will speed this up, but haven't tested to see the impact
powerData <- read.table("household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        na.strings = "?",
                        stringsAsFactors = FALSE,
                        comment.char = "")

# Subset to include only the required dates
powerData <- subset(powerData, Date == "1/2/2007" | Date == "2/2/2007")

# Add datetime field
library(dplyr)
powerData <- mutate(powerData, Datetime = paste(Date, Time))
powerData$Datetime <- strptime(powerData$Datetime, format = "%d/%m/%Y %H:%M:%S")

# Format date and time
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")
powerData$Time <- strptime(powerData$Time, format = "%H:%M:%S")

# Launch PNG graphics device
png(filename = "plot3.png",
    width = 480,
    height = 480,
    units = "px")

# Create plot (note - this is the only block of code that varies between the 4 different plots)
plot(powerData$Datetime,
     powerData$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering)",
     type = "n")
lines(powerData$Datetime,
      powerData$Sub_metering_1)
lines(powerData$Datetime,
      powerData$Sub_metering_2,
      col = "red")
lines(powerData$Datetime,
      powerData$Sub_metering_3,
      col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1)

# Close graphics device / save file
dev.off()