#!/bin/bash

##### About Window #####
interfaceAbout(){
    msgAbout="Version: $1"
    msgMain="By: Mork / Lee Ashley"
    yad --text="$msgAbout$msgMain" --title="About" --center --text-align=center --button=gtk-ok
}

export -f interfaceAbout