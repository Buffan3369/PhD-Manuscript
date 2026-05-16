library(tidyverse)

t <- seq(from = 0.01, to = 50, by = 0.01)
alph1 <- 2
alph2 <- 0.2
# Older species have a higher extinction probability
y_ade <- sapply(X = t, FUN = function(x){x**alph1})
# Red Queen (age-independence)
y_RQ <- sapply(X = t, FUN = function(x){exp(alph2*x)})
df <- data.frame(time = rep(t, 2),
                 y = c(y_ade, y_RQ),
                 lab = c(rep("ADE1", length(t)),
                         rep("Red Queen", length(t))))

plt <- df %>% ggplot(aes(x = time, y = y)) +
  geom_line() +
  scale_x_reverse() +
  scale_y_log10() +
  facet_wrap(.~lab) +
  theme_minimal() 

ggsave("./Figures/Red_Queen_ADE/Baseline.pdf", height = 70, width = 140, units = "mm")
