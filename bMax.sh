#!/bin/bash

##### Global Variables #####
name="bMax";
version="0.0.1";
welcomeTitle="Hello, m0rk here!";

##### About Window #####
interfaceAbout(){
    msgAbout="Version: $1"
    msgMain="By: Mork / Lee Ashley"
    yad --text="$msgAbout$msgMain" --title="About" --text-align=center --button=gtk-ok
}

##### Install DartSdk Function #####
installDartSdk(){
    passUser=$1
    clear
    echo -e "Installing the DartSDK..."
    echo -e "$1" | sudo -S apt-get update > /dev/null 2>&1
    sudo apt-get install apt-transport-https > /dev/null 2>&1
    curlDartSdk=$(sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' 2>&1);
    if [ $? != 0 ]; then
        echo -e "An error occurred in DartSDK dependencies:""$curlDartSdk"
        exit
    fi
    sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' > /dev/null 2>&1
    sudo apt-get update > /dev/null 2>&1
    sudo apt-get install dart > /dev/null 2>&1
    echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
    clear && echo -e "Dart Sdk installed and configured successfully."
}

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

##### Information Window #####
information(){
    msgDependecie="Repositories have been updated and the following items have been installed:Build-essential and Yad"
    msgWarning="If the message appears in the terminal:"
    msgTerminal="Gtk-Message: Failed to load module \"pantheon-filechooser-module\" "
    msgToFix="You can remove using the: sudo rm /etc/profile.d/pantheon-filechooser-module.sh Or click the remove button below."
    yad --text="$msgDependecie\n$msgWarning\n$msgTerminal\n$msgToFix" --title="$1" --text-align=center --button=gtk-remove:"sudo rm /etc/profile.d/pantheon-filechooser-module.sh" --button=gtk-ok
    clear
    echo -e "$name $version $welcomeTitle";
}

installBraveBrowser(){
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    
    source /etc/os-release
    
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
    
    sudo apt update 2>&1 && sudo apt install brave-keyring brave-browser 2>&1 && clear && echo -e "Brave successfully installed."
}

##### Install Utilities Function #####
installUtilities(){
    passUser=$1
    if [ $2 == "brave" ]; then
        installBraveBrowser
    elif [ $2 == "update" ]; then
        echo -e "$passUser" | sudo -S apt update && sudo apt upgrade  
    else
        echo -e "$passUser" | sudo -S apt install $2 2>&1
        clear
        echo -e "$2" "successfully installed."
    fi
}

export -f installDartSdk installFlutter interfaceAbout information installUtilities installBraveBrowser

##### MainNotebook Function #####
mainNotebook(){
    id=$(echo $[($RANDOM % ($[10000 - 32000] + 1)) + 10000] )
    
    yad --plug="$id" --tabnum=1 --form --scroll --field="qBittorrent:FBTN" "bash -c 'installUtilities \"qbittorrent\"' " \
    --field="Curl:FBTN" "bash -c 'installUtilities \"$1\" \"curl\"' " \
    --field="Gdebi:FBTN" "bash -c 'installUtilities \"$1\" \"gdebi\"' " \
    --field="Brave:FBTN" "bash -c 'installUtilities \"$1\" \"brave\"'" \
    --field="Update Upgrade:FBTN" "bash -c 'installUtilities \"$1\" \"update\"' " &

    yad --plug="$id" --tabnum=2 --form --scroll --field="Git:FBTN" "bash -c 'installUtilities \"git\"' " \
    --field="Dart SDK":FBTN "bash -c 'installDartSdk \"$1\"'" \
    --field="Flutter:FBTN" "bash -c 'installFlutter \"$1\"'" &
    
    yad --notebook --title="$name" --key="$id" --window-icon="icons/bMaxIcon.png" --tab="Utilities" --tab="Dev Tools" \
    --button=gtk-about:"bash -c 'interfaceAbout \"$version\"'" --button=gtk-info:"bash -c 'information \"$name\"'" \
    --width=250 --height=250 --button=gtk-close:1 --buttons-layout=center
    
    exitMainScript=$?
    if [ $exitMainScript == 252 ] || [ $exitMainScript == 1 ]; then
        pkill -f curl && sleep 1
    else 
        exit
    fi
}

##### Main Function #####
main(){
    clear
    echo -e "$name $version $welcomeTitle";
    echo "Enter your password to download the dependencies and execute the later commands.";
    echo -n Password:
    read -s senhaUser
    yad --version > /dev/null 2>&1
    verifyDependencie=$?
    if [ $verifyDependencie = 252 ]; then
        mainNotebook $senhaUser
    else
        echo -e "Checking dependencies...";
        yadInstall=$(echo -e "$senhaUser" | sudo -S apt update 2>&1 && sudo apt install build-essential 2>&1 && sudo apt install yad 2>&1)
        if [ $? != 0 ]; then
            echo -e "An error occurred in the dependencies:""$yadInstall"
        else
            echo -e "Dependencies successfully installed."
            mainNotebook $senhaUser
        fi
    fi
}

##### CALL Main Function #####
main