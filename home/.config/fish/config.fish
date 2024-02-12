if status is-interactive
    alias ls="ls -lAh --color"
    alias :q="exit"
    alias :q!="exit"
    alias docker-killall="docker stop (docker ps -qa); docker rm (docker ps -qa); docker rmi -f (docker images -qa); docker volume rm (docker volume ls -q); docker network rm (docker network ls -q)"
    export PATH="$HOME/.cargo/bin:$PATH"
    export SHELL="/usr/bin/fish"
    export VISUAL="/usr/bin/nvim"
    export EDITOR="/usr/bin/nvim"
    export RUST_BACKTRACE=1
    function fish_prompt
        powerline-shell --shell bare $status
    end
    function fish_greeting
    end
end
