---
title: Anders dotfiles
author: Anders Karlsson
---

# Anders' Dotfiles
My personal configuration for Arch Linux with Hyprland, Catppuccin Mocha, and Neovim.

## Contents
- `hypr/.config`: Hyprland config with 8 workspaces and Pasystray toggle.
- `gtk-3.0/.config`: Catppuccin Mocha for GTK-3 apps (pavucontrol, virt-manager).
- `waybar/.config`: Waybar with Pasystray and volume control.
- `nvim/.config`: Neovim with Kanagawa theme.
- `bin/`: Scripts like toggle-pasystray.sh.

More to come..

## Usage
```bash
git clone git@github.com:skallen1959/dotfiles.git ~/dotfiles
cp -r ~/dotfiles/.config/* ~/.config/
cp ~/dotfiles/bin/* ~/bin/
