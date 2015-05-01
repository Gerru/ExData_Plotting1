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

## Create png with plot
png(filename="plot2.png", width=480, height=480)
with(df2, plot(DateTime, Global_active_power, 
               type = "l", 
               xlab = "",
               ylab = "Global Active Power (kilowatts)"))
dev.off()