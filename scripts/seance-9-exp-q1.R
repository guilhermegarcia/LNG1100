# Charger le script de nettoyage
# Le script chargera les bibliothèques aussi
source("mes_scripts/seance_9_net.R")

q1_long

# La précision moyenne de tout le monde? 87 %
q1_long |>
  summarize(
    M = mean(correct),
    ET = sd(correct)
  )

# La précision moyenne pour chaque participant?
q1_long |>
  summarize(
    M = mean(correct),
    .by = id
  ) |>
  arrange(-M) |>
  ggplot(aes(x = fct_reorder(id, M), y = M)) +
  geom_col(alpha = 0.3) +
  geom_point(size = 5) +
  scale_y_continuous(labels = percent_format()) +
  theme_classic(base_size = 14) +
  labs(x = "Participant", y = "Note")

# Exporter la figure avec ggsave()
ggsave("mes_scripts/performance.jpeg",
  dpi = 500, width = 8, height = 4
)


q1_long
