

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


#Plotting data
png(filename = "Plot4.png", width = 480, heigh = 480)
hist(as.numeric(as.character(df2$Global_active_power)), main = "Global Active Power", col = 'red', xlab = "Global Active Power (kilowatts)")

dev.off()