#!/bin/bash
#Author: Turky Abdulaziz Saderaldin
#Create Date: 01/01/23 23:02:28
#Update Date: 01/01/23 23:02:32
#Subject: PS1_Jan2023

##check .bashrc for previous configuration variables before adding the new configuration
normal_user="$HOME/.bashrc"
root_user="/root/.bashrc"

# check whether script run by root user or normal user
if [[ $EUID -ne 0 ]]; then
    user_bashrc=${normal_user}
else
    user_bashrc=${root_user}
fi
#create temporary check file
grep "start PS1 Block" ${user_bashrc} > check.tmp
#check if configuration exist
if [[ ! -s check.tmp ]]; then 
    echo "" >> ${user_bashrc}
    cat variables >> ${user_bashrc}
    echo "" >> ${user_bashrc}

    # check if it is root user configuration file 
    if [[ $user_bashrc == $root_user ]]; then
        #add PS1 format for root user
        echo '# PS1 for root user' >> ${user_bashrc} 2>/dev/null
        echo 'export PS1="\n${white_txt}${light_red_bg} ${OS_ICON} \u ${format_off}${light_red_txt}${light_yellow_bg}${black_txt}  \h${light_green_txt}${red_txt}  \w ${format_off}${light_yellow_txt} \n ${light_cyan_txt}${bold_txt}# ${format_off}"' >> ${user_bashrc} 2>/dev/null
    else
        #add PS1 format for normal user
        echo "# PS1 for normal user" >> ${user_bashrc}
        echo 'export PS1="${black_bg}${light_red_txt}${OS_ICON} \u${light_blue_txt}  \h${light_green_txt}  \$${light_magenta_txt}  ${light_magenta_txt}\w \n${white_txt} ╰─ ${format_off}"' >> ${user_bashrc}
    fi
fi
#remove temporary files
rm -f ./check.tmp
