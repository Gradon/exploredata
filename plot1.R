# question: have total PM2.5 emissions decreased in the US from 1999-2008?
# plot total PM2.5 emission from all sources for 1999, 2002, 2005, 2008.

# national emissions data
NEIdata <- readRDS("summarySCC_PM25.rds")
# classification code mappings
SCCmap <- readRDS("Source_Classification_Code.rds")

# total up the PM2.5 emissions by year
totalemissions <- with(NEIdata, tapply(Emissions, year, sum))

# open file device for plotting
png(filename = "plot1.png", width = 480, height = 480)

# plot total emissions
plot(names(totalemissions), totalemissions, xlab = "Year", ylab = "PM2.5", pch = 20, main = "Total PM2.5 Emissions by Year")

# close png device
dev.off()
