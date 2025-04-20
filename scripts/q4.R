rm(list = ls())
library(tidyverse)
library(janitor)
library(sjPlot)

q4 <- read_csv("donnees/q4.csv")
q4 <- q4 |>
  clean_names() |>
  pivot_longer(
    names_to = "question",
    values_to = "reponse",
    cols = 4:13
  ) |>
  # mutate(voyelle = c("i", "a", "u", "i", "a", "u", "i", "a", "u", "a"), .by = id) |>
  mutate(voyelle = str_extract(string = question, pattern = "\\w$")) |>
  mutate(
    hauteur = if_else(voyelle == "a", "basse", "haute"),
    grand = if_else(reponse == "GRAND", 1, 0),
    petit = if_else(reponse == "GRAND", 0, 1)
  )

q4

# NOTE: Question 1 et question 2
# Calcul pour GRAND :
q4 |>
  summarise(M_grand = mean(grand), .by = hauteur)


# Quelques figures
ggplot(data = q4, aes(x = hauteur, y = grand)) +
  stat_summary()

ggplot(data = q4, aes(x = voyelle, y = grand)) +
  stat_summary()


# NOTE: Question 3

fit1 <- glm(grand ~ hauteur, data = q4, family = "binomial")
fit2 <- glm(petit ~ hauteur, data = q4, family = "binomial")

summary(fit1)
summary(fit2)

# Réponse : -1.74 (à partir d'une analyse de GRAND)


# NOTE: Question 4
tab_model(fit1) # Pseudo R^2 = 0.152


# NOTE: Question 5
fit3 <- glm(grand ~ voyelle, data = q4, family = "binomial")

summary(fit3)

# predict(fit1, newdata = tibble(hauteur = "haute"), type = "response")
predict(fit3, newdata = tibble(voyelle = "i"), type = "response") |> round(2)
# 0.24

# NOTE: Question 6
# Voici notre modèle initial :

# Coefficients:
#              Estimate Std. Error z value Pr(>|z|)
# (Intercept)    1.2622     0.2925   4.316 1.59e-05 ***
# hauteurhaute  -1.7418     0.3564  -4.887 1.03e-06 ***
# confint(fit1)
#                   2.5 %    97.5 %
# (Intercept)   0.7155282  1.870675
# hauteurhaute -2.4663651 -1.063064
# On voit que la hauter a un effet négatif (B = –1.74, IC 95 % = [–2.47, –1.06], p < 0.005) sur la réponse GRAND des participants. Plus spécifiquement, une voyelle haute réduit les log-odds de répondre « grand » en 1.74. C'est un effet considérable : la présence d'une voyelle haute signifie que les cotes pour choisir « grand » en tant que réponse diminuent par un facteur de 5.6 (c'est-à-dire exp(–1.74), soit 1 / 0.173).

# NOTE: Question 7
# On confirme l'hypothèse : il est plus probable d'avoir la réponse « GRAND » si un mot contient des voyelles basses, c'est-à-dire plus sonores.
