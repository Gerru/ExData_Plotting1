## Reading in the file
df <- read.csv("household_power_consumption.txt", sep = ";", na.strings="?")

## Creating a subset for the required dates
df2 <- df[which(df$Date == "1/2/2007" | df$Date == '2/2/2007'), ]

## Removing full dataset from memory
rm(df) 

## Create DateTime Column by merging Date and Time
df2$DateTime <- paste(df2$Date, df2$Time, sep=" ")
df2$DateTime <- as.POSIXct(df2$DateTime, format="%d/%m/%Y %H:%M:%S")

## Convert Date and Time columns into proper Date and Time
df2$Date <- as.Date(df2$Date, format="%d/%m/%y")
df2$Time <- strptime(df2$Time, format="%H:%M:%S")

##Create png with 4 plots
png(filename="plot4.png", width=480, height=480)

par(mfcol=c(2,2))

#Plot 1
with(df2, plot(DateTime, Global_active_power, 
               type = "l", 
               xlab = "",
               ylab = "Global Active Power"))


#Plot 2
with(df2, plot(DateTime, Sub_metering_1, 
               type = "l",
               xlab = "",
               ylab = "Energy sub metering"))
with(df2,lines(DateTime, Sub_metering_2, col = "red"))
with(df2,lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", 
       lwd = 1, 
       bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot 3
with(df2, plot(DateTime, Voltage, 
               type = "l", 
               xlab = "datetime",
               ylab = "Voltage"))

#Plot 4
with(df2, plot(DateTime, Global_reactive_power, 
               type = "l",
               lwd = 1,
               xlab = "datetime",
               ylab = "Global_reactive_power"))

dev.off()