rm(list=ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# Tout d'abord, on a besoin de la version
# nettoyée des données :
source("solutions/ch10.R")
long |> 
  summarize(precision = mean(correct, na.rm = TRUE), 
            .by = langues)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
long |> 
  summarize(precision = mean(correct, na.rm = TRUE), 
            .by = geo)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
long |> 
  filter(id %in% c(4, 7, 14, 15, 17)) |> 
  summarize(Precision = mean(correct, na.rm = TRUE))

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
long = long |> 
  mutate(geo_lang = if_else(geo == "Oui" & langues == "Oui", "Oui", "Non"))

long |> 
  summarize(precision = mean(correct, na.rm = TRUE), 
            .by = geo_lang)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
# Ici, stat_summary() serait une possibilité
# (le code est déjà dans le chapitre). Voilà
# l'avantage de travailler avec 0/1 dans la variable
# de réponse : stat_summary() pourra calculer quelques
# statistiques.
# On parle des pourcentages, donc c'est déjà une
# variable dérivée à partir des données.
# Vous pouvez constater que la distribution de correct
# n'est sera pas normale. On doit donc éviter des
# figures telles que les boîtes à moustache, par exemple.
# En effet, même stat_summary() peut être problématique, vu
# que la figure calcule les erreurs standards : dans une variable
# non normale, ces erreurs sont moins fiables. 
# Il y a d'autres figures qui pourraient être utiles ici :
# a. la performance individuelle de chaque participant
# b. la performance générale selon chaque question
