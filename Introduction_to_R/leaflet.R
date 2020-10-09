library("leaflet")
library("shiny")
library("rgdal")
library("readxl")
library("dplyr")
library("tidyr")
library("tibble")
library("leaflet.minicharts")

setwd("D:/Proejct_GitHub/Intro2EnergyModeling_R/Introduction_to_R")


# read a shape file
world.shape <- readOGR("./world_shape/World_Countries.shp",
                       layer = "World_Countries")


# draw a map using the shape file
map <- leaflet(world.shape) %>%
  addPolygons(color = "#000000",
              weight = 1,
              fillColor = "#ffffff",
              fillOpacity = 1,
              highlightOptions = highlightOptions(color = "#ff0000",
                                                  weight = 2,
                                                  bringToFront = TRUE))

print(map)





# read world population data
pop <- read_xlsx("./Data/Population.xlsx", sheet = 1, skip = 5) %>%
  pivot_longer(cols= as.character(c(1960:2019)),
               names_to="year",
               values_to="population")

colnames(pop) <- c("country", "country.code", "indicator", "indicator.code", "year", "population")


pop <- pop %>% filter(year==2015)



# mapping the data to shp db

shp.country <- as_tibble(world.shape$COUNTRY) %>% rename(country=value)

mappping_pop_shp <- shp.country %>%
  left_join(pop, by=c("country")) %>%
  select(country, population)



# mapping variables to colors

dom <- mappping_pop_shp$population


pal <- colorBin(palette="YlOrRd",
                domain = dom,
                na.color = "#808080",
                bins = 5,
                reverse = FALSE)


# draw a map

map2 <- leaflet(world.shape) %>%
  addPolygons(fillColor = ~pal(dom),
              color = "#000000",
              weight = 1,
              fillOpacity = 1,
              highlightOptions = highlightOptions(color = "#ff0000",
                                                  weight = 2,
                                                  bringToFront = TRUE))

print(map2)



# Add legend

map3 <- map2 %>%
  addLegend(pal = pal,
            #topright, bottomright, bottomleft, topleft
            position ="bottomright",
            values = ~dom,
            title = "Population",
            opacity = 1)


print(map3)




