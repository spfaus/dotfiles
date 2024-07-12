alias docker-killall='docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q)'
export PATH="$HOME/.cargo/bin:$PATH"

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
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
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))$(parse_git_upstream)/"
}

export PS1="\n\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
eval "$(zoxide init bash)"
