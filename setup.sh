#!/bin/bash

# --- Color Definitions ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Zsh Dotfiles Setup...${NC}"

# 1. Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo -e "${GREEN}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo -e "${BLUE}Homebrew already installed.${NC}"
fi

# 2. Install CLI Tools verified in config
echo -e "${GREEN}Installing CLI Tools (zoxide, eza, fzf)...${NC}"
brew install zoxide eza fzf

# 3. Install JetBrains Mono Nerd Font
echo -e "${GREEN}Installing Nerd Font for icons...${NC}"
brew install --cask font-jetbrains-mono-nerd-font

# 4. Install Zinit (to the path used in zshrc)
ZINIT_PATH="$HOME/.local/share/zinit/zinit.git"
if [ ! -d "$ZINIT_PATH" ]; then
    echo -e "${GREEN}Installing Zinit plugin manager...${NC}"
    mkdir -p "$(dirname "$ZINIT_PATH")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_PATH"
else
    echo -e "${BLUE}Zinit already installed.${NC}"
fi

# 5. Create Symlink for .zshrc
echo -e "${GREEN}Linking .zshrc from dotfiles...${NC}"
# Backup existing .zshrc if it's a real file (not a symlink)
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv ~/.zshrc ~/.zshrc.bak
    echo "Existing .zshrc backed up to ~/.zshrc.bak"
fi
ln -sf "$HOME/dotfiles/zshrc" "$HOME/.zshrc"

echo -e "${BLUE}Setup Complete!${NC}"
echo -e "Next steps:"
echo -e "1. Restart your terminal."
echo -e "2. Set your terminal font to 'JetBrainsMono Nerd Font' in iTerm2 Preferences."
