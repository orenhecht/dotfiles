set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl libevent-dev ncurses-dev bash-completion

# install python3.6
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get -y install python3.6 python3.6-dev python3-distutils
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.6

# install nvim
NVIM_VERSION=0.4.4
curl -LO https://github.com/neovim/neovim/archive/v${NVIM_VERSION}.tar.gz
tar xzf v${NVIM_VERSION}.tar.gz
cd neovim-${NVIM_VERSION}
make
sudo make install
cd ..
rm -rf neovim-${NVIM_VERSION} v${NVIM_VERSION}.tar.gz .nvimlog

#install tmux
TMUX_VERSION=3.1b
curl -LO https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure && make
sudo make install
cd ..
rm -rf tmux-${TMUX_VERSION} tmux-${TMUX_VERSION}.tar.gz

# install packages
sudo apt-get -y install exuberant-ctags htop silversearcher-ag autojump

# install fd
FD_VERSION=8.1.1
curl -LO https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd_${FD_VERSION}_amd64.deb
sudo dpkg -i fd_${FD_VERSION}_amd64.deb
rm fd_${FD_VERSION}_amd64.deb

#install bat
BAT_VERSION=0.15.4
curl -LO https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb
sudo dpkg -i bat_${BAT_VERSION}_amd64.deb
rm bat_${BAT_VERSION}_amd64.deb

#install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#install virtualencv
pip3.6 install --user virtualenv virtualenvwrapper

#dotfiles

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6
source ${SCRIPT_DIR}/bash_profile

echo -e "\nsource ${SCRIPT_DIR}/bash_profile" >> ~/.bashrc
mkdir -p ${HOME}/.virtualenvs
mkdir -p ${HOME}/.config/nvim
cd $HOME/.config/nvim && ln -s ${SCRIPT_DIR}/init.vim init.vim
cd $HOME && ln -s ${SCRIPT_DIR}/ctags.conf .ctags.conf
cd $HOME && ln -s ${SCRIPT_DIR}/gitconfig .gitconfig
cd $HOME && ln -s ${SCRIPT_DIR}/scripts .scripts
cd $HOME && ln -s ${SCRIPT_DIR}/tmux.conf .tmux.conf
cd $HOME && ln -s ${SCRIPT_DIR}/pylintrc .pylintrc

cd ${SCRIPT_DIR} && /bin/bash scripts/ctags_hooks.sh


source ${HOME}/.bash_profile
vim +PlugInstall

# install fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh


git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell


mkvirtualenv nvim2
pip install neovim
mkvirtualenv3 nvim3
pip install neovim
