# Dotfiles Repository Guidelines

This file contains important guidelines for managing this dotfiles repository.

## Repository Structure

This repository manages configuration files using symbolic links from the home directory to files in this repository.

## Configuration File Management Rules

### Core Principle
- **All configuration files must be stored in this repository**
- **Use symbolic links to reference them from their expected locations (e.g., ~/.config/)**

### Adding New Configurations

When adding new configuration files:

1. **Place files in the repository structure** that mirrors the home directory
   - Example: `~/.config/hypr/hyprland.conf` → `./config/hypr/hyprland.conf`

2. **Update setup.zsh** to create the appropriate symlinks
   - Use the `create_symlink` function for consistency
   - Add new symlinks in the appropriate section

3. **Do NOT leave configuration files only in ~/.config/** without adding them to this repository

### Existing Configurations

The following configurations are already managed this way:

- `.config/hypr/` - Hyprland window manager configuration
- `.config/sway/` - Sway window manager configuration
- `.config/wezterm/` - WezTerm terminal emulator configuration
- `.config/starship.toml` - Starship prompt configuration
- `.config/chrome-flags.conf` - Chrome/Chromium flags
- Shell configurations (`.zshrc`, `.zprofile`, `.zshenv`)
- Desktop application files in `.local/share/applications/`

### Setup Script

`setup.zsh` is the main setup script that:
- Creates symbolic links from the home directory to this repository
- Backs up existing files before creating symlinks
- Should be run when setting up a new system or after cloning this repository

## When Making Changes

- Always commit configuration file changes to this repository
- Test that symlinks work correctly after modifications
- Keep setup.zsh up to date with any new configuration locations
