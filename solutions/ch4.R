rm(list=ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
library(tidyverse)
villes = read_csv("donnees/villes.csv")

# Note moyenne pour chaque groupe :
villes |> 
  group_by(ville) |> 
  summarize(M = mean(note))

# Alternative :
villes |> 
  summarize(M = mean(note), .by = ville)

# Ordonnez le tableau :
## Ordonnez les notes des deux groupes ensembles
villesOrdonnees = villes |> 
  arrange(desc(note))

## Ordonnez les notes dans chaque groupe
villesOrdonnees = villes |>
  group_by(ville) |> 
  arrange(desc(note))

# Exportez la version ordonnée :
write_csv(villesOrdonnees, "donnees/villesOrdonnees.csv")

# Figure :
ggplot(data = villes, aes(x = ville, y = note)) + 
  stat_summary() +
  labs(x = "Ville", 
       y = "Note") +
  theme_minimal() +
  labs(title = "Moyennes + barres d'erreurs",
       subtitle = "Montréal vs. Québec")

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
sup60 = villes |> 
  filter(note > 60)

ggplot(data = sup60, aes(x = ville, y = note)) + 
  geom_boxplot(fill = "darkviolet", alpha = 0.2) +
  labs(x = "Ville", 
       y = "Note") +
  theme_minimal() +
  labs(title = "Boîte à moustache",
       subtitle = "Montréal vs. Québec")

t.test(note ~ ville, data = sup60)
# l'argument « alternative » accepte trois valeurs : 
# greater, less, two.sided (défaut)
# 
# La moyenne de Québec est toujours plus élevée que la moyenne de Montréal.
# Donc, on rejette l'hypothèse nulle (p < 0.0003). 
# Examinez la figure à nouveau : êtes-vous surpris?

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# L'alternative correcte est la troixième :
# 3. « Si l'hypothèse nulle est vraie, il y a 4 % de probabilité d'obtenir des résultats aussi extrêmes que, ou plus extrêmes que, les résultats observés. »
