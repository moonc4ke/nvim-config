# Neovim Configuration for Arch Linux

Modern Neovim setup with LSP, autocompletion, and productivity tools.

## Quick Install

### One-liner Installation
```bash
curl -fsSL https://raw.githubusercontent.com/moonc4ke/nvim-config/main/install.sh | bash
```

### Or clone and run locally:
```bash
git clone git@github.com:moonc4ke/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
./install.sh
```

## Manual Installation

### All dependencies in one command:
```bash
yay -S --needed neovim git base-devel cmake unzip curl wget gzip tar gcc make ripgrep fd tree-sitter tree-sitter-cli lazygit wl-clipboard asdf-vm python python-pip lua luarocks go rust cargo php composer jdk-openjdk ruby julia-bin imagemagick ghostscript ttf-jetbrains-mono-nerd
```

### Additional setup:
```bash
# Setup asdf and Node.js
source /opt/asdf-vm/asdf.sh
asdf plugin add nodejs
asdf install nodejs 20.18.0
asdf global nodejs 20.18.0

# Python provider
pip install --user --break-system-packages pynvim

# Node.js provider
npm install -g neovim

# Optional: Mermaid diagrams
npm install -g @mermaid-js/mermaid-cli

# Optional: Ruby provider
gem install neovim --user-install
```

## Features

- **LSP Support**: TypeScript, JavaScript, Angular, Vue, HTML, CSS, Tailwind, ESLint, Lua
- **Autocompletion**: nvim-cmp with LSP, buffer, path, and snippet sources
- **Syntax Highlighting**: Tree-sitter based
- **File Management**: Oil.nvim and Snacks explorer
- **Git Integration**: Lazygit, vgit, git-blame
- **Fuzzy Finding**: Snacks picker
- **AI Assistance**: Codeium integration
- **Dashboard**: Custom startup screen
- **Multi-cursor**: Multiple cursor editing
- **Image Preview**: Inline images in supported terminals (Ghostty, Kitty)

## Verification

After installation:
```bash
nvim
:checkhealth
```

## Terminal Recommendation

For best experience (image support), use:
```bash
yay -S ghostty-git  # or kitty, wezterm
```
