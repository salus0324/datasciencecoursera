# Read RDS file
rd <- readRDS("./data/summarySCC_PM25.rds")
# Extract pm2.5 SCC and Emissions data
pm <- rd[,c(4,6)]

# Use tapply to sum up the emissions for each year
total <- with(pm, tapply(Emissions, year, sum, na.rm=T))

# Convert total to data frame and name the data frames
d <- data.frame(year=names(total), total=total)
names(d) <- c("Year", "Emissions")

# Plot the emission data
with(d, plot(x=as.numeric(as.character(d$Year)), y=d$Emissions, main="PM2.5 Total Emissions from US", type="o", xlab="Year", ylab="Emissions"))

# Export the plot as png file
dev.copy(png, "plot1.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
