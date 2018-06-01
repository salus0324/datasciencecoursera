# Import ggplot2 library
library(ggplot2)
# Read RDS file
rd <- readRDS("./data/summarySCC_PM25.rds")
code <- readRDS("./data/Source_Classification_Code.rds")
# Extract pm2.5 SCC, Emissions and year data from Baltimore City Maryland and LA
pmB <- rd[rd$fips=="24510", c(2,4,6)]
pmL <- rd[rd$fips=="06037", c(2,4,6)] 
# Get Vehicle related SCC code
vehicle <- code[grepl("Vehicles", code$EI.Sector),"SCC"]

# Extract emission data that has the Vehicle SCC code for Baltimore and LA
pmB <- subset(pmB, SCC %in% vehicle)
pmL <- subset(pmL, SCC %in% vehicle )
# Use tapply to sum up the emissions by year for each city
totalB <- with(pmB, tapply(Emissions, year, sum, na.rm=T))
totalL <- with(pmL, tapply(Emissions, year, sum, na.rm=T))
# Conver the totalB and totalL to data frames and merge them together
B <- data.frame(year=names(totalB), Emissions=totalB, City="Baltimore")
L <- data.frame(year=names(totalL), Emissions=totalL, City="LA")
mrg <- rbind(B,L)
# Change the data type of the mrg$year to numeric
mrg$year <- as.numeric(as.character(mrg$year))
# Plot motor vehicle sourced PM2.5 emission of Baltimore city and LA.
ggplot(data=mrg, aes(x=year, y=Emissions, color=City))+geom_line()+labs(title="PM25 Emission on Baltimore City from Motor Vehicle", y="Emissions", x="year")




# Export the plot as png file
dev.copy(png, "plot6.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
