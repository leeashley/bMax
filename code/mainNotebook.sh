#!/bin/bash

##### MainNotebook Function #####
mainNotebook(){
    id=$(echo $[($RANDOM % ($[10000 - 32000] + 1)) + 10000] )
    
    yad --plug="$id" --tabnum=1 --form --scroll \
    --field="qBittorrent:FBTN" "bash -c 'installUtilities \"$1\" \"qbittorrent\"' " \
    --field="curl:FBTN" "bash -c 'installUtilities \"$1\" \"curl\"' " \
    --field="gdebi:FBTN" "bash -c 'installUtilities \"$1\" \"gdebi\"' " \
    --field="gnome tweaks:FBTN" "bash -c 'installUtilities \"$1\" \"gnome-tweaks\"' " \
    --field="dconf Editor:FBTN" "bash -c 'installUtilities \"$1\" \"dconf-editor\"' " \
    --field="filezilla:FBTN" "bash -c 'installUtilities \"$1\" \"filezilla\"' " \
    --field="brave:FBTN" "bash -c 'installUtilities \"$1\" \"brave\"'" &

    yad --plug="$id" --tabnum=2 --form --scroll \
    --field="git:FBTN" "bash -c 'installUtilities \"$1\" \"git\"' " \
    --field="dart SDK":FBTN "bash -c 'installDartSdk \"$1\"'" \
    --field="flutter:FBTN" "bash -c 'installFlutter \"$1\"'" &

    yad --plug="$id" --tabnum=3 --form --scroll \
    --field="update:FBTN" "bash -c 'installUtilities \"$1\" \"update\" '" \
    --field="upgrade":FBTN "bash -c 'installUtilities \"$1\" \"upgrade\" '" \
    --field="dist upgrade:FBTN" "bash -c 'installUtilities \"$1\" \"distUpgrade\" '" &

    yad --plug="$id" --tabnum=4 --form --scroll \
    --field="dpkg configure:FBTN" "bash -c 'installUtilities \"$1\" \"dpkg --configure -a\"' " \
    --field="linux headers generic":FBTN "bash -c 'installUtilities \"$1\" \"linux-headers-generic\" '" \
    --field="qemu-kvm":FBTN "bash -c 'installUtilities \"$1\" \"qemu-kvm\" '" \
    --field="bumblebee:FBTN" "bash -c 'installUtilities \"$1\" \"bumblebee\"' " &
    
    yad --notebook --title="$name" --key="$id" --window-icon="icons/bMaxIcon.png" --tab="Utilities" --tab="Dev Tools" --tab="Updates" --tab="Support" --center\
    --button=gtk-about:"bash -c 'interfaceAbout \"$version\"'" --button=gtk-info:"bash -c 'information'" \
    --width=250 --height=250 --button=gtk-close:1 --buttons-layout=center
    
    exitMainScript=$?
    alternativeExit $exitMainScript
}

export -f mainNotebook