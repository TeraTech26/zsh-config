# Zsh Config

Ce dépôt contient une configuration Zsh personnalisée, avec des plugins et un thème pour Oh My Zsh.

## Sommaire

- [Installation](#installation)
- [Précision importante](#précision-importante)
- [Personnalisation](#personnalisation)
- [Plugins inclus](#plugins-inclus)
- [Licence](#licence)


## Installation

1. **Cloner le dépôt** dans le répertoire des plugins d'Oh My Zsh :

   ```bash
   bash <(curl -fsSL https://raw.githubusercontent.com/TeraTech26/zsh-config/main/install_zsh_config.sh)
   ```


2. **Recharger la configuration Zsh** :

   Après l'installation, recharger ta configuration Zsh en exécutant :

   ```bash
   source ~/.zshrc
   ```


## Précision importante

Si aucun des "Aliases" ne fonctionnent, il faut créer le fichier `.zsh_aliases` dans le répertoire `/etc/zsh` et copier le code suivant dans le fichier créé :

```.zsh_aliases
## Aliases pour la navigation dans les répertoires

# Aller au répertoire parent
alias ..="cd .."

# Aller à deux niveaux au-dessus
alias ...="cd ../.."

# Aller directement à ton répertoire home
alias home="cd ~"

# Aller rapidement dans un répertoire spécifique
alias proj="cd /path/to/project"

## Aliases pour la gestion des paquets et des mises à jour

# Mettre à jour tous les paquets
alias update="sudo apt update -y && sudo apt upgrade -y"

# Mettre à jour tout et nettoyer après
alias upgrade="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y"

# Installer un paquet
alias install="sudo apt install -y"

# Supprimer un paquet
alias remove="sudo apt remove -y"

# Rechercher un paquet
alias search="apt search"

# Nettoyer les paquets inutiles
alias clean="sudo apt clean && sudo apt autoremove"

# Mettre à jour les paquets
alias maj="sudo apt update -y && sudo apt upgrade -y"

## Aliases pour la gestion des fichiers

# Lister les fichiers avec détails
alias ll="ls -alF"

# Lister les fichiers sans fichiers cachés
alias la="ls -A"

# Lister les fichiers dans un format plus lisible
alias l="ls -CF"

# Afficher les fichiers avec un format lisible (taille en Ko, Mo, etc.)
alias ls="ls -h"

# Rechercher des fichiers par nom
alias findf="find . -name"

# Ouvrir le fichier de configuration de bash
alias editbashrc="nano ~/.bashrc"

# Ouvrir le fichier de configuration de zsh
alias editzshrc="nano ~/.zshrc"

## Aliases pour la gestion de l'historique

# Voir l'historique des commandes
alias history="history | tail -n 20"

# Rechercher dans l’historique
alias histgrep="history | grep"

## Aliases pour Git

# Vérifier l'état du dépôt Git
alias gs="git status"

# Ajouter tous les fichiers au staging
alias ga="git add ."

# Faire un commit
alias gc="git commit -m"

# Faire un push sur la branche courante
alias gp="git push"

# Voir les logs Git
alias gl="git log --oneline --graph --decorate --all"

## Aliases pour des commandes courantes

# Afficher la mémoire utilisée
alias mem="free -h"

# Afficher l'espace disque
alias disk="df -h"

# Afficher les processus en cours
alias top="htop"

# Afficher les ports utilisés
alias ports="netstat -tulnp"

# Afficher les informations système
alias sysinfo="uname -a"

# Voir l'usage du processeur
alias cpu="lscpu"

## Aliases pour l’utilisation des fichiers compressés

# Extraire un fichier .tar.gz
alias untargz="tar -xzvf"

# Extraire un fichier .zip
alias unzip="unzip -v"

# Créer une archive .tar.gz
alias tarball="tar -czvf"

# Créer une archive .zip
alias zipfile="zip -r"

## Aliases pour les raccourcis en ligne de commande

# Recherche dans les fichiers texte
alias grep="grep --color=auto"

# Utiliser cat avec les numéros de ligne
alias catn="cat -n"

# Afficher la date actuelle
alias now="date '+%Y-%m-%d %H:%M:%S'"

# Afficher la commande précédente
alias !!="!!"

## Aliases pour améliorer la productivité

# Fermer toutes les applications liées à un programme
alias killchrome="pkill chrome"
alias killfirefox="pkill firefox"

## Pour ce qui est de la date et de l'heure

# Afficher la date et l'heure
alias date="date '+On est le %d/%m/%Y. Et il est %H h %M m %S s.'"

# date complète
alias datec='date "+%A %d %B %Y"'

# 2025-03-24_15-07-42 (utile pour des noms de fichiers)
alias datef='date "+%Y-%m-%d_%H-%M-%S"'

# Heure simple (HH:MM:SS)
alias datet="date '+%T'"

# Ouvrir un fichier avec ton éditeur préféré
alias edit="nano"

## Aliases pour les commandes longues ou complexes

# Pour sauvegarder un fichier avec un commit git rapide
alias gsave="git add . && git commit -m 'Auto save' && git push"
```


## Personnalisation

- Tu peux personnaliser le fichier `~/.zshrc` pour changer le thème ou ajouter d'autres plugins.
- Les plugins sont configurés dans le fichier `~/.zshrc` sous la section `plugins=()`.


## Plugins inclus

1. **git**  
   Fournit des commandes pratiques pour interagir avec Git dans le terminal (ex. : `git status`, `git commit`, etc.).

2. **z**  
   Permet une navigation rapide entre les répertoires fréquemment utilisés grâce à une commande simple comme `z <répertoire>`.

3. **sudo**  
   Ajoute un raccourci pour exécuter des commandes avec `sudo` plus facilement (ex. : `zsudo` au lieu de `sudo zsh`).

4. **autojump**  
   Un autre outil pour naviguer rapidement entre les répertoires en fonction de ton historique de navigation.

5. **zsh-autosuggestions**  
   Suggère automatiquement des commandes basées sur ton historique au fur et à mesure que tu tapes.

6. **zsh-syntax-highlighting**  
   Colorie et met en surbrillance la syntaxe des commandes pour détecter les erreurs avant leur exécution.



## Licence

Ce projet est sous licence [MIT License].
