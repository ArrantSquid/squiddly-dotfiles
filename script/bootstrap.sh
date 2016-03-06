#!/bin/sh
#
# Bootstrapper to install
# (allthethings)
# Author: johnpneumann
#

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

setup_gitconfig () {
    if ! [ -f git/gitconfig.local.symlink ]
    then
        info 'setup gitconfig'

        git_credential='cache'
        if [ "$(uname -s)" == "Darwin" ]
        then
            git_credential='osxkeychain'
        fi

        user ' - What is your github author name?'
        read -e git_authorname
        user ' - What is your github author email?'
        read -e git_authoremail

        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

        success 'gitconfig'
    fi
}


link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then

        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
        then

        local currentSrc="$(readlink $dst)"

        if [ "$currentSrc" == "$src" ]
        then

            skip=true;

        else

            user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
            [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
            read -n 1 action

            case "$action" in
                o )
                    overwrite=true;;
                O )
                    overwrite_all=true;;
                b )
                    backup=true;;
                B )
                    backup_all=true;;
                s )
                    skip=true;;
                S )
                    skip_all=true;;
                * )
                ;;
            esac

        fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
        rm -rf "$dst"
        success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
        mv "$dst" "${dst}.backup"
        success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
        success "skipped $src"
    fi
    fi

    if [ "$skip" != "true" ]  # "false" or empty
    then
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}


xcode_install () {
    # Install xcode command line tools
    xcode-select -p >/dev/null
    if [ $? -ne 0 ]; then
        info 'Installing Command Line Tools'
        xcode-select --install
    fi
}


homebrew_install () {
    # Install homebrew
    info 'Install Homebrew'
    command -v brew >/dev/null 2>&1 || { echo >&2
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
    }
}

install_python () {
    # Install python
    info 'Install python'
    brew install python
    # Upgrade python packages
    info 'Upgrading and installing python packages'
    pip install --upgrade pip setuptools
    pip install --upgrade virtualenv
}

install_dotfiles () {
    info 'installing dotfiles'

    local overwrite_all=false backup_all=false skip_all=false

    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
    do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

ansible_config () {
    INSTALL_ANSIBLE=0
    user ' - Do you wish to install packages via ansible? [yes/no]'
    read ansible_case
    if printf "%s\n" "$ansible_case" | grep -Eq "$(locale yesexpr)"
    then
        INSTALL_ANSIBLE=1
    fi

    if [ "$INSTALL_ANSIBLE" = "1" ]
    then
        REMOVE_ANSIBLE=0
        user ' - Do you wish to remove ansible after installation? [yes/no]'
        read remove_ansible
        if printf "%s\n" "$remove_ansible" | grep -Eq "$(locale yesexpr)"
        then
            REMOVE_ANSIBLE=1
        fi
    fi
}

ansible_install () {
    pip freeze > ansible-requirements/your-pip.txt
    pip install pip-tools
    pip-compile ansible-requirements/requirements.in
    pip install -r ansible-requirements/requirements.txt
}

run_playbook () {
    # Run our playbook
    ansible-playbook ansible/playbooks/site.yml -i localhost
}

ansible_post_install () {
    if [ "$REMOVE_ANSIBLE" = "1" ]
    then
        pip uninstall -y -r ansible-requirements/requirements.txt
        info ' I have done my best to clean up after myself,'
        info ' however, to see what was [un]installed check'
        info ' ansible-requirements/requirements.txt.'
    fi
}

setup_gitconfig
install_dotfiles
if [ "$(uname -s)" == "Darwin" ]
then
    ansible_config
    if [ "$INSTALL_ANSIBLE" = "1" ]
    then
        xcode_install
        homebrew_install
        install_python
        ansible_install
        run_playbook
        ansible_post_install
    fi
fi

info ' Your previous pip has been stored in ansible-requirements/your-pip.txt'
echo ''
success '  All installed!'
