library(sepkoski)
library(deeptime)
library(ggplot2)

# "Paleo" -> "Palaeo"
eras <- deeptime::eras
eras$name[which(eras$name == "Paleozoic")] <- "Palaeozoic"

# Plot
spkurve <- sepkoski_curve() +
  theme(axis.title = element_text(size = 15),
        legend.position = "none") +
  scale_fill_manual(values = c("#f0f0f0", "#bdbdbd", "#737373", "#252525")) +
  # Add names of the faunas on the plots
  annotate(geom = "text", x = 480, y = 150, label = "Cambrian fauna", colour = "white", fontface = 2) +
  annotate(geom = "text", x = 370, y = 770, label = "Palaeozoic fauna", colour = "white", fontface = 2) +
  annotate(geom = "text", x = 80, y = 1400, label = "Modern fauna", colour = "black", fontface = 2) +
  # Geoscale
  coord_geo(dat = list("periods", eras),
            height = list(unit(1, "lines"), unit(1, "line")),
            abbrv = list(TRUE, FALSE),
            size = "auto") +
  # 1. Late Ordovician
  geom_segment(aes(x = 443.1, xend = 443.1, y = 2900, yend = 2300),
               arrow = arrow(type = "closed", length = unit(0.3, "cm"))) +
  annotate(geom = "text", fontface = 2, label = "1. Late \nOrdovician", x = 443.1, y = 3150) +
  # 2. Frasnian−Fammenian
  geom_segment(aes(x = 372.15, xend = 372.15, y = 2900, yend = 2300),
               arrow = arrow(type = "closed", length = unit(0.3, "cm"))) +
  annotate(geom = "text", fontface = 2, label = "2. Frasnian−\nFammenian", x = 372.15, y = 3150) +
  # 3. Permo−Triassic
  geom_segment(aes(x = 251.902, xend = 251.902, y = 2300, yend = 1700),
               arrow = arrow(type = "closed", length = unit(0.3, "cm"))) +
  annotate(geom = "text", fontface = 2, label = "3. Permo−\nTriassic", x = 251.902, y = 2550) + 
  # 4. Triassic−Jurassic
  geom_segment(aes(x = 201.4, xend = 201.4,  y = 1950, yend = 1350),
               arrow = arrow(type = "closed", length = unit(0.3, "cm"))) +
  annotate(geom = "text", fontface = 2, label = "4. Triassic−\nJurassic", x = 201.4, y = 2200) +
  # 5. Cretaceous−Palaeogene
  geom_segment(aes(x = 66, xend = 66, y = 4600, yend = 4000),
               arrow = arrow(type = "closed", length = unit(0.3, "cm"))) +
  annotate(geom = "text", fontface = 2, label = "5. Cretaceous−\nPalaeogene", x = 66, y = 4850)

ggsave("./Figures/Sepkoski_curve.pdf", plot = spkurve, height = 150,
       width = 240, units = "mm")
  
