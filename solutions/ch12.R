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

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# L'interprétation dépendra des données.

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
