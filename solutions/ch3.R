rm(list=ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
fb = read_csv("donnees/feedbackData.csv")
glimpse(fb)

fb = fb |>
  select(-c(task_B1:task_B5))

glimpse(fb)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
fb = fb |>
  pivot_longer(
    names_to = "tache",
    values_to = "note",
    cols = task_A1:task_A5
  )

ggplot(data = fb, aes(x = Feedback, y = note)) +
  geom_boxplot() +
  theme_minimal()
# Le groupe de rétroaction `Recast` semble avoir des médianes
# des notes légèrement supérieures, mais c'est un peu difficile
# d'être certain étant donnée la superpositions
# des boîtes, c'est-à-dire la dispersion des données.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
ggplot(data = fb, aes(
  x = Feedback, y = note,
  color = L1
)) +
  geom_boxplot() +
  theme_minimal()

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
ggplot(data = fb, aes(
  x = Feedback, y = note,
  color = L1
)) +
  geom_boxplot() +
  stat_summary() +
  theme_minimal()

# Bien que les boîtes sont ajustées automatiquement,
# les moyennes ne le sont pas. Il faut modifier manuellement
# leurs positions :
ggplot(data = fb, aes(
  x = Feedback, y = note,
  color = L1
)) +
  geom_boxplot() +
  stat_summary(
    position =
      position_dodge(width = 0.75)
  ) +
  theme_minimal()
# Voici une constatation très importante : quand on compare
# les boîtes, les groupes semblent très similaires.
# Autrement dit, les boîtes se superposent.
# Par contre, l'analyse des moyennes et de leurs erreurs standards
# nous amène à une autre conclusion : les moyennes des notes des
# locuteurs du japonais sont équivalentes entre
# `Explicit correction` et `Recast`. Celles des locuteurs de
# l'italien et de l'allemand, en revanche, sont différentes.
# Autrement dit, les erreurs standards ne se superposent pas.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
ggplot(data = fb, aes(x = Hours, y = note)) +
  geom_point() +
  geom_smooth() +
  theme_minimal()
# On observe une tendance importante : plus le nombre
# d'heures d'études d'un participant est élevé, plus
# le score moyen augmente. Donc, apparemment, il y a
# une corrélation positive entre les deux variables.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 6
ggplot(data = fb, aes(x = Hours, y = note)) +
  geom_point(
    size = 3, alpha = 0.3,
    color = "darkviolet"
  ) +
  geom_smooth() +
  theme_minimal() +
  labs(
    x = "Heures",
    y = "Notes"
  )

# Version avec une relation linéaire :
ggplot(data = fb, aes(x = Hours, y = note)) +
  geom_point(
    size = 3, alpha = 0.3,
    color = "darkviolet"
  ) +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(
    x = "Heures",
    y = "Notes"
  )
