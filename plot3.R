# question: of the 4 types of sources indicated by the 'type' (point, nonpoint, onroad, nonroad)
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# which have seen increases in emissions from 1999-2008? Use ggplot2 for this question.

library(ggplot2)

# national emissions data
NEIdata <- readRDS("summarySCC_PM25.rds")
# classification code mappings
SCCmap <- readRDS("Source_Classification_Code.rds")

# subset to Baltimore City emissions only
baltemissions <- subset(NEIdata, fips == 24510)

# subset by type
pointem <- subset(baltemissions, type == "POINT")
nonpointem <- subset(baltemissions, type == "NONPOINT")
onroadem <- subset(baltemissions, type == "ON-ROAD")
nonroadem <- subset(baltemissions, type == "NON-ROAD")

# sum emissions for each
pointtotal <- with(pointem, tapply(Emissions, year, sum))
nonpointtotal <- with(nonpointem, tapply(Emissions, year, sum))
onroadtotal <- with(onroadem, tapply(Emissions, year, sum))
nonroadtotal <- with(nonroadem, tapply(Emissions, year, sum))

# put it in a data frame
plotdata <- data.frame(year = rownames(pointtotal), point = pointtotal, nonpoint = nonpointtotal, onroad = onroadtotal, nonroad = nonroadtotal)

# open file device for plotting
png(filename = "plot3.png", width = 480, height = 480)

# plot total emissions
myplot <- ggplot(plotdata, aes(year, point, color = "Point")) + geom_point(show.legend = TRUE)
myplot <- myplot + labs(x = "Year", y = "PM2.5", title = "Baltimore City PM2.5 Emissions by Year")
myplot <- myplot + geom_point(aes(year, nonpoint, color = "NonPoint"), show.legend = TRUE)
myplot <- myplot + geom_point(aes(year, onroad, color = "OnRoad"), show.legend = TRUE)
myplot <- myplot + geom_point(aes(year, nonroad, color = "NonRoad"), show.legend = TRUE)
myplot <- myplot + scale_color_manual(name = "Type", values = c("Point" = "black", "NonPoint" = "Blue", "OnRoad" = "Red", "NonRoad" = "Green"))
myplot

# close png device
dev.off()
