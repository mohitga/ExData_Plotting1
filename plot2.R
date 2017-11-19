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

## Plot 2
## plot with Global_active_power ~ dateTime variable.
## y-axis label  Global Active Power (kilowatts)
## type as l

plot(Global_active_power ~ dateTime, plotdata,   
                    ylab="Global Active Power (kilowatts)", type="l")

#Export the plot into Png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()





