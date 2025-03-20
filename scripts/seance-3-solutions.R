# Complétez le préambule du script selon
# le besoin
library(tidyverse)

# ================================
# ================================
# PARTIE I : Les tableaux larges et longs
# ================================
# ================================

# Les tableaux sont les objets les plus importants (normalement)
# Bien que nous les importions à partir d'un fichier, il est possible
# de créer un tableau ici manuellement

# Il y a plusieurs types de tableaux :
# tibbles, data frames, data tables sont les plus importants
# On va se concentrer sur les tibbles, qui peuvent être créées
# avec la fonction tibble() ou tribble().
# Tapez ?tibble() et ?tribble() pour comprendre les différences entre elles.


# Voici un exemple d'un tableau (tibble) en deux formats : large et long.
# Ces tableaux sont créés manuellement ici juste
# pour vous donner des exemples :

# Large
large <- tribble(
  ~id, ~phonologie, ~syntaxe, ~phonetique,
  "PLK", 80, 55, 92,
  "GP", 67, 79, 83,
  "MFG", 72, 99, 90
)

large

# Long
long <- tribble(
  ~id, ~cours, ~note,
  "PLK", "phonologie", 80,
  "PLK", "syntaxe", 55,
  "PLK", "phonetique", 92,
  "GP", "phonologie", 67,
  "GP", "syntaxe", 79,
  "GP", "phonetique", 83,
  "MFG", "phonologie", 72,
  "MFG", "syntaxe", 99,
  "MFG", "phonetique", 90
)

long

# Les questions ci-dessous sont basées sur
# les tableaux large et/ou long.
#
# 1. Quel type de tableau est le meilleur pour
# l'analyse de données à vos avis...?
# Les tableaux longs sont presque toujours mieux.

# 2. Quel type est le plus pour les résultats des
# questionnaires à partir des sites tels que
# Google Forms ou MS Forms?
# Malheureusement, le format large...

# On utilise tidyverse (spécifiquement l’extension tidyr) pour transformer
# un tableau de large à long et vice-versa.

# Transformation wide-to-long
WL <- large |>
  pivot_longer(
    names_to = "cours",
    values_to = "note",
    cols = phonologie:phonetique
  )

WL
# Transformation long-to-wide
LW <- long |>
  pivot_wider(
    names_from = cours,
    values_from = note
  )

LW

# 3. Comment calculer la moyenne générale des notes? Et l'écart-type?
long |>
  summarize(
    M = mean(note),
    ET = sd(note)
  )

# 4. Comment créer une nouvelle colonne qui calcule la
# distance entre les notes et 100?
long <- long |>
  mutate(dist = note - 100)

# 5. Comment filtrer seulement les notes supérieures à 70?
sup70 <- long |>
  filter(note > 70)

sup70

# 6. Comment calculer la moyenne *par cours*?
long |>
  summarize(
    M = mean(note),
    ET = sd(note),
    .by = cours
  )

# Une alternative :
long |>
  group_by(cours) |>
  summarize(
    M = mean(note),
    ET = sd(note)
  )


# ================================
# ================================
# PARTIE II : Révision
# ================================
# ================================

# Importer le fichier sampleData.csv
# Donnez-lui le nom « donnees ».
# Examinez les données attentivement pour comprendre leur structure.
donnees <- read_csv("donnees/sampleData.csv")

# 2. Les données sont-elles tidy? Autrement dit,
# le tableau est-il large ou long?
donnees
# Il est large, et donc pas « tidy ». Cela veut
# dire qu'il faudra le transformer
donnees_long <- donnees |>
  pivot_longer(
    names_to = "test",
    values_to = "note",
    cols = testA:testC
  )

donnees_long

# 3. Quelles sont les moyennes et les écarts-types des notes pour chaque test?
donnees_long |>
  summarize(
    M = mean(note),
    ET = sd(note),
    .by = test
  )

# 4. Les moyennes du groupe « control » sont-elles supérieures
# ou inférieures aux celles du groupe « target »?

donnees_long |>
  summarize(
    M = mean(note),
    .by = group
  )
# Le groupe target a une moyenne plus élevée.

# 5. Comment ajouter une colonne qui contient la note au carré?
donnees_long <- donnees_long |>
  mutate(note_au_caree = note^2)
donnees_long

# 6. Filtrez les données pour conserver seulement les étudiants
# dont les notes sont supérieures ou égales à 7
donnees_long <- donnees_long |>
  filter(note >= 7)

donnees_long

# ================================
# ================================
# PARTIE III : villes
# ================================
# ================================

# 1. Importez le fichier villes.csv et examinez-le
# C'est un fichier qui sera utilisé plus tard
# dans notre cours.
# Quelle est la classe de la variable « ville »?
# Quelle fonction pouvons-nous utiliser pour vérifier cela?
# Changez-la en « factor ». Quelle(s) différence(s) notez-vous?
v <- read_csv("donnees/villes.csv")
v
# 2. Quelles villes sont présentes dans les données?
# Québec et Montréal, mais comment savoir la réponse?
# Il est utile de transformer la variable ville en facteur :
v <- v |>
  mutate(ville = as_factor(ville))

summary(v) # maintenant, R nous donne les villes

# 3. Créez une figure appropriée pour les données
ggplot(data = v, aes(x = ville, y = note)) +
  geom_boxplot()

# 4. Calculez la note moyenne par ville
v |>
  summarize(
    M = mean(note),
    .by = ville
  )
# 5. Le tableau est-il tidy? Pouvons-nous le transformer?
# Le tableau est déjà tidy (long). Sa transformation serait
# difficile parce qu'il y a des notes répétées.
#
# Défi :
# 6. Comment pouvons-nous créer un nuage de points ici?
#    La façon la plus simples sera de créer un nouveau tableau
#    qui copie les valeurs de chaque ville. Ajoutez une ligne
#    de tendance à la figure.

# Pour cela, il faut avoir deux colonnes continues.
# La fonction pivot_wider() ne marchera pas ici à cause
# des notes répétées. Mais on a vu comment créer notre propre
# tibble :
v_large <- tibble(
  Montreal = v |>
    filter(ville == "Montréal") |>
    pull(note),
  Quebec = v |>
    filter(ville == "Québec") |>
    pull(note)
)

v_large # Voici le tableau :
# # A tibble: 50 × 2
#    Montreal Quebec
#       <dbl>  <dbl>
#  1     64.0   65.9
#  2     68.7   64.6
#  3     76.6   74.8
#  4     66.2   69.7
#  5     75.1   82.8
#  6     58.3   70.9
#  7     64.6   62.2
#  8     73.5   78.8
#  9     61.7   81.9
# 10     66.5   69.2
# # ℹ 40 more rows

ggplot(data = v_large, aes(x = Montreal, y = Quebec)) +
  geom_point() +
  stat_smooth(method = "lm")

# On remarque que les notes des deux villes ne semblent
# être particulièrement corrélées.
