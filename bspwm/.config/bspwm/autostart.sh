#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

function num_monitors {
				xrandr | grep -w "connected" | wc -l
}

function name_monitors {
				xrandr | grep -w "connected" | cut -f1 -d' '
}

monitors=$(num_monitors)
notify-send "$monitors monitor(s) connected"
if [ $monitors -eq 1 ]; then
				xrandr --auto --output eDP1 --mode 1920x1080 --output DP3 --off
elif [ $monitors -eq 2 ]; then
				xrandr --auto --output DP3 --mode 1920x1080 --pos 0x0 --output eDP1 --mode 1920x1080 --right-of DP3
else
				echo "More than 2 monitors connected"
fi;

$HOME/.config/polybar/launch.sh &

feh --bg-scale ~/.config/bspwm/wall.png &

xsetroot -cursor_name left_ptr &
run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &

conky -c $HOME/.config/bspwm/system-overview &
run nm-applet &
#run xfce4-power-manager &
run powerkit &
run libinput-gestures-setup start &
run xscreensaver &
blueberry-tray &
picom --config $HOME/.config/bspwm/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

notify-send "Desktop's ready" &
