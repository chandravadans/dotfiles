#!/bin/bash
if pgrep -x "picom" > /dev/null
then
	killall picom
fi
picom -b --config ~/.config/picom.conf
