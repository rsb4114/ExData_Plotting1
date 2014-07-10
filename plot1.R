##ED Assignment1

#Individual household electric power consumption Data Set
#The following descriptions of the 9 variables in the dataset :
#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

library(data.table)

initial <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", nrows = 100) 

classes <- sapply(initial, class)
cnames <- colnames(initial)

#read relevant data
hhep <- read.table("./household_power_consumption.txt", header = FALSE, sep = ";", colClasses = classes, col.names = cnames, skip = 66000, nrows = 4000)

#Format Date Time
hhep$DateTime <- paste (hhep$Date, hhep$Time)
hhep$DateTime <- strptime(hhep$DateTime, "%d/%m/%Y %H:%M:%S")

#convert to date format
hhep$Date <- as.Date(hhep$Date, format = "%d/%m/%Y")
class(hhep$Date)


#filter only dates between 2007-02-01 and 2007-02-01
reqdaterows <- (hhep$Date >= "2007-02-01") & (hhep$Date <= "2007-02-02")
sum(reqdaterows)
hhep <- hhep[reqdaterows, ]

#Construct the plot and save it to a PNG file 
#with a width of 480 pixels and a height of 480 pixels

#Plot 1
#Copy the plot to a PNG file
png (file = "plot1.png", width = 480, height = 480)
#plot histogram of Global active power
hist(hhep$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off() ## close the PNG device
