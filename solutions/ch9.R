rm(list=ls()) # Vider l'environnement
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 1
# Oui, les deux analyses sont directement comparables.
# Elles ont la même structure (WrittenFrequency ~ Auxiliary),
# et une ANOVA est simplement un type spécifique de régression
# linéaire. Les résultats sont également en accord : dans le tableau
# 9.1, on constate un effet significatif de zijn, donc il faut 
# rejeter l'hypothèse nulle. C'est la conclusion de l'ANOVA dans
# le tableau 9.2 aussi.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 2
# Une ANOVA confirme un effet significatif de la
# variable Auxiliary sur la fréquence écrite (WrittenFrequency) :
# F(2, 697) = 5.24, p = 0.00551.
aux = read_csv("donnees/auxiliaires.csv")
fit1 = aov(WrittenFrequency ~ Auxiliary, data = aux)
TukeyHSD(fit1)

# Les comparaisons changent nos résultats légèrement par rapport
# au Tableau 9.1. Observez l'effet de zijn, qui doit
# être interprété de façon relative à l'intercept (hebben).
# Dans la régression linéaire, la valeur p pour zijn était
# p = 0.00472**. Dans les comparaisons multiples, par contre,
# la comparaison zijn-hebben nous donne une valeur p de 0.01.
# On constate un changement considérable, qui pourrait affecter
# nos conclusions.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 3
# Cela vaut dire que la fréquence écrite moyenne de l'auxiliaire
# hebben est statistiquement différent de zéro, ce qui n'est pas
# surprenant, vu que le coefficient est de 6,5.

# À partir des tableaux donnés, on peut consulter les
# degrés de libertés de l'ANOVA : 697. Il y a 3 auxiliaires.
# Donc, le nombre d'observations est 700. Vous pouvez confirmer
# cette réponse vous-même à partir des données et du modèle.
# Le point ici est que même sans avoir les données, on est 
# capable de répondre à cette question à partir du Tableau 9.2.

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Question 4
# La différence entre zijn et zijnheb. Il y a plus d'une façon
# de générer cette différence. La façon examinée dans le cours
# implique la fonction emmeans(), qui nous donne des comparaisons
# multiples (essentiellement la méthode utilisé dans la question 2
# ci-dessus, étant données la similarité des modèles examinés ici). 

# Les questions 5-9 portent sur le projet et vos documents Quarto.

