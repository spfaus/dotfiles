if status is-interactive
    alias ls="ls -lah"
    function fish_prompt
        powerline-shell --shell bare $status
    end
    function fish_greeting
    end
end
