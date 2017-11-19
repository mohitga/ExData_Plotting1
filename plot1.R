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

## Plot 1
## Histogram plotting with Global_active_power variable.
## color = Red
## x-axis label  Global Active Power (kilowatts)
## y-axis label Frequency
## Main title Global Active Power
## Cex. sun for subtitle magnification

with(plotdata, hist(Global_active_power, col = "Red", main="Global Active Power", 
                    xlab="Global Active Power (kilowatts)", ylab="Frequency", cex.sub=0.8))

#Export the plot into Png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()





