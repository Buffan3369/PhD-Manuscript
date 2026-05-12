library(rnaturalearth)
library(ggplot2)
library(sf)

sf_use_s2(FALSE)

# Background map
ct <- ne_countries(returnclass = "sf")
ct_rob <- ct %>% 
  st_union() %>% 
  st_transform(crs = "ESRI:54030")

# PBDB mammal collections
mamm_coll <- read.csv("./Data/pbdb_Mammalia_05-2026.csv", skip = 17)
mamm_coll <- mamm_coll %>% 
  st_as_sf(coords = c("lng", "lat"), crs = 4326)
mamm_coll_rob <- mamm_coll %>% st_transform(crs = "ESRI:54030")

# Plot
collection_plot <- ggplot() +
  geom_sf(data = ct_rob, fill = "#fec44f") +
  geom_sf(data = mamm_coll_rob, color = "darkred", size = 0.1) +
  ggtitle("Fossil collections of Mammalia") +
  theme(panel.background = element_rect(fill = "#c6dbef"),
        plot.background = element_rect(fill = "transparent"),
        plot.title = element_text(size = 12, hjust = 0.5),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
ggsave("./Figures/Collection_map/Global_Mammalia_collections_PBDB.pdf", 
       plot = collection_plot, width = 200, units = "mm")
