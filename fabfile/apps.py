#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Basic apps.

.. module:: fabfile.apps
    :platform: Linux, MacOS

.. moduleauthor:: John P. Neumann

.. note::
    None
"""
# Built In
import os
import sys
import platform
from distutils.spawn import find_executable

# Third Party
from fabric.api import local, cd, task, execute

# Custom
import base
from common import setup_vimdirs



def __get_os__():
    return platform.system()

def __get_installer__():
    """Gets the installer based on the os.

    :returns: The installer to use.
    :rtype: obj

    """
    installer = base.brew
    if __get_os__ == 'Linux':
        installer = base.apt
        if find_executable('yum'):
            installer = base.yum
    return installer


@task
def python():
    """Install python."""
    installer = __get_installer__()
    if installer:
        installer('python')


@task
def go():
    """Install go."""
    installer = __get_installer__()
    if installer:
        installer('golang')


@task
def git():
    """Install git."""
    installer = __get_installer__()
    if installer:
        installer('git')


@task
def perforce():
    """Installs perforce cli."""
    url = 'http://cdist2.perforce.com/perforce/r15.1/bin.darwin90x86_64/p4'
    if __get_os__() == 'Linux':
        url = 'http://cdist2.perforce.com/perforce/r15.1/bin.linux26x86_64/p4'
    base.curl_download(url)
    local('mv p4 /usr/local/bin/p4')
    local('sudo chmod+x /usr/local/bin/p4')


@task
def ruby():
    """Install ruby."""
    installer = __get_installer__()
    if installer:
        installer('ruby')


@task
def postgres():
    """Install postgres."""
    installer = __get_installer__()
    if installer:
        installer('postgresql')


@task
def sqlite():
    """Install sqlite."""
    installer = __get_installer__()
    if installer:
        installer('sqlite')


@task
def vim():
    """Install vim."""
    installer = __get_installer__()
    if installer.name == 'brew':
        installer('vim --with-lua --with-python')
    execute(setup_vimdirs)
