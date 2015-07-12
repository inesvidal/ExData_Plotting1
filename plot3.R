# The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory 
# the dataset will require in memory before reading into R. Make sure your computer has enough memory 
#(most modern computers should be fine).
# 
# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset 
# and subsetting to those dates.
# 
# You may find it useful to convert the Date and Time variables to Date/Time 
# classes in R using the strptime() and as.Date() functions.
# 
# Note that in this dataset missing values are coded as ?.

# Goal: Examine how household energy usage varies over a 2-day period in February, 2007. 
# Your task is to reconstruct the following plots below, all of which were constructed 
# using the base plotting system.

# For each plot you should
# 
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 
# Name each of the plot files as plot1.png, plot2.png, etc.
# 
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
# i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for 
# reading the data so that the plot can be fully reproduced. You must also include the code 
# that creates the PNG file.
# Add the PNG file and R code file to the top-level folder of your git repository (no need for separate 
# sub-folders)
# When you are finished with the assignment, push your git repository to GitHub so that the GitHub 
# version of your repository is up to date. There should be four PNG files and four R code files, 
# a total of eight files in the top-level folder of the repo.

#################
# Creates Plot 3 
#################

filename = "./household_power_consumption.txt"

setwd("/Users/inesv/Coursera/4-Exploratory/w1")
if(!file.exists("ExData_Plotting1")) {
    dir.create("ExData_Plotting1")
}
setwd("/Users/inesv/Coursera/4-Exploratory/w1/ExData_Plotting1")

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(filename)) {
    # download file
    download.file(file_url, "./household_power_consumption.zip", method = "curl")
    date_downloaded <- date()    
    
    # unziping the files
    unzip (filename, exdir = "./", junkpaths = TRUE)
}        

# read records for days 1-2/02/2007
library(sqldf)
filter <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
data <-read.csv.sql(filename, header = TRUE, sep = ";", sql = filter)
closeAllConnections()

# showConnections(all = FALSE)
# getConnection(what)
# closeAllConnections()

# create DateTime column

data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# create plot 
plot_name <- "plot3.png"
png(filename = plot_name, width = 480, height = 480, units = "px", pointsize = 12)

with(data, {
    plot(x=DateTime, y=Sub_metering_1, type = "l", xlab = "", 
         ylab = "Energy sub metering")
    lines(x=DateTime, y=Sub_metering_2, type = "l", xlab = "", 
          col ="red")
    lines(x=DateTime, y=Sub_metering_3, type = "l", xlab = "", 
          col ="blue")
})
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col=c("black", "red", "blue"), cex = 1, y.intersp = 1)
dev.off()
