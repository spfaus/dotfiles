#!/bin/bash
set -e

cd $HOME/dotfiles

# Use local or remote state for configuration
echo "Do you wish to discard local changes, checkout master, and pull from remote before running configuration?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) git reset HEAD --hard && git checkout master && git reset HEAD --hard && git pull; break;;
        No ) break;;
    esac
done

# Get user config-group selection
find ./devices/* -type d -printf "%f "

#options=("AAA" "BBB" "CCC" "DDD")
options=($(find ./config-groups/* -maxdepth 0 -type d -printf "%f "))

menu() {
    echo "Avaliable config-groups:"
    for i in ${!options[@]}; do 
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$selection" ]]; then echo "$selection"; fi
}

prompt="Enter one or more options (space-separated) to toggle. Press ENTER without input to continue with current selection: "
while menu && read -rp "$prompt" nums && [[ "$nums" ]]; do 
    while read num; do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#options[@]} )) ||
        { selection="Invalid option: $num"; continue; }
        ((num--))
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
    done < <(echo $nums |sed "s/ /\n/g")
done

# Execute configuration scripts based on user selection
for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && ./config-groups/${options[i]}/configure.sh;
done

# Optional reboot
echo "Reboot now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) reboot; break;;
        No ) break;;
    esac
done