library(tidyverse)

# HACK: Si vous voulez vraiment comprendre comment le test t fonctionne en R,
# étudiez ce script attentivement. Cela vous aidera pour le reste de la session.
#
# NOTE: Révision dans les diapos 4 et 5 de la séance

donnees <- tribble(
  ~Groupe_A, ~Groupe_B,
  87, 76,
  57, 89,
  48, 95,
  90, 67,
  91, 58
)

# NOTE: Vérifions que le résultat est identique
long <- donnees |>
  pivot_longer(
    names_to = "Groupe",
    values_to = "Score",
    cols = Groupe_A:Groupe_B
  )

t.test(Score ~ Groupe, data = long)

# NOTE: Calcul manuel
# 1. Ajouter la colonne qui calcule les écarts au carré
long <- long |>
  mutate(
    Moyenne = mean(Score), .by = Groupe
  ) |>
  mutate(ecarts_au_carre = (Score - Moyenne)^2) |>
  arrange(Groupe)

# 2. Calculer les moyennes :
moyennes <- long |>
  summarize(
    Moyenne = mean(Score),
    .by = Groupe
  )

m_A <- moyennes |>
  filter(Groupe == "Groupe_A") |>
  pull(2)

m_B <- moyennes |>
  filter(Groupe == "Groupe_B") |>
  pull(2)


# 3. La variance de chaque groupe est la somme des écarts
# au carré divisé par le degré de liberté de chaque groupe :
variances <- long |>
  summarize(
    Variance = sum(ecarts_au_carre) / (n() - 1),
    .by = Groupe
  )

var_A <- variances |>
  filter(Groupe == "Groupe_A") |>
  pull(2)
var_B <- variances |>
  filter(Groupe == "Groupe_B") |>
  pull(2)

# 3. Avec les moyennes et les variances, on calcule le test t :
n <- 5 # <- la taille des groupes
t <- (m_A - m_B) / sqrt((var_A / n) + (var_B / n))

t # Voilà!

# NOTE: On calcule la statistique t ici.

villes <- read_csv("donnees/base/villes.csv")

# NOTE: Extraire les notes de chaque ville :
#
# NOTE: Les notes de Montréal
montreal <- villes |>
  filter(ville == "Montréal") |>
  pull(note) # pull() extrait las valeurs d'une colonne

# NOTE: Les notes de Québec
quebec <- villes |>
  filter(ville == "Québec") |>
  pull(note)

# NOTE: Calculer les moyennes :
m_M <- mean(montreal) # moyenne de Montréal
m_Q <- mean(quebec) # moyenne de Québec

# NOTE: La taille des échantillons :
n_M <- length(montreal) # lenght() marche ici parce que montreal est un vecteur
n_Q <- length(quebec)

# On constate que nm = nq :
n_M == n_Q

# Donc, on peut simplment dire :
n <- n_M

# NOTE: Calculer les variances manuellement :
var_M <- sum((montreal - m_M)^2) / (n - 1)
# Vérifier que le calcul est correct :
var(montreal) == var_M

var_Q <- sum((quebec - m_Q)^2) / (n - 1)
# Vérifier que le calcul est correct :
var(quebec) == var_Q


# NOTE: Maintenant, on a toutes les variables nécessaires
# pour le calcul de t :
t <- (m_M - m_Q) /
  sqrt(
    (var_M / n) +
      (var_Q / n)
  )

# NOTE: Comparez les deux méthodes :
t # manuel
t.test(montreal, quebec) # automatique en séparant les villes avant
t.test(note ~ ville, data = villes) # automatique avec un tableau de données

# HACK: Vous pouvez extraire la valeur t du test aussi :
t.test(note ~ ville, data = villes)$statistic
