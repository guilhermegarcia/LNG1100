rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# On commence par le nettoyage à partir du
# script déjà fait :
source("corriges/10-nettoyage2.R")

# Voici un exemple de figure :
ggplot(data = long, aes(x = langues, y = correct)) +
  stat_summary() +
  theme_classic(base_size = 13) +
  labs(
    y = "Correct",
    x = "Parlez-vous d'autres langues?"
  )

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
fit1 <- glm(correct ~ langues, data = long, family = "binomial")
summary(fit1)
confint(fit1)
exp(coef(fit1)) # rapports des cotes (odds ratios)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# L'intercept représente les participants qui ne parlent pas
# d'autres langues (langues = Non, niveau de référence). Leurs
# log-odds de répondre correctement sont négatifs (β̂ = -0,58),
# c'est-à-dire une probabilité inférieure à 50 % : plogis(-0,58) = 0,36.
#
# L'effet de langues est positif et significatif (β̂ = 0,93,
# IC à 95 % = [0,03, 1,89], p = 0,048). Parler d'autres langues
# multiplie les chances (odds) de répondre correctement par
# exp(0,93) = 2,54. En probabilités : 36 % (Non) vs 59 % (Oui).
# On rejette donc l'hypothèse nulle. Notez toutefois que la valeur p
# est très proche de 0,05 et que l'intervalle de confiance est large
# (sa borne inférieure est presque zéro) : l'effet est incertain.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
fit2 <- glm(correct ~ langues + geo, data = long, family = "binomial")
summary(fit2)
confint(fit2)
# Oui : geo a un effet positif et significatif (β̂ = 1,06,
# IC à 95 % = [0,15, 2,00], p = 0,024). Aimer la géographie multiplie
# les chances de répondre correctement par exp(1,06) = 2,88.
# Par contre, une fois que geo est dans le modèle, l'effet de langues
# n'est plus significatif (β̂ = 0,36, IC à 95 % = [-0,72, 1,44],
# p = 0,508). L'effet de langues observé dans fit1 provenait donc
# probablement de geo : les deux variables sont liées dans les données.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
predict(fit2,
  newdata = tibble(
    langues = c("Oui", "Non"),
    geo = c("Non", "Non")
  ),
  type = "response"
)
# Un participant qui n'aime pas la géographie a une probabilité
# de 39 % de répondre correctement s'il parle d'autres langues,
# et de 31 % s'il n'en parle pas.
