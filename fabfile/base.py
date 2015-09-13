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
from distutils.util import strtobool

# Third Party
from fabric.api import run, sudo, task, local

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
def brew(pkgs, use_cask=False):
    """Installs packages via homebrew.

    :param pkgs: The packages to install separated by spaces.
    :type pkgs: str
    :param use_cask: Use cask to install or not.
    :type use_cask: bool
    :returns: None

    """
    cmd = ['brew']
    if strtobool(str(use_cask)):
        cmd.append('cask')
    cmd.append('install')
    cmd.append(pkgs)
    local(' '.join(cmd))


@task
def gitclone(repo, destination):
    """Git clone a repo to a directory.

    :param repo: The url to the repository to clone.
    :type repo: str
    :param destination: Where to clone the repo to on disk.
    :type destination: str
    :returns: None

    """
    local('git clone {repo} {dest}'.format(repo=repo, dest=destination))


@task
def curl_download(url):
    """Use curl to download a file.

    :param url: The url to download from.
    :type url: str
    :returns: None

    """
    local('curl -LOC - {url}'.format(url=url))
