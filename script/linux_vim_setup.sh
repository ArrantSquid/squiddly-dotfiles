#!/bin/sh
# Creates and installs vim on Ubuntu.
# Tested on Ubuntu 14.04
# author: johnpneumann
#

# Install the stuff we need before removing everything
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev liblua5.1-dev luajit libluajit-5.1 libperl-dev

# Remove the default vim
sudo apt-get remove vim vim-runtime gvim ubuntu-minimal vim-common vim-tiny

# Install git
sudo apt-get install git

# clone, configure, build, install
cd ~
git clone https://github.com/vim/vim.git
cd vim
make distclean
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --with-luajit \
            --with-lua-prefix=/usr \
            --prefix=/usr \
            --enable-gui=gtk2 \
            --enable-cscope \
            --enable-largefile \
            --disable-netbeans \
            --enable-fail-if-missing
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install

# Set the editor to the vim we just built and installed
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
