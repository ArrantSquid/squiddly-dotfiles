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
