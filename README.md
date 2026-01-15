# dotfiles

## Support OS

- Arch Linux

## Description

This repository contains dotfiles for the following applications:

- **Neovim:** Configuration files for the Neovim text editor.
  - Plugins:
    - avante.lua: A plugin for managing Neovim.
    - copilot.lua: A plugin for using GitHub Copilot in Neovim.
    - Comment.lua: A plugin for commenting code in Neovim.
    - alpha.lua: A plugin for creating a dashboard in Neovim.
    - mason-lspconfig.lua: A plugin for managing Language Server Protocol configurations in Neovim.
- **Zsh:** Configuration files for the Zsh shell.
- **Hyprland:** Configuration files for the Hyprland compositor.

## Setup

### Quick Setup (Recommended)

The easiest way to set up the dotfiles is to use the provided setup script:

```bash
cd ~/ghq/github.com/yuyagishita/dotfiles
./setup.zsh
```

This script will:
- Create all necessary symbolic links
- Back up any existing files that would be overwritten (saved with `.backup` extension)
- Create required directories if they don't exist
- Display colored output to show progress

### Manual Setup

If you prefer to create symbolic links manually, you can use the following commands.

#### Shell Configuration

```bash
# Zsh configuration files
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.zprofile ~/.zprofile
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.zshenv ~/.zshenv
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.zshrc ~/.zshrc
```

#### Config Directory

```bash
# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Hyprland configuration
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/hypr ~/.config/hypr

# Sway configuration
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/sway ~/.config/sway

# WezTerm configuration
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/wezterm ~/.config/wezterm

# Starship configuration
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/starship.toml ~/.config/starship.toml

# Chrome flags
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/chrome-flags.conf ~/.config/chrome-flags.conf
```

#### Desktop Applications

```bash
# Create applications directory if it doesn't exist
mkdir -p ~/.local/share/applications

# Desktop entry files
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.local/share/applications/code.desktop ~/.local/share/applications/code.desktop
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.local/share/applications/discord.desktop ~/.local/share/applications/discord.desktop
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.local/share/applications/obsidian.desktop ~/.local/share/applications/obsidian.desktop
```

#### All at Once

To set up all symbolic links at once, you can run the following:

```bash
# Shell configuration
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.zprofile ~/.zprofile
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.zshenv ~/.zshenv
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.zshrc ~/.zshrc

# Config directory
mkdir -p ~/.config
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/hypr ~/.config/hypr
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/sway ~/.config/sway
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/wezterm ~/.config/wezterm
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.config/chrome-flags.conf ~/.config/chrome-flags.conf

# Desktop applications
mkdir -p ~/.local/share/applications
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.local/share/applications/code.desktop ~/.local/share/applications/code.desktop
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.local/share/applications/discord.desktop ~/.local/share/applications/discord.desktop
ln -sf ~/ghq/github.com/yuyagishita/dotfiles/.local/share/applications/obsidian.desktop ~/.local/share/applications/obsidian.desktop
```

**Note:** The `-s` flag creates a symbolic link, and the `-f` flag forces the creation even if the target file already exists.
