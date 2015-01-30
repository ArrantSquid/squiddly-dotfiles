# Source our bash_completion file
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

# Shell Aliases
export CLICOLOR=1
export PS1="\e[0;34m\]\W \e[0;31m\]>\e[0;33m\]>\e[0;32m\]> \e[0;35m\]\u \e[0;37m\]"
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTIGNORE='pwd:ll:ls'

# ignores duplicate and empty history
export HISTCONTROL=ignoreboth
# merge all history from multiple tabs together
shopt -s histappend
# # After each command, save and reload history - this preserves the history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export EDITOR='vim'

# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
