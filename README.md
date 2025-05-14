# Anders' Dotfiles
My personal configuration for Arch Linux with Hyprland, Catppuccin Mocha, and Neovim.

## Contents
- `.config/hypr/`: Hyprland config with 8 workspaces and Pasystray toggle.
- `.config/gtk-3.0/`: Catppuccin Mocha for GTK-3 apps (pavucontrol, virt-manager).
- `.config/waybar/`: Waybar with Pasystray and volume control.
- `.config/nvim/`: Neovim with Kanagawa theme.
- `bin/`: Scripts like toggle-pasystray.sh.

## Usage
```bash
git clone git@github.com:skallen1959/dotfiles.git ~/dotfiles
cp -r ~/dotfiles/.config/* ~/.config/
cp ~/dotfiles/bin/* ~/bin/
