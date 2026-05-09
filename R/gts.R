library(ggplot2)
library(deeptime)

source("../Chinchilloids/R/useful/load_GTS.R")

x <- 0:66
y <- rnorm(n = 67)

## Horizontal ------------------------------------------------------------------
p <- ggplot(data = data.frame(x, y), aes(x = x, y = y)) +
  geom_point() +
  scale_x_reverse(breaks = seq(0, 60, 10)) +
  labs(x = "Time (Ma)") +
  coord_geo(dat = list(gsc3, epochs), abbrv = list(T, F), size = "auto") +
  theme(axis.title = element_text(size = 12))

ggsave("./Figures/SAM_simplified_chronogram/geoscale_plot.pdf", plot = p, height = 100, width = 400, units = "mm")

## Vertical --------------------------------------------------------------------

p_vert <- ggplot(data = data.frame(x, y), aes(x = y, y = x)) +
  geom_point() +
  scale_y_reverse(breaks = seq(0, 60, 10)) +
  labs(y = "Time (Ma)") +
  coord_geo(pos = list("left", "left"), dat = list(epochs, gsc3), abbrv = list(F, F), size = list(4, 3), height = unit(6, "line")) +
  theme(axis.title = element_text(size = 12))

ggsave("./Figures/GTS_plot/vertical_gts.pdf", plot = p_vert, height = 240, width = 200, units = "mm")
  
