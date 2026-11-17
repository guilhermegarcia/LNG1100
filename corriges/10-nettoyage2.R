rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# Tout d'abord, on a besoin de la version
# nettoyée des données :
source("corriges/09-nettoyage.R")
long |>
  summarize(
    precision = mean(correct, na.rm = TRUE),
    .by = langues
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
long |>
  summarize(
    precision = mean(correct, na.rm = TRUE),
    .by = geo
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
long |>
  filter(id %in% c(59, 62, 69, 70, 72)) |>
  summarize(Precision = mean(correct, na.rm = TRUE))
# Précision = 0,32 (32 %). Les données sont celles de la cohorte
# 2026 (participants 56 à 77) et ne changeront plus.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
long <- long |>
  mutate(geo_lang = if_else(geo == "Oui" & langues == "Oui", "Oui", "Non"))

long |>
  summarize(
    precision = mean(correct, na.rm = TRUE),
    .by = geo_lang
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
# Ici, stat_summary() serait une possibilité
# (le code est déjà dans le chapitre). Voilà
# l'avantage de travailler avec 0/1 dans la variable
# de réponse : stat_summary() pourra calculer quelques
# statistiques.
# On parle des pourcentages, donc c'est déjà une
# variable dérivée à partir des données.
# Vous pouvez constater que la distribution de correct
# ne sera pas normale. On doit donc éviter des
# figures telles que les boîtes à moustache, par exemple.
# En effet, même stat_summary() peut être problématique, vu
# que la figure calcule les erreurs standards : dans une variable
# non normale, ces erreurs sont moins fiables.
# Il y a d'autres figures qui pourraient être utiles ici :
# a. la performance individuelle de chaque participant
# b. la performance générale selon chaque question

# a. Précision de chaque participant (ordonnée) :
long |>
  summarize(precision = mean(correct, na.rm = TRUE), .by = id) |>
  ggplot(aes(x = fct_reorder(id, precision), y = precision)) +
  geom_col(alpha = 0.3) +
  geom_point(size = 3) +
  labs(x = "Participant", y = "Précision")

# b. Précision selon chaque question (les noms des questions
# sont longs : on les raccourcit et on met les barres à l'horizontale) :
long |>
  summarize(precision = mean(correct, na.rm = TRUE), .by = question) |>
  mutate(question = question |> as.character() |> str_trunc(30)) |>
  ggplot(aes(x = fct_reorder(question, precision), y = precision)) +
  geom_col(alpha = 0.3) +
  coord_flip() +
  labs(x = NULL, y = "Précision")
