library(tidyverse)

# ==============================================
# La notion d'échantillonnage
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
# Notes et exercices de la séance
# ==============================================
# ==============================================
