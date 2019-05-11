#!/bin/bash

##### Imports #####
source code/braveBrowser.sh

export -f installUtilities

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
    else
        echo -e "$passUser" | sudo -S apt install $2 -y
        echo -e "$2" "installed."
    fi
}