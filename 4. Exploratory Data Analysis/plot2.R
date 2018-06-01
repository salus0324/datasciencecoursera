# Read RDS file
rd <- readRDS("./data/summarySCC_PM25.rds")
# Extract pm2.5 Emissions and year data from Baltimore City Maryland
pm <- rd[rd$fips=="24510", c(4,6)]
# Use tapply to sum up the emissions by year
total <- with(pm, tapply(Emissions, year, sum, na.rm=T))
# Convert total to data frame
final <- data.frame(year=format(as.Date(names(total), "%Y"), "%Y"), total=total)
# Plot the emission from Baltimore city from 1999 to 2008
plot(x=as.numeric(as.character(final[,1])), y= final[,2],type = "o", main ="PM2.5 Emission in the Baltimore City, Maryland", xlab="Year", ylab="Emissions")
# Export the plot as png file
dev.copy(png, "plot2.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
