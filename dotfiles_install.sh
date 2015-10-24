#!/bin/sh
#
# Download and install xcode and
# then clone our git repo and
# install our development environment
# Author: johnpneumann
#
set -e
# Install xcode
xcode-select --install
# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install python
brew install python
# Get the users github username
read -p "What's your GitHub username: " username
if [ "$username" = "" ]; then
    echo "Need a GitHub username to continue."
    echo "Or just give it a bs name and re-run it. I don't care."
    exit 1
fi
# Make the repo dir
mkdir -p ~/repos/$username
cd ~/repos/$username
# Clone the dotfiles repo
git clone https://github.com/johnpneumann/dotfiles.git
# Make the foss repos dir
mkdir -p ~/repos/foss
cd ~/repos/foss
# Install Ansible pre-reqs
pip install paramiko PyYAML Jinja2 httplib2 six
# Clone ansible
git clone git://github.com/ansible/ansible.git --recursive
# Go home
cd
# Agree to the Xcode license
sudo xcodebuild -license
