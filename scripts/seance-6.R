library(tidyverse)

# Pratique d'une régression linéaire
#
# Nos données simulées (séance 5) :

set.seed(1)
groupes <- tibble(
  A = rnorm(100, mean = 70, sd = 20),
  B = rnorm(100, mean = 80, sd = 20),
  C = rnorm(100, mean = 83, sd = 20),
  D = rnorm(100, mean = 70, sd = 20)
)

# On a déjà créé une figure, donc allons
# directement à l'analyse. Exécutez une
# régression ici :


# Interprétez et rapportez les résultats
# Quelles différences remarquez-vous par
# rapport à l'ANOVA de la séance 5?


# =======================================
# =======================================
# =======================================

# Pratique : une ville de plus
# 1. importez le fichier

# 2. explorez les différences (ville)

# 3. créez une figure

# 4. modèle linéaire

# 5. interprétez les résultats

# Pratique : une variable de plus
# 1. créez une figure pour ville et durée

# 2. modèle

# 3. interprétez les résultats

# 4. un modèle juste avec durée :

# ===============================
# ===============================
# ===============================
# Pratique à la maison : figure à reproduire
