#!/bin/bash
LAPTOP=eDP-1
DESK=DP-3
WORK1=DP1-1
WORK2=DP1-2

MODE_1080p=1920x1080

function last_state() {                                                           
        if [ -f /tmp/numdisplays ]; then                           
                cat /tmp/numdisplays 
        else                                                
                echo "1"                                    
        fi                        
}                         
 
function current_state() {                                 
        xrandr | grep -w "connected" | wc -l
}                         
                                               
prev=$(last_state)                         
current=$(current_state)

if [ $current -eq 1 ]; then
				xrandr --output $LAPTOP --mode $MODE_1080p
elif [ $current -eq 2 ]; then
				xrandr --output $DESK --mode $MODE_1080p --pos 0x0 --output $LAPTOP --mode $MODE_1080p --right-of $DESK
elif [ $current -eq 3 ]; then
				xrandr --output $WORK1 --mode $MODE_1080p --pos 0x0 --output $WORK2 --mode $MODE_1080p --right-of $WORK1 --output $LAPTOP --below $WORK1 --mode $MODE_1080p
else 
				notify-send "$current laptop setup not scripted yet, falling back to laptop setup"
				xrandr --output $LAPTOP --mode $MODE_1080p
fi

echo $current > /tmp/numdisplays
case $prev in
      1)            
                case $current in  
												1)
																# no-op
																;;
                        2)        
																i3-msg '[class=".*"]' move workspace to output $DESK
                                ;;   
                        3)            
																i3-msg '[class=".*"]' move workspace to output $WORK1
                                ;;
                        *)
																notify-send "Connected $current display(s)"
																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                                ;;
                esac
                ;;
        2) 
                case $current in
                        1)
																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                                ;;
                        3)
                                notify-send "Switching over from 2 connected displays to 3 not supported"
																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                                ;;
                        *)
                                notify-send "Connected $current displays. Whoa!"
																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                                ;;
                esac
                ;;
        3) 
                case $current in
                        1)      

																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                                ;;
                        2)
                                notify-send "Switching over from 3 connected displays to 2 not supported"
																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                                ;;
                        *)
                                notify-send "Connected $current displays. Whoa!"
																i3-msg '[class=".*"]' move workspace to output $LAPTOP
                esac
                ;;
        *)
                notify-send "Whoa, connected $prev display(s). How!"
								i3-msg '[class=".*"]' move workspace to output $LAPTOP
                ;;
esac
