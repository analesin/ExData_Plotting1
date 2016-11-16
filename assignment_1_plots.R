data<- read.table("/Users/analesin/household_power_consumption.txt", as.is=T, header=T, sep=";")

#changing the date variable to date format
data$Date<- as.Date(data$Date, sep="//", "%d/%m/%Y")
Date1<- as.Date("01/02/2007",sep="//", "%d/%m/%Y")
Date2<- as.Date("02/02/2007",sep="//", "%d/%m/%Y")

#dividing the data to work with
data_sub<- data[data$Date >= Date1 & data$Date <= Date2,]

#Other transformations
Golbal_active<- data_sub["Global_active_power"]
data_sub$time<- strptime(data_sub$Time, "%H:%M:%S",tz="UTC")
data_sub$Global_active_power<- as.numeric(data_sub$Global_active_power)
data_sub$Sub_metering_1= as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2=as.numeric(data_sub$Sub_metering_2)
data_sub$datetime <- as.POSIXct(paste(data_sub$Date,data_sub$Time),tz="UCT")

#Plotting and saving the graphs
png("plot_1.png",width=480,height=480)
hist(data_sub$Global_active_power, main="Global Active Power", xlab="Global active power", col="red")
dev.off()
png("plot_2.png", width=480, height=480)
plot(data_sub$datetime,data_sub$Global_active_power,type="l", ylab="Global Active Power(kilowatt)",xlab="")
dev.off()
png("plot_3.png", width=480, height=480)
plot(data_sub$datetime, data_sub$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="Days")
lines(data_sub$datetime, data_sub$Sub_metering_2, type="l", col="red")
lines(data_sub$datetime, data_sub$Sub_metering_3, type="l", col="blue")
dev.off()
png("plot_4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(data_sub$datetime,data_sub$Global_active_power,type="l",ylab="Global Active Power")
plot(data_sub$datetime,data_sub$Voltage,type="l",ylab="Voltage",xlab="datetime")
plot(data_sub$datetime, data_sub$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="Days")
lines(data_sub$datetime, data_sub$Sub_metering_2, type="l", col="red")
lines(data_sub$datetime, data_sub$Sub_metering_3, type="l", col="blue")
plot(data_sub$datetime,data_sub$Global_reactive_power,type="l",ylim=c(0,0.5),ylab="Global_reactive_power",xlab="datetime")
dev.off()


