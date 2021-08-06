#!/usr/bin/env bash
set -e -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt upgrade -y
sudo apt install -y ninja-build gettext libtool libtool-bin \
    autoconf automake cmake g++ pkg-config unzip curl libevent-dev ncurses-dev bash-completion htop software-properties-common \
    zsh git jq

# install apps
sudo apt install -y fasd
source ${SCRIPT_DIR}/install_apps.sh

#install venv
sudo apt install -y python3-venv python3-pip
pip3 install --upgrade pip

#dotfiles
mkdir -p ${HOME}/.venv
mkdir -p ${HOME}/.config/nvim
mkdir -p ${HOME}/.ctags.d
cd ${HOME}/.config/nvim && rm -f init.vim && ln -s ${SCRIPT_DIR}/env/init.vim init.vim
cd ${HOME}/.ctags.d && rm -rf  ${HOME}/.ctags.d/conf.ctags && ln -s ${SCRIPT_DIR}/configs/ctags.conf conf.ctags
cd ${HOME} && rm -f  .gitconfig &&  ln -s ${SCRIPT_DIR}/env/gitconfig .gitconfig
cd ${HOME} && rm -rf .scripts && ln -s ${SCRIPT_DIR}/scripts .scripts
cd ${HOME} && rm -f  .tmux.conf && ln -s ${SCRIPT_DIR}/env/tmux.conf .tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# base16 shell colors - use base16_bright and make sure iterm2 text supports powerline glyphs
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# create nvim python venv
python3 -m venv ${HOME}/.venv/nvim && source "${HOME}/.venv/nvim/bin/activate" && pip3 install wheel && pip3 install pynvim yapf

# install all nvim plugins
# uncomment in 0.6 when this is fixed https://github.com/neovim/neovim/issues/11362
#nvim --headless +PlugInstall +qall
nvim +PlugInstall +qall >/dev/null

# activate zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo usermod -s $(which zsh) ${USER}
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
echo -e "\nsource ${SCRIPT_DIR}/env/zshrc" >> ${HOME}/.zshrc

echo "============================================="
echo 'Now run: git config -f ~/.gitconfig.local user.email "you@example.com" && git config -f ~/.gitconfig.local user.name "Your Name"'
echo "Logout and login to switch to zsh."
echo "============================================="
