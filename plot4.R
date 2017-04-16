##  Exploratory Data Analysis Course Project
if (!exists("NEI") || !exists("SCC") ) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
                  destfile = "data.zip")
    
    unzip("data.zip", overwrite = TRUE)
    
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

##  Plot 4

#   Get the list of SCC values for all classifications involving combustion AND coal
SCC_combust <- SCC[grepl("Combustion", SCC$SCC.Level.One),]
SCC_combust_coal <- SCC_combust[grepl("Coal", SCC_combust$SCC.Level.Three),]
scc_list <- SCC_combust_coal$SCC

#   Filter NEI by this classification
NEI_coal <- subset(NEI, NEI$SCC %in% scc_list)

#Plot it
if (!exists("NEI_coal_sum")) {
    NEI_coal_sum <- aggregate(Emissions ~ year, NEI_coal, sum)
}

png(filename = "plot4.png")
plot(NEI_coal_sum$year, 
     NEI_coal_sum$Emissions, pch = 20, 
     main = "Total coal emissions by year", 
     xlab = "Year",
     ylab = "Plot 4: Total Coal Emissions")
dev.off()
