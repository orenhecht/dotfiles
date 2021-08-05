#!/usr/bin/env bash
set -e -x

function install_github_latest() {
    local github_repo=${1}
    local file_pattern=${2}

    echo "Searching for ${file_pattern} in Github repo ${github_repo}"

    local latest_url=$( curl -sL https://api.github.com/repos/${github_repo}/releases/latest | \
                        jq -r '.assets[].browser_download_url' | \
                        grep ${file_pattern})

    echo "URL Found: ${latest_url} Downloading..."
    wget -q ${latest_url}

    local file_basename=$(basename ${latest_url})
    if [[ ${file_basename} == *.deb ]]; then
        sudo dpkg -i ${file_basename}
        rm -f ${file_basename}
    elif [[ ${file_basename} == *.tar.gz ]]; then
        tar xzf ${file_basename}
        cd $(basename ${file_basename} .tar.gz) && ./configure && make && sudo make install
        rm -rf ${file_basename} $(basename ${file_basename} .tar.gz)
    elif [[ ${file_basename} == *.appimage ]]; then
        chmod u+x ${file_basename}
	sudo mv ${file_basename} /usr/bin/$(basename ${file_basename} .appimage)
    else
        echo "Extension not recognized, skipping..."
    fi

}


# requires manual install due to not having a proper release
function install_universal_tags() {
    echo "Downloading universal-ctags"
    local latest_url=$( curl -sL https://api.github.com/repos/universal-ctags/ctags/tags | jq -r '.[0].tarball_url')
    local file_basename=$(basename ${latest_url})
    echo "URL Found: ${latest_url} Downloading..."
    wget -q ${latest_url}
    mv ${file_basename} ${file_basename}.tar.gz
    mkdir ${file_basename} && tar xzf ${file_basename}.tar.gz -C ${file_basename}/ --strip-components=1
    cd ${file_basename} && ./autogen.sh && ./configure && make && sudo make install
    rm -rf ${file_basename} ${file_basename}.tar.gz
}


install_github_latest neovim/neovim 'nvim.appimage$'
install_github_latest tmux/tmux tmux-.*.tar.gz
install_github_latest sharkdp/fd fd_.*amd64.deb
install_github_latest sharkdp/bat bat_.*amd64.deb
install_github_latest BurntSushi/ripgrep ripgrep_.*_amd64.deb
install_universal_tags
