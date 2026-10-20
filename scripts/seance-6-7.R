library(tidyverse)
library(emmeans)

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
#

ville <- read_csv("donnees/base/villes2.csv")

ville

fit1 <- lm(note ~ duree, data = ville)
fit2 <- lm(note ~ ville, data = ville)
fit3 <- lm(note ~ ville + duree, data = ville)

summary(fit1) # 0.03 R^2
summary(fit2) # 0.06 R^2 <- meilleure option
summary(fit3) # 0.056 R^2

anova(fit2, fit3)

# 1. Le modèle 2 nous donne le meilleur coef de det
# 2. Les modèles 2 et 3 ne sont pas stat différents
#

ville |>
  summarize(
    M = mean(note),
    ET = sd(note),
    VAR = var(note),
    .by = ville
  )

confint(fit2)


d <- read_csv("donnees/base/feedbackData.csv")

d

ggplot(data = d, aes(x = Feedback, y = task_A1, fill = L1)) +
  geom_boxplot(
    # position = position_dodge(width = 0.95),
  ) +
  stat_summary(
    position = position_dodge(width = 0.75),
    show.legend = FALSE
  )

fit2 |> summary()

# Calgary vs Montréal
# Calgary vs Québec


fit2 |>
  emmeans(pairwise ~ ville) |>
  _$contrasts |>
  as_tibble() |>
  ggplot(aes(x = estimate, y = contrast)) +
  geom_point()
