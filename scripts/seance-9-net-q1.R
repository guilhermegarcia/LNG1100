# 0. Importer les bibliothèques
library(tidyverse)
library(janitor)
library(scales) # Pour les figures dans le script ..._exp

# 1. Importer le questionnaire :
q1 <- read_csv2("donnees/supplementaires/questionnaire.csv")
# q1 |> glimpse()

# Quand vos colonnes sont trop longues, names() est plus utile que glimpse()
# names(q1)
# q1 |> names()

# Le tableau n'est pas tidy : en général, les formulaires
# Google/MS/etc. ne sont jamais tidy parce que chaque
# question nous donne une colonne séparée, et donc chaque
# ligne contiendra n réponses/observations...

# 2. Standardiser les noms
q1_net <- q1 |>
  clean_names()

# Vérifier le résultat :
# q1_net |> names()

# Ensuite, enlever les colonnes inutiles :
# feedback, points, email, name, time
q1_net <- q1_net |>
  select(-matches("^(heure|adresse|nom|total|quiz|points|feedback|x51)"))

# Vérifier le résultat :
# q1_net |> names()

# 3. Simplifier les noms des colonnes pertinentes

q1_net <- q1_net |>
  rename(
    "artiste" = 2,
    "naissance" = 3,
    "langues" = 4,
    "phon" = 5
  )

# Vérifier le résultat :
# q1_net |> names()

# 4. Transformer le tableau (processus wide-to-long)
q1_long <- q1_net |>
  pivot_longer(
    names_to = "question",
    values_to = "reponse",
    cols = 6:15
  )

# q1_long

# 5. Corriger/noter le questionnaire
# Créer les réponses correctes :
cle <- rep(c("Oui", "Non"), times = 5)

# Ajouter ces réponses au tableau :
q1_long <- q1_long |>
  mutate(
    cle = cle,
    .by = id
  )

# Vérifier le résultat :
# q1_long |> sample_n(size = 10)

# Correction :
q1_long <- q1_long |>
  mutate(
    correct = if_else(
      reponse == cle, 1, 0
    )
  )

# q1_long |> sample_n(size = 10)

q1_long <- q1_long |>
  mutate(
    id = as_factor(id)
  )
