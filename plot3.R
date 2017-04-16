##  Exploratory Data Analysis Course Project
library(ggplot2)

if (!exists("NEI") || !exists("SCC") ) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                  destfile = "data.zip")
    
    unzip("data.zip", overwrite = TRUE)
    
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

##  Plot 3
#   
if (!exists("NEI_types")) {
    NEI_types <- split(subset(NEI, NEI$fips == "24510"), NEI$type)
}

#   Creates a plot with the sums for each year marked in red
qplot(as.factor(year),
      Emissions,
      data = subset(NEI, NEI$fips == "24510"), 
      facets=.~type) + stat_summary(data = subset(NEI, NEI$fips == "24510"), 
                                    fun.y = sum, 
                                    geom = "point", 
                                    color = "red")

ggsave("plot3.png", device = "png")