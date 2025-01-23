# Séance 2 - Introduction au language R
rm(list = ls()) # cette ligne est utilisée pour
# effacer tous les objets dans l'onglet « Environnement » 
# Commentaires avec un # (Cmd/Ctrl+Shift+C)
# Préambule
# Importer nos extensions :
library(tidyverse)

# Pour installer une extension (juste une fois) :
# install.packages("tidyverse")

# Exemple de commande :
# Notre itinéraire aujourd'hui :

# La structure d'un script typique : les fichiers .R

# Création des variables : = OU <- (Option -)


# Les objets les plus importants
# Vecteurs : c() dans un tableau, chaque
# colonne est un vecteur
villes = c("Montreal", "Quebec", "Halifax")
nombres = c(1, 2, 3, 87, 12, 15, 29, 1, 2, 3, 1000, NA)
lesDeux = c("Montréal", 2, "Calgary", "25")
# Les vecteurs n'acceptent qu'UNE seule classe
# de valeurs

# Fonctions basiques pour les vecteurs :
nombres
# Quelques fonctions basiques (statistique)
# Le vecteur contient un NA, donc il faut
# ajouter na.rm = TRUE a chaque fonction :
mean(nombres, na.rm = TRUE)
median(nombres, na.rm = TRUE)
min(nombres, na.rm = TRUE)
max(nombres, na.rm = TRUE)
range(nombres, na.rm = TRUE)

nombres[1:3]

# Data frames -> tibbles, nos tableaux
# Deux façons de créer un tableau (tibble)
# Façon visuellement plus facile :
monTableau = tribble(~nom, ~age,
                     "Pierre", 19,
                     "Juan", 25,
                     "Ted", 50)

# Façon traditionnelle (plus difficile) :
monTableau = tibble(nom = c("Pierre", "Juan", "Ted"),
                    age = c(19, 25, 50))

glimpse(monTableau)
# Les classes les plus importantes
# numeric, factor, character, boolean, NA



# Importer nos données
mes_donnees = read_csv("donnees/sampleData.csv")

# Visualiser notre tableau
mes_donnees
glimpse(mes_donnees)

# Explorer nos colonnes (chaque colonne est une variable; un vecteur)
# Calculer les moyennes pour les tests :
mean(mes_donnees$testA) # Pour le test A
mean(mes_donnees$testB) # Pour le test B
mean(mes_donnees$testC) # Pour le test C

# Calculer les écarts-types :
sd(mes_donnees$testA) # Pour le test A
sd(mes_donnees$testB) # Pour le test B
sd(mes_donnees$testC) # Pour le test C


