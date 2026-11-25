library(tidyverse)
library(sjPlot)

# NOTE: Importer le fichier
v2 <- read_csv("donnees/base/villes2.csv") |>
  mutate(across(where(is_character), as_factor))

# NOTE: Ajouter une colonne
v2 <- v2 |>
  mutate(
    # francophone = if_else(ville %in% c("Montréal", "Québec"), 1, 0),
    francophone = if_else(ville == "Calgary", 0, 1) |> as_factor()
  )

v2 |> glimpse()

# NOTE: Créer une figure
ggplot(data = v2, aes(x = francophone, y = note, shape = ville, color = ville)) +
  stat_summary()

# NOTE: Une version plus détaillée
ggplot(data = v2, aes(x = duree, y = note)) +
  geom_point(size = 5, alpha = 0.5, aes(color = francophone)) +
  geom_smooth(method = "lm", color = "black") +
  scale_color_manual(values = c("darkorange2", "slateblue2")) +
  theme_classic() +
  theme(legend.position = "top") +
  labs(
    x = "Durée d'études",
    y = "Note",
    color = "La ville est-elle francophone?"
  )

# WARN: Veuillez noter que les variables prédictives duree et francophone
# sont corrélées (c'est un cas de collinéarité). Cela peut poser des problèmes
# au modèle, vu qu'il essaie d'estimer l'effet de chaque variable de façon
# isolée (orthogonale).


# NOTE: Créer des modèles
fit_0 <- lm(note ~ duree + ville, data = v2)
fit_1 <- lm(note ~ duree + francophone, data = v2)
fit_2 <- lm(note ~ francophone, data = v2) # NOTE: Version sans duree

fit_0 |> summary()
fit_1 |> summary()
fit_2 |> summary()

fit_0 |> confint()
fit_1 |> confint()
fit_2 |> confint()

# HACK: On remarque que le modèle sans duree nous donne un effet
# significatif pour francophone. La question est donc si on enlève la variable
# en question.
# duree : oui ou non?
anova(fit_1, fit_2)

# HACK: anova(), déjà discutée dans le cours, nous permet de comparer
# des modèles pour les mêmes données. Ici, le modèle avec duree n'est
# pas statistiquement différent du modèle sans duree :

# Analysis of Variance Table
#
# Model 1: note ~ duree + francophone
# Model 2: note ~ francophone
#   Res.Df   RSS Df Sum of Sq      F Pr(>F)
# 1    147 17068
# 2    148 17136 -1    -68.12 0.5867 0.4449

# NOTE: On favorise donc le modèle sans duree, évidemment.

# NOTE: Rapporter les résultats
# On a exécuté trois modèles statistiques, dont deux considérait duree aussi.
# Le modèle A considérait "ville" comme variable prédictive.
# Dans ce modèle, Québec avait un effet significatif
# (beta = 8.55, IC 95 % = [1,43 15,68], p < 0,05)
# par rapport à l'intercept du modèle (Calgary).
# Toutefois, lorsqu'on a remplacé "ville" par "francophone" (c'est-à-dire une
# simplification), l'effet est disparu pour francophone = 1 (beta = 3,43,
# IC à 95 % = [-1,78 8,66], p = 0,196). Le coefficient de détermination du modèle
# en question est de 0,035. Autrement dit, le modèle n'explique que
# 3,5 % de la variation dans les données examinées.
# Finalement, le modèle C enlève la variable duree et nous montre un effet
# significatif de francophone : beta = 4,87, CI 95 % = [1,19 8,55], p < 0,01. Ce modèle n'est pas
# statistiquement différent du modèle B, donc la variable duree peut être
# enlévée du modèle.
# En conclusion, la simplification de la variable linguistique
# a eu un effet négatif sur nos résultats. Toutefois, on est capable de trouver
# un effet de francophone lorsqu'on enlève la variable duree de notre modèle.

# Générer le tableau des résultats avec sjPlot :
fit_1 |> tab_model()

# Une option plus automatique : on extrait les valeurs d'un objet (modèle)
# en Quarto :
coef(fit_1)[[1]] # Exemple : l'intercept

# Cela nous permettrait d'avoir un texte automatisé dans no tre document :
# L'intercept de notre modèle (`r coef(fit_1)[[1]]`).
