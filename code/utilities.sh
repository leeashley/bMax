#!/bin/bash

##### Install Utilities Function #####
installUtilities(){
    passUser=$1
    finishedMsg="Finished."
    clear
    if [ $2 == "brave" ]; then
        installBraveBrowser $passUser
    elif [ $2 == "update" ]; then
        echo -e "$passUser" | sudo -S apt update
        echo -e "$finishedMsg"
    elif [ $2 == "upgrade" ]; then
        echo -e "$passUser" | sudo -S apt upgrade -y
        echo -e "$finishedMsg"
    elif [ $2 == "distUpgrade" ]; then
        echo -e "$passUser" | sudo -S apt dist-upgrade -y
        echo -e "$finishedMsg"
    elif [ $2 == "qemu-kvm" ]; then
        echo -e "$passUser" | sudo -S apt install qemu-kvm -y
        echo -e "$passUser" | sudo -S adduser $USER kvm
        echo -e "restart session.\n"
    else
        echo -e "$passUser" | sudo -S apt install $2 -y
        echo -e "$2" "installed."
    fi
}

export -f installUtilities