library(tidyverse)
library(raster)
library(scico)
library(sf)

# bien_occ <- readRDS("./Data/BIEN_global_plant_occ.RDS")
# occ_sf <- st_as_sf(bien_occ, coords = c("longitude", "latitude"), 
#                    crs = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs")
# 
# mamm_map <- raster("./Data/Extant_distribs/LandVertebrates/Mammals/Richness_10km_MAMMALS_mar2018_EckertIV.tif")
# xy_grid <- xyFromCell(mamm_map, cell = 1:ncell(mamm_map))
# grid_sf <- st_as_sf(as.data.frame(xy_grid), coords = c("x", "y"), 
#                     crs = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs")
# 
# 
# matched <- st_join(occ_sf, grid_sf, join = st_nearest_feature)
# 
# grid_counts <- matched %>%
#   group_by(geometry) %>%           # Group by the unique grid cell identifier
#   summarise(occ_count = n(),      # Count the number of rows (occurrences) in each group
#             .groups = 'drop')
# 
# saveRDS(grid_counts, "./Data/plant_grid_counts.RDS")

grid_counts <- readRDS("./Data/plant_grid_counts.RDS")

plant_map <- ggplot() +
  geom_sf(data = grid_counts, 
          aes(fill = occ_count),  # Color based on the count
          color = "white",        # White borders between cells
          linewidth = 0.1) +
  scale_fill_scico(palette = "tokyo", na.value = '#2b1238')

ggsave("./Figures/plant_distrib.png", plot = plant_map, dpi = 60, height = 100, width = 200, units = "mm")
