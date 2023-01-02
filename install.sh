#!/bin/bash

## Install NerdFonts (https://nerdfonts.com)
echo "Install NerdFonts ..."

# create temporary folder
if [[ ! -e nf.tmp ]]; then
    mkdir nf.tmp 
fi
cd nf.tmp

# download JetBrainsMono NerdFonts
echo '* Downloading JetBrainsMono font.'
wget -nc https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip 

echo '* Installing JetBrainsMono font.'
# unzip fonts
if [[ ! -e JetBrainsMono ]]; then
    unzip JetBrainsMono.zip -d JetBrainsMono
fi 

# move fonts to (/usr/share/fonts/) or (/usr/local/share/fonts/)
if [[ ! -e /usr/share/fonts/JetBrainsMono ]]; then
    sudo mv JetBrainsMono /usr/share/fonts/
fi

# update and regenerate font cache
echo '* Updating fonts cache.'
fc-cache -f &>/dev/null

# remove temporary folder
rm -rf nf.tmp
cd ..

# run script (PS1_Jan2023.sh) as normal user
./PS1_Jan2023.sh

# re-run script (PS1_Jan2023.sh) as root user
sudo ./PS1_Jan2023.sh

