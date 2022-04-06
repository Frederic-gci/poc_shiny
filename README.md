# shiny4oracle

Ce projet est un test pour l'utilisation de R + shiny pour créer une application "web" locale pour le projet Oracle1. R fournit les librairies géospatiales utilisées pour le traitement des fichiers de même que les fonctionnalités d'analyse et de présentation de données. Shiny permet d'utiliser les langages du web pour la création de l'interface. L'utilisation "locale" de l'application permet d'éviter les transferts de fichiers volumineux et d'utiliser les ressources de calcul de l'utilisateur.

## Installation

### Installation de R
La page [cran.r-project.org](https://cran.r-project.org/) comprend des liens vers les différentes méthodes d'installation. Un exécutable windows pour l'installation de la dernière version de R peut être téléchargé ici: [R-4.1.3-win.exe](https://cran.r-project.org/bin/windows/base/R-4.1.3-win.exe).

### Installation de la librairie shiny4oracle
Depuis R, installer la librairie *devtools* et l'utiliser pour installer shiny4oracle depuis github:
```r
# Installer la librairie devtools depuis CRAN:
install.packages("devtools")

# Charger la librairie devtools
library(devtools)

# Installer shiny4oracle depuis github:
devtools::install_github("frederic-gci/shiny4oracle")
```

## Utilisation

Depuis R, charger la librairie et lancer l'application: 
```r
# Charger la librairie: 
library(shiny4oracle) 

# Lancer l'application: 
oracle()
```
L'application sera ouverte dans le navigateur web par défaut de l'utilisateur. 

### Fonctionalités

Les fonctionnalités sont extrêmement limitées et visent à illustrer: 
* L'utilisation de librairies géospatiales pour la lecture de fichiers en format geotiff / shp / gpkg
* L'utilisation de librairies géospatiales pour l'exécution d'un processus de prétraitement relativement long
* L'ajout de données à une carte intéractive