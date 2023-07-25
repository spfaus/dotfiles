if status is-interactive
    alias ls="ls -lAh --color"
    alias :q="exit"
    alias :q!="exit"
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
