rm(list = ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# On commence par le nettoyage à partir du
# script déjà fait :
source("solutions/ch10.R")

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
#
# Call:
# glm(formula = correct ~ langues, family = "binomial", data = long)
#
# Coefficients:
#             Estimate Std. Error z value Pr(>|z|)
# (Intercept)  -0.6931     0.5477  -1.266    0.206
# languesOui    0.1823     0.6377   0.286    0.775
#
# (Dispersion parameter for binomial family taken to be 1)
#
#     Null deviance: 72.103  on 54  degrees of freedom
# Residual deviance: 72.020  on 53  degrees of freedom
# AIC: 76.02
#
# Number of Fisher Scoring iterations: 4
#

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# L'effet de la variable prédictive en question (langues)
# n'est pas significatif (B = 0.18, p = 0.775). On ne peut
# pas donc rejeter l'hypothèse nulle, c'est-à-dire que
# la variable langues n'a aucun effet sur la performance des participants.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
fit2 <- glm(correct ~ langues + geo, data = long, family = "binomial")
summary(fit2)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
predict(fit2,
  newdata = tibble(
    langues = c("Oui", "Non"),
    geo = c("Non", "Non")
  ),
  type = "response"
)
