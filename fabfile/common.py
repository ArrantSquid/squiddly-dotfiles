#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Common pieces that work on all Nix OS'

.. module:: common
    :platform: Linux, MacOS

.. moduleauthor:: John P. Neumann

.. note::
    None
"""
# Built In
import os
import sys

# Third Party
from fabric.api import local, cd, task, execute

# Custom


@task
def setup_devdirs():
    """Creates all of our directories."""
    home = os.path.expanduser('~')
    dirpaths = ['go', 'src', 'bin', 'envs', 'repos']
    execute(setup_vimdirs)
    for pth in dirpaths:
        _create_dir(os.path.join(home, pth))


@task
def setup_vimdirs():
    """Sets up vim directories."""
    home = os.path.expanduser('~')
    _create_dir(os.path.join(home, '.vim_swap'))
    _create_dir(os.path.join(home, '.vim_undo'))


@task
def powerline_fonts(repo_dir):
    """Download and install the powerline fonts.

    :param repo_dir: The base directory to check the repo out to.
    :type repo_dir: str
    :returns: None

    """
    execute(setup_devdirs)
    with cd(repo_dir):
        if not os.path.exists(os.path.join(repo_dir, 'powerline-fonts')):
            local('git clone git@github.com:powerline/fonts.git powerline-fonts')
        with cd('powerline-fonts'):
            local('./install.sh')


@task
def dotfiles(repo_dir):
    """Download dotfiles and create our symlinks.

    :param repo_dir: The base directory to check the repo out to.
    :type repo_dir: str
    :returns: None

    """
    execute(setup_devdirs)
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
def vundle_install():
    """Install vundle and all of the plugins."""
    local('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')
    local('vim +PluginInstall +qall')


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


def _create_dir(path):
    """Creates a directory.

    :param path: The path to the directory to create.
    :type path: str
    :returns: None

    """
    if os.path.exists(path):
        sys.stdout.write('{path} exists\n'.format(path=path))
        return
    local('mkdir -p {pth}'.format(pth=path))
