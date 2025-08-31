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
| `<leader>ff` | Normal | Open Telescope to find files |
| `<leader>fg` | Normal | Open Telescope for live grep/search in project |
| `<leader>fb` | Normal | Open Telescope to list buffers |
| `<leader>fh` | Normal | Open Telescope to search help tags |
| `gd` | Normal | Go to the definition of the symbol under the cursor |
| `gr` | Normal | List all references to the symbol under the cursor |
| `K` | Normal | Show hover documentation/info for symbol under cursor |
| `<leader>rn` | Normal | Rename the symbol under the cursor |
| `<leader>ca` | Normal | Show code actions available at the cursor position |
| `<leader>n` | Normal | Show diagnostics/errors/warnings for current line |
| `<leader>e` | Normal | Toggle/focus NvimTree file explorer |
| `<leader>q` | Normal | Close NvimTree or quit current buffer |
| `<C-b>` | Insert (autocomplete menu) | Scroll documentation up in autocomplete popup |
| `<C-f>` | Insert (autocomplete menu) | Scroll documentation down in autocomplete popup |
| `<C-Space>` | Insert | Trigger completion/autocomplete manually |
| `<C-e>` | Insert | Abort/close autocomplete popup |
| `<CR>` | Insert | Confirm the selected autocomplete item |

## TODO
- improve docs
- add more config
