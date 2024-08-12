#!/bin/zsh

if [[ -f "/opt/homebrew/bin/brew" ]] then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

ensure_installed() {
    if ! brew list --formula "$1" &> /dev/null; then
        echo "Installing $1..."
        brew install "$1"
    else
        echo "$1 is already installed."
    fi
}

ensure_installed alacritty
ensure_installed tmux
ensure_installed zoxide
ensure_installed bat
ensure_installed fd
ensure_installed ripgrep
ensure_installed fzf
ensure_installed yazi
ensure_installed jq
ensure_installed btop
ensure_installed nvim
ensure_installed starship
