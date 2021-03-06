#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

if [ $# -ne 2 ]; then
				echo "Usage: launch.sh <bar_name> <tray_display>"
				exit 1
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		if [ $m = "$2" ]; then			
						MONITOR=$m TRAY=right polybar --reload $1 -c ~/.config/polybar/config &
		else
				    MONITOR=$m TRAY=none polybar --reload $1 -c ~/.config/polybar/config &
		fi
  done
else
  polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
fi
    # second polybar at bottom
    # if type "xrandr" > /dev/null; then
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config &
    #   done
    # else
    # polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config &
    # fi
