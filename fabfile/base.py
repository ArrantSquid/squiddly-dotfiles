#!/usr/bin/env python
# encoding: utf-8
"""Helper functions.

.. module:: fabfile.base
    :platform: Linux, MacOS

.. moduleauthor:: John P. Neumann

.. note::
    None
"""
# Built In

# Third Party
from fabric.api import run, sudo, task

# Custom


@task
def ls(path):
    """Lists a directories contents.

    :param path: The directory to list.
    :type path: str
    :returns: None

    """
    run('ls -ltrha {pth}'.format(pth=path))


@task
def apt(pkgs):
    """Installs packages via apt-get.

    :param pkgs: The packages to install separated by spaces.
    :type pkgs: str
    :returns: None

    """
    sudo('apt-get install -yq {packages}'.format(packages=pkgs))


@task
def yum(pkgs):
    """Installs packages via yum.

    :param pkgs: The packages to install separated by spaces.
    :type pkgs: str
    :returns: None

    """
    sudo('yum -y install {packages}'.format(packages=pkgs))


@task
def brew(pkgs):
    """Installs packages via homebrew.

    :param pkgs: The packages to install separated by spaces.
    :type pkgs: str
    :returns: None

    """
    sudo('brew install {packages}'.format(packages=pkgs))
