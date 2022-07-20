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

    # Install brew dependencies
    sudo apt-get install build-essential

    if [ "$(uname)" == "Linux" ]; 
    then
        echo "Adding Linux Homebrew to path"
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
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
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # remove template file
    rm .zshrc.pre-oh-my-zsh
    chezmoi apply --verbose
fi

zsh
source ~/.zshrc
