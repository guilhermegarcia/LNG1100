rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
library(tidyverse)
villes <- read_csv("donnees/villes2.csv")
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

analyse <- aov(note ~ ville, data = notes_80)
analyse |>
  TukeyHSD()

# Les résultats sont très différents, vu que, maintenant
# il n'y a aucune différence significative. L'effet est
# donc disparu. Cela suggère que plus un apprenant est précis dans
# le test, plus il est difficile de trouver un effet de `ville`.
# Pour calculer la valeur F manuellement, vous devez simplement
# exécuter les codes dans le chapitre en utilisant la variable notes_80.
