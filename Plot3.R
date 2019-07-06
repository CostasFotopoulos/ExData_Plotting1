
#Variable used for printing in console for debugging
printOut <- FALSE

#Download and unzip data
if(!file.exists('data.zip')){
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                    destfile = "data.zip", method = "curl")
      if(printOut){print("File downloaded successfully")}
} else {if(printOut){print('File already exist')}}

if(!file.exists('household_power_consumption.txt')){
      unzip("data.zip")
      if(printOut){print("File unzipped successfully")}
} else {if(printOut){print('File already unzipped')}}

#Set time variables for subsetting data
time1 <- strptime("2007-02-01", format = "%Y-%m-%d")
time2 <- strptime("2007-02-02", format = "%Y-%m-%d")

#Loading data to dataframe
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Convert data
df$Date <- strptime(df$Date, format = "%d/%m/%Y")
df2 <- df[which(df$Date>=time1 & df$Date<=time2),]
df2$Global_active_power <- as.numeric(df2$Global_active_power)/500
df2$weekday <- as.factor(weekdays(df2$Date))
df2$Time <- paste(df2$Date, df2$Time)
df2$Time <- strptime(df2$Time, format = "%Y-%m-%d %H:%M:%S")



#Plotting and saving data
png(filename = "Plot4.png", width = 480, heigh = 480)
plot(df2$Time, df2$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering',yaxt="none", ylim = c(0,40))
lines(df2$Time, as.numeric(paste(df2$Sub_metering_1)), col = 'black')
lines(df2$Time, as.numeric(paste(df2$Sub_metering_2)), col = 'red')
lines(df2$Time, df2$Sub_metering_3, col = 'blue')
axis(2, seq(0,30,10))
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1,1,1))


dev.off()