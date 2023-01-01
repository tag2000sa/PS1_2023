#!/bin/bash
#Author: Turky Abdulaziz Saderaldin
#Create Date: 01/01/23 23:02:28
#Update Date: 01/01/23 23:02:32
#Subject: PS1_Jan2023

#copy fonts to system folder
sudo cp -rp ./font-awesome /usr/share/fonts/

#clear and regenerate font cache
fc-cache -f

##check .bashrc for previous configuration variables
normal_user="~/.bashrc"
root_user="/root/.bashrc"
for user_bashrc in {${normal_user} ${root_user}}
do
	#create temporary check file
	sudo grep "start PS1 Block" ${user_bashrc} > check.tmp
	#check if configuration exist
	if [[ ! -s check.tmp ]]; then 
		sudo echo "" >> ${user_bashrc}
		sudo cat variables >> ${user_bashrc}
		sudo echo "" >> ${user_bashrc}
	fi
done
#remove temporary files
rm ./*.tmp

#add PS1 format for normal user
export PS1="${black_bg}${light_red_txt}${OS_ICON} \u${light_blue_txt}  \h${light_green_txt}  \$${light_magenta_txt}  ${light_magenta_txt}\w \n${white_txt} ╰─ ${format_off}"

#add PS1 format for root user
export PS1="\n${white_txt}${light_red_bg} ${OS_ICON} \u ${format_off}${light_red_txt}${light_yellow_bg}${black_txt}  \h${light_green_txt}${red_txt}  \w ${format_off}${light_yellow_txt} \n ${light_cyan_txt}${bold_txt}# ${format_off}"
