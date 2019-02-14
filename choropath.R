library(ggplot2)
library(maps)
library(scales)

unemployment <- read.csv("data/unemployment.csv", header= F, stringsAsFactors= F)
names(unemployment) <- c("id", "state_fips", "county_fips", "name", "year", "?", "?", "?", "rate")

#prepare data
#Q2 what does gsub syntax mean? Can you use grep instead?
unemployment$county <- tolower(gsub(" County, [A-Z]{2}", "", unemployment$name))
unemployment$state <- gsub("^.*([A-Z]{2})", "\\1", unemployment$name)

#prepare map
county_df <- map_data("county")
names(county_df) <- c("long", "lat", "group", "order", "state_name", "county")

county_df$state <- state.abb[match(county_df$state_name, tolower(state.name))]

county_df$state_name <- NULL


# Combine together 
choropleth <- merge(county_df, unemployment, by= c("state", "county"))

choropleth <- choropleth[order(choropleth$order), ]
# Discretise rate to use with Brewer color scheme 
# choropleth$rate_d <- cut_number(choropleth$rate, 5) #(Figure 11)
# choropleth$rate_d <- cut_interval(choropleth$rate, 5) 
choropleth$rate_d <- cut(choropleth$rate, breaks = c(seq(0, 10, by = 2), 31)) #(Figure 11)

# summary(unemployment$rate)
# max_rate <- max(unemployment$rate)

# plot the employment rate by counties across America into bins
ggplot(choropleth, aes(long, lat, group = group)) +
  scale_fill_brewer(palette = "PuRd")+
  geom_polygon(aes(fill = rate_d))

# outline state borders (Figure 12)
state_df <- map_data("state")

ggplot(choropleth, aes(long, lat, group= group)) +
  scale_fill_brewer(palette = "OrRd")+
  geom_polygon(aes(fill= rate_d)) +
  geom_polygon(data= state_df, colour= "white", fill = NA) 
