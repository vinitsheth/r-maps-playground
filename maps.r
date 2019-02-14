require(maps)
library(maps)
map("state") #(Figure 1)
map("world") #(Figure 2)

# plot north America (Figure 3)
xlim <- c(-171.738281, -56.601563)
ylim <- c(12.039321, 71.856229)
map("world", col= "#f3f3f3", fill= TRUE, bg= "white", lwd= 0.3, xlim=xlim, ylim=ylim)
# plot new york state (Figure 4 & 5)
map("state", "New York")
data(us.cities)
map.cities(us.cities, country="NY")

# add color or text on existing maps (Figure 6)
map("state", interior= FALSE)
map("state", boundary= TRUE, col="gray", add= TRUE)

# highlight texas (Figure 7)
map("state", col= "grey", boundary=TRUE, fill= TRUE, lty= 5,lwd= 0.2)
map("state", regions= "texas", col = "red", fill= TRUE, add= TRUE, lty= 1, lwd= 2)
map.text("state","texas", col="white", add= TRUE)
  
