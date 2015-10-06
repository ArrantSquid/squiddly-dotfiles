# vim: set ft=sh:
##################
# SETUP ENV VARS #
##################
# Virtual Env Dir
export VIRTUAL_ENV_DIR=$HOME/envs
# Maya FBXSDK
export FBXSDK='/Applications/Autodesk/FBX Python SDK/2016.0/lib/Python27'
# GO path
export GOPATH=$HOME/go

##############
# SETUP PATH #
##############
# Local bin and src
PATH=$PATH:$HOME/bin:$HOME/src
# Add in scripts folders
PATH=$PATH:$HOME/scripts:$HOME/public_scripts
# Add in ruby
PATH=$(brew --prefix ruby)/bin:$PATH
# Add gopath to the path
PATH=$PATH:$GOPATH/bin
export PATH

####################
# SETUP PYTHONPATH #
####################
PYTHONPATH=$FBXSDK:$PYTHONPATH
export PYTHONPATH

#################
# SETUP ANDROID #
#################
export ANDROID_HOME=/usr/local/opt/android-sdk

#############
# SETUP GIT #
#############
git config --global user.email $EMAIL > /dev/null
git config --global core.email $EMAIL > /dev/null
git config --global github.token $GITHUB_API_TOKEN > /dev/null
