##  Exploratory Data Analysis Course Project
## Plot 5
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

##  Filter NEI list on SCC and reduce to Baltimore City
NEI_motor <- subset(NEI, NEI$SCC %in% scc_list)
NEI_motor <- subset(NEI_motor, NEI_motor$fips == "24510")

##  Plot by year and total sum
if (!exists("NEI_motor_sum")) {
    NEI_motor_sum <- aggregate(Emissions ~ year, NEI_motor, sum)
}

png(filename = "plot5.png")
plot(NEI_motor_sum$year, 
     NEI_motor_sum$Emissions, pch = 20, 
     main = "Total Motor Vehicle emissions by year in Baltimore", 
     xlab = "Year",
     ylab = "Plot 5: Total Motor Vehicle Emissions")
dev.off()