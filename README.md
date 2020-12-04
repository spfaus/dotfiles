# dotfiles
Collection of configs, scripts, etc. for setting up and tracking changes to my work environment.

## Current setup
Gnome with Pop Shell for tiling functionality on Arch Linux  
Neovim as editor  
...  

## How do I use this?
I use this as a second step to my [automatic Arch Linux install](https://github.com/Simon-A-P/arch-install) or anytime I wish to update or reset my configuration.  
Simply clone this repository into its own directory in your $HOME directory: ```cd ~ && git clone https://github.com/Simon-A-P/dotfiles.git```  
Running the contained ```arch-configure.sh``` will do the rest.  

## Notes
- This is a work in progress and probably always will be.  
- The scripts will overwrite some config files and import a full dconf dump.  
- Make sure to look through and understand the scripts before executing them if you want to avoid unintended side-effects.  
