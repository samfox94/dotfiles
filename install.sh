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
    curl -sS https://starship.rs/install.sh | sudo sh
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
    sudo apt install cmake
    git clone https://github.com/neovim/neovim.git
    cd neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    cd ..

    echo "Installing custom Nvim configs"
    stow -t $HOME_DIRECTORY nvim
}

#install_nerd_font
install_submodules
install_zsh
install_tmux
install_nvim







