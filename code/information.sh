#!/bin/bash

##### Information Window #####
information(){
    clear
    msgDependecie="Repositories have been updated and the following items have been installed:Build-essential and Yad"
    msgWarning="If the message appears in the terminal:"
    msgTerminal="Gtk-Message: Failed to load module \"pantheon-filechooser-module\" "
    msgToFix="You can remove using the: sudo rm /etc/profile.d/pantheon-filechooser-module.sh Or click the remove button below."
    yad --text="$msgDependecie\n$msgWarning\n$msgTerminal\n$msgToFix" --title="Information" --center --text-align=center --button=gtk-remove:"sudo rm /etc/profile.d/pantheon-filechooser-module.sh" --button=gtk-ok
    clear
    echo -e "$name $version $welcomeTitle";
}

export -f information