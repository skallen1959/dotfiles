# My currently installed packages

## Arch packages

### Save packages
pacman -Q | awk '{print $1}' > ~/dotfiles/packages/pkglist.txt

### Restore packages (efter base install)
sudo pacman -S --needed - < ~/dotfiles/packages/pkglist.txt

## AUR packages

### Save AUR packages
pacman -Qm | awk '{print $1}' > ~/dotfiles/packages/aurlist.txt

### Restore AUR packages
yay -S --needed - < ~/dotfiles/packages/aurlist.txt
