library(ggplot2)
library(deeptime)

source("../Chinchilloids/R/useful/load_GTS.R")

x <- 0:66
y <- rnorm(n = 67)

p <- ggplot(data = data.frame(x, y), aes(x = x, y = y)) +
  geom_point() +
  scale_x_reverse(breaks = seq(0, 60, 10)) +
  labs(x = "Time (Ma)") +
  coord_geo(dat = list(gsc3, epochs), abbrv = list(T, F), size = "auto") +
  theme(axis.title = element_text(size = 12))

ggsave("./Figures/SAM_simplified_chronogram/geoscale_plot.pdf", plot = p, height = 100, width = 400, units = "mm")
View(deeptime::stages)
