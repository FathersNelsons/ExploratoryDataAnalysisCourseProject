##  Exploratory Data Analysis Course Project
if (!exists("NEI") || !exists("SCC") ) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                  destfile = "data.zip")
    
    unzip("data.zip", overwrite = TRUE)
    
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

##  Plot 2
#   Do the same thing, but now do it for just Baltimore City
if (!exists("NEI_year_baltimore")) {
    NEI_year_baltimore <- aggregate(Emissions ~ year, subset(NEI, fips == "24510"), sum)
}

png(filename = "plot2.png")
plot(NEI_year_baltimore$year, 
     NEI_year_baltimore$Emissions, pch = 20, 
     main = "Total emissions by year for Baltimore", 
     xlab = "Year",
     ylab = "Total Emissions")
dev.off()