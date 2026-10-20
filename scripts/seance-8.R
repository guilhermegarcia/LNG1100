# NOTE: Pratique finale : PISA 2025
library(tidyverse)
library(emmeans)
library(sjPlot)

load("donnees/base/pisa_2025.RData")

# Q: 1. Créer un sous-ensemble : CAN, FRA, ESP, USA
# Q: 2. Créer une nouvelle colonne pour la moyenne des tests
pays <- pisa |>
  filter(country %in% c("CAN", "FRA", "ESP", "USA")) |>
  droplevels() |>
  mutate(score = mean(c(math, read, scie)), .by = c(school))

# A: mutate() avec .by = school calcule la moyenne des trois tests pour chaque école.
# Le décalage trouvé entre (math + read + scie) / 3 et mean(math, read, scie) est
# expliqué par la fonction c() : mean() ne prend qu'un seul vecteur. Sans c(), R
# interprète read et scie comme d'autres arguments et retourne simplement math.

pays

# Q: 3. Créer un résumé des notes moyennes : moyennes et écarts-types
pays |>
  summarize(
    M = mean(score),
    ET = sd(score),
    .by = country
  )

# Q: 4. Créer une figure : changer les étiquettes selon le besoin
ggplot(data = pays, aes(x = country, y = score)) +
  geom_boxplot() +
  stat_summary() +
  theme_classic() +
  labs(x = "Pays", y = "Performance globale (moyenne)")

# Q: 5. Quel pays sera représenté par l'intercept ici?
# Quelles sont les hypothèses nulles? Lesquelles pensez-vous que
# nous serons capable de rejeter dans une régression linéaire?

# A: Canada (le premier pays en ordre alphabétique)
# Hypothèse nulle = tous les coefficients sont égaux à zéro.
# Autrement dit, l'intercept a une moyenne de zéro et les slopes
# sont égaux à zéro aussi. Si les slopes sont nuls, cela veut dire
# qu'il n'y a pas de différence entre l'intercept et les autres pays.


# Q: 6. Régression linéaire + IC + interprétation :
fit <- lm(score ~ country, data = pays)
summary(fit)
confint(fit)
# A: La régression confirme que les notes de
# l'Espagne (bêta = -20) et de la France (bêta = -35) sont statistiquement
# inférieures à celle du Canada (bêta = 482), notre intercept : p < 0,0001.
# En revanche, la différence entre les États-Unis et le Canada (bêta = -3)
# n'est pas significative (p = 0,53) : son IC à 95 % [-11,7 ; 6,0] inclut zéro.
# Les intervalles de confiance à 95 % sont générés par la fonction ci-dessus.
#
# A: Une autre option serait d'utiliser sjPlot :
fit |> tab_model()
fit |> plot_model()

# Q: 7. Que révèlent les comparaisons multiples?
fit |>
  emmeans(pairwise ~ country, adjust = "tukey") |>
  _$contrasts

# A: Toutes les comparaisons sont significatives, sauf
# CAN vs USA (p = 0,92). On peut également créer une figure personnalisée :
fit |>
  emmeans(~country) |>
  pairs() |>
  confint() |>
  as_tibble() |> # Visualiser le tibble pour mieux comprendre le code
  ggplot(aes(x = estimate, y = contrast)) +
  geom_point() +
  geom_errorbar(
    aes(xmin = lower.CL, xmax = upper.CL),
    height = 0.2
  ) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  theme_classic() +
  labs(
    x = "Coefficient", y = "Comparaison",
    title = "Comparaisons à partir de emmeans"
  )

# Q: ANOVA

mon_anova <- aov(score ~ country, data = pays)
mon_anova |> summary()

mon_anova |> TukeyHSD()

# A: Une ANOVA confirme un résultat significatif pour la variable pays :
# F(3, 2281) = 45,85, p < 0,0001. Les comparaisons multiples indiquent qu'une seule
# paire n'est pas significative, c'est-à-dire USA vs CAN. Vous pouvez donc confirmer que la régression et l'ANOVA nous donnent les mêmes résultats pour un scénario simple.
# Évidemment, ceci n'est pas toujours le cas. Finalement, remarquez que les degrés de liberté
# pour l'ANOVA sont également affichés à la fin du résultat de lm().
