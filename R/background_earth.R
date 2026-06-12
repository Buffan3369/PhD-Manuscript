library(rnaturalearth)
library(sf)
library(tidyverse)

sf_use_s2(FALSE)

ctr <- ne_countries(returnclass = "sf")
ctr_rob <- ctr %>% 
  st_union() %>% 
  st_transform(crs = "ESRI:54030")

bck <- ctr_rob %>% 
  ggplot() + 
  geom_sf(fill = "#fec44f") +
  theme(panel.background = element_rect(fill = "#c6dbef"),
        plot.background = element_rect(fill = "transparent"),
        panel.grid = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank())

ggsave("./Figures/Aliens/background_earth.pdf", plot = bck, height = 100, width = 150, units = "mm")
