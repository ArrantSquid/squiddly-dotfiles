#!/bin/sh
# Creates all the symlinks for you automagically
printf "Symlinking everything for you automagically\n"
printf "Hold on to your butts...\n"
ln -s .gvimrc $HOME/.gvimrc
ln -s .vimrc $HOME/.vimrc
ln -s .vim $HOME/.vim
ln -s .bashrc $HOME/.bashrc
ln -s .bash_aliases $HOME/.bash_aliases
ln -s .bash_profile $HOME/.bash_profile
ln -s .profile $HOME/.profile
ln -s iterm2_prefs $HOME/iterm2_prefs
ln -s public_scripts $HOME/public_scripts
printf "Done symlinking!\n"
