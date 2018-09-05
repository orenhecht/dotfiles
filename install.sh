
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install nvim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

#install tmux 2.7
curl -LO https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz
tar xzf tmux-2.7.tar.gz
cd tmux-2.7
./configure && make
sudo make install
cd ..
rm -rf tmux-2.7 tmux-2.7.tar.gz

#install latest git
sudo apt-add-repository ppa:git-core/ppa
sudo apt update && sudo apt install git

# install packages
sudo apt install exuberant-ctags htop silversearcher-ag autojump

# install fd
curl -LO https://github.com/sharkdp/fd/releases/download/v7.1.0/fd_7.1.0_amd64.deb
sudo dpkg -i fd_7.1.0_amd64.deb
rm fd_7.1.0_amd64.deb

#install bat
curl -LO https://github.com/sharkdp/bat/releases/download/v0.7.0/bat_0.7.0_amd64.deb
sudo dpkg -i bat_0.7.0_amd64.deb
rm bat_0.7.0_amd64.deb

#install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#install virtualenc
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


mkvirtualenv nvim2
pip install neovim
mkvirtualenv3 nvim3
pip install neovim
