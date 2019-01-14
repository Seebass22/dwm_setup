#!/bin/sh
caps="$(xset q | grep Caps | cut -d':' -f 3 | awk '{print $1}')"
if [ "$caps" == "on" ]; then
	capslock="CAPSLOCK ON   "
else
	capslock=""
fi
wifi="$(iwgetid | cut -d ':' -f2)"
vol="Volume: $(amixer | grep '%' | head -n 1 | awk '{print $5 $6}' | sed -e 's/\[//g' -e 's/\]//g' -e 's/off/ muted/' -e 's/on//')"
brightness="Brightness: $(light)%"
battery="Battery: $(cat /sys/class/power_supply/BAT1/capacity)%$(cat /sys/class/power_supply/BAT1/status | sed -e 's/Discharging//' -e 's/Charging/ (Charging)/')"
cputemp="CPU: $(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000 ))°C"
time="$(date +'%b %d, %H:%M')"

xsetroot -name "${capslock}${wifi}   ${vol}   ${brightness}   ${battery}   ${cputemp}   ${time}"
