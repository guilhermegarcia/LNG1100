library(tidyverse)

v2 <- read_csv("donnees/villes2.csv") |>
  mutate(
    francophone = if_else(ville == "Calgary", 0, 1),
    langue = if_else(ville == "Calgary", "anglais", "français")
  )

v2

ggplot(data = v2, aes(x = langue, y = note)) +
  geom_boxplot() +
  stat_summary(color = "red") +
  theme_classic(base_size = 18)

mod1 <- glm(francophone ~ note, data = v2, family = "binomial")

mod1 |> summary()

predict(
  mod1,
  newdata = tibble(note = c(50, 75, 80, 95)),
  type = "response"
)

# Nouveau tableau pour une simulation de notes
# à partir de notre modèle mod1

simulation <- tibble(
  note = seq(from = 0, to = 100, by = 5),
  P = predict(
    mod1,
    newdata = tibble(note = seq(from = 0, to = 100, by = 5)),
    type = "response"
  )
)

simulation |>
  ggplot(aes(x = note, y = P)) +
  geom_point(size = 5, color = "darkorange") +
  theme_classic(base_size = 15) +
  labs(title = "Prédictions à partir du modèle mod1")


# Pratique 2

fr <- read_csv("donnees/francais.csv")

fr

# 1. Nouvelle colonne
fr <- fr |>
  mutate(correct = if_else(reponse == "correct", 1, 0)) |>
  mutate(across(where(is_character), as_factor),
    id = id |> as_factor()
  )

fr

# 2. La relation entre la langue et la précision :
ggplot(data = fr, aes(x = langue, y = correct)) +
  stat_summary(geom = "bar", alpha = 0.3, color = "black") +
  stat_summary() +
  theme_classic(base_size = 18)

# 3. La relation entre la note de l'examen et la précision :
ggplot(data = fr, aes(x = reponse, y = examen1)) +
  geom_boxplot() +
  theme_classic(base_size = 18)

# 4. Une figure qui combine les deux variables
ggplot(data = fr, aes(x = reponse, y = examen1)) +
  geom_boxplot(aes(fill = langue)) +
  theme_classic(base_size = 18) +
  theme(legend.position = "top")


mod2 <- glm(correct ~ langue, data = fr, family = "binomial")
mod2 |> summary()

# Créer un tableau avec des simulations basées sur mod2
predict(
  mod2,
  type = "response",
  newdata = tibble(
    langue = c("japonais", "italien", "alemmand")
  )
)
