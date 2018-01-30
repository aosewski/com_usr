#!/bin/sh
ssh -C -f -L 5900:localhost:5900 nvidia@jetsonTx2 \
    x11vnc -safer -localhost -auth guess -usepw -once -display :0 -geometry 1920x1200 \
    && sleep 2 \
    && vncviewer -AutoSelect=0 localhost:0

# potrzebne żeby uruchomić menadżera okien X
#    
#    startx & \
#    export DISPLAY=:0 & \
#    xrandr --fb 1920x1200 & \
#    lxpanel & 
# w tym przypadku x11vnc tworzy serwer X -> parametry -create -xvnc
#  x11vnc -safer -localhost -auth /var/lib/gdm/:0.Xauth -usepw -once -create -geometry 1920x1200 \
#
# -xrandr (parametr do x11vnc)

