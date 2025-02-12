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
# Il faut transformer les données avant
# de commencer (le tableau n'est pas tidy)
long <- groupes |> 
  pivot_longer(names_to = "lettre",
               values_to = "note",
               cols = A:D)

# Moyennes et écarts-types :
long |> 
  summarize(M = mean(note),
            ET = sd(note),
            .by = lettre)

# 2. Visualisez les données (créez une figure) :
# boxplot, stat_summary, ...
ggplot(data = long, aes(x = lettre, y = note)) +
  geom_boxplot() +
  stat_summary(color = "red")


# 3. L'ANOVA :
mon_anova <- aov(note ~ lettre, data = long)
summary(mon_anova)

# 4. L'hypothèse nulle; les comparaisons :
TukeyHSD(mon_anova)

# 5. Des erreurs (type 1 et 2) :
# Il y a deux erreurs de type 2
# Les comparaisons nous donnent des valeurs
# p non significatives pour B-A et  C-B. Toutefois,
# on sait A et B sont différents, et on sait que
# B et C sont différents aussi, vu qu'on a simulé
# les données nous mêmes.


# Le code utilisé ici est le même du chapitre 5.