#!/bin/sh
#
# Download and install xcode and
# then clone our git repo and
# install our development environment
# Author: johnpneumann
#
set -e

if [ "$1" == "" ]; then
    echo "Please specify a username"
    exit 1
fi
if [ "$2" == "" ]; then
    echo "No clone directory specified"
    exit 1
fi
pushd . >/dev/null

# Agree to the Xcode license
echo "Agree to the xcode license."
sudo xcodebuild -license accept

# Install xcode command line tools
echo “Installing Command Line Tools”
xcode-select -p >/dev/null
if [ $? -ne 0 ]; then
    xcode-select --install
fi
# Install homebrew
echo “Install Homebrew”
command -v brew >/dev/null 2>&1 || { echo >&2
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
# Install python
echo “Install python”
brew install python

# Make the repo dir
echo “Make the repo dirs”
if [ ! -d "$2/$1" ]; then
    mkdir -p "$2/$1"
fi
if [ ! -d "$2/$1/dotfiles" ]; then
    echo “Clone the dotfiles repo”
    cd "$2/$1"
    git clone https://github.com/johnpneumann/dotfiles.git
else
    echo “Update the dot files repo”
    cd "$2/$1/dotfiles"
    git fetch -ap
    git pull
fi

# Install Ansible pre-reqs
echo “Installing ansibile requirements”
pip install paramiko PyYAML Jinja2 httplib2 six
# Make the foss repos dir
echo “Making a foss dir for git repos”
if [ ! -d "$2/foss" ]; then
    mkdir -p "$2/foss"
fi
popd >/dev/null

# Clone ansible
pushd . >/dev/null
if [ ! -d "$2/foss/ansible" ]; then
    echo “Cloning ansible”
    cd "$2/foss"
    git clone git://github.com/ansible/ansible.git --recursive
else
    echo “Updating ansible”
    cd "$2/foss/ansible"
    git fetch -ap
    git pull --rebase
    git submodule update --init --recursive
fi

# Come on back
popd >/dev/null
sudo -k
echo "Finished"
