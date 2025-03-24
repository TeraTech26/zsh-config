#!/bin/bash

# ─── VARIABLES ────────────────────────────────────────────────────────────────
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
ZSHRC="${HOME}/.zshrc"
ALIASES_FILE="/etc/zsh/.zsh_aliases"  # Adapté à ta config partagée
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
THEMES_DIR="$ZSH_CUSTOM/themes"


# ─── INSTALLATION DE ZSH ──────────────────────────────────────────────────────
echo "[*] Installation de Zsh..."
sudo apt update && sudo apt install -y zsh git curl wget fonts-powerline

# ─── INSTALLATION DE OH MY ZSH ────────────────────────────────────────────────
echo "[*] Installation de Oh My Zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ─── PLUGINS ──────────────────────────────────────────────────────────────────
echo "[*] Installation des plugins..."

which fzf || sudo apt install fzf -y
which autojump || sudo apt install autojump -y

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# zsh-vi-mode
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-vi-mode" ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
fi

# fzf-tab (nécessite que fzf soit déjà installé)
if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
fi

# zsh-completions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
fi

# theme powerlevel10k
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
fi


# ─── FICHIER .ZSHRC ───────────────────────────────────────────────────────────

echo "[*] Configuration du fichier .zshrc..."

# Sauvegarde de .zshrc avant modification
cp "$ZSHRC" "${ZSHRC}.backup"

if [ -w "$ZSHRC" ]; then
    cat > "$ZSHRC" <<EOF
    # Path to Oh My Zsh
    export ZSH="\$HOME/.oh-my-zsh"
    
    # Theme
    ZSH_THEME="powerlevel10k/powerlevel10k"
    
    # Plugins
    plugins=(git sudo z autojump zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode fzf-tab zsh-completions)

    # Source Oh My Zsh
    source \$ZSH/oh-my-zsh.sh
    
    # Autojump
    [[ -s /usr/share/autojump/autojump.zsh ]] && . /usr/share/autojump/autojump.zsh
    
    # Aliases communs
    [ -f $ALIASES_FILE ] && source $ALIASES_FILE
    
    # Éditeur par défaut
    export EDITOR="nano"
    export VISUAL="nano"
    
    # Amélioration de l’autocomplétion
    autoload -U compinit && compinit
    
    # Powerlevel10k config (optionnel)
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    EOF
else
    echo "Le fichier $ZSHRC n'est pas accessible en écriture."
fi


# ─── FICHIER .Aliases ───────────────────────────────────────────────────────────

echo "[*] Configuration des aliases..."

if sudo [ -w "$ALIASES_FILE" ]; then
    sudo tee "$ALIASES_FILE" > /dev/null <<EOF
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
    
    # Utiliser `cat` avec les numéros de ligne
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
    alias current_date="date '+On est le %d/%m/%Y. Et il est %H h %M m %S s.'"
    
    # date complète
    alias datec='date "+%A %d %B %Y"'
    
    # 2025-03-24_15-07-42 (utile pour des noms de fichiers)
    alias datef='date "+%Y-%m-%d_%H-%M-%S"'
EOF
else
    echo "Le fichier d'aliases $ALIASES_FILE n'est pas accessible en écriture."
fi

echo "[*] Installation et configuration terminées !"
echo "N'oublie pas de redémarrer ton terminal ou d'exécuter : source ~/.zshrc"
