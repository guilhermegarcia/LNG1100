library(tidyverse)

v2 <- read_csv("donnees/villes2.csv")

v2

# Exploration des données :
v2 |>
  summarize(
    Moyennes = mean(note),
    `Écart-types` = sd(note),
    min = min(note),
    max = max(note),
    n = n(),
    .by = ville
  )

# Figure pour note ~ ville :
ggplot(data = v2, aes(x = ville, y = note)) +
  geom_boxplot() +
  stat_summary()

# Modèle :
mod1 <- lm(note ~ ville, data = v2)
summary(mod1)
nrow(v2)

# La variable duree :
v2 |>
  summarize(
    note_moyenne = mean(note),
    duree_moyenne = mean(duree),
    .by = ville
  )

# Une figure pour examiner la relation entre
# la durée et la note

ggplot(data = v2, aes(x = duree, y = note)) +
  geom_point() +
  geom_smooth(method = "lm") # ou stat_smooth()

# Options pour combiner les variables :
# ggplot(data = v2, aes(x = duree, y = note)) +
#   geom_point(aes(color = ville), size = 3, alpha = 0.5) +
#   geom_smooth(method = "lm") +
#   scale_color_manual(values = c("darkorange2", "steelblue2", "black"))

# Ma figure préférée :
ggplot(data = v2, aes(x = duree, y = note)) +
  geom_smooth(
    method = "lm",
    color = "red",
    linetype = "solid"
  ) +
  geom_point(aes(color = ville, shape = ville), size = 4, alpha = 0.6) +
  # geom_smooth(aes(color = ville), method = "lm") +
  scale_color_manual(values = c("darkorange2", "steelblue2", "black")) +
  theme_classic() +
  labs(
    x = "Durée (en mois)",
    y = "Note dans le test (/100)",
    title = "La relation entre ville et la durée",
    subtitle = "Il y a une corrélation problématique entre les variables",
    color = "Ville :",
    shape = "Ville :"
  ) +
  theme(
    legend.position = "bottom"
  )

# Pour enregistrer la figure :
ggsave(
  filename = "diapos/seance-6-7/ma_figure.jpeg",
  dpi = 500, width = 7, height = 3.5
)

# ggplot(data = v2, aes(x = duree, y = note)) +
#   geom_point(size = 3, alpha = 0.5) +
#   geom_smooth(method = "lm") +
#   facet_grid(~ville) +
#   scale_color_manual(values = c("darkorange2", "steelblue2", "black"))

# Le modèle
mod1 <- lm(note ~ ville, data = v2)
mod2 <- lm(note ~ duree, data = v2)
mod3 <- lm(note ~ ville + duree, data = v2)

summary(mod1) # Q ≠ C
summary(mod2) # duree a un effet
summary(mod3)

mod3 |> confint()
