# Downloading, unzipping and reading the Household power consumption data.

library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="HPC.zip")
unzip("HPC.zip")
HPC1 <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Transforming the date variables in date format and converting the relevant subset
# of the table into a dataframe

HPC1$Date <- as.Date(HPC1$Date, format="%d/%m/%Y")
HPC2 <- as.data.frame(HPC1[HPC1$Date=="2007-02-01"|HPC1$Date=="2007-02-02",])

# Now transforming date and time in time format and the remaining variables as numeric

HPC2$Time <- paste(HPC2$Date, HPC2$Time)
HPC2$Time <- strptime(HPC2$Time, format="%Y-%m-%d %H:%M:%S")
for(i in 3:9) {HPC2[, i] <- as.numeric(HPC2[, i])}

# Constructing 2nd plot - a 2-way line plot of Global active power over time
# and including it creating the PNG file

png("plot2.png")
plot(HPC2$Time, HPC2[, 3], main="", type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()