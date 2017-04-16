##  Exploratory Data Analysis Course Project
## Plot 6

if (!exists("NEI") || !exists("SCC") ) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                  destfile = "data.zip")
    
    unzip("data.zip", overwrite = TRUE)
    
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

##  Get list of SCC for motor vehicle sources
SCC_motor <- SCC[grepl("Vehicles", SCC$SCC.Level.Two),]
scc_list <- SCC_motor$SCC

##  Filter NEI list on SCC and reduce to Baltimore City and LA County
NEI_motor <- subset(NEI, NEI$SCC %in% scc_list)
NEI_motor_baltimore <- subset(NEI_motor, NEI_motor$fips == "24510")
NEI_motor_LA <- subset(NEI_motor, NEI_motor$fips == "06037")

#   Plot
if (!exists("baltsum") || !exists("lasum")) {
    baltsum <- aggregate(Emissions ~ year, NEI_motor_baltimore, sum)
    lasum <- aggregate(Emissions ~ year, NEI_motor_LA, sum)
}

#   Set the range for comparison purposes
rng <- range(baltsum$Emissions, lasum$Emissions)

png(filename = "plot6.png", width = 800, height = 640)
par(mfrow = c(1,2))
plot(baltsum$year, 
     baltsum$Emissions, pch = 20, ylim = rng,
     main = "Baltimore City",
     xlab = "Year",
     ylab = "Total Motor Vehicle Emissions")
plot(lasum$year, 
     lasum$Emissions, pch = 20, ylim = rng, 
     main = "LA County",
     xlab = "Year",
     ylab = "Total Motor Vehicle Emissions")
dev.off()