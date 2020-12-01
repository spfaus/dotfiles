#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

BLUE="\[$(tput setaf 32)\]" 
RESET="\[$(tput sgr0)\]"

PS1="${BLUE}[\w]\$${RESET} "
PS2="${BLUE}>${RESET} "
