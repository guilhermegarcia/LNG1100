rm(list=ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
## Partie I : note ~ ville ===================
library(tidyverse)
villes = read_csv("donnees/villes2.csv")

# Les moyennes et les écarts-types :
villes |> 
  group_by(ville) |> 
  summarize(M = mean(note),
            ET = sd(note))

# Figure :
ggplot(data = villes, aes(x = ville, y = note)) + 
  stat_summary() +
  labs(x = "Ville", 
       y = "Note") +
  theme_minimal(base_size = 13) +
  labs(title = "Moyennes + barres d'erreurs",
       subtitle = "Calgary vs. Montréal vs. Québec")

# Le modèle :
fit1 = lm(note ~ ville, data = villes)
summary(fit1)

# La figure suggère une différence de note moyenne entre les ville. En plus, 
# l'erreur standard de Calgary est clairement plus élevé que celles de 
# Montréal et Québec.

# Interprétation. Le modèle confirme une différence statistiquement 
# significative entre le groupe de Calgary (notre intercept; β0) et 
# de Québec (β̂ = 7.16$, IC 95 % = [2.96, 11.37], p = 0.001). Cela 
# veut dire que la différence entre les deux groupes est de 7.16 points. 
# La différence entre Calgary et Montréal, par contre, n'est pas 
# statistiquement significative (β̂ = 2.57, IC 95 % = [-1.63, 6.78], p = 0.228). 
# Ces résultats sont attendus si on examine la figure ci-dessus : 
# il y a beaucoup de variation dans le groupe de Calgary. En plus, 
# vu que le groupe de Calgary a les notes les plus basses, les coefficients 
# pour les autres villes seront positifs. Veuillez noter que rien ne peut 
# être dit sur la comparaison entre Montréal et Québec, vu qu'il faut comparer 
# chaque effet à l'effet de l'intercept.

## Partie I : note ~ duree ===================
# Figure :
ggplot(data = villes, aes(x = duree, y = note)) + 
  geom_point(alpha = 0.25, size = 4, color = "darkviolet") +
  geom_smooth(method = "lm") +
  labs(x = "Temps d'étude du français (en mois)", 
       y = "Note") +
  theme_minimal(base_size = 13) +
  labs(title = "Relation entre note et temps d'étude")

# Le modèle :
fit2 = lm(note ~ duree, data = villes)
summary(fit2)

# Interprétation. Le modèle confirme un effet statistiquement significatif 
# de la variable `duree` sur les notes (β̂ = 0.17, IC 95 % = [0.03, 0.31], 
# p = 0.018). Cela veut dire que chaque mois de temps d'étude donne lieu 
# à une augmentation de 0.17 point dans la note moyenne d'un apprenant. 
# Donc, on peut également dire qu'une période de 10 mois d'étude additionnels 
# augmente la note de 1,7 point. Observez la figure et notez que la droite 
# est légèrement positive (inclinée). Cela a du sens, vu que l'effet ici est 
# positif. Toutefois, il est essentiel de noter que l'inclination est très 
# subtile, c'est-à-dire que l'effet n'est pas fort (notre coefficient bêta 
# est seulement 0.17, après tout).

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
# Figure :
ggplot(data = villes, aes(x = duree, y = note)) + 
  geom_point(size = 3, alpha = 0.25, color = "darkviolet") +
  geom_smooth(method = "lm") + 
  facet_grid(~ville) + 
  labs(x = "Temps d'étude du français (en mois)", 
       y = "Note") +
  theme_minimal(base_size = 11) +
  labs(title = "Temps d'étude + ville",
       subtitle = "Calgary vs. Montréal vs. Québec")

# Avant d'exécuter notre régression, examinez attentivement la figure. 
# Une fois que les variables `ville` et `duree` sont visualisées ensemble, 
# l'effet du temps d'étude ne semble plus avoir d'importance : 
# les droites sont essentiellement horizontales, ce qui suggère qu'il n'y a 
# aucun effet (n'oubliez pas la définition de l'$H_0$). Maintenant, 
# exécutons notre régression pour vérifier les effets en question.

# Le modèle :
fit3 = lm(note ~ ville + duree, data = villes)
summary(fit3)

# Interprétation. Le modèle confirme un effet statistiquement significatif 
# de la variable `ville`, mais l'effet de la variable `duree` n'est plus 
# significatif. Cela ne devrait pas être surprenant étant données les figures 
# ci-dessus : lorsqu'on considère les différentes villes, l'effet du temps 
# d'étude disparaît ($\hat\beta = -0.06$, IC 95 % $= [-0.30, -0.18], p = 0.632$). 
# L'effet de ville est toujours là pour Québec, c'est-à-dire qu'il y a une 
# différence statistiquement significative entre Calgary et Québec 
# (β̂ = 8.56, IC 95 % = [1.44, 15.68], p = 0.019). Veuillez noter 
# que le R^2 (le coefficient de détermination) est minuscule : 0.056. 
# Simplement dit, lorsqu'on utilise ces deux variables prédictives, on 
# n'explique que 5 % de la variation des notes dans les données.


# La figure. La figure ci-dessous utilise la fonction `facet_grid()`, qui permet 
# d'ajouter des fenêtres au graphique pour séparer les données à partir d'une 
# variable catégorielle (`ville` ici). La figure « extra » dans les diapos, 
# par contre, utilise des couleurs pour représenter les différents groupes. 
# C'est toujours une question subjective : il faut considérer quel type de 
# graphique sera approprié pour les données examinées. L'objectif doit être 
# la communication efficace. Voici le code pour générer la figure.
ggplot(villes, aes(x = duree, y = note)) + 
  stat_smooth(method = "lm") +
  geom_point(size = 4, alpha = 0.5, aes(color = ville)) +
  coord_cartesian(xlim = c(0, 60)) + 
  labs(x = "Temps d'étude du français (en mois)",
       y = "Note",
       color = "Ville:",
       title = "Les notes des trois groupes") + 
  theme_minimal(base_size = 12) + 
  coord_cartesian(ylim = c(0, 100)) +
  theme(plot.title = ggtext::element_markdown(),
        plot.subtitle = ggtext::element_markdown())

