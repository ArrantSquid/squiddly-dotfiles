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
from fabric.api import local, cd, task, execute

# Custom
from base import brew, cask
from common import setup_vimdirs


@task
def coretools():
    """Basics that are used regularly."""
    apps = [
        'coreutils', 'ctags', 'cmake', 'tree', 'htop',
        'wget', 'fortune', 'cowsay', 'caskroom/cask/brew-cask'
    ]
    brew(' '.join(apps))


@task
def python():
    """Install python."""
    brew('python')


@task
def go():
    """Install go."""
    brew('go')


@task
def node():
    """Install node.js."""
    brew('node')


@task
def git():
    """Install git."""
    brew('git')


@task
def perforce():
    """Installs perforce and the p4v client."""
    local('brew tap homebrew/binary')
    brew('homebrew/binary/perforce')
    cask('p4v')


@task
def ruby():
    """Install ruby."""
    brew('ruby')


@task
def postgres():
    """Install postgres."""
    brew('postgresql')


@task
def sqlite():
    """Install sqlite."""
    brew('sqlite')


@task
def dbeaver():
    """Install DBeaver."""
    cask('dbeaver-community')


@task
def java6():
    """Install Java6."""
    local('brew tap caskroom/versions')
    cask('java6')


@task
def skype():
    """Installs skype."""
    cask('skype')


@task
def vim():
    """Install vim."""
    brew('vim --with-lua --with-python')
    execute(setup_vimdirs)


@task
def macvim():
    """Installs macvim."""
    brew('macvim --with-lua --with-python')
    local('brew linkapps macvim')


@task
def dockertoolbox():
    """Installs dockertoolbox."""
    cask('dockertoolbox')


@task
def vagrant():
    """Installs vagrant."""
    cask('vagrant')
