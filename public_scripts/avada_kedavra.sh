#!/bin/sh
# Kills a process Harry Potter style
# Not that amazing and requires homebrew
printf '\n\033[0;32;40mAvada Kedavra\n'
pkill $1
printf '\033[0;35;40m'
printf '\nKilled the following processes:\n\n'
printf '\033[1;32;40m'
pgrep $1
printf '\n\033[0mDone\n'
