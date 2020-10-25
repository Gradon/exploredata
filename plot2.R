# question: have total PM2.5 emissions decreased in Baltimore City, MD (fips = 24510)
# from 1999 to 2008? Plot the answer to this question using base plotting system

# national emissions data
NEIdata <- readRDS("summarySCC_PM25.rds")
# classification code mappings
SCCmap <- readRDS("Source_Classification_Code.rds")

# subset to Baltimore City emissions only
baltemissions <- subset(NEIdata, fips == 24510)

# total up emissions in Baltimore City
totalemissions <- with(baltemissions, tapply(Emissions, year, sum))

# open file device for plotting
png(filename = "plot2.png", width = 480, height = 480)

# plot total emissions
plot(names(totalemissions), totalemissions, xlab = "Year", ylab = "PM2.5", pch = 20, main = "Baltimore City PM2.5 Emissions by Year")

# close png device
dev.off()
