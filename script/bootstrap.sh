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
    # Agree to the Xcode license
    echo "Agree to the xcode license."
    sudo xcodebuild -license accept

    # Install xcode command line tools
    echo "Installing Command Line Tools"
    xcode-select -p >/dev/null
    if [ $? -ne 0 ]; then
        xcode-select --install
    fi
}


homebrew_install () {
    # Install homebrew
    echo "Install Homebrew"
    command -v brew >/dev/null 2>&1 || { echo >&2
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
    }
}

install_python () {
    # Install python
    echo "Install python"
    brew install python
    # Upgrade python packages
    echo "Upgrading and installing python packages"
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


ansible_install () {
    # Create a virtualenv for us
    echo "Creating our virtualenv in $ANSIBLE_INSTALL_DIR"
    virtualenv --no-site-packages $ANSIBLE_INSTALL_DIR
    . $ANSIBLE_INSTALL_DIR/bin/activate
    # Install Ansible pre-reqs
    echo "Installing ansibile requirements"
    pip install paramiko PyYAML Jinja2 httplib2 six
    echo "Installing ansibile requirements"
    # install ansible
    pip install ansible
}

run_playbook () {
    # Run our playbook
    ansible-playbook ansible/playbooks/site.yml -i localhost
}

ansible_cleanup() {
    # get rid of our ansible dir
    rm -rf $ANSIBLE_INSTALL_DIR
}


setup_gitconfig
install_dotfiles
if [ "$(uname -s)" == "Darwin" ]
then
    ANSIBLE_INSTALL_DIR=`mktemp -d 2>/dev/null || mktemp -d -t 'ansible'`
    xcode_install
    homebrew_install
    install_python
    ansible_install
    run_playbook
    ansible_cleanup
fi

echo ''
echo '  All installed!'
