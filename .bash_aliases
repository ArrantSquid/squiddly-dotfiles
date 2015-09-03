# vim: set ft=sh:
##################
# SYSTEM ALIASES #
##################
alias ll='ls -l'

##################
# HELPER ALIASES #
##################
# List out envs or git repos
alias listenvs='ls -1 $VIRTUAL_ENV_DIR'
# Source our .bashrc and .bash_profile for easy env reloads
alias src='source $HOME/.bashrc; source $HOME/.bash_profile'
# Kill a program with Harry Potter style
alias ak='avada_kedavra.sh'
# Get your current ip
alias curip='ifconfig -a | grep -w inet | cut -d" " -f2 '

##################
# RANDOM ALIASES #
##################
# Docker commands
alias startdocker='boot2docker init; boot2docker start; $(boot2docker shellinit)'
# Fake SMTP server
alias tsmtp='python -m smtpd -n -c DebuggingServer localhost:1025'

####################
# FUNCTION ALIASES #
####################
# Deactivate a virtualenv if we have one already sourced
deacenv() {
    if command -v deactivate > /dev/null 2>&1; then
        deactivate;
    fi
}

# Create a new virtual env
createenv() {
    if [ "$1" == "" ]; then
        echo "You must provide a name for the environment"
        return 1
    fi
    deacenv;
    virtualenv --no-site-packages $VIRTUAL_ENV_DIR/$1;
    workon $1;
}

# Work on a virtualenv
workon()
{
    deacenv;
	. $VIRTUAL_ENV_DIR/$1/bin/activate;
}

# Generate a patch file
genpatch()
{
	diff -Naur $1 $2 > $HOME/patches/$3;
}

# Copy a file or directory and append the current date to it
cpdate()
{
	cp -Rp $1 $2/$1_`date +%F_%T`;
}

# Search files with a single extension in a directory
supafind()
{
    grep -rin --include \*.$1 $2 $3
}
