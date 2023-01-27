if status is-interactive
    alias ls="ls -lAh --color"
    function fish_prompt
        powerline-shell --shell bare $status
    end
    function fish_greeting
    end
end
