#!/bin/bash

TOGGLE=$HOME/.toggle_private

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    git config --global user.name "spfaus"
    git config --global user.email "simon.pfaus@web.de"
    echo "Private mode enabled"
else
    rm $TOGGLE
    git config --global user.name "Simon Alexander Pfaus"
    git config --global user.email "simon.pfaus@pixlinemedia.de"
    echo "Work mode enabled"
fi
