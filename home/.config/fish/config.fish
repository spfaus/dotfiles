if status is-interactive
    alias ls="ls -lAh --color"
    alias :q="exit"
    alias :q!="exit"
    alias hx="helix"
    export PATH="$HOME/.cargo/bin:$PATH"
    export SHELL="/usr/bin/fish"
    export VISUAL="/usr/bin/helix"
    export EDITOR="/usr/bin/helix"
    function fish_prompt
        powerline-shell --shell bare $status
    end
    function fish_greeting
    end
end
