# LNG-1100

## Méthodes expérimentales et analyse de données

> Bienvenue!

Ce dépôt Git sert à réunir tous les fichiers utilisés dans le cours LNG-1100.
Le livre numérique du cours est disponible sur <https://fr.gdgarcia.ca/lng1100>.
Il est de votre responsabilité d'organiser et gérer vos fichiers selon vos besoins et préférences.

## Commencer à travailler sur votre ordinateur

### 1. Télécharger et décompresser le dossier

1. Téléchargez le fichier `LNG1100.zip` à partir de Brio.
2. **Décompressez le fichier ZIP.** Il ne faut pas travailler directement dans le
   fichier ZIP.
3. Déplacez le dossier décompressé `LNG1100` vers un emplacement permanent et
   facile à retrouver, par exemple dans votre dossier `Documents`.

Évitez de laisser le dossier dans `Téléchargements` : il sera plus difficile à
retrouver et pourrait être supprimé par erreur.

Après la décompression, la structure du dossier devrait ressembler à ceci :

```text
LNG1100/
├── LNG1100.Rproj
├── README.md
├── donnees/
├── problemes/
├── quarto/
└── scripts/
```

### 2. Toujours ouvrir le projet RStudio

Dans le dossier `LNG1100`, double-cliquez sur le fichier `LNG1100.Rproj`. Cette
étape ouvre RStudio à la racine du projet, c'est-à-dire au bon endroit pour
trouver les scripts et les données du cours.

Ne commencez pas en ouvrant simplement RStudio ou en double-cliquant sur un
script `.R`. Commencez toujours par `LNG1100.Rproj`.

### 3. Installer le tidyverse

Le cours utilise l'ensemble de bibliothèques `tidyverse`. Vous devez l'installer
une seule fois sur votre ordinateur. Dans la console de RStudio, exécutez :

```r
install.packages("tidyverse")
```

Attendez la fin de l'installation, puis vérifiez qu'elle a réussi :

```r
library(tidyverse)
```

`install.packages("tidyverse")` sert à installer les bibliothèques sur
l'ordinateur et ne doit normalement être exécuté qu'une seule fois.
`library(tidyverse)` sert à les charger dans une séance de travail et doit être
exécuté chaque fois qu'un script en a besoin.

### 4. Vérifier que vous êtes au bon endroit

Dans la console de RStudio, exécutez :

```r
file.exists("donnees/villes.csv")
```

Si R affiche `[1] TRUE`, le projet est ouvert correctement. Si R affiche
`[1] FALSE`, fermez RStudio, retrouvez le dossier `LNG1100` décompressé, puis
ouvrez de nouveau `LNG1100.Rproj`.

Dans l'onglet **Files** de RStudio, vous devriez également voir les dossiers
`donnees`, `problemes`, `quarto` et `scripts`.

### 5. Ajouter de nouveaux fichiers

Lorsque vous téléchargez un nouveau fichier pour le cours :

- placez les fichiers de données (`.csv`, `.RData`, etc.) dans `donnees`;
- placez les scripts R (`.R`) dans `scripts`;
- placez les fichiers associés à un problème dans le dossier du problème
  correspondant.

Déplacez le fichier à l'aide du Finder (macOS) ou de l'Explorateur de fichiers
(Windows), puis vérifiez qu'il apparaît dans l'onglet **Files** de RStudio.

Dans vos scripts, utilisez toujours des chemins relatifs au projet :

```r
read_csv("donnees/villes.csv") # cette commande exige l'installation de Tidyverse
```

N'utilisez pas `setwd()` et n'écrivez pas le chemin complet propre à votre
ordinateur. Les chemins relatifs permettent au même script de fonctionner sur
n'importe quel ordinateur.

### En cas de problème

Si vous ne retrouvez plus vos fichiers, vérifiez d'abord :

1. que vous travaillez dans le dossier `LNG1100` **décompressé**, et non dans le
   fichier `LNG1100.zip`;
2. que vous avez ouvert RStudio en double-cliquant sur `LNG1100.Rproj`;
3. que `file.exists("donnees/villes.csv")` retourne `TRUE`;
4. que le fichier recherché se trouve dans le bon sous-dossier.

## Organisation du matériel

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

## Plan de secours : utiliser Posit Cloud

Si vous rencontrez un problème majeur avec R ou RStudio sur votre ordinateur,
vous pouvez temporairement travailler dans
[Posit Cloud](https://posit.cloud). Vous aurez besoin d'un compte Posit Cloud,
mais vous n'avez pas besoin d'installer R, RStudio ou Git sur votre ordinateur.

Pour créer une copie du projet du cours :

1. Connectez-vous à [Posit Cloud](https://posit.cloud).
2. Cliquez sur **New Project**.
3. Choisissez **New Project from Git Repo**.
4. Dans le champ réservé à l'adresse du dépôt, collez :

   ```text
   https://github.com/guilhermegarcia/LNG1100.git
   ```

5. Créez le projet et attendez que RStudio s'ouvre.
6. Dans la console, vérifiez que vous êtes à la racine du projet :

   ```r
   file.exists("donnees/villes.csv")
   ```

   Le résultat devrait être `[1] TRUE`.
7. Installez le tidyverse dans le projet Posit Cloud :

   ```r
   install.packages("tidyverse")
   ```

   Attendez la fin de l'installation. Cette étape ne doit normalement être
   effectuée qu'une seule fois dans ce projet.
8. Chargez ensuite le tidyverse :

   ```r
   library(tidyverse)
   ```

Le projet créé dans Posit Cloud contient les fichiers du dépôt Git, mais **pas
les fichiers que vous avez créés ou modifiés uniquement sur votre ordinateur**.
Au besoin, utilisez le bouton **Upload** dans l'onglet **Files** de RStudio pour
téléverser une copie de vos scripts ou de vos autres fichiers dans le projet
infonuagique.

Posit Cloud constitue un plan de secours en cas de problème important. La
méthode normale pour le cours demeure le projet local ouvert à partir de
`LNG1100.Rproj`.
