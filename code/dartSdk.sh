#!/bin/bash

export -f installDartSdk

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