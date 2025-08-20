#!/bin/bash

# Neovim Configuration Installer for Arch Linux
# This script clones the config and installs all required dependencies

set -e

echo "🚀 Installing Neovim configuration for Arch Linux..."

# Clone the Neovim configuration
echo "📁 Cloning Neovim configuration..."
if [ -d "$HOME/.config/nvim" ]; then
    echo "⚠️  Neovim config already exists at ~/.config/nvim"
    read -p "Do you want to backup and replace it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✅ Backed up existing config"
    else
        echo "❌ Installation cancelled"
        exit 1
    fi
fi

git clone git@github.com:moonc4ke/nvim-config.git "$HOME/.config/nvim"
cd "$HOME/.config/nvim"

# Core dependencies
echo "📦 Installing core dependencies..."
yay -S --needed --noconfirm \
    neovim \
    git \
    base-devel \
    cmake \
    unzip \
    curl \
    wget \
    gzip \
    tar \
    gcc \
    make

# Search and file tools
echo "🔍 Installing search tools..."
yay -S --needed --noconfirm \
    ripgrep \
    fd \
    tree-sitter \
    tree-sitter-cli

# Git tools
echo "🔧 Installing git tools..."
yay -S --needed --noconfirm \
    lazygit

# Clipboard support (Wayland)
echo "📋 Installing clipboard support..."
yay -S --needed --noconfirm \
    wl-clipboard

# Language runtimes and tools
echo "💻 Installing language runtimes..."
yay -S --needed --noconfirm \
    python \
    python-pip \
    lua \
    luarocks \
    go \
    rust \
    cargo \
    php \
    composer \
    jdk-openjdk \
    ruby \
    julia-bin

# Install asdf if not already installed
echo "📦 Setting up asdf version manager..."
if ! command -v asdf &> /dev/null; then
    yay -S --needed --noconfirm asdf-vm
    echo "⚠️  Please restart your shell and run this script again to complete Node.js setup"
    echo "   Or source asdf manually: source /opt/asdf-vm/asdf.sh"
    exit 1
fi

# Install Node.js via asdf
echo "📦 Installing Node.js 20.18.0 via asdf..."
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2>/dev/null || true
asdf install nodejs 20.18.0
asdf global nodejs 20.18.0

# Verify Node.js installation
if ! command -v node &> /dev/null; then
    echo "⚠️  Node.js not found in PATH. Please restart your shell and run:"
    echo "   source /opt/asdf-vm/asdf.sh"
    echo "   asdf reshim nodejs"
fi

# Image support tools
echo "🖼️ Installing image support tools..."
yay -S --needed --noconfirm \
    imagemagick \
    ghostscript

# Optional: LaTeX support (commented out due to large size)
# echo "📐 Installing LaTeX support..."
# yay -S --needed --noconfirm texlive-core

# Python packages
echo "🐍 Installing Python packages..."
pip install --user --break-system-packages pynvim

# Node.js packages
echo "📦 Installing Node.js packages..."
if command -v npm &> /dev/null; then
    npm install -g neovim
else
    echo "⚠️  npm not available, skipping Node.js provider installation"
    echo "   Please run after setting up asdf: npm install -g neovim"
fi

# Optional: Mermaid CLI for diagram support
echo "📊 Installing Mermaid CLI..."
if command -v npm &> /dev/null; then
    npm install -g @mermaid-js/mermaid-cli
else
    echo "⚠️  npm not available, skipping Mermaid CLI installation"
    echo "   Please run after setting up asdf: npm install -g @mermaid-js/mermaid-cli"
fi

# Ruby gem (optional)
echo "💎 Installing Ruby Neovim gem..."
gem install neovim --user-install

echo "✅ All dependencies installed successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Launch Neovim: nvim"
echo "2. Wait for plugins to auto-install"
echo "3. Run :checkhealth to verify installation"
echo "4. LSP servers will auto-install via Mason"
echo ""
echo "💡 Tip: Install a Nerd Font for proper icon display"
echo "   yay -S ttf-jetbrains-mono-nerd"