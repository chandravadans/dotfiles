#!/bin/bash
LAPTOP=eDP-1
DESK=DP-3
WORK1=DP-2-1
WORK2=DP-1-2

MODE_1080p=1920x1080

function current_state () {                                 
        xrandr | grep -w "connected" | wc -l
}                         

function setup_laptop () {
				xrandr --auto --output $LAPTOP --primary --mode $MODE_1080p --pos 0x0
				i3-msg '[class=".*"]' move workspace to output $LAPTOP
}

function setup_home () {
				xrandr --auto --output $DESK --primary --mode $MODE_1080p --pos 0x0 --output $LAPTOP --mode $MODE_1080p --below $DESK
				i3-msg '[class=".*"]' move workspace to output $DESK
}

function setup_work () {
				xrandr --auto --output $WORK1 --primary --mode $MODE_1080p --pos 0x0 --output $WORK2 --mode $MODE_1080p --right-of $WORK1 --output $LAPTOP --below $WORK1 --mode $MODE_1080p
				i3-msg '[class=".*"]' move workspace to output $WORK1
}

current=$(current_state)
case $current in  
		1)
						setup_laptop
				    notify-send "Configured laptop"
			;;
    2)        
						setup_home
				    notify-send "Configured home"
      ;;   
    3)
						setup_work
				    notify-send "Configured work"
      ;;
    *)
				    notify-send "Connected $current display(s)"
				    setup_laptop
        ;;
esac
