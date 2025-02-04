rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
library(tidyverse)
# a.
rc <- read_csv("donnees/rClauseData.csv")
rc |> glimpse() # explorez les données

rc <- rc |>
  filter(Type != "Filler") |>
  mutate(across(where(is_character), as_factor))

# b.
ggplot(data = rc, aes(x = L1, y = RT)) +
  stat_summary(geom = "bar", alpha = 0.5, color = "black") +
  stat_summary()

# c.
fit1 <- lm(RT ~ L1, data = rc)
fit2 <- glm(L1 ~ RT, data = rc, family = "binomial")
summary(fit1)
summary(fit2)
# Il est plus intuitif de créer une nouvelle variable :
rc <- rc |>
  mutate(Anglais = if_else(L1 == "English", 1, 0))
fit2 <- glm(Anglais ~ RT, data = rc, family = "binomial")
# Maintenant, on sait que le modèle prédit les log odds
# que la L1 soit l'anglais (plus transparent)
# Les régressions confirment un effet de L1 sur TR ainsi
# qu'un efffet de TR sur L1. Interprétez-les en ajoutant
# les betas, les intervalles de confiance, et les valeurs
# p des effets en question.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
# a.
# Il faut que notre axe y soit Response. Toutefois,
# la variable est catégorielle (binaire) actuellement.
# Transformons-la!
# Prenons High comme référence.
rc <- rc |>
  mutate(High = if_else(Response == "High", 1, 0))

# Voici une figure qui peut certainement être
# améliorée :)
ggplot(data = rc, aes(x = Condition, y = High, fill = L1)) +
  stat_summary(
    geom = "bar", alpha = 0.5,
    position = position_dodge(width = 0.9)
  ) +
  stat_summary(position = position_dodge(width = 0.9))

# b.
fit3 <- glm(High ~ Condition + L1, data = rc, family = "binomial")
summary(fit3)
confint(fit3)

# Les deux variables ont un effet significatif sur les choix
# des participants. Dans la condition High, on constate
# un effet positif (β̂ = 0,74 IC à 95 % = [0,38 1,11], p < 0,0001).
# On trouve l'effet contraire dans la condition Low. On voit donc
# que les conditions High et Low produisent des résultats plus extrêmes
# par rapport aux niveau de référence (notre intercept; NoBreak).
# L'intercept ici a un effet négatif et significatif :
# (β̂ = -0,53, IC à 95 % = [-0,85 -0,22], p = 0,0009).
# Cela veut dire que dans une phrase sans une pause (la condition neutre),
# les participants ont tendance à privilégier une interprétation
# High. Finalement, on constate un effet de L1, où les hispanophones
# préfèrent High plus que les anglophones (β̂ = 1,40,
# IC à 95 % = [1,09 1,72], p < 0,0001). Conclusion : oui, la pause semble
# avoir un effet dans les données.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# a.
fb <- read_csv("donnees/feedbackData.csv")

# b.
fb <- fb |>
  dplyr::select(-c(task_B1:task_B5)) |>
  pivot_longer(
    names_to = "Tache",
    values_to = "Note",
    cols = task_A1:task_A5
  ) |>
  mutate(Recast = if_else(Feedback == "Recast", 1, 0))

# Ensuite, créons une figure :
ggplot(data = fb, aes(y = Note, x = Recast |> as_factor())) +
  stat_summary() +
  theme_minimal(base_size = 13) +
  scale_x_discrete(labels = c(
    "0" = "Correction explicite",
    "1" = "Reformulation"
  )) +
  labs(x = "Rétroaction")

# Finalement, notre modèle :
fit4 <- glm(Recast ~ Note, data = fb, family = "binomial")
summary(fit4)
# La réponse :
predict(fit4, newdata = tibble(Note = 90), type = "response")
# Oui, P(recast = 1 | note = 90) = 0.62
