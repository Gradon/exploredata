# question: How have emissions from motor vehicles changed from 1999–2008 in Baltimore City?

# national emissions data
NEIdata <- readRDS("summarySCC_PM25.rds")
# classification code mappings
SCCmap <- readRDS("Source_Classification_Code.rds")

# subset to Baltimore City emissions only
baltemissions <- subset(NEIdata, fips == 24510)

# on-road and non-road sources are motor vehicles, can just subset by type instead of SCC code
baltmotors <- subset(baltemissions, type == "ON-ROAD" | type == "NON-ROAD")

# total Baltimore City motor vehicle data for each year
totalbaltmotors <- with(baltmotors, tapply(Emissions, year, sum))

# open file device for plotting
png(filename = "plot5.png", width = 480, height = 480)

# plot total emissions
plot(names(totalbaltmotors), totalbaltmotors, xlab = "Year", ylab = "PM2.5", pch = 20, main = "Motor Vehicle-Related PM2.5 Emissions in Baltimore City by Year")

# close png device
dev.off()