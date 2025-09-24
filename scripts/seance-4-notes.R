library(tidyverse)

# 1. Importer les données :
d1 <- read_csv("donnees/sampleData.csv")

d1

long1 <- d1 |>
  pivot_longer(
    names_to = "test",
    values_to = "note",
    cols = testA:testC
  )

long1

# Pratique 1 :
# 1. Créer un graphique de boîtes à moustache
# à partir du tableau long1
ggplot(data = long1, aes(x = test, y = note)) +
  geom_boxplot()

# 2. Créer un graphique de moyennes + erreurs
# à partir du tableau long1
ggplot(data = long1, aes(x = test, y = note)) +
  stat_summary()

# Combiner les deux :
ggplot(data = long1, aes(x = test, y = note)) +
  geom_boxplot(
    fill = "orange",
    # color = "orange",
    alpha = 0.3
  ) +
  stat_summary(color = "black") +
  labs(
    title = "Ma première figure avec ggplot2",
    subtitle = "Ceci est le sous-titre de la figure",
    x = "Test",
    y = "Note (/10)"
  ) +
  theme_classic(
    base_family = "Arial",
    base_size = 20
  )

# Simuler 20 000 personnes (notes!)
set.seed(1)
population <- rnorm(n = 20000, mean = 74, sd = 5)
hist(population)
mean(population)

set.seed(2)
echant <- sample(
  x = population,
  size = 50,
  replace = FALSE
)

mean(echant)

mean(population) - mean(echant)

# Donc, l'inférence statistique à partir
# d'un échantillon de données est suffisamment
# précise!


# ==================
# ================== PRATIQUE : villes.csv
# ==================
# Question de recherche possible : les apprenants à Québec ont-ils
# un avantage d'exposition à langue française quand on examine
# leurs notes moyennes dans un test de français?
#
# 1. Importez le fichier villes.csv (fonction : read_csv())
villes <- read_csv("donnees/villes.csv")
villes
# 2. Calculez la note moyenne pour chaque groupe de participants  (fonction : summarize())
villes |>
  summarize(
    moyenne = mean(note),
    et = sd(note),
    .by = ville
  )

# 3. Ordonnez les notes en ordre décroissant (fonction : arrange())
villes |>
  arrange(-note) |> # question 3
  write_csv("donnees/villesOrdonnees.csv") # question 4

# 4. Exportez le tableau en tant que villesOrdonnees.csv (fonction : write_csv())
#
# 5. Créez un graphique pour comparer les deux groupes (fonction : ggplot())
ggplot(data = villes, aes(x = ville, y = note)) +
  geom_boxplot() +
  stat_summary()


# ==================
# TEST t

# Pour confirmer s'il y a une différence
# entre les notes moyennes de Montréal et Québec,
# on peut utiliser un test t, qui compare un OU deux
# groupes par rapport à une variable continue
# (plus spécifiquement sa moyenne)
#

t.test(note ~ ville, data = villes)

# Valeur p = 0,000083 -> alpha = 0,05
# La valeur est inférieure à 0,05, donc
# on rejette l'hypothèse nulle :
# il y a une différence entre les villes!
# t = -4,10, p < 0,0001 (ou p = 0,000083)
#
# Valeur p = la probabilité de voir des données
# si extrêmes si l'hypothèse nulle était vraie.
# Probabilité de voir les données en question SI
# H0 = vraie.
# df = 100 - 2 = 98

t.test(note ~ ville,
  data = villes,
  alternative = "less"
)

# On confirme qu'il y a une différence significative :
# la note moyenne de Québec (74) est
# statistiquement supérieure à celle de
# Montréal : t(97,989) = -4,1,
# IC 95 % = [-Inf, -2,73],
# p = 0,00004 OU p < 0,0001.
