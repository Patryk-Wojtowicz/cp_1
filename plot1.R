# Assignment Week 1

## Plot 1

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


# Plot 1
par(mfrow = c(1,1))
with(df2, hist(Global_active_power, main = "Global active power", xlab = "Global active power (kilowatts)", col="red"))
dev.copy(png, file="./plot1.png")
dev.off()
