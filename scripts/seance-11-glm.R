library(tidyverse)
library(sjPlot)
library(arm) # pour utiliser la fonction invlogit()

# NOTE: Importer le fichier
rm(list = ls())
v2 <- read_csv("donnees/base/villes2.csv") |>
  mutate(across(where(is_character), as_factor)) |>
  mutate(
    francophone = if_else(ville == "Calgary", 0, 1) # |> as_factor()
  )

v2 |> sample_n(size = 10)

ggplot(data = v2, aes(x = note, y = francophone)) +
  geom_point(alpha = 0.3)

# NOTE: Modèle :

fit_1 <- glm(francophone ~ note, data = v2, family = "binomial")
fit_1 |> summary()
fit_1 |> tab_model(transform = NULL)

# L'intercept : la réponse prévue SI les autres variables prédictives
# sont égales à zéro. C'est le même système utilisé pour une régression linéaire.
# Toutefois, la réponse ici est en log-odds.
# Si la note est égale à zéro, les log-odds d'être dans une ville francophone
# est de -2,18.
# Hypothèse nulle : beta_0 = 0 (log-odds)

# Effet de note : beta = 0,04 (sig)
# Hypothèse nulle : beta_1 = 0 (log-odds)
# Le changement en y pour chaque unité de x
# Pour chaque point additionnel dans la note,
# les log-odds d'être francophone augmente de 0,04 (log-odds)
# Pour chaque 10 points additionnels dans la note,
# les log-odds d'être francophone augmente de 0,4

# HACK: Comment convertir log-odds en probabilités?
# option 1 : la fonction invlogit de la bibliothèque arm
invlogit(-2.18)

# option 2 : la fonction predict()
mes_notes <- tibble(
  note = c(55, 78, 99, 32, 64),
)

predict(fit_1, newdata = mes_notes, type = "response")
