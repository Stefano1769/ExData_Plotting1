file <- file("household_power_consumption.txt")
data <-read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

data1 <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date),data1$Time)
data1$Datetime <- as.POSIXct(datetime)

par(mfrow= c(2,2),mar= c(4,4,2,1), oma=c(0,0,2,0))
with(data1, {
        plot(Global_active_power~Datetime,type="l",ylab="Global Active Power (kilowatts)",xlab="")
        plot(Voltage~Datetime, type="l",ylab="Energy sub metering", xlab="datetime")
        plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
                lines(Sub_metering_2~Datetime, col="red")
                lines(Sub_metering_3~Datetime, col="blue")
                legend("topright",col=c("black","red","blue"), lty = 1,lwd=2,bty = "n", c("sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        plot(Global_reactive_power~Datetime,type="l",ylab="Global Reactive Power",xlab="datetime")
})

dev.copy(png,file="plot4.png")
dev.off()