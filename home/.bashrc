# FZF
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS='--preview="bat --color=always {}"'
alias j='cd'
alias ji='cdi'

# GENERAL
set -o vi
alias docker-killall='docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q)'
alias ls='ls --color=auto'
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR="/usr/bin/nvim"
export VISUAL="$EDITOR"
export HISTSIZE="10000"
export HISTFILESIZE="$HISTSIZE"
export HISTTIMEFORMAT="$(tput setaf 4)%Y-%m-%d %T$(tput sgr0)  "
export HISTCONTROL="ignoredups"
function cdev() {
    clang -Weverything -g -O0 ${1}
    clang --analyze -Xanalyzer -analyzer-output=text ${1}
    echo ""
    ./a.out
}

# PROMPT
source ~/.config/bash/git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_STATESEPARATOR=""
export GIT_PS1_SHOWCONFLICTSTATE="yes"
bold="\[$(tput bold)\]"
noStyle="\[$(tput sgr0)\]"
#export PS1="${bold}\n${colorDir}\w\$(__git_ps1 " %s")${noStyle} \$ "
export PS1='\n\[$(tput bold)$(tput setaf 4)\]\W\[$(tput sgr0)$(tput bold)\]$(__git_ps1 " %s") \$\[$(tput sgr0)\] '

# ZOXIDE
eval "$(zoxide init bash --cmd cd)"
