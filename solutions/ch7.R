rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
library(tidyverse)
ang <- read_csv("donnees/anglais.csv")
ang
ang <- ang |>
  mutate(TRms = exp(TR))

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
ggplot(data = ang, aes(x = TR)) +
  geom_histogram() +
  labs(title = "Log TR")

ggplot(data = ang, aes(x = TRms)) +
  geom_histogram() +
  labs(title = "TR millisecondes")

# La distribution de TRms est moins normale,
# c'est-à-dire moins symétrique,
# que celle de TR (log). Voilà pourquoi on
# utilise TR (log).

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
ggplot(data = ang, aes(x = Age, y = TR)) +
  geom_boxplot() +
  stat_summary(color = "red") +
  geom_smooth(method = "lm")
# Oui : il y a un effet très clair. Les participants
# jeunes sont plus rapides.

fit1 <- lm(TR ~ Age, data = ang)
summary(fit1)

# L'effet est confirmé par la régression (p < 0,001)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
ggplot(data = ang, aes(x = Familiarite, y = TR)) +
  geom_point() +
  geom_smooth(method = "lm")
# Oui : il y a un effet très clair. Plus un mot est
# familier, plus le temps de réaction est rapide.

fit2 <- lm(TR ~ Familiarite, data = ang)
summary(fit2)

# L'effet est confirmé par la régression (p < 0,001)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
# Voici une figure qui combine les deux variables prédictives.
# Age = facteur (2 niveaux)
# Familiarite = numérique
# Donc, on utilise les coulers pour les groupes d'âge
# et l'axe x pour la variable continue Familiarite
ggplot(data = ang, aes(x = Familiarite, y = TR, color = Age)) +
  geom_point() +
  geom_smooth(method = "lm")

# Si deux variables ont un effet, il faut vérifier si
# ces effets sont toujours là lorsqu'on considère un
# modèle avec les deux variables ensemble.
fit3 <- lm(TR ~ Age + Familiarite, data = ang)
summary(fit3)
# Le modèle confirme que les effets sont significatifs (p < 0,001).
# Le R^2 ici est de 0.69, ce qui est supérieur à ceux des
# modèles fit1 (0,48) et fit2 (0,19).

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 6
# Avant d'interpréter le modèle, on calcule les intervalles
# de confiance à 95 % :
confint(fit3)
# Une régression linéaire multiple confirme l'effet de l'âge
# des participants (β̂ = -0.22, IC à 95 % = [-0,22 -0,21], p < 0,0001) et de
# la familiarité des mots utilisés (β̂ = -0,06,
# IC à 95 % = [-0,06 -0,05], p < 0,0001). Le modèle en question a un
# coefficient de détermination de 0,69, ce qui est considérable :
# deux variables sont capables d'expliquer presque 70 % de la variations
# des temps de réactions dans les données en question.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 7
ang <- ang |>
  mutate(Fam_cat = ntile(Familiarite, n = 4) |> as_factor())

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 8
fit4 <- lm(TR ~ Age + Fam_cat, data = ang)
# Les coefficients de détermination sont virtuellement identiques.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 9
# Tout d'abord, il convient de noter que l'effet de Familiarite
# est a peu près linéaire dans une figure :
ggplot(data = ang, aes(x = Familiarite, y = TR)) +
  geom_point() +
  geom_smooth()

# On n'a pas donc de raisons pour modifier la classe de
# la variable continue en question. En plus, lorsqu'on
# examine le modèle avec la version catégorielle, on remarque
# qu'il n'y a pas d'avantages de l'utiliser.
library(emmeans)
emmeans(fit4, pairwise ~ Fam_cat, adjust = "Tukey")$contrasts
# Notez que tous les contrastes sont significatifs.
