library(tidyverse)
library(sf)
library(raster)
library(ggpubr)

## Spatialised fossil collections ----------------------------------------------
spl <- readRDS("../PostPal_SAM/Data/Fully_cleaned_Cnz_SA_mammals_SALMA_kept_Tropics_Diet.RDS")

spl_lonlat <- spl %>%
  dplyr::select(epoch, lng, lat) %>% 
  distinct(lng, lat, epoch)

## New-World ecoregions --------------------------------------------------------
nw <- st_read("../Chapter_1/data_2023/New_World_map_ecoregions/New_World_18_regions_DCsplit.shp")
# switch off the use of s2, otherwise st_union does not work
sf_use_s2(FALSE)

## Elevation -------------------------------------------------------------------
r <- raster("../Chapter_1/data_2023/New_World_map_ecoregions/South_America_topography_Boschman_2021-0_Ma.grd")
r.df <- as.data.frame(r, xy = TRUE)
colnames(r.df) <- c("lon", "lat", "elev")
r.df <- r.df %>% filter(elev >= 0)

# Save SA map
SA_simple <- nw %>%
  # Extract South America 
  filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
  # Merge extracted polygons
  st_union() %>% 
  # Plot
  ggplot() + 
  geom_sf(lwd=0) +
  geom_tile(data = r.df, aes(x = lon, y = lat, fill = elev)) +
  scale_fill_continuous(low = "#fee391", high = "#662506") +
  labs(fill = "Elevation (m)", colour = NULL) +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = "#87aade"),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5))

ggsave("./Figures/Physiography/SA_Physiographic_map.png", SA_simple, dpi = 600, height = 20, width = 15, units = "cm")

## Process map data and plot ---------------------------------------------------
PL <- list()
itr <- factor(unique(spl_lonlat$epoch),
              levels = c("Paleocene", "Eocene", "Oligocene", "Miocene", "Pliocene", "Pleistocene", "Holocene"))

col_geo <- deeptime::epochs$color[1:7]

for(epch in levels(itr)){
  i <- which(levels(itr) == epch)
  coll <- spl_lonlat %>% filter(epoch == epch)
  plt <- nw %>%
    # Extract South America 
    filter(ECO_NAM %in% c("North_Mesoamerica", "Nearctic", "South_Mesoamerica", "Carribean") == F) %>%
    # Merge extracted polygons
    st_union() %>% 
    # Plot
    ggplot() + 
    geom_sf(lwd=0) +
    geom_tile(data = r.df, aes(x = lon, y = lat, fill = elev)) +
    scale_fill_continuous(low = "#deebf7", high = "#08306b") +
    geom_point(data = coll, aes(x = lng, y = lat), colour = "#cc4c02", size = .75) +
    ggtitle(epch) +
    labs(fill = "Elevation (m)", colour = NULL) +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.title = element_blank(),
          axis.ticks = element_blank(),
          panel.background = element_rect(fill = "grey40"),
          panel.grid = element_blank(),
          plot.title = element_text(hjust = 0.5))
  if(epch %in% c("Oligocene", "Pleistocene") == FALSE){
    plt <- plt +
      theme(legend.position = "none")
  }
  PL[[i]] <- plt
}

coll_plot <- ggarrange(plotlist = PL[-length(PL)], ncol = 3, nrow = 2, align = "h")
ggsave("./Figures/Collection_map/Collection_plot.png", dpi = 300, plot = coll_plot, height = 200, width = 300, units = "mm")
