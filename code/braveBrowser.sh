#!/bin/bash

installBraveBrowser(){
    clear
    yad --title="Choice Distribution" --text "What's your distribution?" --center \
    --button="Ubuntu":31 --button="Linux Mint":96 --buttons-layout=center
    choiceDistro=$?
    passUser=$1
    if [ "$choiceDistro" -eq "31" ]; then 
        echo -e "$passUser" | sudo -S curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    
        source /etc/os-release
    
        echo -e "$passUser" | sudo -S echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo -S tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
    
        echo -e "$passUser" | sudo -S apt update 2>&1 && sudo apt install brave-keyring brave-browser 2>&1 && clear && echo -e "Brave installed."
        echo -e "Brave installed."
    elif [ "$choiceDistro" -eq "96" ]; then
        echo -e "$passUser" | sudo -S curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

        echo -e "$passUser" | sudo -S echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | sudo -S tee /etc/apt/sources.list.d/brave-browser-release-trusty.list

        echo -e "$passUser" | sudo -S apt update

        echo -e "$passUser" | sudo -S apt install brave-keyring brave-browser -y
        echo -e "Brave installed."
    fi
}

export -f installBraveBrowser