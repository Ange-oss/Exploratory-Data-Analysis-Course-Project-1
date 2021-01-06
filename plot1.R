#Download the file
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('Plot Dataset.zip')){
        download.file(url1, 'Plot Dataset.zip', method = "curl" )
        unzip("Plot Dataset.zip", exdir= getwd())
        
}
#Read head of the file
headata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                      nrows = 10)
view(headata)

# read file from 2007-02-01 to 2007-02-02
data1 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                    col.names = names(headata), skip = 66636, nrows = 2881, 
                    na.strings = "?", colClasses = c('character','character',
                                                     'numeric','numeric','numeric','numeric','numeric','numeric',
                                                     'numeric'))
View(data1)

#Convert time data
data1$Date <- as.Date(data1$Date, format = "%d/%m/%Y")
data1$Time<-strptime(paste(data1$Date,data1$Time),"%F %T")
data1<-subset(data1,data1$Date %in% as.Date(c("2007-02-01","2007-02-02")))

#PLOT 1
par(mfrow=c(1,1))
hist(data1$Global_active_power, main ="Global Active Power", xlab = "Global Active Power (Kilowatts)", col = "red" )
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()