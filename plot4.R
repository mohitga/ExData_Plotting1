#
#download and unzip file
DownlaodUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(DownlaodUrl, destfile="data.zip", method="curl")
unzip ("data.zip", exdir = "./")

#read data into rawdata
filename <- "household_power_consumption.txt"
rawdata <- read.table(filename, header=TRUE, na.strings="?", sep=";")

#subset the data required for plotting into plotdata
plotdata <- rawdata[(rawdata$Date=="1/2/2007" | rawdata$Date=="2/2/2007" ), ]

#change the format for date variable to Date from factor
plotdata <- transform(plotdata, Date = as.Date(Date,format = "%d/%m/%Y") )

#add dateTime as paste of date and time with class as POSIXct
plotdata <- transform(plotdata, dateTime = as.POSIXct(paste(plotdata$Date, plotdata$Time)))

#remove the rawdata
rm(rawdata)

#Now create the plot.

## Plot 4
## Set the layout 2,2 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#Plot
with(plotdata, {
  
  #1. Global_active_power~dateTime type line
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  
  #2. Voltage~dateTime type line  
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="", cex=0.8)
  
  #3. Sub_metering_1~dateTime type line  
  #set the appropriate legends 
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
  
  #4. Global_reactive_power~dateTime type line  
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="", cex=0.8)
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()




