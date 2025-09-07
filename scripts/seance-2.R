# Ceci est mon premier commentaire! :)

# Installer tidyverse
# install.packages("tidyverse")
library(tidyverse)

# 1. Attribution de variable vs. l'impression d'un résultat

5 + 4 # l'impression d'un résultat
monExample <- 5 + 4 # l'attribution d'une variable
monExample

# 2. Les variables (vecteur)
mes_nombres <- c(10, 15, 8, 0, 150)
mes_nombres[2]
sort(mes_nombres)

mes_villes <- c("Montréal", "Québec", "Halifax", "Tadoussac", "Ottawa")

combiner <- c("Montréal", "Québec", 125, 10, "Tadoussac")
combiner

mon_tableau <- tibble(
  Ville = mes_villes,
  Nombre = mes_nombres
)

mon_tableau

# 3. Opérations

mes_nombres

mean(mes_nombres)
sd(mes_nombres)
max(mes_nombres)
min(mes_nombres)
range(mes_nombres)

# 4. Importer un tableau

donnees <- read_csv("donnees/sampleData.csv")

donnees

# Calculer la moyenne du testC : façon traditionnelle
mean(donnees$testC)
sd(donnees$testC)

# Calculer la moyenne du testC : façon tidyverse

# |> "ensuite; donc, ..."

mon_resume <- donnees |>
  summarize(
    Moyenne = mean(testC),
    Écart_type = sd(testC)
  )

# Large -> long
# Le tableau en question n'est pas TIDY
# TIDY : UNE observation par ligne; UNE colonne par variable!

donnees

mean(donnees$testA)
mean(donnees$testB)
mean(donnees$testC)

long <- donnees |>
  pivot_longer(
    names_to = "test",
    values_to = "note",
    cols = testA:testC
  )

donnees
long


mon_resume_long <- long |>
  summarize(
    Moyenne = mean(note),
    Écart_type = sd(note)
  )

mon_resume_long
