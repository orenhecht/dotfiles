#!/usr/bin/env bash
set -e -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y install ninja-build gettext libtool libtool-bin \
    autoconf automake cmake g++ pkg-config unzip curl libevent-dev ncurses-dev bash-completion htop software-properties-common \
    zsh

# install apps
sudo apt install -y fasd
source ${SCRIPT_DIR}/install_apps.sh

#install venv
sudo apt install -y python3-venv python3-pip
pip3 install --upgrade pip

#dotfiles
echo -e "\nsource ${SCRIPT_DIR}/bash_profile" >> ~/.bashrc
mkdir -p ${HOME}/.venv
mkdir -p ${HOME}/.config/nvim
mkdir -p ${HOME}/.ctags.d
cd ${HOME}/.config/nvim && rm -f init.vim && ln -s ${SCRIPT_DIR}/init.vim init.vim
cd ${HOME}/.ctags.d && rm -rf  ${HOME}/.ctags.d/conf.ctags && ln -s ${SCRIPT_DIR}/ctags.conf conf.ctags
cd ${HOME} && rm -f  .gitconfig &&  ln -s ${SCRIPT_DIR}/gitconfig .gitconfig
cd ${HOME} && rm -rf .scripts && ln -s ${SCRIPT_DIR}/scripts .scripts
cd ${HOME} && rm -f  .tmux.conf && ln -s ${SCRIPT_DIR}/tmux.conf .tmux.conf

# install fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# base16 shell colors - use base16_bright and make sure iterm2 terminal (in profile) is set to xterm-color
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# create nvim python venv
python3 -m venv ${HOME}/.venv/nvim && source "${HOME}/.venv/nvim/bin/activate" && pip3 install wheel pynvim

# install all nvim plugins
nvim --headless +PlugInstall +qall

#TODO
# switch to zsh, install oh my zsh, source zshrc
# set theme as base_bright
#source ${SCRIPT_DIR}/zshrc


echo "============================================="
echo "NOW INSTALL yapf ON THE MAIN VENV"
echo "============================================="
