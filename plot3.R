#########################################################################################################
#Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007

#Firstly create figure folder for figure 
if (!file.exists("figure"))
{
        dir.create("figure");
}

#We will only be using data from the dates 2007-02-01 and 2007-02-02
data<- read.table(pipe('grep "^[1-2]/2/2007" "./PowerData/household_power_consumption.txt"'), sep = ";", na.strings = "?");
#Reading the columns names of the data frame
ColNames<-read.table("./PowerData/household_power_consumption.txt",nrow=1,sep=";");
#Naming the columns for the data frame
colnames(data)<-as.character(unlist(ColNames[1,]));

#Combining Time and date Columns
data[,1]<-paste(data$Date, data$Time, sep=" ");
#Naming the modified Time and date concatenated column
colnames(data)[1] = "Date/Time";
#Removing the date column
data <- subset(data, select = -c(Time));
#data[,1]<-strptime(data[,1], format='%d/%m/%Y %H:%M:%S');

#Opening the file device
png("./figure/plot3.png", width = 480, height = 480)
#Writing to the file device
plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_1,xlab="",ylab="Energy sub metering",main="",type="n");
#Line for sub meteting 1
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_1,col="black");
#Line for sub meteting 2
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_2,col="red");
#Line for sub meteting 3
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_3,col="blue");
#Adding legends
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend 
       
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue"));
#Closing the file device
dev.off()
