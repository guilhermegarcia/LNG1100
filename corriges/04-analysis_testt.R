rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
library(tidyverse)
villes <- read_csv("donnees/base/villes.csv")

# Note moyenne pour chaque groupe :
villes |>
  group_by(ville) |>
  summarize(M = mean(note))

# Alternative :
villes |>
  summarize(M = mean(note), .by = ville)

# Ordonnez le tableau :
## Ordonnez les notes des deux groupes ensembles
villesOrdonnees <- villes |>
  arrange(desc(note))

## Ordonnez les notes dans chaque groupe
## (attention : arrange() ignore group_by() par défaut,
## donc on ordonne d'abord par ville, puis par note)
villesOrdonnees <- villes |>
  arrange(ville, desc(note))

# Exportez la version ordonnée :
write_csv(villesOrdonnees, "donnees/villesOrdonnees.csv")

# Figure :
ggplot(data = villes, aes(x = ville, y = note)) +
  stat_summary() +
  labs(
    x = "Ville",
    y = "Note"
  ) +
  theme_minimal() +
  labs(
    title = "Moyennes + barres d'erreurs",
    subtitle = "Montréal vs. Québec"
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
sup60 <- villes |>
  filter(note > 60)

ggplot(data = sup60, aes(x = ville, y = note)) +
  geom_boxplot(fill = "darkviolet", alpha = 0.2) +
  labs(
    x = "Ville",
    y = "Note"
  ) +
  theme_minimal() +
  labs(
    title = "Boîte à moustache",
    subtitle = "Montréal vs. Québec"
  )

t.test(note ~ ville, data = sup60)
# l'argument « alternative » accepte trois valeurs :
# greater, less, two.sided (défaut)
#
# La moyenne de Québec (74,2) est plus élevée que celle de Montréal (70,1).
# Donc, on rejette l'hypothèse nulle (p < 0.0003).
# Examinez la figure à nouveau : êtes-vous surpris?

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# L'alternative correcte est la troisième :
# 3. « Si l'hypothèse nulle est vraie, il y a 4 % de probabilité d'obtenir des résultats aussi extrêmes que, ou plus extrêmes que, les résultats observés. »
#
# Les autres interprétations sont incorrectes :
# 1. La valeur p est calculée en supposant que H0 est vraie.
#    Elle ne peut donc pas nous donner la probabilité que H0 soit vraie.
# 2. La valeur p ne dit rien sur la réplication de l'expérience.
#    Elle porte sur nos données, étant donnée H0.
# 4. Un résultat est significatif ou non selon un seuil fixé à
#    l'avance (α = 0,05). Ici, p = 0,04 < 0,05 : le résultat est
#    significatif. La valeur p n'est pas une « probabilité d'être
#    significatif ».
# 5. C'est la même erreur que l'interprétation 1 : « dus au hasard »
#    veut dire « H0 est vraie ». Or, la valeur p suppose déjà que
#    H0 est vraie.
