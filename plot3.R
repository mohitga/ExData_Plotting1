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

## Plot 3
## plot with Global_active_power ~ dateTime variable.
## y-axis label  Global Active Power (kilowatts)
## type as l

with(plotdata, {
     plot(Sub_metering_1 ~ dateTime, plotdata,  type="l",
          ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
     lines(Sub_metering_2 ~ dateTime, col = "Red")
     lines(Sub_metering_3 ~ dateTime, col = "Blue")
})     

#put the legends
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
#Export the plot into Png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()





