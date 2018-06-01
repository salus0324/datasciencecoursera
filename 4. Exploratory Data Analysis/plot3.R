# Import ggplot2 library
library(ggplot2)
# Read RDS file
rd <- readRDS("./data/summarySCC_PM25.rds")
# Extract pm2.5 SCC and Emissions and type for Baltimore City for each year
pm1 <- rd[rd$fips=="24510"& rd$year=="1999", c(4,5:6)]
pm2 <- rd[rd$fips=="24510"& rd$year=="2002", c(4,5:6)]
pm3 <- rd[rd$fips=="24510"& rd$year=="2005", c(4,5:6)]
pm4 <- rd[rd$fips=="24510"& rd$year=="2008", c(4,5:6)]

# Use tapply to sum up the emissions by type for each year and convert them to a data frame
total1 <- with(pm1, tapply(Emissions, type, sum, na.rm=T))
d1 <- data.frame(type=names(total1), total=total1, year="1999")
total2 <- with(pm2, tapply(Emissions, type, sum, na.rm=T))
d2 <- data.frame(type=names(total2), total=total2, year="2002")
total3 <- with(pm3, tapply(Emissions, type, sum, na.rm=T))
d3 <- data.frame(type=names(total3), total=total3, year="2005")
total4 <- with(pm4, tapply(Emissions, type, sum, na.rm=T))
d4 <- data.frame(type=names(total4), total=total4, year="2008")
# Combine data frames of all the years
d <- rbind(d1,d2,d3,d4)
# Assign index number to d dataframe
rownames(d) <- 1:16
# Convert the data class of d$year column
d$year <- as.numeric(as.character(d$year))
# Plot the PM25 emission on Baltimore City over time by type category.
ggplot(data=d, aes(x=year, y=total, color=type))+geom_line()+labs(title="PM25 Emission on Baltimore City, Maryland", y="Emissions", x="year")

# Export the plot as png file
dev.copy(png, "plot3.png", width = 480, height = 480)
# Turn off the graphic device
dev.off()
