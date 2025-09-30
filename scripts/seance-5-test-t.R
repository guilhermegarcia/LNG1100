library(tidyverse)

# NOTE: On calcule la statistique t ici.

villes <- read_csv("donnees/villes.csv")

# NOTE: Extraire les notes de chaque ville :
#
# NOTE: Les notes de Montréal
montreal <- villes |>
  filter(ville == "Montréal") |>
  pull(note) # pull() extrait las valeurs d'une colonne

# NOTE: Les notes de Québec
quebec <- villes |>
  filter(ville == "Québec") |>
  pull(note)

# NOTE: Calculer les moyennes :
mm <- mean(montreal) # moyenne de Montréal
mq <- mean(quebec) # moyenne de Québec

# NOTE: La taille des échantillons :
nm <- length(montreal) # lenght() marche ici parce que montreal est un vecteur
nq <- length(quebec)

# On constate que nm = nq :
nm == nq

# Donc, on peut simplment dire :
n <- nm

# NOTE: Calculer les variances manuellement :
vm <- sum((montreal - mm)^2) / (n - 1)
# Vérifier que le calcul est correct :
var(montreal) == vm

vq <- sum((quebec - mq)^2) / (n - 1)
# Vérifier que le calcul est correct :
var(quebec) == vq


# NOTE: Maintenant, on a toutes les variables nécessaires
# pour le calcul de t :
t <- (mm - mq) /
  sqrt(
    (vm / n) +
      (vq / n)
  )

# NOTE: Comparez les deux méthodes :
t # manuel
t.test(montreal, quebec) # automatique en séparant les villes avant
t.test(note ~ ville, data = villes) # automatique avec un tableau de données

# HACK: Vous pouvez extraire la valeur t du test aussi :
t.test(note ~ ville, data = villes)$statistic
