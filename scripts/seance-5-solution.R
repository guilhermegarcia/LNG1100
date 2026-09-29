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

long <- groupes |>
  pivot_longer(
    names_to = "groupe",
    values_to = "score",
    cols = A:D
  )

long

# 1. Calculez les moyennes/écarts-types :
long |>
  summarize(
    M = mean(score),
    ET = sd(score),
    .by = groupe
  )

# 2. Visualisez les données (créez une figure) :
ggplot(data = long, aes(x = groupe, y = score)) +
  geom_boxplot() +
  stat_summary() +
  theme_classic()

# 3. L'ANOVA :
lanova <- aov(score ~ groupe, data = long)

# 4. L'hypothèse nulle; les comparaisons :
lanova |> TukeyHSD()

# 5. Des erreurs (type 1 et 2) :
# Type II : B-A, D-A, C-B
# Pas d'erreur de type I, vu que tous les groupes ont une moyenne distincte
