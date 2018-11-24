#!/bin/bash

#echo "-----------------------------------Xvfb-------------------------------"
#Xvfb :0 -screen 0 1200x800x16 +extension RANDR +extension GLX &
##
#echo "Waiting for Xvfb to be ready..."
#while ! xdpyinfo -display :0; do
#    echo -n ''
#    sleep 0.1
#done

#echo "-----------------------------------lxde-----------------------------"
#source $FREESURFER_HOME/SetUpFreeSurfer.sh

echo "$X11VNC_PASSWORD" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

vncserver -rfbport 5900 -geometry 1200x800 

echo "tailing to keep it running..."
tail -f ~/.vnc/*.log


