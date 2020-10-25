# question: compare emissions from motor vehicles in Baltimore City with those in Los Angeles.
# which city has seen greater changes over time in motor vehicle emissions?

# national emissions data
NEIdata <- readRDS("summarySCC_PM25.rds")
# classification code mappings
SCCmap <- readRDS("Source_Classification_Code.rds")

# subset to Baltimore City emissions only
baltemissions <- subset(NEIdata, fips == 24510)

# on-road and non-road sources are motor vehicles, can just subset by type instead of SCC code
baltmotors <- subset(baltemissions, type == "ON-ROAD" | type == "NON-ROAD")

# total Baltimore City motor vehicle data data for each year
totalbaltmotors <- with(baltmotors, tapply(Emissions, year, sum))

# subset to LA County emissions only
laemissions <- subset(NEIdata, fips == "06037")

# on-road and non-road sources are motor vehicles, can just subset by type instead of SCC code
lamotors <- subset(laemissions, type == "ON-ROAD" | type == "NON-ROAD")

# total LA County motor vehicle data data for each year
totallamotors <- with(lamotors, tapply(Emissions, year, sum))

# open file device for plotting
png(filename = "plot6.png", width = 480, height = 480)

# plot vehicle emissions
plot(names(totalbaltmotors), totalbaltmotors, xlab = "Year", ylab = "PM2.5", pch = 20, col = "red", main = "Motor Vehicle-Related PM2.5 Emissions in Baltimore City by Year", ylim = range(totalbaltmotors, totallamotors))
points(names(totallamotors), totallamotors, pch = 18, col = "blue")
legend("topright", c("Baltimore City", "LA County"), lty = 1, col = c("red", "blue"))

# close png device
dev.off()