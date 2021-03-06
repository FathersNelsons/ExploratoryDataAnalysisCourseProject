##  Exploratory Data Analysis Course Project
if (!exists("NEI") || !exists("SCC") ) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                  destfile = "data.zip")
    
    unzip("data.zip", overwrite = TRUE)
    
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

##  Plot 1
#   Aggregate the sum of each year as a factor
if (!exists("NEI_years")){
    NEI_years <- aggregate(Emissions ~ year, NEI, sum)
}

png(filename = "plot1.png")
plot(NEI_years$year, 
     NEI_years$Emissions, pch = 20, 
     main = "Total emissions by year", 
     xlab = "Year",
     ylab = "Total Emissions")
dev.off()