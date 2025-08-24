# Arch Dotfiles
this repository is used to store my backup configuration files on arch linux. you have to be aware that my config may not work on your distro unless it's arch or arch based distro.

# Setup
install [gnu-stow](https://www.gnu.org/s/stow/manual/stow.html) on your distro to be able to use/implement this config.

- ### Arch
```bash
sudo pacman -S stow
```

- ### Debian
```bash
sudo apt install stow
```

# Usage
move your config files (if there's already some files), and clone the repo:
```bash
mv ~/.config/nvim ~/.config/nvim.bak # for example
cd ~
git clone https://github.com/fauzymadani/dots.git
cd dots
stow nvim # example
```

## TODO
- improve docs
- add more config
