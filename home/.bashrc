eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS='--preview="bat --color=always {}"'
alias j='cd'
alias ji='cdi'

set -o vi
alias docker-killall='docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q)'
alias ls='ls --color=auto'
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR="/usr/bin/nvim"
export VISUAL="$EDITOR"
export HISTSIZE="10000"
export HISTFILESIZE="$HISTSIZE"

colorDir=$(tput setaf 4)
colorGit=$(tput setaf 2)
colorDirty=$(tput setaf 3)
bold=$(tput bold)
noStyle=$(tput sgr0)
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo " *"
}
function parse_git_upstream {
    local commitCount=$(git rev-list --count --left-right @{upstream}...HEAD 2> /dev/null)
    if [ -n "$commitCount" ]; then
       local behindCount=$(echo -n "$commitCount" | cut -f1)
       local aheadCount=$(echo -n "$commitCount" | cut -f2)
       if [ "$behindCount" != "0" ]; then
           echo -n " ${behindCount}↓"
       fi
       if [ "$aheadCount" != "0" ]; then
          echo -n " ${aheadCount}↑"
       fi
    fi
}
function parse_git_branch {
	local branch=$(git branch --show-current --no-color 2> /dev/null)
	[ -n "$branch" ] || local branch=$(git rev-parse --short HEAD 2> /dev/null)
	[ -n "$branch" ] && echo " $branch"
}
export PS1="\n$bold$colorDir\w$colorGit\$(parse_git_branch)$colorDirty\$(parse_git_dirty)\$(parse_git_upstream)$noStyle \$ "

eval "$(zoxide init bash --cmd cd)"
