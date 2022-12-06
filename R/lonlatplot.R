#library(sf)
library(ggmap)
library(ggplot2)

df <- subset(crimeData, RPT_DT > "2020-01-01")
df <- na.omit(df[,c("Latitude", "Longitude", "LAW_CAT_CD")])
df <- head(df, 00000)
names(df) <- c("lat", "lon")

#sf <- st_as_sf(df, coords = c("Longitude", "Latitude"))
#st_crs(sf) = 4326

nyc_map_coord <- c(left = -74.3, right = -73.65, top = 40.95, bottom = 40.45)
nyc_map <- get_stamenmap(nyc_map_coord, maptype = "terrain") %>% ggmap()

nyc_map +
  geom_point(data = df)

#ggplot(sf) +
#  geom_sf(aes(color = LAW_CAT_CD)) +
#  xlim(-74.3, -73.65) +
#  ylim(40.45, 40.95)

