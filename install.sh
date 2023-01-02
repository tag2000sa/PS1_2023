#!/bin/bash

echo 'Install tools ...'
# install wget tool
sudo apt install wget -y > /dev/null 2>&1

# install fontcofig tools and redirect output to /dev/null
sudo apt install fontconfig -y > /dev/null 2>&1

# clear and regenerate font cache
sudo fc-cache -f > /dev/null 2>&1

## Install NerdFonts (https://nerdfonts.com)
echo 'Install NerdFonts ...'

# create temporary folder
echo ' - create temporary folder nf.tmp'
if [[ ! -e nf.tmp ]]; then
    mkdir nf.tmp 
fi
# get into the new created folder (nf.tmp)
cd nf.tmp

# download JetBrainsMono NerdFonts
echo ' - downloading JetBrainsMono font.'
wget -nc https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip > /dev/null 2>&1

echo ' - installing JetBrainsMono font.'
# unzip fonts
if [[ ! -e JetBrainsMono ]]; then
    unzip -qq JetBrainsMono.zip -d JetBrainsMono
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
# back to parent folder
cd ..

# run script (PS1_Jan2023.sh) as normal user
./PS1_Jan2023.sh

# re-run script (PS1_Jan2023.sh) as root user
sudo ./PS1_Jan2023.sh

