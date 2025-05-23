library(tidyverse)

# Pratique d'une ANOVA
# Ici, on va générer des données,
# donc on sait déjà où sont les différences
# dans les populations en question.
#
# Nos données simulées :

set.seed(1)
groupes <- tibble(
  A = rnorm(100, mean = 70, sd = 20),
  B = rnorm(100, mean = 80, sd = 20),
  C = rnorm(100, mean = 83, sd = 20),
  D = rnorm(100, mean = 70, sd = 20)
)

# 1. Calculez les moyennes/écarts-types :

# 2. Visualisez les données (créez une figure) :

# 3. L'ANOVA :

# 4. L'hypothèse nulle; les comparaisons :

# 5. Des erreurs (type 1 et 2) :
