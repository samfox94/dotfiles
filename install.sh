#!/bin/bash
HOME_DIRECTORY=/home/$USER
NERD_FONT_NAME=Meslo
set -e
set -x

install_zsh()
{
    sudo apt install zsh starship
    echo "Setting zsh as current ${USER}'s default shell."
    sudo chsh -s $(which zsh) $USER
   
    echo "Installing custom zsh configs."
    stow -t $HOME_DIRECTORY zsh
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
#    if command -v "nvim --version 2>&1 > /dev/null"
#    then
#        echo "nvim not found... attempting to install"
#        cd neovim
#        make CMAKE_BUILD_TYPE=RelWithDebInfo
#        sudo make install
#        cd ..
#    fi

    echo "Installing custom Nvim configs"
    stow -t $HOME_DIRECTORY nvim
}

#install_nerd_font
install_submodules
install_zsh
install_tmux
install_nvim







