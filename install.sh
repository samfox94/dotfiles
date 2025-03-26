#!/bin/bash
HOME_DIRECTORY=/home/$USER
NERD_FONT_NAME=Meslo
set -e
set -x

install_zsh()
{
    sudo apt install zsh 
    echo "Setting zsh as current ${USER}'s default shell."
    sudo chsh -s $(which zsh) $USER

    echo "Installing custom zsh configs."
    stow -t $HOME_DIRECTORY zsh
    curl -sS https://starship.rs/install.sh | sh
    stow -t $HOME_DIRECTORY starship
}

install_nerd_font()
{
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/${NERD_FONT_NAME}.zip
    unzip ${NERD_FONT_NAME}.zip -d ~/.local/share/fonts/ 
    rm ${NERD_FONT_NAME}.zip 
    fc-cache -fv
}

install_tmux()
{
    sudo apt install tmux

    stow -t $HOME_DIRECTORY tmux
    ~/.tmux/plugins/tpm/bin/install_plugins
}

install_submodules()
{
    sudo apt install git
    git submodule update --init --recursive
}

install_nvim()
{
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim

    echo "Installing custom Nvim configs"
    stow -t $HOME_DIRECTORY nvim
}

#install_nerd_font
install_submodules
install_zsh
install_tmux
install_nvim







