#!/bin/bash

export -f installFlutter

##### Install Flutter Function #####
installFlutter(){
    passUser=$1
    clear
    echo -e "Installing the Flutter..."
    echo -e "Starting flutter download..."
    curlFlutter=$(curl --url https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.2.1-stable.tar.xz --output $HOME/flutter.tar.xz);
    commandExit=$?
    if [ $commandExit = 143 ]; then
        rm -f $HOME/flutter.tar.xz
        echo -e "Stoped installing flutter and removed file."
        elif [ $commandExit != 0 ]; then
        echo -e "An error occurred in Flutter dependencies$curlFlutter"
    else
        tar xf $HOME/flutter.tar.xz -C $HOME 2>&1
        rm -f $HOME/flutter.tar.xz 2>&1
        echo -e "$passUser" | sudo -S echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.profile
        #export PATH="$PATH:$HOME/flutter/bin"
        echo -e "Flutter installed and configured successfully."
    fi
}