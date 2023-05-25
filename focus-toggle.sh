#!/bin/bash

blockedWebsites=(youtube.com twitch.tv reddit.com)
TOGGLE=$HOME/.toggle_focus

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    for t in ${blockedWebsites[@]}; do
        grep -qxF "127.0.0.1   $t" /etc/hosts || echo "127.0.0.1   $t" | sudo tee -a /etc/hosts >/dev/null
        grep -qxF "127.0.0.1   www.$t" /etc/hosts || echo "127.0.0.1   www.$t" | sudo tee -a /etc/hosts >/dev/null
    done
    echo "Focus mode enabled"
else
    rm $TOGGLE
    for t in ${blockedWebsites[@]}; do
        sudo sed -i -e "/127.0.0.1   $t/d" /etc/hosts
        sudo sed -i -e "/127.0.0.1   www.$t/d" /etc/hosts
    done
    echo "Focus mode disabled"
fi
