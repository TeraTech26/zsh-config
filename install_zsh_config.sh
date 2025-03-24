#!/bin/bash

echo "🔧 Installation de Zsh, git, curl et autojump..."
sudo apt update && sudo apt install -y zsh git curl autojump

echo "💡 Suppression d'Oh My Zsh existant (si présent)..."
rm -rf ~/.oh-my-zsh

echo "📦 Installation de Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


echo "🔌 Installation des plugins personnalisés..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# zsh-vi-mode
git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode

# fzf-tab (nécessite que fzf soit déjà installé)
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab

# zsh-completions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

# theme powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k


echo "⚙️ Configuration de ~/.zshrc..."
cat > ~/.zshrc <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
# Pour Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git sudo z autojump zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode fzf-tab zsh-completions)
source $ZSH/oh-my-zsh.sh
[[ -s /usr/share/autojump/autojump.zsh ]] && . /usr/share/autojump/autojump.zsh
export EDITOR="nano"
export VISUAL="nano"
autoload -U compinit && compinit
EOF

echo "✅ Configuration terminée. Tu peux redémarrer ton terminal ou exécuter : source ~/.zshrc"
