# question: across the US, how have emissions from coal combustion sources changed from 1999–2008?

# national emissions data
NEIdata <- readRDS("summarySCC_PM25.rds")
# classification code mappings
SCCmap <- readRDS("Source_Classification_Code.rds")

# get the set of source classification codes corresponding to coal
coalcodes <- subset(SCCmap, grepl("coal", SCCmap$EI.Sector, ignore.case = TRUE))

# take the NEI data for the SCC codes matching the coal sources
coalsources <- subset(NEIdata, NEIdata$SCC %in% coalcodes$SCC)

# total all coal source data for each year
totalcoal <- with(coalsources, tapply(Emissions, year, sum))

# open file device for plotting
png(filename = "plot4.png", width = 480, height = 480)

# plot coal emissions
plot(names(totalcoal), totalcoal, xlab = "Year", ylab = "PM2.5", pch = 20, main = "Coal-Related PM2.5 Emissions by Year")

# close png device
dev.off()