colorDir="\[$(tput setaf 4)\]"
colorGit="\[$(tput setaf 2)\]"
colorDirty="\[$(tput setaf 3)\]"
colorHistory="\[$(tput setaf 4)\]"
bold="\[$(tput bold)\]"
noStyle="\[$(tput sgr0)\]"

eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS='--preview="bat --color=always {}"'
alias j='cd'
alias ji='cdi'

alias docker-killall='docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q)'
alias ls='ls --color=auto'
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR="/usr/bin/nvim"
export VISUAL="$EDITOR"
export HISTSIZE="10000"
export HISTFILESIZE="$HISTSIZE"
export HISTTIMEFORMAT="$colorHistory%Y-%m-%d %T$noStyle  "
export HISTCONTROL="ignoredups"

function parse_git_untracked {
    local untrackedCount=$(git ls-files --others --exclude-standard 2> /dev/null | wc -l)
    [ -n "$untrackedCount" ] && [ "$untrackedCount" != "0" ] && echo " ${untrackedCount}?"
}
function parse_git_unstaged {
    local unstagedCount=$(git ls-files --modified --exclude-standard 2> /dev/null | wc -l)
    [ -n "$unstagedCount" ] && [ "$unstagedCount" != "0" ] && echo " ${unstagedCount}○"
}
function parse_git_staged {
    local stagedCount=$(git diff --cached --numstat 2> /dev/null | wc -l)
    [ -n "$stagedCount" ] && [ "$stagedCount" != "0" ] && echo " ${stagedCount}●"
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
export PS1="\n$bold$colorDir\w$colorGit\$(parse_git_branch)$colorDirty\$(parse_git_untracked)\$(parse_git_unstaged)\$(parse_git_staged)\$(parse_git_upstream)$noStyle \$ "

eval "$(zoxide init bash --cmd cd)"
