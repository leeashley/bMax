#!/bin/bash

##### Imports #####
source code/mainNotebook.sh
source code/flutter.sh
source code/information.sh
source code/about.sh
source code/dartSdk.sh
source code/braveBrowser.sh
source code/utilities.sh

##### Global Variables #####
name="bMax";
version="0.2.1";
welcomeTitle="Hello, m0rk here!";

alternativeExit(){
    if [ $1 == 252 ] || [ $1 == 1 ]; then
        pkill -f curl && sleep 1
    else 
        exit
    fi
}

export -f alternativeExit

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
        yadInstall=$(echo -e "$senhaUser" | sudo -S apt update 2>&1 && sudo apt install build-essential -y 2>&1 && sudo apt install yad -y 2>&1)
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