rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
library(tidyverse)
villes <- read_csv("donnees/base/villes2.csv")
qc_mtl <- villes |>
  filter(ville != "Calgary")

t.test(note ~ ville, data = qc_mtl)
# Le test confirme un effet significatif de `ville` (p < 0,05),
# ce qui contredit le test posthoc Tukey effectué plus tôt
# dans le chapitre (Québec-Montréal, p adj = 0.08).
# L'ajustement de la valeur p dans le test Tukey
# a effectivement « effacé » la différence significative entre les
# deux villes. Au fait, si on décidait d'ignorer
# Calgary dans l'étude, on conclurait que les notes
# entre Québec et Montréal sont différentes. Si, par
# contre, on décidait d'inclure Calgary, on aurait besoin
# d'une ANOVA et, par conséquent, d'un test posthoc,
# ce qui changera les résultats dans les données en question,
# et notre différence ne sera plus significative.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
notes_80 <- villes |>
  filter(note > 80)

# Combien d'observations par ville?
notes_80 |>
  count(ville)
# Calgary = 12, Montréal = 1, Québec = 7 (N = 20)

# L'ANOVA manuelle (même code que dans le chapitre) :
N <- nrow(notes_80)
X <- mean(notes_80$note)
k <- 3

notes_80 <- notes_80 |>
  mutate(moyenne = mean(note), .by = ville)

SCEentre <- notes_80 |>
  summarize(moyenne = mean(note), n = n(), .by = ville) |>
  mutate(n_CE = n * (moyenne - X)^2) |>
  summarize(SCEentre = sum(n_CE)) |>
  pull()

SCEintra <- notes_80 |>
  summarize(SCEintra = sum((note - moyenne)^2)) |>
  pull()

MSCEentre <- SCEentre / (k - 1)
MSCEintra <- SCEintra / (N - k)
valeurF <- MSCEentre / MSCEintra
valeurF
pf(valeurF, df1 = k - 1, df2 = N - k, lower.tail = FALSE)

# La fonction aov() donne les mêmes valeurs
# (F(2, 17) = 0,93, p = 0,415) :
analyse <- aov(note ~ ville, data = notes_80)
summary(analyse)

analyse |>
  TukeyHSD()

# Les résultats sont très différents, vu que, maintenant
# il n'y a aucune différence significative. L'effet est
# donc disparu. Attention, par contre : cela ne veut pas dire que
# les villes sont identiques chez les meilleurs apprenants. Le
# sous-ensemble est minuscule (N = 20) et très déséquilibré :
# il n'y a qu'un seul apprenant de Montréal. Avec si peu de
# données, il est presque impossible de détecter une différence.
# En plus, en ne gardant que les notes supérieures à 80, on réduit
# artificiellement la variation des notes.
