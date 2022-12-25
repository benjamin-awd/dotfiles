#!/bin/bash
# script to set up a new macos machine

# https://github.com/roconnorr/dotfiles/blob/master/init.sh

# Update all packages
sudo apt update

# Install Homebrew
if ! which brew;
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # Add Brew to path
    if [ "$(uname)" == "Linux" ]; 
    then
        echo "Adding Linux Homebrew to path"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    if [ "$(uname)" == "Darwin" ]; 
    then
        echo "Adding Homebrew to path"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

else
    echo "Homebrew is already installed."
fi

echo "init chezmoi"
brew install chezmoi
chezmoi init --apply --verbose https://github.com/benjamin-awd/dotfiles.git

# Install homebrew packages
# brew bundle install --verbose

# Run chezmoi
# chezmoi apply --verbose

# Install oh-my-zsh
OMZDIR=~/.oh-my-zsh
if [ -d "$OMZDIR" ]; then
    echo "oh-my-zsh is already installed"
else 
    echo "oh-my-zsh not installed - installing"
    sudo apt-get -y install zsh
    # remove template file
    rm .zshrc.pre-oh-my-zsh
    chezmoi apply --verbose
fi

zsh
source ~/.zshrc
exec zsh

# Install gpg
GPGDIR=~/.gnupg
if [ -d "GPGDIR" ]; then
    echo "Gnupg is already installed"
else
    mkdir ~/.gnupg
fi
