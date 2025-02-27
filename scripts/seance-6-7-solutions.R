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
v2 <- read_csv("donnees/villes2.csv")

# 2. explorez les différences (ville)
v2 |>
  summarize(M = mean(note), .by = ville)

# 3. créez une figure
ggplot(data = v2, aes(x = ville, y = note)) +
  geom_boxplot()

# 4. modèle linéaire
mod1 <- lm(note ~ ville, data = v2)
summary(mod1)

# 5. interprétez les résultats
# Québec a un effet significatif par rapport
# à Calgary (B=7, p < 0.001). Toutefois,
# Montréal n'a pas d'éffet significatif
# (par rapport à Calgary). Notre modèle explique
# juste 6 % de la variation des notes.
# Veuillez noter qu'on n'est pas capable d'examiner
# l'effet de Québec par rapport à Montréal directement.


# Pratique : une variable de plus
# 1. créez une figure pour ville et durée
ggplot(data = v2, aes(x = duree, y = note, color = ville)) +
  geom_point(alpha = 0.3) +
  stat_smooth(method = "lm") +
  theme_classic()

# 2. modèle
mod2 <- lm(note ~ ville + duree, data = v2)
summary(mod2)

# Considérez aussi un modèle avec duree simplement
# Vous verrez que dans ce modèle, duree a un effet
# significatif, ce qui n'est pas le cas dans le modèle
# ici, avec ville.

# 3. interprétez les résultats
# L'effet de Québec est toujours là (bien que
# moins significatif maintenant). La durée n'affecte
# pas la performance lorsqu'on considère la ville.

# 4. un modèle juste avec durée :
mod3 <- lm(note ~ duree, data = v2)
summary(mod3)
# On voit que la durée semble être pertinant,
# mais il s'agit d'un effet des villes.

# ===============================
# ===============================
# ===============================
# Pratique à la maison : figure à reproduire
ggplot(data = v2, aes(x = duree, y = note)) +
  geom_point(aes(color = ville), size = 3, alpha = 0.7) +
  stat_smooth(method = "lm") +
  theme_bw() +
  labs(
    x = "Temps d'étude du français (en mois)",
    y = "Note",
    color = "Ville :",
    title = "Les notes des trois groupes"
  )
