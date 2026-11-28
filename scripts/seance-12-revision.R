library(tidyverse)
library(arm) # pour utiliser la fonction invlogit()

# Séance 12 : révision et régression logistique

# NOTE: Données : titanic.csv (passagers et équipage du Titanic)
#       Class : 1st, 2nd, 3rd, Crew; Sex : Male, Female; Age : Child, Adult;
#       Survived : 0 = n'a pas survécu, 1 = a survécu

# ---------------------------------------------------------------
# PARTIE 1 : Importer les données et créer des facteurs
# ---------------------------------------------------------------

# Q: 1. Importez titanic.csv (dossier donnees/base) dans un tableau `d`
#    et examinez-le avec glimpse(). Quelle est la classe de chaque
#    colonne? Quelle est notre variable réponse?


# Q: 2. AVANT d'exécuter du code : si on transforme toutes les colonnes
#    de type <chr> en facteurs avec as_factor(), quel sera le premier
#    niveau (la référence) de Class, de Sex et de Age? Pourquoi?

# HACK: Regardez les premières lignes du tableau.


# Q: 3. Transformez les colonnes <chr> en facteurs avec un seul mutate(),
#    puis vérifiez les niveaux avec levels(). Votre prédiction était-elle
#    correcte? Quels niveaux obtiendrait-on avec factor() plutôt
#    qu'avec as_factor()?


# Q: 4. Faut-il aussi transformer Survived en facteur? Pourquoi?



# ---------------------------------------------------------------
# PARTIE 2 : Visualiser une réponse binaire (0/1)
# ---------------------------------------------------------------

# Q: 5. Essayez la figure suivante :
#    ggplot(data = d, aes(x = Class, y = Survived)) + geom_point()
#    Pourquoi cette figure ne nous apprend-elle presque rien?


# Q: 6. Créez une figure qui montre la proportion de survivants pour
#    chaque classe avec stat_summary(). Que représente l'axe y?
#    Pourquoi la moyenne d'une colonne de 0 et de 1 est-elle une proportion?


# Q: 7. Ajoutez Sex à la figure (couleur ou facet_grid()). Décrivez le
#    patron. Que remarquez-vous au sujet de l'équipage (Crew)?


# Q: 8. Calculez la proportion de survivants pour chaque classe avec
#    summarize(). Gardez ces valeurs : on les retrouvera dans le modèle.



# ---------------------------------------------------------------
# PARTIE 3 : Un seul prédicteur (Class)
# ---------------------------------------------------------------

# Q: 9. Ajustez le modèle mod1 : Survived en fonction de Class.
#    Quel est le niveau de référence? Combien de coefficients obtient-on
#    en plus de l'intercept? Que compare chacun?


# Q: 10. Interprétez l'intercept en log-odds, puis convertissez-le en
#    probabilité avec invlogit(). Comparez avec vos résultats de Q8.


# Q: 11. Interprétez le coefficient Class1st. Quelle est la probabilité
#    prévue de survie en 1re classe? Calculez-la de deux façons :
#    (a) avec invlogit() et les coefficients;
#    (b) avec predict().
#    Ensuite, calculez avec predict() la probabilité prévue pour les
#    quatre classes d'un coup. Comparez avec la figure de Q6.


# Q: 12. Les membres de l'équipage ont-ils survécu moins souvent que les
#    passagers de 3e classe? Et que ceux de 1re classe? mod1 ne répond
#    qu'à l'une de ces deux questions : laquelle?


# Q: 13. AVANT d'exécuter du code : si 1st devient la référence, quelles
#    seront les valeurs de l'intercept, de Class3rd et de ClassCrew?
#    Justifiez. Ensuite, changez la référence avec fct_relevel(),
#    ajustez de nouveau mod1 et vérifiez.


# Q: 14. Les probabilités prévues pour chaque classe changent-elles
#    avec la nouvelle référence? Pourquoi?



# ---------------------------------------------------------------
# PARTIE 4 : Plusieurs prédicteurs (Sex, Class et Age)
# ---------------------------------------------------------------

# Q: 15. On veut que l'intercept du modèle complet corresponde à un
#    homme adulte de 1re classe. Quelles références faut-il encore
#    changer? Pourquoi la référence créée par as_factor() pour Age
#    serait-elle un mauvais choix? Changez-la, puis ajustez mod2 :
#    Survived en fonction de Sex, Class et Age. Interprétez l'intercept
#    en log-odds, puis en probabilité.


# Q: 16. Dans mod1, l'équipage et la 3e classe avaient des taux de survie
#    presque identiques. Comparez maintenant ClassCrew et Class3rd dans
#    mod2. Qu'est-ce qui a changé, et pourquoi?

# HACK: Utilisez count(Class, Sex).


# Q: 17. Interprétez les coefficients de Sex et de Age dans mod2. Que
#    signifie « à valeurs égales des autres variables » ici?


# Q: 18. Sur papier (sans R!) : avec les coefficients de mod2,
#    calculez les log-odds de survie de Jack (homme, adulte, 3e classe)
#    et de Rose (femme, adulte, 1re classe). Ensuite, vérifiez avec
#    predict(), puis convertissez en probabilités.


# Q: 19. Que donne predict() si on omet type = "response"? Comment
#    passer de ce résultat à une probabilité?


# Q: 20. Créez un tableau avec toutes les combinaisons de Sex, Class et
#    Age (expand_grid()), ajoutez la probabilité prévue par mod2 et
#    faites une figure (x = Class, y = probabilité, couleur = Sex,
#    un panneau par Age). Une de ces combinaisons n'existe pas dans
#    les données : laquelle? Que penser de sa prédiction?


# Q: 20b. Discussion : données ou prédictions?
#    (a) Le modèle peut-il prédire une combinaison qu'il n'a jamais vue?
#    D'où vient la probabilité prévue pour un garçon membre de l'équipage?
#    Calculez ses log-odds à la main avec les coefficients de mod2.
#    (b) Comment vérifier, avant d'interpréter une prédiction, qu'elle
#    repose sur des données?



# ---------------------------------------------------------------
# PARTIE 5 : Rapporter les résultats
# ---------------------------------------------------------------

# Q: 21. Rédigez une phrase qui rapporte l'effet de Sex dans mod2
#    (estimation, valeur p, interprétation), comme dans les diapos.

