if status is-interactive
    alias ls="ls -lAh --color"
    alias :q="exit"
    alias :q!="exit"
    function fish_prompt
        powerline-shell --shell bare $status
    end
    function fish_greeting
    end
end
