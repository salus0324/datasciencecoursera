# Read RDS files
rd <- readRDS("./data/summarySCC_PM25.rds")
code <- readRDS("./data/Source_Classification_Code.rds")
# Extract pm2.5 SCC, Emissions and year data from Baltimore City Maryland
pm <- rd[rd$fips=="24510", c(2,4,6)]
# Get Vehicle related SCC code
vehicle <- code[grepl("Vehicles", code$EI.Sector),"SCC"]
# Extract emission data that has the Vehicle SCC code
pm <- subset(pm, SCC %in% vehicle)
# Use tapply to sum up the emissions by year
total <- with(pm, tapply(Emissions, year, sum, na.rm=T))
# Plot PM2.5 Emission from motor Vehicle source over time
plot(x=as.numeric(names(total)), y= total,type = "o", main ="PM2.5 Emission from Motor Vehicle Source", xlab="Year", ylab="Emissions", sub= "[Baltimore City]")

# Export the plot as png file
dev.copy(png, "plot5.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
