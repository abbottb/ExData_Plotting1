# This script was developed for an assignment for Coursera's Exploratory Data Analysis course
# It creates Plot 1 of the Week 1 course project

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
png(filename = "plot1.png",
    width = 480,
    height = 480,
    units = "px")

# Create plot (note - this is the only block of code that varies between the 4 different plots)
hist(powerData$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Close graphics device / save file
dev.off()