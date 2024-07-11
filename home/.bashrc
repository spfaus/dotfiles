alias docker-killall='docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q)'

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

export PS1="\n\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
