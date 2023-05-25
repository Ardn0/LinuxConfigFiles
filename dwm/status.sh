#!/bin/bash
#
#

while true; do
datumCas=$(date +'%H:%M %d.%m.%Y')
verzeKernelu=$(uname -r | cut -d '-' -f1)
statusBaterie=$(cat /sys/class/power_supply/BAT1/status)
procentoBaterie=$(cat /sys/class/power_supply/BAT1/capacity)
procentoJas=$(light -G)
procentoZvuk=$(pactl get-sink-volume 0 | cut -d '/' -f2 | head -n 1 | xargs)
zvukZtlumen=$(pactl get-sink-mute 0)
mikrofonZtlumen=$(pactl get-source-mute 0)
teplota=$(cat ~/.config/sway/teplota)
teplotaCPU=$(sensors | grep Tdie | cut -d ' ' -f10 | cut -d '+' -f2)
rozlozeniKlavesnice=$(xkb-switch)
wifiPripojena=$(nmcli | grep "wlp1s0" | head -1 | cut -d ':' -f2 | cut -d ' ' -f4 | xargs)


#if [[ "$rozlozeniKlavesnice" == *"Czech"* ]];
#then
#        rozlozeniKlavesnice="cz"
#else
#        rozlozeniKlavesnice="en"
#fi

# WIFI
if [[ "$wifiPripojena" == "" ]]
then
	wifiPripojena="WIFI odpojena"
fi

# ZVUK a MIKROFON
if [[ "$zvukZtlumen" == *"yes"* ]]
then
	procentoZvuk="----"
fi

if [[ "$mikrofonZtlumen" == *"yes"* ]]
then
	mikrofonZtlumen="----"
else
	mikrofonZtlumen=$(pactl get-source-volume 0 | cut -d '/' -f2 | head -n 1 | xargs)
fi

# ZBYTEK
if [[ "$statusBaterie" == "Not charging" ]]
then 
	  xsetroot -name "[$wifiPripojena][$rozlozeniKlavesnice][CPU $teplotaCPU][Zvuk $procentoZvuk, Mic $mikrofonZtlumen][Jas $procentoJas%][Baterie $procentoBaterie%][Kernel $verzeKernelu][$datumCas]"

else
        if [[ "$statusBaterie" == "Charging" ]]
        then
        statusBaterie="+"
        fi

        if [[ "$statusBaterie" == "Discharging" ]]
        then
        statusBaterie="-"
        fi

xsetroot -name  "[$wifiPripojena][$rozlozeniKlavesnice][CPU $teplotaCPU][Zvuk $procentoZvuk '|' Mic $mikrofonZtlumen][Jas $procentoJas%][Baterie $statusBaterie $procentoBaterie%][Kernel $verzeKernelu][$datumCas]"
fi

sleep 1
done
