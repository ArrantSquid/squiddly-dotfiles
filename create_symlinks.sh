#!/bin/sh
#
# Create symlinks.
# Author: johnpneumann
# 
set -e
# Create our symlinks
ln -s `pwd`/.bash_aliases ~/.bash_aliases
ln -s `pwd`/.bash_profile ~/.bash_profile
ln -s `pwd`/.bashrc ~/.bashrc
ln -s `pwd`/.inputrc ~/.inputrc
ln -s `pwd`/.profile ~/.profile
ln -s `pwd`/.vim ~/.vim
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/iterm2_prefs ~/iterm2_prefs
