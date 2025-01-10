rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
mesNombres = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50)

# Voici une alternative plus élégante :
mesNombres = seq(from = 5, to = 50, by = 5)
# Combien d'éléments a-t-on dans l'objet en question?
# Connaissez-vous une fonction qui trouve la réponse?
length(mesNombres)

# Ensuite, on peut examiner la classe de
# l'objet `mesNombres` en utilisant la fonction `class()` :
class(mesNombres)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
villes = c("Québec", "Montréal", "Paris", "Lisbonne")
class(villes)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
villesNombres = c("Québec", 23, "Montréal", 3)
class(villesNombres)
# La classe sera « character » (chr)
# Un vecteur contient des éléments d'une seule classe
# Ici, les nombres sont transformés en
# caractères (d'où les guillemets "...")

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
moyenne = mean(mesNombres)
et = sd(mesNombres)
# Bien que la moyenne soit informative,
# il faut connaître aussi le niveau de dispersion
# des données. Par exemple, le vecteur
# `c(1, 2, 3, 4, 5)` est moins dispersé
# que `c(1, 20, 30, 40, 50)`.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
langues = c("français", "anglais", "espagnol", "allemand")

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 6
nchar(langues)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 7
sort(langues)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 8
langues = sort(langues)

# Cette commande changera l'ordre de
# l'objet original (remplacement)
langues

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 9
# Le format long est presque toujours préférable, mais
# on peut facilement convertir un format en l'autre.
# Il s'agit du format « tidy » (tidy data) :
# une variable par colonne, une observation par ligne.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 10
# Le format large, malheureusement. Donc, il est **essential**
# de savoir comment faire la transformation *wide-to-long*

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 11
# Voici le tableau long créé dans le chapitre :
library(tidyverse)
long = tribble(
  ~id, ~cours, ~note,
  "PLK", "phonologie", 80,
  "PLK", "syntaxe", 55,
  "PLK", "phonetique", 92,
  "GP", "phonologie", 67,
  "GP", "syntaxe", 79,
  "GP", "phonetique", 83,
  "MFG", "phonologie", 72,
  "MFG", "syntaxe", 99,
  "MFG", "phonetique", 90
)

mean(long$note)
sd(long$note)
# Voici une version plus élégante :
long |>
  summarize(
    M = mean(note),
    ET = sd(note)
  )
# « Prend l'objet 'long' et créez un résumé avec deux colonnes :
# M et ET »

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 12
long = long |>
  mutate(dist = 100 - note)

long

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 13
notes_sup = long |>
  filter(note > 70)

notes_sup

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 14
long |>
  summarize(
    M = mean(note),
    .by = cours
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 15
donnees = read_csv("donnees/sampleData.csv")

donnees

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 16
# Ce n'est pas *tidy*. Donc, le tableau est large :
# plus d'une observation par ligne.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 17
# C'est plus facile de travailler avec un tableau long
donnees_long = donnees |>
  pivot_longer(
    names_to = "test",
    values_to = "note",
    col = testA:testC
  )

# Maintenant, on peut calculer les moyennes en groupant
# les données par test :
donnees_long |>
  summarize(
    M = mean(note),
    ET = sd(note),
    .by = test
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 18
donnees_long |>
  summarize(M = mean(note), .by = group)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 19
donnees_long = donnees_long |>
  mutate(note_carree = note^2)

donnees_long

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 20
bonnes_notes = donnees_long |>
  filter(note >= 7)

bonnes_notes
