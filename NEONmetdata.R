# Install neonUtilities package if you have not yet.
install.packages("neonUtilities")
install.packages("padr")

# Set global option to NOT convert all character variables to factors
options(stringsAsFactors=F)

# Load required packages
library(neonUtilities)
library(ggplot2)
library(dplyr)
library(padr)
library(tidyverse)
library(hydroTSM)


#to follow R script:https://www.neonscience.org/resources/learning-hub/tutorials/explore-neon-ais-data#jump-4

#.............................BARC AIR TEMP........................................#
airT <- loadByProduct(dpID="DP1.20046.001", site="BARC", 
                     startdate="2017-08", enddate="2021-02", 
                     package="basic",
                     check.size = F)
names(airT)
# View the dataFrame
View(airT$RHbuoy_30min)
str(airT$RHbuoy_30min) #horizontalPosition = 103 = on lake bouy
list2env(airT, .GlobalEnv) #30min = 61193 obs and 16 variables

#plot
airTplot <- ggplot() +
  geom_line(data = RHbuoy_30min, color="red",
            aes(endDateTime, tempRHMean), 
            na.rm=TRUE ) +
  ylim(-5, 40) + ylab("Mean Air Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
  plot.title = element_text(color="black",size = 12, face="bold.italic"),
  panel.background = element_rect(fill = 'white', colour = 'black'),
  legend.position = "none") +
  ggtitle("BARCO site - 30min data")
airTplot

#subdaily to daily values
airT30min <- airT$RHbuoy_30min %>% 
  select(startDateTime, tempRHMean)

BARCOairTdaily <- subdaily2daily(airT30min, FUN = mean, dates = 1, na.rm = T)
BARCOairTdaily <- as.data.frame(BARCOairTdaily) #Convert to dataframe
BARCOairTdaily$Date <- as.POSIXct(row.names(BARCOairTdaily)) #Now it is ready to plot
str(BARCOairTdaily)

#plot
airTplot <- ggplot() +
  geom_line(data = BARCOairTdaily, color="red",
            aes(Date, BARCOairTdaily), 
            na.rm=TRUE ) +
  ylim(-5, 40) + ylab("Mean Air Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
airTplot

#BARCO daily air T
write.csv(BARCOairTdaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCOairT.csv", row.names = FALSE)


#.............................BARC PRECIPITATION (terrestrial site)........................................#
rain <- loadByProduct(dpID="DP1.00006.001", site="BARC", 
                      startdate="2017-08", enddate="2021-02", 
                      package="basic",
                      check.size = F)
names(rain)
# View the dataFrame
str(rain$PRIPRE_30min) 
list2env(rain, .GlobalEnv) 

#plot
rainplot <- ggplot() +
  geom_line(data = PRIPRE_30min, color="red",
            aes(endDateTime, priPrecipBulk), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Precipitation (mm)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
rainplot

#subdaily to daily values
rain30min <- rain$PRIPRE_30min %>% 
  select(startDateTime, priPrecipBulk)

BARCOraindaily <- subdaily2daily(rain30min, FUN = sum, dates = 1, na.rm = T)
BARCOraindaily <- as.data.frame(BARCOraindaily) #Convert to dataframe
BARCOraindaily$Date <- as.POSIXct(row.names(BARCOraindaily)) #Now it is ready to plot
str(BARCOraindaily)

#plot
rainplot <- ggplot() +
  geom_line(data = BARCOraindaily, color="red",
            aes(Date, BARCOraindaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Precipitation (mm)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
rainplot

#BARCO daily rain
write.csv(BARCOraindaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCOrain.csv", row.names = FALSE)

#.............................BARC air pressure ........................................#
Barom <- loadByProduct(dpID="DP1.20004.001", site="BARC", 
                      startdate="2017-08", enddate="2021-02", 
                      package="basic",
                      check.size = F)
names(Barom)
# View the dataFrame
str(Barom$BP_30min) 
list2env(Barom, .GlobalEnv) 

#plot
Baromplot <- ggplot() +
  geom_line(data = BP_30min, color="red",
            aes(endDateTime, staPresMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Barometric pressure (kPa)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
Baromplot

#subdaily to daily values
Barom30min <- Barom$BP_30min %>% 
  select(startDateTime, staPresMean)

BARCOBaromdaily <- subdaily2daily(Barom30min, FUN = mean, dates = 1, na.rm = T)
BARCOBaromdaily <- as.data.frame(BARCOBaromdaily) #Convert to dataframe
BARCOBaromdaily$Date <- as.POSIXct(row.names(BARCOBaromdaily)) #Now it is ready to plot
str(BARCOBaromdaily)

#plot
Baromplot <- ggplot() +
  geom_line(data = BARCOBaromdaily, color="red",
            aes(Date, BARCOBaromdaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Barometric pressure (kPa)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
Baromplot

#BARCO daily rain
write.csv(BARCOBaromdaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCObarom.csv", row.names = FALSE)

#.............................BARC relative humidity........................................#
RH <- loadByProduct(dpID="DP1.20271.001", site="BARC", 
                       startdate="2017-08", enddate="2021-02", 
                       package="basic",
                       check.size = F)
names(RH)
# View the dataFrame
str(RH$RHbuoy_30min) 
list2env(RH, .GlobalEnv) 

#plot
RHplot <- ggplot() +
  geom_line(data = RHbuoy_30min, color="red",
            aes(endDateTime, RHMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Relative Humidity (%)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
RHplot

#subdaily to daily values
RH30min <- RH$RHbuoy_30min %>% 
  select(startDateTime, RHMean)

BARCORHdaily <- subdaily2daily(RH30min, FUN = mean, dates = 1, na.rm = T)
BARCORHdaily <- as.data.frame(BARCORHdaily) #Convert to dataframe
BARCORHdaily$Date <- as.POSIXct(row.names(BARCORHdaily)) #Now it is ready to plot
str(BARCORHdaily)

#plot
RHplot <- ggplot() +
  geom_line(data = BARCORHdaily, color="red",
            aes(Date, BARCORHdaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Relative Humidity (%)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
RHplot

#BARCO daily rain
write.csv(BARCORHdaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCOhumidity.csv", row.names = FALSE)

#.............................BARC PAR at surface water........................................#
PAR <- loadByProduct(dpID="DP1.20042.001", site="BARC", 
                    startdate="2017-08", enddate="2021-02", 
                    package="basic",
                    check.size = F)
names(PAR)
# View the dataFrame
str(PAR$PARWS_30min) 
list2env(PAR, .GlobalEnv) 

#plot
PARplot <- ggplot() +
  geom_line(data = PARWS_30min, color="red",
            aes(endDateTime, PARMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("PAR (umols/m2*s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
PARplot

#subdaily to daily values
PAR30min <- PAR$PARWS_30min %>% 
  select(startDateTime, PARMean)

BARCOPARdaily <- subdaily2daily(PAR30min, FUN = mean, dates = 1, na.rm = T)
BARCOPARdaily <- as.data.frame(BARCOPARdaily) #Convert to dataframe
BARCOPARdaily$Date <- as.POSIXct(row.names(BARCOPARdaily)) #Now it is ready to plot
str(BARCOPARdaily)

#plot
PARplot <- ggplot() +
  geom_line(data = BARCOPARdaily, color="red",
            aes(Date, BARCOPARdaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("PAR (umols/m2*s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
PARplot

#BARCO daily rain
write.csv(BARCOPARdaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_PAR.csv", row.names = FALSE)


#.............................BARC net radiation........................................#
netRad <- loadByProduct(dpID="DP1.20032.001", site="BARC", 
                     startdate="2017-08", enddate="2021-02", 
                     package="basic",
                     check.size = F)
names(netRad)
# View the dataFrame
str(netRad$SLRNRB_30min) 
list2env(netRad, .GlobalEnv) 

#plot
SWRadplot <- ggplot() +
  geom_line(data = SLRNRB_30min, color="red",
            aes(endDateTime, inSWMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("SW radiation (W/m2)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
SWRadplot

LWRadplot <- ggplot() +
  geom_line(data = SLRNRB_30min, color="red",
            aes(endDateTime, inLWMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("LW radiation (W/m2)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
LWRadplot

#subdaily to daily values
SWRad30min <- netRad$SLRNRB_30min %>% 
  select(startDateTime, inSWMean)
LWRad30min <- netRad$SLRNRB_30min %>% 
  select(startDateTime, inLWMean)

BARCOSWRaddaily <- subdaily2daily(SWRad30min, FUN = mean, dates = 1, na.rm = T)
BARCOSWRaddaily <- as.data.frame(BARCOSWRaddaily) #Convert to dataframe
BARCOSWRaddaily$Date <- as.POSIXct(row.names(BARCOSWRaddaily)) #Now it is ready to plot

BARCOLWRaddaily <- subdaily2daily(LWRad30min, FUN = mean, dates = 1, na.rm = T)
BARCOLWRaddaily <- as.data.frame(BARCOLWRaddaily) #Convert to dataframe
BARCOLWRaddaily$Date <- as.POSIXct(row.names(BARCOLWRaddaily)) #Now it is ready to plot

#plot
SWRadplot <- ggplot() +
  geom_line(data = BARCOSWRaddaily, color="red",
            aes(Date, BARCOSWRaddaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("SW radiation (W/m2)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
SWRadplot

LWRadplot <- ggplot() +
  geom_line(data = BARCOLWRaddaily, color="red",
            aes(Date, BARCOLWRaddaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("LW radiation (W/m2)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
LWRadplot

#BARCO daily rain
write.csv(BARCOSWRaddaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_SWrad.csv", row.names = FALSE)
write.csv(BARCOLWRaddaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_LWrad.csv", row.names = FALSE)

#.............................BARC wind speed & direction........................................#
wind <- loadByProduct(dpID="DP1.20059.001", site="BARC", 
                        startdate="2017-08", enddate="2021-02", 
                        package="basic",
                        check.size = F)
names(wind)
# View the dataFrame
str(wind$WSDBuoy_30min) 
list2env(wind, .GlobalEnv) 

#plot
Wspeed <- ggplot() +
  geom_line(data = WSDBuoy_30min, color="red",
            aes(endDateTime, buoyWindSpeedMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Speed (m/s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
Wspeed

Wdire <- ggplot() +
  geom_line(data = WSDBuoy_30min, color="red",
            aes(endDateTime, buoyWindDirMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Direction (degrees)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
Wdire 

#subdaily to daily values
Wspeed30min <- wind$WSDBuoy_30min %>% 
  select(startDateTime, buoyWindSpeedMean)
Wdirection30min <- wind$WSDBuoy_30min %>% 
  select(startDateTime, buoyWindDirMean)

BARCOWspeeddaily <- subdaily2daily(Wspeed30min, FUN = mean, dates = 1, na.rm = T)
BARCOWspeeddaily <- as.data.frame(BARCOWspeeddaily) #Convert to dataframe
BARCOWspeeddaily$Date <- as.POSIXct(row.names(BARCOWspeeddaily)) #Now it is ready to plot

BARCOWdirectiondaily <- subdaily2daily(Wdirection30min, FUN = mean, dates = 1, na.rm = T)
BARCOWdirectiondaily <- as.data.frame(BARCOWdirectiondaily) #Convert to dataframe
BARCOWdirectiondaily$Date <- as.POSIXct(row.names(BARCOWdirectiondaily)) #Now it is ready to plot

#plot
Wspeed <- ggplot() +
  geom_line(data = BARCOWspeeddaily, color="red",
            aes(Date, BARCOWspeeddaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Speed (m/s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
Wspeed

Wdirection <- ggplot() +
  geom_line(data = BARCOWdirectiondaily, color="red",
            aes(Date, BARCOWdirectiondaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Direction (degrees)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
Wdirection

#BARCO daily rain
write.csv(BARCOWspeeddaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_Wspeed.csv", row.names = FALSE)
write.csv(BARCOWdirectiondaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_Wdirection.csv", row.names = FALSE)

#.................................BARCO: MERGE MET DATA WITH TARGET VARIABLES...........................#

##set your working directory
setwd("C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge")

#INPUT FILES --> manually change the "time" for "Date" in aquatics-targets.csv file!
targets <- read.csv("aquatics-targets.csv", stringsAsFactors = T)
targets$Date <- as.Date(targets$Date,"%d/%m/%Y")
str(targets)
#filter only BARCO + select oxygen and temperature columns
BARCtargets <-targets[targets$siteID %in% "BARC",]
BARCtargets <- BARCtargets %>% 
  select(Date, oxygen, temperature)
str(BARCtargets)

#meteo variables
a <- read.csv("BARCOairT.csv", stringsAsFactors = T)
a$Date <- as.Date(a$Date,"%Y-%m-%d")
str(a)
b <- read.csv("BARCOrain.csv", stringsAsFactors = T)
b$Date <- as.Date(b$Date,"%Y-%m-%d")
str(b)
c <- read.csv("BARCObarom.csv", stringsAsFactors = T)
c$Date <- as.Date(c$Date,"%Y-%m-%d")
str(c)
d <- read.csv("BARCOhumidity.csv", stringsAsFactors = T)
d$Date <- as.Date(d$Date,"%Y-%m-%d")
str(d)
e <- read.csv("BARCO_PAR.csv", stringsAsFactors = T)
e$Date <- as.Date(e$Date,"%Y-%m-%d")
str(e)
f <- read.csv("BARCO_SWrad.csv", stringsAsFactors = T)
f$Date <- as.Date(f$Date,"%Y-%m-%d")
str(f)
g <- read.csv("BARCO_LWrad.csv", stringsAsFactors = T)
g$Date <- as.Date(g$Date,"%Y-%m-%d")
str(g)
h <- read.csv("BARCO_Wspeed.csv", stringsAsFactors = T)
h$Date <- as.Date(h$Date,"%Y-%m-%d")
str(h)
i <- read.csv("BARCO_Wdirection.csv", stringsAsFactors = T)
i$Date <- as.Date(i$Date,"%Y-%m-%d")
str(i)

#daily
daily <- read.csv("BARCOdates.csv", stringsAsFactors = T)
daily$Date <- as.Date(daily$Date,"%d/%m/%Y")
str(daily)

#join DATASETS by DATE = BARCOmetadata
join1 <- full_join(daily, BARCtargets, by = "Date")
join2 <- full_join(join1, a, by = "Date")
join3 <- full_join(join2, b, by = "Date")
join4 <- full_join(join3, c, by = "Date")
join5 <- full_join(join4, d, by = "Date")
join6 <- full_join(join5, e, by = "Date")
join7 <- full_join(join6, f, by = "Date")
join8 <- full_join(join7, g, by = "Date")
join9 <- full_join(join8, h, by = "Date")
join10 <- full_join(join9, i, by = "Date")
str(join10)
summary(join10)

write.csv(join10,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCOmetadata.csv", row.names = FALSE)

wtr <- ggplot() +
  geom_point(data = join10, color="blue",
            aes(Date, temperature), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Water Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
wtr

oxy <- ggplot() +
  geom_point(data = join10, color="blue",
             aes(Date, oxygen), 
             na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("O2 (mgO2/L)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
oxy 

airT <- ggplot() +
  geom_point(data = join10, color="red",
             aes(Date, BARCOairTdaily), 
             na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Air Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
airT

rain <- ggplot() +
  geom_line(data = join10, color="red",
             aes(Date, BARCOraindaily), 
             na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Accumulated rain (mm)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
rain

pressure <- ggplot() +
  geom_line(data = join10, color="red",
            aes(Date, BARCOBaromdaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Air Pressure (kPa)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
pressure

humidity <- ggplot() +
  geom_line(data = join10, color="red",
            aes(Date, BARCORHdaily ), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Relative Humidity (%)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
humidity

PAR <- ggplot() +
  geom_line(data = join10, color="red",
            aes(Date, BARCOPARdaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("PAR (umol/m2*s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
PAR

#and more......



#.........................POSE AIR T........................................#

airT <- loadByProduct(dpID="DP1.00002.001", site="POSE", 
                      startdate="2016-02", enddate="2021-02", 
                      package="basic",
                      check.size = F)
names(airT)
list2env(airT, .GlobalEnv)

#plot
airTplot <- ggplot() +
  geom_line(data = SAAT_30min, color="red",
            aes(endDateTime, tempSingleMean), 
            na.rm=TRUE ) +
  ylim(-5, 40) + ylab("Mean Air Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - 30min data")
airTplot

airT30min <- airT$SAAT_30min %>% 
  select(startDateTime, tempSingleMean)

POSEairTdaily <- subdaily2daily(airT30min, FUN = mean, dates = 1, na.rm = T)
POSEairTdaily <- as.data.frame(POSEairTdaily) #Convert to dataframe
POSEairTdaily$Date <- as.POSIXct(row.names(POSEairTdaily)) #Now it is ready to plot
str(POSEairTdaily)

#plot
airTplot <- ggplot() +
  geom_line(data = POSEairTdaily, color="red",
            aes(Date, POSEairTdaily), 
            na.rm=TRUE ) +
  ylim(-5, 40) + ylab("Mean Air Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
airTplot

#POSE daily air T
write.csv(POSEairTdaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/POSEairT.csv", row.names = FALSE)


#.........................POSE discharge.......................................#

Q <- loadByProduct(dpID="DP4.00130.001", site="POSE", 
                      startdate="2016-02", enddate="2021-02", 
                      package="basic",
                      check.size = F)
names(Q)
list2env(Q, .GlobalEnv)

#plot
Qplot <- ggplot() +
  geom_line(data = csd_continuousDischarge, color="red",
            aes(endDate,maxpostDischarge), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Total discharge (L/s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - 1 min data")
Qplot

Q1min <- Q$csd_continuousDischarge %>% 
  select(endDate, maxpostDischarge)

POSEQdaily <- subdaily2daily(Q1min, FUN = sum, dates = 1, na.rm = T)
POSEQdaily <- as.data.frame(POSEQdaily) #Convert to dataframe
POSEQdaily$Date <- as.POSIXct(row.names(POSEQdaily)) #Now it is ready to plot
str(POSEQdaily)
summary(POSEQdaily)

#plot
Qplot <- ggplot() +
  geom_line(data = POSEQdaily, color="red",
            aes(Date, POSEQdaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) 
  ylab("Total discharge (L/s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
Qplot

#POSE daily Q --> with outlier in Jan 2018!
write.csv(POSEQdaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/POSEQ.csv", row.names = FALSE)


#.............................POSE PRECIPITATION (terrestrial site)........................................#
rain <- loadByProduct(dpID="DP1.00006.001", site="POSE", 
                      startdate="2016-02", enddate="2021-02", 
                      package="basic",
                      check.size = F)
names(rain)
# View the dataFrame
str(rain$PRIPRE_30min) 
list2env(rain, .GlobalEnv) 

#plot
rainplot <- ggplot() +
  geom_line(data = PRIPRE_30min, color="red",
            aes(endDateTime, priPrecipBulk), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Precipitation (mm)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - 30min data")
rainplot

#subdaily to daily values
rain30min <- rain$PRIPRE_30min %>% 
  select(startDateTime, priPrecipBulk)

POSEraindaily <- subdaily2daily(rain30min, FUN = sum, dates = 1, na.rm = T)
POSEraindaily <- as.data.frame(POSEraindaily) #Convert to dataframe
POSEraindaily$Date <- as.POSIXct(row.names(POSEraindaily)) #Now it is ready to plot
str(POSEraindaily)

#plot
rainplot <- ggplot() +
  geom_line(data = POSEraindaily, color="red",
            aes(Date, POSEraindaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Precipitation (mm)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
rainplot

#BARCO daily rain
write.csv(POSEraindaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/POSErain.csv", row.names = FALSE)

#.............................POSE wind speed & direction........................................#
wind <- loadByProduct(dpID="DP1.00001.001", site="POSE", 
                      startdate="2016-02", enddate="2021-02", 
                      package="basic",
                      check.size = F)
names(wind)
# View the dataFrame
list2env(wind, .GlobalEnv) 

#plot
Wspeed <- ggplot() +
  geom_line(data = 2DWSD_30min, color="red", #not working because dataset starting with 2!!!! what can I do?
            aes(endDateTime, windSpeedMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Speed (m/s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - 30min data")
Wspeed

Wdire <- ggplot() +
  geom_line(data = WSDBuoy_30min, color="red",
            aes(endDateTime, buoyWindDirMean), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Direction (degrees)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - 30min data")
Wdire 

#subdaily to daily values
Wspeed30min <- wind$WSDBuoy_30min %>% 
  select(startDateTime, buoyWindSpeedMean)
Wdirection30min <- wind$WSDBuoy_30min %>% 
  select(startDateTime, buoyWindDirMean)

BARCOWspeeddaily <- subdaily2daily(Wspeed30min, FUN = mean, dates = 1, na.rm = T)
BARCOWspeeddaily <- as.data.frame(BARCOWspeeddaily) #Convert to dataframe
BARCOWspeeddaily$Date <- as.POSIXct(row.names(BARCOWspeeddaily)) #Now it is ready to plot

BARCOWdirectiondaily <- subdaily2daily(Wdirection30min, FUN = mean, dates = 1, na.rm = T)
BARCOWdirectiondaily <- as.data.frame(BARCOWdirectiondaily) #Convert to dataframe
BARCOWdirectiondaily$Date <- as.POSIXct(row.names(BARCOWdirectiondaily)) #Now it is ready to plot

#plot
Wspeed <- ggplot() +
  geom_line(data = BARCOWspeeddaily, color="red",
            aes(Date, BARCOWspeeddaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Speed (m/s)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
Wspeed

Wdirection <- ggplot() +
  geom_line(data = BARCOWdirectiondaily, color="red",
            aes(Date, BARCOWdirectiondaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Wind Direction (degrees)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("BARCO site - daily data")
Wdirection

#BARCO daily rain
write.csv(BARCOWspeeddaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_Wspeed.csv", row.names = FALSE)
write.csv(BARCOWdirectiondaily,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/BARCO_Wdirection.csv", row.names = FALSE)




#.................................BARCO: MERGE MET DATA WITH TARGET VARIABLES...........................#

##set your working directory
setwd("C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge")

#INPUT FILES --> manually change the "time" for "Date" in aquatics-targets.csv file!
targets <- read.csv("aquatics-targets.csv", stringsAsFactors = T)
targets$Date <- as.Date(targets$Date,"%d/%m/%Y")
str(targets)
#filter only BARCO + select oxygen and temperature columns
POSEtargets <-targets[targets$siteID %in% "POSE",]
POSEtargets <- POSEtargets %>% 
  select(Date, oxygen, temperature)
str(POSEtargets)

#meteo variables
a <- read.csv("POSEairT.csv", stringsAsFactors = T)
a$Date <- as.Date(a$Date,"%Y-%m-%d")
str(a)
b <- read.csv("POSErain.csv", stringsAsFactors = T)
b$Date <- as.Date(b$Date,"%Y-%m-%d")
str(b)

#daily
daily <- read.csv("POSEdates.csv", stringsAsFactors = T)
daily$Date <- as.Date(daily$Date,"%d/%m/%Y")
str(daily)

#join DATASETS by DATE = BARCOmetadata
join1 <- full_join(daily, POSEtargets, by = "Date")
join2 <- full_join(join1, a, by = "Date")
join3 <- full_join(join2, b, by = "Date")
str(join3)


write.csv(join3,"C:/Users/calderom/OneDrive - Dundalk Institute of Technology/ForecastChallenge/POSEmetadata.csv", row.names = FALSE)

wtr <- ggplot() +
  geom_point(data = join3, color="blue",
             aes(Date, temperature), 
             na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Water Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
wtr

oxy <- ggplot() +
  geom_point(data = join3, color="blue",
             aes(Date, oxygen), 
             na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("O2 (mgO2/L)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
oxy 

airT <- ggplot() +
  geom_line(data = join3, color="red",
             aes(Date, POSEairTdaily), 
             na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Air Temperature (oC)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
airT

rain <- ggplot() +
  geom_line(data = join3, color="red",
            aes(Date, POSEraindaily), 
            na.rm=TRUE ) +
  #ylim(-5, 40) + 
  ylab("Accumulated rain (mm)") +
  xlab(" ") +
  theme(text = element_text(size = 12),
        plot.title = element_text(color="black",size = 12, face="bold.italic"),
        panel.background = element_rect(fill = 'white', colour = 'black'),
        legend.position = "none") +
  ggtitle("POSE site - daily data")
rain


