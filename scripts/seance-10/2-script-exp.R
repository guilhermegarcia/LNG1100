source("scripts/seance-10/1-script-net.R")

long2 |>
  dplyr::summarize(
    M = mean(correct), # Il faut ajouter le préfixe si vous chargez Hmisc
    ET = sd(correct),
    .by = geo
  )

# Précision moyenne par participant
prec_part <- long2 |>
  dplyr::summarize(
    M = mean(correct),
    ET = sd(correct),
    .by = id
  )

ggplot(data = prec_part, aes(x = M)) +
  geom_histogram()

# Moyenne globale : 36 % (!)

# Figure : le goût pour la géographie affecte-t-il la performance dans le Q?
ggplot(data = long2, aes(x = geo, y = correction)) +
  geom_point()

ggplot(data = long2, aes(x = geo, y = correct)) +
  stat_summary(
    color = "red",
    position = position_nudge(x = -0.1)
  ) +
  stat_summary(fun.data = mean_cl_boot) +
  stat_summary(
    fun.data = mean_cl_normal,
    color = "blue",
    position = position_nudge(x = 0.1)
  ) +
  theme_classic()

# NOTE: Explication :
# Les barres d'erreurs traditionnelles nous donnent
# l'erreur standard. Cela n'est pas idéal si nos données
# ne sont pas normales (notre situation ici). Un favorise donc
# les barres plus conservatrices, c'est-à-dire les barres
# qui calculent les intervalles de confiance à partir de la méthode
# bootstrapping. La figure ici vous montre trois types de barres d'erreurs :
# erreur standard (rouge), IC boostrapped (noir), et IC normal (bleu).
# Dans notre situation, on préférerait les barres noires, mais on n'examine pas
# cela dans notre cours.
