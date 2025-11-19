source("scripts/seance-9/1-script-net.R")

long1

# Créer une figure
ggplot(data = long1, aes(x = id, y = correct)) +
  stat_summary()

ggplot(data = long1, aes(x = phon, y = correct)) +
  stat_summary() +
  coord_cartesian(ylim = c(0, 1))

ggplot(data = long1, aes(x = langues, y = correct)) +
  stat_summary() +
  coord_cartesian(ylim = c(0, 1))

long1
