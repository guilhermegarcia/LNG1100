library(tidyverse)

# ==============================================
# NOTE: La notion d'échantillonnage
# ==============================================

# Imaginez une langue avec 20 locuteurs natifs.
# Ils vivent dans plusieurs régions et on peut
# en contacter juste 3.
# Notre projet examine le temps de réaction (TR) des
# locuteurs dans une expérience psycholinguistique.

# Simulons les TR de la population
# entière (N = 20) :
set.seed(1) # pour reproduire les valeurs générées
pop <- rnorm(20, mean = 5, sd = 2)

# Voici les TR de la population (auxquels on n'a pas accès) :
pop

# Remarquez que la moyenne de la population est ~5 :
mean(pop)
# [1] 5.381048

# Maintenant, simulons notre échantillon de 3 participants :
set.seed(2)
echant <- sample(x = pop, size = 3)
mean(echant)
# [1] 5.750456

# Notez que la moyenne de l'échantillon est très
# similaire à celle de la population, même avec
# juste 3 participants (!)

# On vient d'observer la logique de l'échantillonnage :
# on déduit la population (sa moyenne) à partir de l'échantillon
# L'exemple de la diapo considère une population de 20 000.

# ==============================================
# ==============================================
# NOTE: Notes et exercices de la séance
# ==============================================
# ==============================================

# Exemple avec le fichier villes.csv
# Importons le fichier :
villes <- read_csv("donnees/villes.csv")

# Voici les premières lignes :
villes
# # A tibble: 100 × 2
#     note ville
#    <dbl> <chr>
#  1  65.9 Québec
#  2  64.6 Québec
#  3  74.8 Québec
#  4  69.7 Québec
#  5  82.8 Québec
#  6  70.9 Québec
#  7  62.2 Québec
#  8  78.8 Québec
#  9  81.9 Québec
# 10  69.2 Québec
# # ℹ 90 more rows
# # ℹ Use `print(n = ...)` to see more rows

# Figure pour explorer les données :
ggplot(data = villes, aes(x = ville, y = note)) +
  geom_boxplot()


# Test pour vérifier la différence entre les villes :
# (je colle le résultat ici)
t.test(note ~ ville, data = villes)
#
# 	Welch Two Sample t-test
#
# data:  note by ville
# t = -4.1049, df = 97.919, p-value = 8.385e-05
# alternative hypothesis: true difference in means between group Montréal and group Québec is not equal to 0
# 95 percent confidence interval:
#  -6.807543 -2.370457
# sample estimates:
# mean in group Montréal   mean in group Québec
#                69.5838                74.1728
#
