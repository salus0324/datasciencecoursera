# Read RDS file
rd <- readRDS("./data/summarySCC_PM25.rds")
# Extract pm2.5 SCC and Emissions data for each year
pm1 <- rd[rd$year=="1999",c(2,4)]
pm2 <- rd[rd$year=="2002",c(2,4)]
pm3 <- rd[ard$year=="2005",c(2,4)]
pm4 <- rd[rd$year=="2008",c(2,4)]

# Use tapply to sum up the emissions by SCC for each year
total1 <- with(pm1, tapply(Emissions, SCC, sum, na.rm=T))
total2 <- with(pm2, tapply(Emissions, SCC, sum, na.rm=T))
total3 <- with(pm3, tapply(Emissions, SCC, sum, na.rm=T))
total4 <- with(pm4, tapply(Emissions, SCC, sum, na.rm=T))

# Convert total1-4 to data frame and name the data frames
d1 <- data.frame(SCC=names(total1), mean=total1)
d2 <- data.frame(SCC=names(total2), mean=total2)
d3 <- data.frame(SCC=names(total3), mean=total3)
d4 <- data.frame(SCC=names(total4), mean=total4)
names(d1) <- c("SCC", "mean_1999")
names(d2) <- c("SCC", "mean_2002")
names(d3) <- c("SCC", "mean_2005")
names(d4) <- c("SCC", "mean_2008")

# Merge all the data frames
mrg <- merge(d1, merge(d2, merge(d3, d4, by="SCC"), by="SCC"), by="SCC")
# Plot the emission data for 1999
with(mrg, plot(rep(1999,2577), mrg[,2], xlim=c(1998,2009), main="PM2.5 Total Emissions from US"))
# Plot the emission data for 2002
with(mrg, points(rep(2002,2577), mrg[,3], xlim=c(1998,2009)))
# Plot the emission data for 2005
with(mrg, points(rep(2005,2577), mrg[,4], xlim=c(1998,2009)))
# Plot the emission data for 2008
with(mrg, points(rep(2008,2577), mrg[,5], xlim=c(1998,2009)))
# Connect data point from each year 
segments(rep(1999,2577), mrg[,2], rep(2002,2577),mrg[,3])
segments(rep(2002,2577), mrg[,3], rep(2005,2577),mrg[,4])
segments(rep(2005,2577), mrg[,4], rep(2008,2577),mrg[,5])
# Export the plot as png file
dev.copy(png, "plot1.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
