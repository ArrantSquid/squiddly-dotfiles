#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Mac fabfile setup. Utilizes homebrew.

.. module:: fabfile.mac
    :platform: Linux, MacOS

.. moduleauthor:: John P. Neumann

.. note::
    None
"""
# Built In
import os
import sys

# Third Party
from fabric.api import local, cd, task

# Custom


@task
def python():
    """Install python."""
    local('brew install python')


@task
def go():
    """Install go."""
    local('brew install go')


@task
def nodejs():
    """Install node.js."""
    local('brew install nodejs')


@task
def git():
    """Install git."""
    local('brew install git')


@task
def perforce():
    """Installs perforce and the p4v client."""
    local('brew install homebrew/binary/perforce')
    local('brew cask install p4v')


@task
def coretools():
    """Basics that are used regularly."""
    apps = [
        'coreutils', 'ctags', 'cmake', 'tree', 'htop',
        'wget', 'fortune', 'cowsay'
    ]
    local('brew install {apps}'.format(apps=' '.join(apps)))


@task
def setup_vimdirs():
    """Sets up vim directories."""
    _create_vimdirs()


@task
def vim():
    """Install vim."""
    local('brew install vim --with-lua --with-python')
    _create_vimdirs()


@task
def macvim():
    """Installs macvim."""
    local('brew install macvim --with-lua --with-python')
    local('brew linkapps macvim')


@task
def powerline_fonts(repo_dir):
    """Download and install the powerline fonts.

    :param repo_dir: The base directory to check the repo out to.
    :type repo_dir: str
    :returns: None

    """
    if not os.path.exists(repo_dir):
        local('mkdir -p {dirname}'.format(dirname=repo_dir))
    with cd(repo_dir):
        if not os.path.exists(os.path.join(repo_dir, 'powerline-fonts')):
            local('git clone git@github.com:powerline/fonts.git powerline-fonts')
        with cd('powerline-fonts'):
            local('./install.sh')


@task
def vundle_install():
    """Install vundle and all of the plugins."""
    local('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')
    local('vim +PluginInstall +qall')


@task
def dotfiles(repo_dir):
    """Download dotfiles and create our symlinks.

    :param repo_dir: The base directory to check the repo out to.
    :type repo_dir: str
    :returns: None

    """
    if not os.path.exists(repo_dir):
        local('mkdir -p {rdir}'.format(rdir=repo_dir))
    dotfiles_dir = os.path.join(
        repo_dir, 'dotfiles'
    )
    if os.path.exists(dotfiles_dir):
        sys.exit('dotfiles repo already exists')
    with cd(repo_dir):
        local('git clone git@github.com:johnpneumann/dotfiles.git')


@task
def dotfiles_symlinks(repo_dir):
    """Creates all of our dotfile symlinks.

    :param repo_dir: The base directory to check the repo out to.
    :type repo_dir: str
    :returns: None

    """
    linkage = {
        '.bash_aliases': 'bash_aliases_prev',
        '.bash_profile': 'bash_profile_prev',
        '.bashrc': 'bashrc_prev', '.profile': 'profile_prev',
        '.vimrc': 'vimrc_prev', '.vim': 'vim_prev',
        'iterm2_prefs': 'iterm2_prefs_prev',
        'public_scripts': 'public_scripts_prev'
    }
    home_dir = os.path.expanduser('~')
    for key, value in linkage.items():
        dest = os.path.join(home_dir, key)
        backup = os.path.join(home_dir, value)
        source = os.path.join(repo_dir, key)
        _create_symlinks(
            source=source, destination=dest, backup=backup
        )


@task
def dockertoolbox():
    """Installs dockertoolbox."""
    local('brew cask install dockertoolbox')


@task
def vagrant():
    """Installs vagrant."""
    local('brew cask install vagrant')


def _create_vimdirs():
    """Creates our vim directories."""
    swp_dir = os.path.join(
            os.path.expanduser('~'),
            '.vim_swap'
    )
    undo_dir = os.path.join(
            os.path.expanduser('~'),
            '.vim_undo'
    )
    if not os.path.exists(swp_dir):
        local('mkdir {swp}'.format(swp=swp_dir))
    if not os.path.exists(undo_dir):
        local('mkdir {undo}'.format(undo=undo_dir))


def _create_symlinks(source, destination, backup):
    """Creates symlinks and backs up directories.

    :param source: The source file.
    :type source: str
    :param destination: The destination for the symlink.
    :type destination: str
    :param backup: The destination to backup the file to if it exists.
    :type backup: str
    :returns: None

    """
    if os.path.exists(source):
        if os.path.exists(destination):
            local('mv {dst} {bckp}'.format(dst=destination, bckp=backup))
        local('ln -s {src} {dst}'.format(src=source, dst=destination))
