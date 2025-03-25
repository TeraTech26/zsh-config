# Zsh Config

Ce dépôt contient une configuration Zsh personnalisée, avec des plugins et un thème pour Oh My Zsh.

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
