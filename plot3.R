## import data from the "household_power_consumption.txt" file, separator is ;, NA is ? (2075259 rows x 9 columns)
data_complete <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
# 1. Date: Date in format dd/mm/yyyy 
# 2. Time: time in format hh:mm:ss 
# 3. Global_active_power: household global minute-averaged active power (in kilowatt) 
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
# 5. Voltage: minute-averaged voltage (in volt) 
# 6. Global_intensity: household global minute-averaged current intensity (in ampere) 
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds 
#    to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not 
#    electric but gas powered). 
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to 
#    the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. 
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to 
#    an electric water-heater and an air-conditioner.

## convert data column in data format 
data_complete$Date <- as.Date(data_complete$Date, "%d/%m/%Y")
## filter rows with date between "2007-02-01" and "2007-02-02", all collumns (2880 rows x 9 columns)
data_filtered <- data_complete[data_complete$Date>=as.Date("2007-02-01") & data_complete$Date<=as.Date("2007-02-02"), ]
## remove complete dataset for memory efficiency
rm(data_complete)
## create Timestamp column
data_filtered$Timestamp <- paste(as.Date(data_filtered$Date), data_filtered$Time)
## convert in a time format
data_filtered$Timestamp <- strptime(data_filtered$Timestamp, "%Y-%m-%d %H:%M:%S")

## create plot3.png image
png("plot3.png", width = 480, height = 480, units = "px")
with(data_filtered, {
        ## create chart on Sub_metering_1
        plot (x=Timestamp, y=Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        ## add line for Sub_metering_2
        lines(x=Timestamp, y=Sub_metering_2, col="red")
        ## add line for  Sub_metering_3
        lines(x=Timestamp, y=Sub_metering_3, col="blue")
        ## create legend
        legend("topright", col=c("black","red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1) )
        ## close graphical device and save image
})
dev.off()