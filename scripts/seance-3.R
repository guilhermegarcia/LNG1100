# Complétez le préambule du script selon
# le besoin


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

# 2. Quel type est le plus pour les résultats des
# questionnaires à partir des sites tels que
# Google Forms ou MS Forms?

# On utilise tidyverse (spécifiquement l’extension tidyr) pour transformer
# un tableau de large à long et vice-versa.

# Transformation wide-to-long

# Transformation long-to-wide

# 3. Comment calculer la moyenne générale des notes? Et l'écart-type?

# 4. Comment créer une nouvelle colonne qui calcule la
# distance entre les notes et 100?

# 5. Comment filtrer seulement les notes supérieures à 70?

# 6. Comment calculer la moyenne *par cours*?

# ================================
# ================================
# PARTIE II : Révision
# ================================
# ================================

# Importer le fichier sampleData.csv
# Donnez-lui le nom « donnees ».
# Examinez les données attentivement pour comprendre leur structure.

# 2. Les données sont-elles tidy? Autrement dit,
# le tableau est-il large ou long?

# 3. Quelles sont les moyennes et les écarts-types des notes pour chaque test?

# 4. Les moyennes du groupe « control » sont-elles supérieures
# ou inférieures aux celles du groupe « target »?

# 5. Comment ajouter une colonne qui contient la note au carré?

# 6. Filtrez les données pour conserver seulement les étudiants
# dont les notes sont supérieures ou égales à 7
#

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
#
# 2. Quelles villes sont présentes dans les données?
# 3. Créez une figure appropriée pour les données
# 4. Calculez la note moyenne par ville
# 5. Le tableau est-il tidy? Pouvons-nous le transformer?
#
# Défi :
# 6. Comment pouvons-nous créer un nuage de points ici?
#    La façon la plus simples sera de créer un nouveau tableau
#    qui copie les valeurs de chaque ville. Ajoutez une ligne
#    de tendance à la figure.
