# Source our bash_completion file
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

# Shell Aliases
export CLICOLOR=1
# Colors
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      BLACK=$(tput setaf 0)
      RED=$(tput setaf 1)
      GREEN=$(tput setaf 190)
      YELLOW=$(tput setaf 3)
      BLUE=$(tput setaf 4)
      ORANGE=$(tput setaf 172)
      MAGENTA=$(tput setaf 9)
      PURPLE=$(tput setaf 141)
      CYAN=$(tput setaf 6)
      WHITE=$(tput setaf 256)
    else
      BLACK=$(tput setaf 0)
      RED=$(tput setaf 1)
      GREEN=$(tput setaf 2)
      YELLOW=$(tput setaf 3)
      BLUE=$(tput setaf 4)
      MAGENTA=$(tput setaf 5)
      CYAN=$(tput setaf 6)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    BLACK="\033[1;30m"
    RED="\033[1;31m"
    GREEN="\033[1;32m"
    YELLOW="\033[1;33m"
    BLUE="\033[1;34m"
    MAGENTA="\033[1;35m"
    CYAN="\033[1;36m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$BLUE\]\W\[$RED\] >\[$YELLOW\]>\[$GREEN\]>\[$MAGENTA\] \u \[$WHITE\]\[$RESET\]"
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTIGNORE='pwd:ll:ls:cd ..:cd ../..:listenvs:src:ak:curip:startdocker'
export HISTTIMEFORMAT='%F %T '

# ignores duplicate and empty history
export HISTCONTROL=ignoreboth
# merge all history from multiple tabs together
shopt -s histappend
# After each command, save and reload history - this preserves the history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export EDITOR='vim'

# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
