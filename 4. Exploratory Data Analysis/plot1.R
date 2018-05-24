og <- read.table("./data/household_power_consumption.txt",na.strings = "?", stringsAsFactors = F, header=T, sep=";")
og$Date <- as.Date(og$Date, "%d/%m/%Y")
og$Time <- format(strptime(og$Time, "%H:%M:%S"),"%H:%M:%S")
epc <- subset(og, (og$Date==as.Date("1/2/2007", "%d/%m/%Y")| og$Date ==as.Date("2/2/2007", "%d/%m/%Y")))
dim(epc)

