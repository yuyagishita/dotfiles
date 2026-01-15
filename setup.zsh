#!/usr/bin/env zsh

# Dotfiles setup script
# This script creates symbolic links from the home directory to the dotfiles repository

set -e

# Color output
autoload -U colors && colors

DOTFILES_DIR="${HOME}/ghq/github.com/yuyagishita/dotfiles"

echo "${fg[cyan]}Starting dotfiles setup...${reset_color}\n"

# Check if dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "${fg[red]}Error: Dotfiles directory not found at $DOTFILES_DIR${reset_color}"
    exit 1
fi

# Function to create symbolic link with backup
create_symlink() {
    local source="$1"
    local target="$2"

    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "${fg[yellow]}Backing up existing file: $target -> ${target}.backup${reset_color}"
        mv "$target" "${target}.backup"
    elif [[ -L "$target" ]]; then
        echo "${fg[blue]}Removing existing symlink: $target${reset_color}"
        rm "$target"
    fi

    ln -sf "$source" "$target"
    echo "${fg[green]}✓${reset_color} Created symlink: $target -> $source"
}

echo "${fg[cyan]}Setting up shell configuration...${reset_color}"
create_symlink "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "\n${fg[cyan]}Setting up .config directory...${reset_color}"
mkdir -p "$HOME/.config"

create_symlink "$DOTFILES_DIR/.config/hypr" "$HOME/.config/hypr"
create_symlink "$DOTFILES_DIR/.config/sway" "$HOME/.config/sway"
create_symlink "$DOTFILES_DIR/.config/wezterm" "$HOME/.config/wezterm"
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$DOTFILES_DIR/.config/chrome-flags.conf" "$HOME/.config/chrome-flags.conf"

echo "\n${fg[cyan]}Setting up desktop applications...${reset_color}"
mkdir -p "$HOME/.local/share/applications"

create_symlink "$DOTFILES_DIR/.local/share/applications/code.desktop" "$HOME/.local/share/applications/code.desktop"
create_symlink "$DOTFILES_DIR/.local/share/applications/discord.desktop" "$HOME/.local/share/applications/discord.desktop"
create_symlink "$DOTFILES_DIR/.local/share/applications/obsidian.desktop" "$HOME/.local/share/applications/obsidian.desktop"

echo "\n${fg[green]}✓ Dotfiles setup completed successfully!${reset_color}"
echo "${fg[cyan]}Please restart your shell or run 'source ~/.zshrc' to apply changes.${reset_color}"
