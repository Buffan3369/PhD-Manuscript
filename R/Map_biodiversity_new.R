library(raster)
library(ggplot2)
library(scico)
library(ggpubr)

# Load rasters
mammals <- raster("./Data/Extant_distribs/LandVertebrates/Mammals/Richness_10km_MAMMALS_mar2018_EckertIV.tif")
birds <- raster("./Data/Extant_distribs/LandVertebrates/Birds/Richness_10km_Birds_v7_EckertIV_breeding_no_seabirds.tif")
amphibians <- raster("./Data/Extant_distribs/LandVertebrates/Amphibians/Richness_10km_AMPHIBIANS_dec2017_EckertIV.tif")

mammal.df <- as.data.frame(mammals, xy = TRUE)
colnames(mammal.df) <- c("lon", "lat", "div")

bird.df <- as.data.frame(birds, xy = TRUE)
colnames(bird.df) <- c("lon", "lat", "div")

amphibian.df <- as.data.frame(amphibians, xy = TRUE)
colnames(amphibian.df) <- c("lon", "lat", "div")

# Now plotting
mammal_plt <- ggplot() +
  geom_tile(data = mammal.df, aes(x = lon, y = lat, fill = div)) +
  scale_fill_scico(palette = "tokyo", na.value = '#2b1238') +
  ggtitle("Terrestrial mammal richness") +
  labs(fill = NULL) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "bottom",
        plot.title = element_text(hjust = 0.5, size = 14))

bird_plt <- ggplot() +
  geom_tile(data = bird.df, aes(x = lon, y = lat, fill = div)) +
  scale_fill_scico(palette = "tokyo", na.value = '#2b1238') +
  ggtitle("Non-marine bird richness") +
  labs(fill = NULL) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "bottom",
        plot.title = element_text(hjust = 0.5, size = 14))


amphibian_plt <- ggplot() +
  geom_tile(data = amphibian.df, aes(x = lon, y = lat, fill = div)) +
  scale_fill_scico(palette = "tokyo", na.value = '#2b1238') +
  ggtitle("Amphibian richness") +
  labs(fill = NULL) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "bottom",
        plot.title = element_text(hjust = 0.5, size = 14))

## Assemble and save
cat("Assembling the three plots.\n")
tot_plt <- ggarrange(mammal_plt, bird_plt, amphibian_plt, ncol = 3, labels = c("(A)", "(B)", "(C)"))
ggsave("./Figures/richness_mammal_bird_amphibian.png", dpi = 400, height = 100, width = 300, units = "mm")
