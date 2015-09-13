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
from base import brew
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
def skype():
    """Installs skype."""
    brew('skype', True)


@task
def java6():
    """Install Java6."""
    local('brew tap caskroom/versions')
    brew('java6', True)


@task
def p4v():
    """Install p4v."""
    brew('p4v', True)


@task
def dbeaver():
    """Install DBeaver."""
    brew('dbeaver-community', True)


@task
def node():
    """Install node.js."""
    brew('node', True)


@task
def macvim():
    """Installs macvim."""
    brew('macvim --with-lua --with-python')
    local('brew linkapps macvim')


@task
def dockertoolbox():
    """Installs dockertoolbox."""
    brew('dockertoolbox', True)


@task
def vagrant():
    """Installs vagrant."""
    brew('vagrant', True)
