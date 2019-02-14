library(ggplot2)
require(ggmap)

#CIDSE map (Figure 9)
#maptype: terrain, satellite, roadmap, hybrid, toner, watercolor
cidse.map <- get_map(location=c(lon=-111.9389 , lat=33.4234), zoom=16, maptype="roadmap")
ggmap(cidse.map) 
#nyc.map <- get_stamenmap(bbox = c(left = -74.9975, bottom = 40.8125, right = -73.9750, top = 40.8000), zoom=12, maptype="watercolor")

# Generate some data
# http://www.gpsvisualizer.com/geocoder/
# starbucks 33.42576,-111.94037
# brickyard 33.42475,-111.94001
# tennis courts 33.42475,-111.93402 
long = c(-111.94037, -111.94001,-111.93402 )
lat = c(33.42576, 33.42475,33.42475)
who = c("starbucks", "brickyard", "tennis court")
sharon = data.frame (long, lat, who)

# overlay the data on the googlemap (Figure 9)
ggmap(cidse.map) + geom_point(data=sharon, aes(x=long, y=lat, fill= factor(who)), colour="blue", size=4,  alpha= 0.6)


#earthquake map (Figure 10)
earthquake <- read.csv("data/earthquake.csv")
earthquake.points <-earthquake[,c("Longitude","Latitude")]

earthquake.map <- get_map(location=c(lon=150, lat=20), zoom=3, maptype="watercolor", filename="earthquake_map.png")
ggmap(earthquake.map) + geom_point(data=earthquake.points, aes(x=Longitude, y=Latitude), col="red", size=2)
