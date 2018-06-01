# Read RDS files
rd <- readRDS("./data/summarySCC_PM25.rds")
code <- readRDS("./data/Source_Classification_Code.rds")

# Get coal combustion related SCC code
coalcomb <- code[grepl("Coal", code$EI.Sector),"SCC"]
# Extract emission data that has the coalcomb SCC code
pm <- subset(rd, SCC %in% coalcomb)
# Use tapply to sum up the emissions by year
total <- with(pm, tapply(Emissions, year, sum, na.rm=T))
# Plot PM2.5 Emission from coal-combusition source over time
plot(x=as.numeric(names(total)), y= total,type = "o", main ="PM2.5 Emission from Coal-combustion Source", xlab="Year", ylab="Emissions", sub="[US]")
# Export the plot as png file
dev.copy(png, "plot4.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
