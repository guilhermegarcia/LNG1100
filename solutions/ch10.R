rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# Le fichier utilise le point-virgule pour
# séparer les colonnes, donc on utilise read_csv2() :
library(tidyverse)
library(janitor)
# Les exercices ici dépendent du fichier
# questionnaire2.csv, qui sera disponible à
# partir du chapitre 10.
# Vérifiez si le fichier csv est importé
# correctement :
q2 <- read_csv2("donnees/questionnaire2.csv")

# 1. Simplifier les noms des colonnes
q2 <- q2 |>
  clean_names()

# 2. Enlever des colonnes inutiles
q2 <- q2 |>
  select(-matches("heure|adresse|nom|total|quiz|points|feedback"))

# 2. Transformer les colonnes des question (wide-to-long)
long <- q2 |>
  pivot_longer(
    names_to = "question",
    values_to = "reponse",
    cols = 4:8
  )

# 3. Renommer quelques colonnes?
long <- long |>
  rename(
    "geo" = 2,
    "langues" = 3
  )

# 4. Corriger le questionnaire (il faut avoir la clé de correction!)

# Il faut s'assurer que les réponses dans la clé sont IDENTIQUES aux
# réponses réelles dans le questionnaire :
cle <- c(
  "le dzongkha",
  "le catalan",
  "le néerlandais",
  "le swati et l'anglais",
  "le tétum et le portugais"
)

long <- long |>
  mutate(cle = cle, .by = id)

# IMPORTANT : l'ordre de cle et l'ordre des questions
# doivent être identiques!
# Sinon, il faut utiliser une autre méthode (..._join())

# Maintenant, on corrige/compare les deux colonnes pertinentes :
long <- long |>
  mutate(correct = if_else(reponse == cle, 1, 0)) |>
  select(-cle)

# Finalement, on vérifie les classes des colonnes :
glimpse(long)

# Changer quelques classes (selon le besoin) :
long <- long |>
  mutate(
    id = as_factor(id),
    across(
      where(is_character),
      as_factor
    )
  )

# Si vous voulez exporter le fichier nettoyé :
# write_csv(long, file = "scripts/q2_nettoye.csv")
# Le fichier sera nécessaire pour les exercices
# du chapitre 11, donc vous pouvez :
# a) utiliser source() dans ce script
# b) exporter le csv nettoyé pour l'importer plus tard

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
long |>
  summarize(Score = mean(correct, na.rm = TRUE), .by = id)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
long |>
  summarize(Score = mean(correct, na.rm = TRUE), .by = geo)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
# Voici une figure sur la relation entre la connaissance
# d'autres langues et la performance dans le questionnaire :
ggplot(data = long, aes(x = langues, y = correct)) +
  stat_summary()
# C'est une figure très simple : vous pouvez l'améliorer, naturellement!

