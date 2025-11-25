# Premier script de l'analyse
# bibliothèques, fichier, nettoyage

# 1. Charger les bibliothèques
library(tidyverse)
# install.packages("janitor")
library(janitor)

# 2. Importer les données
q1 <- read_csv2("donnees/q1.csv")

# 3. « Visualiser » le tableau
# q1
# q1 |> glimpse()
# q1 |> names()

# 4. Standardiser les noms
q1 <- q1 |>
  clean_names()

q1 |> names()
# names(q1)

# 5. Enlever des colonnes inutiles
q1 <- q1 |>
  # select(-c(id, heure_de_debut)) |> # même chose que la ligne suivante
  # select(-c(1, 2)) # Les deux façons sont très manuelle!
  select(-matches("feedback|points|heure|adresse|nom")) # expressions régulières

# names(q1)

# 6. Transformation vers le format long/tidy
long1 <- q1 |>
  pivot_longer(
    names_to = "question",
    values_to = "reponse",
    cols = 5:14
  )

# long1

# 7. Simplification des noms
long1 <- long1 |>
  rename(
    "naissance" = 2,
    "langues" = 3,
    "phon" = 4
  )

# long1

# 8. Correction
reponses <- rep(c("Oui", "Non"), 5)

long1 <- long1 |>
  mutate(cle = reponses, .by = id)

# long1

long1 <- long1 |>
  mutate(correct = if_else(reponse == cle, 1, 0))

# long1

# mean(long1$correct)

# Ajustements finaux
long1 <- long1 |>
  mutate(
    id = as_factor(id),
    langues = as_factor(langues),
    across(where(is_character), as_factor)
  )

# J'ai un tutoriel sur les snippets dans mon site/blog (en anglais) :
# https://gdgarcia.ca/posts/2024-01-15-snippets/


# Calculer l'âge de façon « manuelle »
long1 <- long1 |>
  mutate(
    annee = str_extract(
      string = naissance,
      pattern = "\\d{4}$"
    ) |> as.numeric(),
    age = 2025 - annee
  ) |>
  select(-annee)

# C'est une façon « OK ». La bibliothèque lubridate
# vous permet de calculer l'âge correctement (voir chapitre 9 du livre du cours)

long1

# Fonction pour vérifier un échantillon des données :
# long1 |>
#   sample_n(size = 10)
