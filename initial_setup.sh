#!/bin/sh
#
# Installs the basics for us.
# Author: johnpneumann
#
set -e
# Install xcode command line tools
xcode-select --install
# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Tap the cask
brew install caskroom/cask/brew-cask
# Install python
brew install python
# Upgrade pip and setuptools
pip install --upgrade pip setuptools
# Install virtualenv and ansible
pip install virtualenv ansible
