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

# Keymaps
several config uses the default keymap, i'm only focused on their appearance.

## Nvim 
| Keymap | Mode | Description |
|--------|------|-------------|
| <kbd>Space</kbd> + <kbd>f</kbd> + <kbd>f</kbd> | Normal | Open Telescope to find files |
| <kbd>Space</kbd> + <kbd>f</kbd> + <kbd>g</kbd> | Normal | Open Telescope for live grep/search in project |
| <kbd>Space</kbd> + <kbd>f</kbd> + <kbd>b</kbd> | Normal | Open Telescope to list buffers |
| <kbd>Space</kbd> + <kbd>f</kbd> + <kbd>h</kbd> | Normal | Open Telescope to search help tags |
| <kbd>g</kbd> + <kbd>d</kbd> | Normal | Go to the definition of the symbol under the cursor |
| <kbd>g</kbd> + <kbd>r</kbd> | Normal | List all references to the symbol under the cursor |
| <kbd>K</kbd> | Normal | Show hover documentation/info for symbol under cursor |
| <kbd>Space</kbd> + <kbd>r</kbd> + <kbd>n</kbd> | Normal | Rename the symbol under the cursor |
| <kbd>Space</kbd> + <kbd>c</kbd> + <kbd>a</kbd> | Normal | Show code actions available at the cursor position |
| <kbd>Space</kbd> + <kbd>n</kbd> | Normal | Show diagnostics/errors/warnings for current line |
| <kbd>Space</kbd> + <kbd>e</kbd> | Normal | Toggle/focus NvimTree file explorer |
| <kbd>Space</kbd> + <kbd>q</kbd> | Normal | Close NvimTree or quit current buffer |
| <kbd>Ctrl</kbd> + <kbd>b</kbd> | Insert (autocomplete menu) | Scroll documentation up in autocomplete popup |
| <kbd>Ctrl</kbd> + <kbd>f</kbd> | Insert (autocomplete menu) | Scroll documentation down in autocomplete popup |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd> | Insert | Trigger completion/autocomplete manually |
| <kbd>Ctrl</kbd> + <kbd>e</kbd> | Insert | Abort/close autocomplete popup |
| <kbd>Enter</kbd> | Insert | Confirm the selected autocomplete item |

## TODO
- improve docs
- add more config
