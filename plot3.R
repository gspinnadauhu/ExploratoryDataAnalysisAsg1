#Download & unzip
if(!file.exists("data")){
  dir.create("data")
}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./data/elec_power_consumption.zip",method="curl")
unzip("./data/elec_power_consumption.zip",overwrite=TRUE,exdir="./data/")
datalist<-list.files("./data/")
datadir<-paste0("./data/",datalist[2])
list.files(datadir)
#read file
library(data.table)
dataset<-read.table(datadir,sep=";",na.strings="?",header=TRUE)
library(dplyr)
dataset<-mutate(dataset,Time=paste(Date,Time,sep=" "))
dataset$Time<-strptime(dataset$Time,"%d/%m/%Y %H:%M:%S")
dataset$Date<-as.Date(dataset$Date,"%d/%m/%Y")
#subset for 2007-02-01 to 2007-02-02
date1<-as.Date("2007-02-01")
date2<-as.Date("2007-02-02")
datasubset<-dataset[dataset$Date>=date1 & dataset$Date<=date2,]
#plot3
with(datasubset,plot(Time,
                     Sub_metering_1,
                     ylab="Energy sub metering",
                     type="l"))
with(datasubset,lines(Time,Sub_metering_2,col="red"))
with(datasubset,lines(Time,Sub_metering_3,col="blue"))
with(datasubset,legend("topright",
                       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                       col=c("black","red","blue"),
                       lty=1))