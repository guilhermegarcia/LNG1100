rm(list = ls()) # Vider l'environnement
# PRATIQUE FINALE

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# a. 3
# b. 60
# c. H0 = les trois groupes sont identiques par rapport
# à leur performance moyenne
# d. ANOVA
# e. Oui : p < 0,05
# f. Non.
# g. Il n'y a pas de groupe de contrôle. Donc,
# on n'est pas capable de savoir se l'amélioration
# dans la performance des participants n'est pas
# identique à celle d'une méthode traditionnel (!).
# Effectivement, il est difficile d'évaluer la question
# de recherche... ce n'est pas une bonne étude :)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
# Facteur A = 3; facteur B = 2. Observations
# totales = 92 + 3 + 2 = 97

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# Moyenne des carrés = somme des carrés / ddl
# F = Moyenne des carrés du facteur / moyenne des
# carrés des résiduelles (3,034 / 0,334 ~ 9,073)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
load("donnees/phonetique.RData")
# Les classes sont correctes : on voit des
# facteurs au lieu des chr. Le format RData
# enregistre les métadonnées. Donc, si vous
# changez des classes avant d'enregistrer le
# fichier sous le format RData, vous aurez pas
# besoin de le faire à nouveau lorsque vous importez
# le fichier plus tard. Il y a d'autres avantages aussi.

# a.
# Il faut calculer l'amélioration à partir des tests.
# Donc, on commence par une nouvelle colonne :
phon <- phon |>
  mutate(Diff = Post - Pre)
# Cette colonne quantifie la différence entre les tests.
# Effectivement, elle nous donne l'apprentissage des
# participants.
ggplot(data = phon, aes(x = Condition, y = Diff)) +
  stat_summary() +
  stat_summary(geom = "bar", alpha = 0.3, color = "black") +
  facet_grid(Compétence ~ L1)
# Vous verrez qu'il est plus facile de visualiser les patrons
# si on ajoute des barres. Veuillez noter que les langues
# sont ordonnées « danois, portugais, espagnol ». Cette ordre
# n'est pas alphabétique : elle suit l'ordre de performance.
# J'ai changé l'ordre moi-même avant d'enregistrer le fichier, et
# parce qu'on utilise le format RData, l'information sur l'ordre
# reste là.
# Observez la figure : la méthode semble avoir un effet
# très clair. Confirmons-le maintenant.

# b.
# Voici le modèle :
fit1 <- lm(Diff ~ L1 + Compétence + Condition, data = phon)
summary(fit1)
# Coefficients:
#                     Estimate Std. Error t value Pr(>|t|)
# (Intercept)           4.7339     0.7381   6.414 1.88e-09 ***
# L1portugais           0.8588     0.7614   1.128    0.261
# L1espagnol           -4.6410     0.7641  -6.074 1.04e-08 ***
# CompétenceAdv         1.3500     0.6234   2.166    0.032 *
# Conditionphonétique   7.7557     0.6318  12.275  < 2e-16 ***

# confint(fit1)
#                          2.5 %    97.5 %
# (Intercept)          3.2751907  6.192700
# L1portugais         -0.6461588  2.363720
# L1espagnol          -6.1512305 -3.130751
# CompétenceAdv        0.1178855  2.582068
# Conditionphonétique  6.5069746  9.004454

# La méthode a un effet clair (β̂ = 7,75, IC à 95 % = [6,5 9], p < 0,0001).
# Examinez les autres effets dans le modèle. Veuillez noter
# que dans notre cours on ignore les interactions.
# Vous pouvez comparer le coefficient de détermination du
# modèle en question avec celui d'un modèle sans L1, par exemple.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 5
# a.
titanic <- read_csv("donnees/titanic.csv")
fit2 <- glm(Survived ~ Class + Sex + Age, data = titanic, family = "binomial")
summary(fit2)
# b.
# Homme, 2e classe, adulte ~ 20 %
predict(fit2,
  newdata = tibble(
    Sex = "Male",
    Class = "2nd",
    Age = "Adult"
  ),
  type = "response"
)

# Femme, 2e classe, adulte ~ 73 %
predict(fit2,
  newdata = tibble(
    Sex = "Female",
    Class = "2nd",
    Age = "Adult"
  ),
  type = "response"
)

# c.
# Voici une façon de créer un tableau
# avec toutes les combinaisons dans nos données :
newdata <- expand.grid(
  Class = c("1st", "2nd", "3rd", "Crew"),
  Sex = rep(c("Male", "Female")),
  Age = c("Child", "Adult")
) |>
  as_tibble()

# Vérifiez newdata maintenant :
newdata

# Ensuite, on utilise ce tableau dans la fonction
# predict() :
newdata <- newdata |>
  mutate(pred = predict(fit2, newdata, type = "response"))

# Finalement, on ordonne les résultats selon la probabilité
# de survie :
newdata |> arrange(desc(pred))
