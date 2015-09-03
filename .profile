# vim: set ft=sh:
##################
# SETUP ENV VARS #
##################
# Virtual Env Dir
export VIRTUAL_ENV_DIR=$HOME/envs
# Maya FBXSDK
export FBXSDK='/Applications/Autodesk/FBX Python SDK/2016.0/lib/Python27'

##############
# SETUP PATH #
##############
# Local bin and src
PATH=$PATH:$HOME/bin:$HOME/src
# Add in scripts folders
PATH=$PATH:$HOME/scripts:$HOME/public_scripts
# Add in ruby
PATH=$(brew --prefix ruby)/bin:$PATH
export PATH

####################
# SETUP PYTHONPATH #
####################
PYTHONPATH=$FBXSDK:$PYTHONPATH
export PYTHONPATH
