# NOTE: Pratique finale : PISA 2025

load("donnees/base/pisa_2025.RData")

# Q: 1. Créer un sous-ensemble : CAN, FRA, ESP, USA
# Q: 2. Créer une nouvelle colonne pour la moyenne des tests
cfeu <- pisa |>
  filter(country %in% c("CAN", "FRA", "ESP", "USA")) |>
  droplevels() |>
  mutate(score = (math + read + scie) / 3)

cfeu

# Q: 3. Créer un résumé des notes moyennes : moyennes et écarts-types
cfeu |>
  summarize(
    M = mean(score),
    ET = sd(score),
    .by = country
  )

# Q: 4. Créer une figure : changer les étiquettes selon le besoin
ggplot(data = cfeu, aes(x = country, y = score)) +
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
fit <- lm(score ~ country, data = cfeu)
summary(fit)
confint(fit)
# A: La régression confirme que les notes de
# l'Espagne (482 - 19) et de la France (bêta = 482 - 35)
# sont statistiquement inférieures à celle du Canada (bêta = 482) :
# p < 0,0001. Toutefois, le modèle n'est pas capable de trouver un effet
# significatif pour USA (482 - 2,8), p = 0,53. On n'est donc pas capable
# de rejeter l'hypothèse nulle selon laquelle la différence entre le Canada
# et les États-Unis est nulle. Notez que la comparaison ici *combine* tous
# les examens de PISA (mat, sciences, lecture). Les intervalles de confiance à
# 95 % doivent être rapportés aussi.

# Q: 7. Que révèlent les comparaisons multiples?
library(emmeans)
fit |>
  emmeans(pairwise ~ country, adjust = "tukey") |>
  _$contrasts

# A: Toutes les comparaisons sont significatives, sauf
# CAN vs USA. On peut également créer une figure :
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
