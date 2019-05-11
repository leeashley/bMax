#!/bin/bash

##### Imports #####
source code/about.sh
source code/information.sh
source code/dartSdk.sh
source code/flutter.sh
source code/utilities.sh

export -f mainNotebook

##### MainNotebook Function #####
mainNotebook(){
    id=$(echo $[($RANDOM % ($[10000 - 32000] + 1)) + 10000] )
    
    yad --plug="$id" --tabnum=1 --form --scroll \
    --field="qBittorrent:FBTN" "bash -c 'installUtilities \"$1\" \"qbittorrent\"' " \
    --field="Curl:FBTN" "bash -c 'installUtilities \"$1\" \"curl\"' " \
    --field="Gdebi:FBTN" "bash -c 'installUtilities \"$1\" \"gdebi\"' " \
    --field="Gnome Tweaks:FBTN" "bash -c 'installUtilities \"$1\" \"gnome-tweaks\"' " \
    --field="Dconf Editor:FBTN" "bash -c 'installUtilities \"$1\" \"dconf-editor\"' " \
    --field="Filezilla:FBTN" "bash -c 'installUtilities \"$1\" \"filezilla\"' " \
    --field="Brave:FBTN" "bash -c 'installUtilities \"$1\" \"brave\"'" &

    yad --plug="$id" --tabnum=2 --form --scroll \
    --field="Git:FBTN" "bash -c 'installUtilities \"$1\" \"git\"' " \
    --field="Dart SDK":FBTN "bash -c 'installDartSdk \"$1\"'" \
    --field="Flutter:FBTN" "bash -c 'installFlutter \"$1\"'" &

    yad --plug="$id" --tabnum=3 --form --scroll \
    --field="Update:FBTN" "bash -c 'installUtilities \"$1\" \"update\" '" \
    --field="Upgrade":FBTN "bash -c 'installUtilities \"$1\" \"upgrade\" '" \
    --field="Linux headers generic":FBTN "bash -c 'installUtilities \"$1\" \"linux-headers-generic\" '" \
    --field="Dist Upgrade:FBTN" "bash -c 'installUtilities \"$1\" \"distUpgrade\" '" &

    yad --plug="$id" --tabnum=4 --form --scroll \
    --field="DPKG Configure:FBTN" "bash -c 'installUtilities \"$1\" \"dpkg --configure -a\"' " \
    --field="Bumblebee:FBTN" "bash -c 'installUtilities \"$1\" \"bumblebee\"' " &
    
    yad --notebook --title="$name" --key="$id" --window-icon="icons/bMaxIcon.png" --tab="Utilities" --tab="Dev Tools" --tab="Updates" --tab="Support" --center\
    --button=gtk-about:"bash -c 'interfaceAbout \"$version\"'" --button=gtk-info:"bash -c 'information'" \
    --width=250 --height=250 --button=gtk-close:1 --buttons-layout=center
    
    exitMainScript=$?
    alternativeExit $exitMainScript
}