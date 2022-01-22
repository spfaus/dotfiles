if status is-interactive
    function fish_prompt
        powerline-shell --shell bare $status
    end
    function fish_greeting
        fortune -a | lolcat
    end
end
