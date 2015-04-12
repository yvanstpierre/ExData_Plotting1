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

# Constructing 4th plot, with plots number 2 and 3 included as well as line plots
# of Voltage and Global_reactive_power on time, and including in a PNG file

png("plot4.png")
par(mfcol=c(2,2))
plot(HPC2$Time, HPC2[, 3], main="", type="l", xlab="", ylab="Global Active Power")
plot(HPC2$Time, HPC2[, 7], main="", type="l", xlab="", ylab="Energy sub metering")
lines(HPC2$Time, HPC2[, 8], col="red")
lines(HPC2$Time, HPC2[, 9], col="blue")
legend("topright", bty="n", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1)
plot(HPC2$Time, HPC2[, 5], main="", type="l", ylab="Voltage", xlab="datetime")
plot(HPC2$Time, HPC2[, 4], main="", type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()