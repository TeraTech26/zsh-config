#!/bin/bash

# ─── VARIABLES ────────────────────────────────────────────────────────────────
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
ZSHRC="${HOME}/.zshrc"
ALIASES_FILE="/etc/zsh/.zsh_aliases"  # Adapté à ta config partagée
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
THEMES_DIR="$ZSH_CUSTOM/themes"

# ─── OPTION POUR SAUVEGARDER LE MDP UTILISATEUR TEMPORAIREMENT ───────────────────
echo "[*] Sauvegarde temporaire du mot de passe sudo pour faciliter l'installation..."
sudo -v  # Demande le mot de passe sudo pour le rendre valide pendant un certain temps

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

# ─── FICHIER .ALIASES ────────────────────────────────────────────────────────
if [ -w "$ALIASES_FILE" ]; then
    sudo tee "$ALIASES_FILE" > /dev/null <<EOF
    ## Aliases pour la navigation dans les répertoires
    alias ..="cd .."
    alias ...="cd ../.."
    alias home="cd ~"
    alias proj="cd /path/to/project"
    alias update="sudo apt update -y && sudo apt upgrade -y"
    alias upgrade="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y"
    alias install="sudo apt install -y"
    alias remove="sudo apt remove -y"
    alias search="apt search"
    alias clean="sudo apt clean && sudo apt autoremove"
    alias maj="sudo apt update -y && sudo apt upgrade -y"
    alias ll="ls -alF"
    alias la="ls -A"
    alias l="ls -CF"
    alias ls="ls -h"
    alias findf="find . -name"
    alias editbashrc="nano ~/.bashrc"
    alias editzshrc="nano ~/.zshrc"
    alias history="history | tail -n 20"
    alias histgrep="history | grep"
    alias gs="git status"
    alias ga="git add ."
    alias gc="git commit -m"
    alias gp="git push"
    alias gl="git log --oneline --graph --decorate --all"
    alias mem="free -h"
    alias disk="df -h"
    alias top="htop"
    alias ports="netstat -tulnp"
    alias sysinfo="uname -a"
    alias cpu="lscpu"
    alias untargz="tar -xzvf"
    alias unzip="unzip -v"
    alias tarball="tar -czvf"
    alias zipfile="zip -r"
    alias grep="grep --color=auto"
    alias catn="cat -n"
    alias now="date '+%Y-%m-%d %H:%M:%S'"
    alias !!="!!"
    alias killchrome="pkill chrome"
    alias killfirefox="pkill firefox"
    alias date="date '+On est le %d/%m/%Y. Et il est %H h %M m %S s.'"
    alias datec='date "+%A %d %B %Y"'
    alias datef='date "+%Y-%m-%d_%H-%M-%S"'
    alias datet="date '+%T'"
    alias edit="nano"
    alias gsave="git add . && git commit -m 'Auto save' && git push"
EOF
else
    echo "Le fichier $ALIASES_FILE n'est pas accessible en écriture."
fi

# ─── SHELL PAR DÉFAUT ─────────────────────────────────────────────────────────
echo "[*] Changement du shell par défaut vers zsh..."
chsh -s "$(which zsh)"

echo "✅ Configuration terminée. Lorsque tu modifies les paramètres de Oh My Zsh, tu peux redémarrer ton terminal ou exécuter : source ~/.zshrc"

echo "ATTENTION ! : Tu dois modifier le fichier ~/.zshrc"
