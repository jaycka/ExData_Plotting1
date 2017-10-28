library(dplyr)
library(lubridate)

data <- read.table('./household_power_consumption.txt',header=TRUE,sep = ';',na.strings = '?')
data $Date <-dmy(data$Date)
feb <- filter(data,Date=='2007-02-01' | Date == '2007-02-02')
feb$Datetime <- as.POSIXct(paste(feb$Date, feb$Time), format="%Y-%m-%d %H:%M:%S")

png(filename = 'plot4.png',width = 480,height = 480,units = 'px')
par(mfrow=c(2,2))

with(feb,plot(Datetime,Global_active_power,type='l',xlab='',ylab = 'Global Active Power'))

with(feb,plot(Datetime,Voltage,type='l',xlab='datetime',ylab = 'Voltage'))

with(feb,plot(Datetime,Sub_metering_1,type = 'l',xlab = '',ylab='Energy sub metering'))
with(feb,lines(Datetime,Sub_metering_2,type = 'l',col='red'))
with(feb,lines(Datetime,Sub_metering_3,type = 'l',col='blue'))
legend('topright',lty=1,col=c('black','red','blue'),bty='n',cex=0.9,legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

with(feb,plot(Datetime,Global_reactive_power,type='l',xlab = 'datetime',ylab = 'Global_reactive_power'))

dev.off()