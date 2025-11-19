library(tidyverse)
library(janitor)
library(Hmisc)

# 1. Importer les données
# Les colonnes sont séparées avec ; (pas ,)
# Donc, utilisons read_csv2()
q2 <- read_csv2("donnees/q2.csv")

names(q2)

# 2. Standardiser les noms des colonnes
q2 <- q2 |>
  clean_names()

# 3. Enlever les colonnes inutiles
q2 <- q2 |>
  select(-matches("feedback|points|heure|adresse|nom")) # expressions régulières

q2

# 4. Renommer les colonnes :
q2 <- q2 |>
  rename(
    "geo" = 2,
    "langues" = 3
  )

q2
names(q2)

# 5. Transformation wide-to-long :
long2 <- q2 |>
  pivot_longer(
    names_to = "question",
    values_to = "reponses",
    cols = 4:8
  )

long2

# 6. Ajouter la clé de réponses et corriger le questionnaire
cle <- c(
  "le dzongkha",
  "le catalan",
  "le néerlandais",
  "le swati et l'anglais",
  "le tétum et le portugais"
)

long2 <- long2 |>
  mutate(
    cle = cle,
    .by = id
  ) |>
  mutate(
    correct = if_else(
      reponses == cle, 1, 0
    ),
    correction = if_else(
      reponses == cle, "correct", "incorrect"
    )
  )

# long2 |> glimpse()


# =============== COMBINER ============ PRATIQUE

# Utilisez l'espace ici pour combiner toutes les
# opérations ci-dessus. Cela vous permet de pratiquer
# les fonctions et l'enchaînement des commandes.
