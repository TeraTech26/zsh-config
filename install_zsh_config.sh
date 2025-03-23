#!/bin/bash

echo "🔧 Installation de Zsh, git, curl et autojump..."
sudo apt update && sudo apt install -y zsh git curl autojump

echo "💡 Suppression d'Oh My Zsh existant (si présent)..."
rm -rf ~/.oh-my-zsh

echo "📦 Installation de Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "🔌 Installation des plugins personnalisés..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "⚙️ Configuration de ~/.zshrc..."
cat > ~/.zshrc <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git sudo z autojump zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
[[ -s /usr/share/autojump/autojump.zsh ]] && . /usr/share/autojump/autojump.zsh
export EDITOR="nano"
export VISUAL="nano"
autoload -U compinit && compinit
EOF

echo "✅ Configuration terminée. Tu peux redémarrer ton terminal ou exécuter : source ~/.zshrc"
