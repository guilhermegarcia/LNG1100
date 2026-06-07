# LNG-1100

## Méthodes expérimentales et analyse de données

> Bienvenue!

Ce dépôt Git sert à réunir tous les fichiers utilisés dans le cours LNG-1100.
Le livre numérique du cours est disponible sur <https://lng1100.quarto.pub>.
Il est de votre responsabilité d'organiser et gérer vos fichiers selon vos besoins et préférences.

- `diapos` - les `PDF` des diapos pour chaque séance
- `donnees` - les fichiers des données qui seront analysées pendant le cours
- `problemes` - les fichiers pour vos problèmes (les données seront disponibles sur `monPortail`)
- `scripts` - tous les fichiers `.R` seront dans ce dossier

C'est toujours une bonne idée de séparer les données des scripts, voilà pourquoi il y a deux dossiers séparés.

### Contenu et activités du cours

1. Introduction
2. Question de recherche; introduction à R
3. Exploration
4. Analyse : test _t_
5. Analyse : ANOVA
6. Analyse : régression linéaire
7. Analyse : régression linéaire
8. **Examen de mi-session**
9. _Semaine de lecture_
10. Bilan du mi-session et préparation à la 2e partie
11. Nettoyage de données
12. Exploration
13. Analyse : régression logistique
14. Analyse : régression logistique + révision
15. **Examen final**

Consultez les informations sur les évaluations du cours sur `Brio`.

### Comment optimiser votre apprentissage à la maison

1. **Écrivez votre code vous-même, sans IA.**
2. **Quand ça ne fonctionne pas, déboguez d'abord par vous-même** : lisez le message d'erreur, formulez une hypothèse, testez-la. C'est précisément là que l'apprentissage se fait.
3. **Ensuite seulement, utilisez l'IA (p. ex. Claude)** — non pas pour « régler » le problème à votre place, mais pour confirmer votre diagnostic, comprendre _pourquoi_ le code échouait, ou vous débloquer en cas d'impasse réelle. Demandez toujours une explication, pas seulement le code corrigé.
4. **Vérifiez la vérification.** L'IA se trompe aussi : corrections inutiles, fonctions désuètes, bogues introduits. Exécutez le code proposé et comparez-le à un résultat que vous connaissez déjà.
5. **Tenez un fil de conversation dédié au cours.** L'IA pourra ainsi tenir compte de vos erreurs précédentes, et la rétroaction deviendra de plus en plus pertinente au fil de la session.

#### Des questions ciblées à poser

- « Puis-je simplifier mon code sans quitter l'univers du `tidyverse`? Expliquez-moi le principe qui rend la version plus simple, pas seulement la réécriture. »
- « À partir des erreurs que j'ai faites jusqu'ici, créez-moi des exercices où je dois repérer les erreurs dans des blocs de code. Consignes :
  - certains blocs ne contiennent **aucune** erreur;
  - variez les types d'erreurs : erreurs de syntaxe, mais aussi **erreurs silencieuses** (le code s'exécute, mais le résultat est faux — p. ex. un `group_by()` sans `ungroup()`, un mauvais type de jointure, un `mutate()` mal placé);
  - utilisez le pipe natif de R (`|>`);
  - couvrez les fonctions clés de manipulation de tibbles (`group_by()`, `summarize()`, `select()`, `mutate()`, `pivot_*()`, etc.);
  - des blocs ni trop courts ni trop longs, avec peu d'erreurs par bloc;
  - donnez-moi le corrigé séparément, pour que je puisse m'auto-évaluer d'abord. »

> **À noter :** ce fil sert à _apprendre_, pas à obtenir des solutions toutes faites aux travaux notés.
