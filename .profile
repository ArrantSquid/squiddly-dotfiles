# vim: set ft=sh:

##################
# SETUP ENV VARS #
##################
# Virtual Env Dir
export VIRTUAL_ENV_DIR=$HOME/envs

# Application Helpers
export APP_HOME=/Applications
export ECLIPSE_HOME=$APP_HOME/eclipse

# Mayapy
export MAYABIN=$APP_HOME/Autodesk/maya2015/Maya.app/Contents/bin
export MAYAPY=$mayabin/mayapy

# Maya prefs dir
export MAYA_PREFS_DIR=$HOME/Library/Preferences/Autodesk/maya/2015-x64

# My git directory
export MYGIT=$HOME/mygit
######################
# END SETUP ENV VARS #
######################

##############
# SETUP PATH #
##############
# Make my Ctags show up first for vim
PATH=/usr/local/bin:$PATH
# Main Path
PATH=$PATH:/usr/bin:/usr/local/sbin:$HOME/bin
# Set PATH for my personal scripts
PATH=$PATH:$HOME/scripts:$HOME/public_scripts
# Add in the src directory and perforce src dir
PATH=$PATH:$HOME/src:$HOME/src/p4api
# Add in mayapy
PATH=$PATH:$MAYABIN
export PATH
##################
# END SETUP PATH #
##################

################
# WORK EXPORTS #
################
# Set WKGIT
export WKGIT=$HOME/wkgit
####################
# END WORK EXPORTS #
####################
