---
title: "Un document"
format: pdf
date: today
editor: visual
number-sections: true
lang: fr
theme: united
---

# Figures

Voici comment ajouter une figure **externe** au document Quarto. La @fig-chatte vous montre Peggy.

![La chatte Peggy](../figures/chatte.jpeg){#fig-chatte fig-align="center" width="50%"}

# Les auxiliaires de l'holandais

On commence en chargeant la bibliothèque `tidyverse` ainsi que les données à partir du fichier `auxiliaires.csv`. 


::: {.cell}

```{.r .cell-code}
library(tidyverse)
aux <- read_csv("../../donnees/auxiliaires.csv")
```
:::


On peut imprimer le nombre de variables (supposant un tableau *tidy*) en utilisant la fonction `ncol()` : Il y a 13 colonnes et 700 observations dans les données, mais on n'analyse que deux variables, c'est-à-dire les variables `WrittenFrequency` et `Auxiliary`. On peut utiliser la fonction `select()` pour simplifier les données.

## Figures avec `ggplot2`

On va créer un histogramme pour vérifier si la variable de réponse est Gaussienne. 



::: {.cell layout-align="center"}

```{.r .cell-code}
ggplot(data = aux, aes(x = WrittenFrequency)) +
  geom_histogram() +
  theme_classic() + 
  labs(x = "Fréquence", y = "")
```

::: {.cell-output-display}
![](demo_quarto_files/figure-pdf/unnamed-chunk-2-1.pdf){fig-align='center' fig-pos='H' width=70%}
:::
:::



Maintenant, la figure principale :


::: {.cell layout-align="center"}

```{.r .cell-code}
ggplot(data = aux, 
       aes(x = Auxiliary |> fct_reorder(WrittenFrequency), 
           y = WrittenFrequency)) + 
  # geom_jitter(alpha = 0.1) + 
  geom_boxplot(aes(fill = Auxiliary), alpha = 0.3) +
  stat_summary(color = "black") + 
  theme_classic() +
  theme(
    legend.position = "none"
  ) +
  labs(
    x = "Auxiliaire",
    y = "Fréquence écrite"
  ) +
  scale_fill_manual(
    values = c("darkorange2", "white", "white")
  )
```

::: {.cell-output-display}
![](demo_quarto_files/figure-pdf/unnamed-chunk-3-1.pdf){fig-align='center' fig-pos='H' width=70%}
:::
:::





