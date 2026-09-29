library(tidyverse)

# Importer les données RData :
load("donnees/base/pisa_2025.RData")


# Filtrer les pays d'intérêt :
bonus <- pisa |>
  filter(country %in% c("CAN", "FRA", "ESP"))

# Vérifier que le filtre a fonctionné :
bonus |> sample_n(size = 10)

# Figure :
ggplot(data = bonus, aes(x = country, y = read)) +
  geom_boxplot() +
  stat_summary(color = "darkorange") +
  theme_classic()

# ANOVA :

mon_anova <- aov(read ~ country, data = bonus)
mon_anova |> TukeyHSD()

# Conclusion : la moyenne de lecture du Canada
# est statistiquement supérieure à celles de l'Espagne
# et de la France.
