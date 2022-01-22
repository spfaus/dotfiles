set -U fish_greeting ""
if status is-interactive
    fortune -a | lolcat
end
