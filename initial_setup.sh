#!/bin/sh
#
# Installs the basics for us.
# Run this before running the ansible playbook.
# Author: johnpneumann
#
set -e
# Create our symlinks
ln -s .bash_aliases ~/.bash_aliases
ln -s .bash_profile ~/.bash_profile
ln -s .bashrc ~/.bashrc
ln -s .inputrc ~/.inputrc
ln -s .profile ~/.profile
ln -s .vim ~/.vim
ln -s .vimrc ~/.vimrc
ln -s iterm2_prefs ~/iterm2_prefs
# Install xcode command line tools
xcode-select --install
# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install python
brew install python
# Make the foss repos dir
mkdir -p ~/repos/foss
# Clone ansible
git clone git://github.com/ansible/ansible.git --recursive
# Cd to ansible
cd ~/repos/foss/ansible
# Source our ansibile stuff
source ./hacking/env-setup
