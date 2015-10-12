#!/bin/sh
#
# Installs the basics for us.
# Run this before running the ansible playbook.
# Author: johnpneumann
#
set -e
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
