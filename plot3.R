## Assignment Week 1

## Read data
install.packages("tidyverse")
install.packages("sqldf")
install.packages("hms")
library(readr)
library(tidyverse)
library(sqldf)
library(data.table)
library(hms)

fpath = "./data/household_power_consumption.txt"

# Read data
df <- read.table(file = fpath, header = T, na.strings = "?", sep = ";")

# convert Date for period selection
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Subset data
df <- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02",]

#copy data frame
df2 <- df

# Create timestamp column
df2 <- within(df2, { timestamp=strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S") })


# Plot 3
with(df2, plot(timestamp, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"), ylim = 40)
with(df2, lines(timestamp, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"), ylim = c(0, 40))
with(df2, lines(timestamp, Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red"), ylim = c(0,40))
with(df2, lines(timestamp, Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue"), ylim = c(0,40))

legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col =c("black","red", "blue"), lty=1)

dev.copy(png, file="./plot3.png")
dev.off()
