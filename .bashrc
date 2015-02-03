# Source our bash_completion file
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

# Shell Aliases
export CLICOLOR=1
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput setaf 4)\]\W\[$(tput setaf 1)\] >\[$(tput setaf 3)\]>\[$(tput setaf 2)\]>\[$(tput setaf 5)\] \u \[$(tput setaf 7)\]\[$(tput sgr0)\]"
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTIGNORE='pwd:ll:ls:cd ..:cd ../..:listenvs:src:ak:curip:startdocker'
export HISTTIMEFORMAT='%F %T '

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
