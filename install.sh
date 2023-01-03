#!/bin/bash
#Author: Turky Abdulaziz Saderaldin
#Create Date: 01/01/23 23:02:28
#Update Date: 03/01/23 07:55:00
#File Name: install.sh
#Subject: Installation Script

sudo echo ''

# Error Messages
err1='more than one input.'
err2="invalid input.\nvalid values are {JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC}"
err3="file not found."

# function test input exist in a list
function isIn() { [[ $2 =~ (^|[[:space:]])$1($|[[:space:]]) ]]; }

# set default design input
input=`date +%b` && input=${input^^}

# check input
if [[ $# -eq 1 ]]; then
        isIn $1 "JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC"
        if [[ $? -eq 0 ]]; then
                input=$1
        else
                echo -e "Error: ${err2}" && exit 1
        fi
elif [[ $# -gt 1 ]]; then
        echo -e "Error: ${err1}" && exit 1
fi

# find correspond contiguration file
case ${input} in
        "JAN") dd=PS1_Jan2023.sh;;
        "FEB") dd=PS1_Feb2023.sh;;
        "MAR") dd=PS1_Mar2023.sh;;
        "APR") dd=PS1_Apr2023.sh;;
        "MAY") dd=PS1_May2023.sh;;
        "JUN") dd=PS1_Jun2023.sh;;
        "JUL") dd=PS1_Jul2023.sh;;
        "AUG") dd=PS1_Aug2023.sh;;
        "SEP") dd=PS1_Sep2023.sh;;
        "OCT") dd=PS1_Oct2023.sh;;
        "NOV") dd=PS1_Nov2023.sh;;
        "DEC") dd=PS1_Dec2023.sh;;
esac

# check design file existance
if [[ ! -e ./${dd} ]]; then
    echo -e " Error: $PWD/${dd}\t${err3}" && exit 1
fi

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
echo "Install script ... (${dd})"
# run script as normal user
echo -e " - install script as normal user\c"
./${dd}
echo -e "\tdone"

# re-run script as root user
echo -e " - install script as root user\c"
sudo ./${dd}
echo -e "\t\tdone"

# complete installation message
echo -e "Installation Completed.\n"
