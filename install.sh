#!/bin/bash
sudo echo ''
# start installation message
echo -e "Install tools ...\c"

# install wget tool
sudo apt install wget -y > /dev/null 2>&1

# install fontcofig tools and redirect output to /dev/null
sudo apt install fontconfig -y > /dev/null 2>&1

# clear and regenerate font cache
sudo fc-cache -f > /dev/null 2>&1
# complete installation message
echo -e "\t\t\tdone"

## Install NerdFonts (https://nerdfonts.com)
echo 'Install NerdFonts ...'

# create temporary folder
echo -e " - create temporary folder nf.tmp\c"
if [[ ! -e nf.tmp ]]; then
    mkdir nf.tmp 
    echo -e "\tdone"
fi
# get into the new created folder (nf.tmp)
cd nf.tmp

# download JetBrainsMono NerdFonts
echo -e " - downloading JetBrainsMono font\c"
wget -nc https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip > /dev/null 2>&1
echo -e "\tdone"

echo -e " - installing JetBrainsMono font\c"
# unzip fonts
if [[ ! -e JetBrainsMono ]]; then
    unzip -qq JetBrainsMono.zip -d JetBrainsMono
fi 

# move fonts to (/usr/share/fonts/) or (/usr/local/share/fonts/)
if [[ ! -e /usr/share/fonts/JetBrainsMono ]]; then
    sudo mv JetBrainsMono /usr/share/fonts/
fi
echo -e "\tdone"

# update and regenerate font cache
echo -e " - updating fonts cache\c"
fc-cache -f &>/dev/null
echo -e "\t\t\tdone"

# back to parent folder
cd ..

# remove temporary folder
echo -e " - remove temporary folder nf.tmp\c"
rm -rf nf.tmp
if [[ ! -e nf.tmp ]]; then
    echo -e "\tdone"
fi

# start script installation message
echo 'Install script ...'
# run script (PS1_Jan2023.sh) as normal user
echo -e " - install script as normal user\c"
./PS1_Jan2023.sh
echo -e "\tdone"

# re-run script (PS1_Jan2023.sh) as root user
echo -e " - install script as root user\c"
sudo ./PS1_Jan2023.sh
echo -e "\t\tdone"

# complete installation message
echo -e "Installation Completed.\n"
