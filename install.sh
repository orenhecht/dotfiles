
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir ${HOME}/.virtualenvs
mkdir -p ${HOME}/.config/nvim
cd $HOME/.config/nvim && ln -s ${SCRIPT_DIR}/init.vim init.vim
cd $HOME && ln -s ${SCRIPT_DIR}/bash_profile .bash_profile
cd $HOME && ln -s ${SCRIPT_DIR}/ctags.conf .ctags.conf
cd $HOME && ln -s ${SCRIPT_DIR}/.gitconfig .gitconfig
cd $HOME && ln -s ${SCRIPT_DIR}/scripts .scripts
cd $HOME && ln -s ${SCRIPT_DIR}/tmux.conf .tmux.conf

sudo apt-get install exuberant-ctags ripgrep
cd ${SCRIPT_DIR} && /bin/bash ctags_hooks.sh


source ${HOME}/.bash_profile
vim +PlugInstall

# clone
git clone https://github.com/powerline/fonts.git
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh


