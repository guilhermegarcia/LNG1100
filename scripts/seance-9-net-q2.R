library(tidyverse)
library(janitor)

# Importer les données :
q <- read_csv2("donnees/supplementaires/questionnaire.csv")

# ===============================

# Nettoyage :
# Le fichier est-il tidy?
glimpse(q) # Non!


# Notez que les questions du questionnaire commencent dans la colonne 6 (jusqu'à la colonne 15)


# Trois problèmes :
# 1. les noms des colonnes sont horribles
# 2. il y a des colonnes inutiles (merci, MS Forms)
# 3. le tableau n'est pas tidy

# Pour régler le problème 1, on utilise l'extension janitor :
q <- clean_names(q)
glimpse(q)

# On veut enlever les colonnes qui contiennent « feedback », « points » etc. :
q <- q |>
  select(-matches("^(heure|adresse|nom|feedback|points|total|quiz)"))

glimpse(q)

# Vérifions les noms des colonnes :
names(q)

# Transformation wide-to-long :
long <- q |>
  pivot_longer(
    names_to = "question",
    values_to = "reponse",
    cols = 6:15
  )

glimpse(long)

# C'est une bonne idée de simplifier les noms des variables aussi :
long <- long |>
  rename(
    "artiste" = "votre_artiste_prefere",
    "naissance" = "votre_date_de_naissance",
    "langues" = "combien_de_langues_parlez_vous",
    "phonologie" = "avez_vous_suivi_le_cours_de_phonologie_ou_de_phonetique"
  )

glimpse(long)


# Observez la colonne « id ». Sa classe est-elle appropriée?
# Non : il faut la changer
long <- long |>
  mutate(
    id = as_factor(id),
    across(where(is_character), as_factor)
  )

glimpse(long)

# =============================

# Comment évaluer les réponses? Il faut avoir une clé de correction!
reponses <- c(
  "oui", "non", "oui", "non",
  "oui", "non", "oui", "non",
  "oui", "non"
)

# Maintenant, on colle les responses dans notre tableau principal
# Faites attention : on n'a que 10 réponses, mais notre tableau contient
# 10 * n lignes (n = nombre de participants). Donc, il faut GROUPER les
# données avant d'ajouter la nouvelle colonne :
long <- long |>
  mutate(correction = reponses, .by = id)

long


# Finalement, on peut corriger les réponses en utilisant la fonction if_else() :
# (Notez la différence entre les lettres majuscules et minuscules)
long <- long |>
  mutate(bonne_reponse = if_else(str_to_lower(reponse) == correction, 1, 0))

glimpse(long)

# Maintenant, on peut enlever la colonne « correction » :
long <- long |>
  select(-correction)

long

# =============

# Bonus : l'âge à partir de la date de naissance avec l'extension lubridate
long <- long |>
  mutate(
    naissance = mdy(naissance),
    age = (interval(naissance, today()) / years(1)) |> round(0)
  )

glimpse(long, width = 50) # Voilà!


# ========== Pratique

cle <- c(
  "le dzongkha",
  "le catalan",
  "le néerlandais",
  "le swati et l'anglais",
  "le tétum et le portugais"
)


q2 <- read_csv2("donnees/supplementaires/questionnaire2.csv")

glimpse(q2)

# 1. Simplifier les noms des variables :
q2 <- clean_names(q2)

glimpse(q2)

# 2. Enlever des colonnes inutiles :
q2 <- q2 |>
  select(-matches("^(heure|adresse|nom|feedback|points|total|quiz)"))

glimpse(q2)

# 3. Renommer des colonnes :
q2 <- q2 |>
  rename(
    "artiste" = 2,
    "geographie" = 3,
    "langues" = 4
  ) |>
  select(-artiste) # inutile pour l'analyse

glimpse(q2)

# 4. Transformation wide-to-long :
names(q2)

long2 <- q2 |>
  pivot_longer(
    names_to = "question",
    values_to = "reponse",
    cols = 4:8
  )

# 5. Ajouter les réponses correctes et corriger les réponses données :
long2 <- long2 |>
  mutate(bonne_reponse = cle, .by = id) |>
  mutate(correct = if_else(reponse == bonne_reponse, 1, 0)) |>
  select(-bonne_reponse)

long2

# 6. Ajustements additionnels :
# Les classes des variables
long2 <- long2 |>
  mutate(
    id = as_factor(id),
    across(where(is_character), as_factor)
  )

glimpse(long2)

# =============================

# Bonus : correction

# Le score de chaque participant (proportion de bonnes réponses) :
long2 |>
  summarize(score = mean(correct, na.rm = TRUE), .by = id)

# Le goût pour la géographie affecte-t-il la précision des réponses?
long2 |>
  summarize(score = mean(correct, na.rm = TRUE), .by = geographie)

# Une figure possible :
ggplot(data = long2, aes(x = geographie, y = correct)) +
  stat_summary() +
  coord_cartesian(ylim = c(0, 1)) +
  labs(x = "Aime la géographie", y = "Proportion de bonnes réponses")
