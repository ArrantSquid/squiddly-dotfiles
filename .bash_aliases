# vim: set ft=sh:

##################
# SYSTEM ALIASES #
##################
alias cp='cp -p'
alias ll='ls -l'
alias lt='ls -ltr'
alias la='ls -la'
alias cl='clear'
alias ..='cd ..'
alias ...='cd ../../'
######################
# END SYSTEM ALIASES #
######################

###############
# VIM ALIASES #
###############
alias gvim=mvim
alias sugvim='sudo mvim'
alias gviml='gvim -V9log.txt'
###################
# END VIM ALIASES #
###################

####################
# PERSONAL ALIASES #
####################

##################
# HELPER ALIASES #
##################
# Flush our cache on osx
alias flushcache='dscacheutil -flushcache'
# List out envs or git repos
alias listenvs='ls -1 $VIRTUAL_ENV_DIR'
alias listwk='ls -1 $WKGIT'
alias listmine='ls -1 $MYGIT'
# Source our .bashrc and .bash_profile for easy env reloads
alias src='source $HOME/.bashrc; source $HOME/.bash_profile'
# Easily edit our dotfiles
alias ebashrc='gvim ~/.bashrc'
alias ebashprof='gvim ~/.profile'
alias ebasha='gvim ~/.bash_aliases'
alias evimrc='gvim ~/.vimrc'
# Kill a program with Harry Potter style
alias ak='avada_kedavra.sh'
# Ping stuff
alias gping='ping -c 3 www.google.com'
alias rping='ping -c 3 192.168.1.1'
# Get your current ip
alias curip='ifconfig -a | grep -w inet | cut -d" " -f2 '
alias curiph='ifconfig -a | grep -w inet | cut -d" " -f2  | grep 192.'
######################
# END HELPER ALIASES #
######################

################
# FIND ALIASES #
################
# Find stuff in bash
alias bfind='cat $HOME/.bash_history | grep --color $1'
# Find python files containing a string - ignores files with a leading 0 (for South)
alias findpy='find . -type f -name "*.py" -not -name "*.pyc" -not -name "0*.py" | xargs grep --color'
# Find js files containing a string - ignores minified files and collected files (from Django's collectstatic)
alias findjs='find . -type f -name "*.js" -not -name "*.min.js" -not -name "min*" | grep -ve "./static/javascript" | xargs grep --color'
# Find actionscript files containing a string
alias findas='find . -type f -name "*.as" | xargs grep --color'
# Find java files containing a string
alias findjv='find . -type f -name "*.java" | xargs grep --color'
# Find html files containing a string
alias findht='find . -type f -name "*.html" | xargs grep --color'
# Find csharp files containing a string
alias findcs='find . -type f -name "*.cs" | xargs grep --color'
# Find .m files containing a string (c/obj c)
alias findm='find . -type f -name "*.m" | xargs grep --color'
# Find .mm files containing a string (c/obj c)
alias findmm='find . -type f -name "*.mm" | xargs grep --color'
# Find .h files containing a string (c/obj c)
alias findh='find . -type f -name "*.h" | xargs grep --color'
# Find fuck in any files in a directory - because you don't want to commit fuck
alias findfuck='grep --color -rin "fuck" .'
####################
# END FIND ALIASES #
####################

################
# EASY ALIASES #
################
alias ipy=ipython
alias mywork='cd $HOME/working'
alias mysc='cd $HOME/scripts'
alias myenvs='cd $VIRTUAL_ENV_DIR'
alias alfred='cd $HOME/Library/Application\ Support/Alfred/extensions/'
alias mygit='cd $MYGIT'
####################
# END EASY ALIASES #
####################

###############
# FUN ALIASES #
###############
alias cs='cowsay'
alias randcow='cowsay -f $(ls /usr/local/share/cows/ | gshuf -n1)'
alias cfort='fortune | randcow'
alias cforto='fortune -o | randcow'
###################
# END FUN ALIASES #
###################

################
# MAYA ALIASES #
################
alias mayaprefs='cd $MAYA_PREFS_DIR'
####################
# END MAYA ALIASES #
####################

########################
# END PERSONAL ALIASES #
########################

##################
# RANDOM ALIASES #
##################
# Docker commands
alias startdocker='boot2docker init; boot2docker start; $(boot2docker shellinit)'

# Eclipse VIM - For when you enjoy the memory leaking from your brain
alias eclim='$ECLIPSE_HOME/eclimd'

# MySQL Aliases
alias mysqlstart='mysql.server start'
alias mysqlstop='mysql.server stop'
alias mysql='$(brew --prefix mysql)/bin/mysql -u root -p'
alias mysqladmin='$(brew --prefix mysql)/bin/mysqladmin -u root -p'
alias mysqld='cd /usr/local/opt/mysql ; /usr/local/opt/mysql/bin/mysqld_safe &'
alias loadmysql='launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias unloadmysql='unlaunchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'

# Fake SMTP server
alias tsmtp='python -m smtpd -n -c DebuggingServer localhost:1025'
######################
# END RANDOM ALIASES #
######################

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
    deacenv;
    virtualenv --no-site-packages $VIRTUAL_ENV_DIR/$1;
    workon $1;
}

# Work on a virtualenv
workon()
{
    deacenv;
	source $VIRTUAL_ENV_DIR/$1/bin/activate;
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

# For n times ping an ip address
mping()
{
	ping -c $1 $2;
}

# Find a file and open it in vim
findvim()
{
	gvim $(find . -name "$1");

}

# Run pylint
runpylint()
{
	pylint --rcfile pylint.rc $1 --generated-members=object
}

########################
# END FUNCTION ALIASES #
########################

################
# WORK ALIASES #
################
alias wkgit='cd $WKGIT'
####################
# END WORK ALIASES #
####################
